/*
    This file is part of the Lingui distribution.

    https://github.com/senselogic/LINGUI

    Copyright (C) 2018 Eric Pelzer (ecstatic.coder@gmail.com)

    Lingui is free software: you can redistribute it and/or modify
    it under the terms of the GNU Lesser General Public License
    as published by the Free Software Foundation, version 3.

    Lingui is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
    GNU Lesser General Public License for more details.

    You should have received a copy of the GNU Lesser General Public License
    along with Lingui.  If not, see <http://www.gnu.org/licenses/>.
*/

// -- IMPORTS

import core.stdc.stdlib : exit;
import std.algorithm : countUntil, sort;
import std.array : replicate;
import std.conv : to;
import std.file : dirEntries, exists, readText, thisExePath, write, SpanMode, FileException;
import std.path : dirName;
import std.stdio : writeln;
import std.string : endsWith, indexOf, join, replace, startsWith, split, strip, stripRight, toLower, toUpper;

// -- TYPES

class LINE
{
    // -- ATTRIBUTES

    long
        IndentationSpaceCount;
    dstring
        Text;
}

// ~~

enum CODE_LANGUAGE
{
    Cs,
    D,
    Dart
}

// ~~

class CODE
{
    // -- ATTRIBUTES

    CODE_LANGUAGE
        Language;
    long
        IndentationSpaceCount;
    LINE[]
        LineArray;

    // -- INQUIRIES

    dstring GetText(
        )
    {
        dstring
            line_text,
            text;

        foreach ( line; LineArray )
        {
            line_text = stripRight( line.Text );

            if ( line_text.length > 0 )
            {
                text ~= " "d.replicate( line.IndentationSpaceCount ) ~ line.Text;
            }

            text ~= '\n';
        }

        return text;
    }

    // -- OPERATIONS

    void AddLine(
        dstring text,
        bool indentation_is_applied = true
        )
    {
        dstring
            prior_text;
        LINE
            line;

        line = new LINE();
        line.Text = text;

        if ( text == "}" )
        {
            IndentationSpaceCount -= 4;
        }

        if ( indentation_is_applied )
        {
            line.IndentationSpaceCount = IndentationSpaceCount;
        }

        if ( text == "{" )
        {
            IndentationSpaceCount += 4;
        }

        if ( LineArray.length > 0 )
        {
            prior_text = LineArray[ $ - 1 ].Text;
        }

        if ( prior_text.length > 0
             && text.length > 0
             && ( ( ( text.startsWith( "if " )
                      || text.startsWith( "return " ) )
                    && prior_text != "{" )
                  || ( prior_text == "}"
                       && text != "}"
                       && text != "else"
                       && !text.startsWith( "else if " ) ) ) )
        {
            LineArray ~= new LINE();
        }

        LineArray ~= line;
    }

    // ~~

    void AddText(
        dstring text
        )
    {
        LineArray[ $ - 1 ].Text ~= text;
    }

    // ~~

    void AddFile(
        dstring file_path
        )
    {
        dstring[]
            line_array;

        line_array = file_path.ReadLineArray();

        foreach ( line; line_array )
        {
            AddLine( line, false );
        }
    }
}

// ~~

enum RULE_TYPE
{
    Language,
    Function,
    Var,
    Return,
    If,
    Elseif,
    Else,
    Assignment,
    Expression
}

// ~~

class RULE
{
    // -- ATTRIBUTES

    dstring
        FilePath;
    long
        LineIndex,
        IndentationSpaceCount;
    dstring
        Text;
    long
        Level;
    RULE
        SuperRule;
    RULE[]
        SubRuleArray;
    RULE_TYPE
        Type;
    dstring[]
        TokenArray;
    dstring
        ClassName,
        LanguageName;
    bool
        IsBaseLanguage,
        IsDerivedLanguage;
    RULE
        LanguageRule,
        BaseLanguageRule;
    dstring
        FunctionName;
    dstring[]
        ParameterNameArray,
        VariableNameArray;
    bool
        IsBooleanFunction,
        IsIntegerFunction,
        IsRealFunction,
        IsStringFunction,
        IsTranslationFunction,
        IsNativeFunction,
        IsNativeAttribute,
        IsNativeImport,
        IsBaseFunction;
    RULE
        FunctionRule;

    // -- INQUIRIES

    void Abort(
        dstring message
        )
    {
        writeln( FilePath, "(", ( LineIndex + 1 ), ") : ",Text );
        writeln( "*** ERROR : ", message );

        exit( -1 );
    }

    // ~~

    dchar GetDotCharacter(
        )
    {
        if ( LanguageName == "German"
             || LanguageName == "French"
             || LanguageName == "Spanish"
             || LanguageName == "Portuguese"
             || LanguageName == "Russian"
             || LanguageName == "Turquish"
             || LanguageName == "Dutch"
             || LanguageName == "Swedish"
             || LanguageName == "Norwegian"
             || LanguageName == "Danish"
             || LanguageName == "Arabic" )
        {
            return ',';
        }
        else
        {
            return '.';
        }
    }

    // ~~

    bool IsLastSubRule(
        )
    {
        return
            SuperRule !is null
            && SuperRule.SubRuleArray[ $ - 1 ] == this;
    }

    // ~~

    bool IsFunction(
        dstring text
        )
    {
        return
            text.length > 0
            && text[ 0 ] >= 'A'
            && text[ 0 ] <= 'Z';
    }

    // ~~

    bool IsString(
        dstring text
        )
    {
        return
            text.length >= 2
            && ( ( text.startsWith( '"' )
                   && text.endsWith( '"' ) )
                 || ( text.startsWith( '\'' )
                      && text.endsWith( '\'' ) ) );
    }

    // ~~

    bool IsNumber(
        dstring text
        )
    {
        return
            text.length > 0
            && ( ( text[ 0 ] >= '0'
                   && text[ 0 ] <= '9' )
                 || text[ 0 ] == '-' );
    }

    // ~~

    dstring GetNumberCode(
        dstring text
        )
    {
        if ( FloatOptionIsEnabled
             && text.indexOf( '.' ) >= 0 )
        {
            return text ~ "f";
        }
        else
        {
            return text;
        }
    }

    // ~~

    bool IsQuantity(
        dstring text
        )
    {
        return
            IsNumber( text )
            && text.indexOf( '*' ) >= 0;
    }

    // ~~

    dstring GetQuantityCode(
        dstring text
        )
    {
        long
            asterisk_character_index;
        dstring
            code,
            genre,
            quantity;

        asterisk_character_index = text.indexOf( '*' );

        quantity = text[ 0 .. asterisk_character_index ];
        text = text[ asterisk_character_index + 1 .. $ ];

        if ( text.endsWith( ":neutral" ) )
        {
            text = text[ 0 .. $ - 8 ];
            genre = "GENRE.Neutral";
        }
        else if ( text.endsWith( ":male" ) )
        {
            text = text[ 0 .. $ - 5 ];
            genre = "GENRE.Male";
        }
        else if ( text.endsWith( ":female" ) )
        {
            text = text[ 0 .. $ - 7 ];
            genre = "GENRE.Female";
        }
        else
        {
            genre = "GENRE.Neutral";
        }

        if ( !text.startsWith( '\"' ) )
        {
            text = "\"" ~ text ~ "\"";
        }

        if ( genre == "GENRE.Neutral" )
        {
            code = "TRANSLATION( " ~ text ~ ", \"" ~ quantity ~ "\" )";
        }
        else
        {
            code = "TRANSLATION( " ~ text ~ ", \"" ~ quantity ~ "\", " ~ genre ~ " )";
        }

        if ( CsOptionIsEnabled )
        {
            return "new " ~ code;
        }
        else
        {
            return code;
        }
    }

    // ~~

    bool HasVariablePrefix(
        dstring text
        )
    {
        return
            text.length > 0
            && "$*^#%!.@°&:".indexOf( text[ 0 ] ) >= 0;
    }

    // ~~

    bool IsVariableName(
        dstring text
        )
    {
        return
            text.length > 0
            && text[ 0 ] >= 'a'
            && text[ 0 ] <= 'z';
    }

    // ~~

    bool IsVariable(
        dstring text
        )
    {
        return
            IsVariableName( text )
            || ( HasVariablePrefix( text )
                 && IsVariableName( text[ 1 .. $ ] ) );
    }

    // ~~

    dstring GetVariableName(
        dstring text
        )
    {
        if ( HasVariablePrefix( text ) )
        {
            return text[ 1 .. $ ];
        }
        else
        {
            return text;
        }
    }

    // ~~

    bool HasVariable(
        dstring variable_name,
        dchar prefix_character
        )
    {
        dchar
            first_character;

        foreach ( function_parameter_name; FunctionRule.ParameterNameArray )
        {
            first_character = function_parameter_name[ 0 ];

            if ( prefix_character == 0
                 && first_character >= 'a'
                 && first_character <= 'z' )
            {
                if ( variable_name == function_parameter_name )
                {
                    return true;
                }
            }
            else if ( first_character == prefix_character )
            {
                if ( variable_name == function_parameter_name[ 1 .. $ ] )
                {
                    return true;
                }
            }
        }

        foreach ( function_variable_name; FunctionRule.VariableNameArray )
        {
            first_character = function_variable_name[ 0 ];

            if ( prefix_character == 0
                 && first_character >= 'a'
                 && first_character <= 'z' )
            {
                if ( variable_name == function_variable_name )
                {
                    return true;
                }
            }
            else if ( first_character == prefix_character )
            {
                if ( variable_name == function_variable_name[ 1 .. $ ] )
                {
                    return true;
                }
            }
        }

        return false;
    }

    // ~~

    bool IsStringVariable(
        dstring variable_name
        )
    {
        return HasVariable( variable_name, 0 );
    }

    // ~~

    bool IsBooleanVariable(
        dstring variable_name
        )
    {
        return HasVariable( variable_name, '!' );
    }

    // ~~

    bool IsIntegerVariable(
        dstring variable_name
        )
    {
        return HasVariable( variable_name, '#' );
    }

    // ~~

    bool IsRealVariable(
        dstring variable_name
        )
    {
        return HasVariable( variable_name, '%' );
    }

    // ~~

    bool IsTranslationVariable(
        dstring variable_name
        )
    {
        return HasVariable( variable_name, ':' );
    }

    // ~~

    bool IsScalarVariable(
        dstring variable_name
        )
    {
        return
            IsStringVariable( variable_name )
            || IsBooleanVariable( variable_name )
            || IsIntegerVariable( variable_name )
            || IsRealVariable( variable_name );
    }

    // ~~

    dstring GetVariableCode(
        dstring text
        )
    {
        bool
            it_is_translation_variable;
        dchar
            first_character;
        dstring
            variable_name;

        if ( IsScalarVariable( text ) )
        {
            return text;
        }
        else
        {
            first_character = text[ 0 ];
            variable_name = GetVariableName( text );

            if ( IsBooleanVariable( variable_name )
                 && first_character == '$' )
            {
                return "GetBooleanText( " ~ variable_name ~ " )";
            }
            else if ( IsIntegerVariable( variable_name )
                      && first_character == '$' )
            {
                return "GetIntegerText( " ~ variable_name ~ " )";
            }
            else if ( IsRealVariable( variable_name )
                      && first_character == '$' )
            {
                return "GetRealText( " ~ variable_name ~ " )";
            }
            else if ( IsTranslationVariable( variable_name ) )
            {
                if ( first_character >= 'a'
                     && first_character <= 'z' )
                {
                    return variable_name ~ "_translation";
                }
                else if ( first_character == '$' )
                {
                    return variable_name ~ "_translation.Text";
                }
                else if ( first_character == '*' )
                {
                    return variable_name ~ "_translation.Quantity";
                }
                else if ( first_character == '^' )
                {
                    return variable_name ~ "_translation.GetQuantityFirstCharacter()";
                }
                else if ( first_character == '#' )
                {
                    return variable_name ~ "_translation.IntegerQuantity";
                }
                else if ( first_character == '%' )
                {
                    return variable_name ~ "_translation.RealQuantity";
                }
                else if ( first_character == '!' )
                {
                    return variable_name ~ "_translation.HasIntegerQuantity";
                }
                else if ( first_character == '.' )
                {
                    return variable_name ~ "_translation.HasRealQuantity";
                }
                else if ( first_character == '@' )
                {
                    if ( LanguageRule.IsBaseLanguage
                         || LanguageRule.IsDerivedLanguage )
                    {
                        return "GetCardinalPlurality( " ~ variable_name ~ "_translation )";
                    }
                    else
                    {
                        return variable_name ~ "_translation.Get" ~ LanguageRule.LanguageName ~ "CardinalPlurality()";
                    }
                }
                else if ( first_character == '°' )
                {
                    if ( LanguageRule.IsBaseLanguage
                         || LanguageRule.IsDerivedLanguage )
                    {
                        return "GetOrdinalPlurality( " ~ variable_name ~ "_translation )";
                    }
                    else
                    {
                        return variable_name ~ "_translation.Get" ~ LanguageRule.LanguageName ~ "OrdinalPlurality()";
                    }
                }
                else if ( first_character == '&' )
                {
                    return variable_name ~ "_translation.Genre";
                }
                else
                {
                    Abort( "Invalid prefix : " ~ text );
                }
            }
            else
            {
                Abort( "Invalid variable : " ~ variable_name );
            }
        }

        return "";
    }

    // ~~

    dstring GetCode(
        dstring[] code_token_array
        )
    {
        dstring
            code;

        foreach ( code_token_index, code_token; code_token_array )
        {
            if ( code_token_index > 0
                 && code_token != "," )
            {
                code ~= ' ';
            }

            code ~= code_token;
        }

        return code;
    }

    // ~~

    dstring GetStringCode(
        dstring token
        )
    {
        dchar
            character;
        dstring
            code;
        long
            character_index;

        for ( character_index = 0;
              character_index < token.length;
              ++character_index )
        {
            character = token[ character_index ];

            if ( character == '§' )
            {
                code ~= "\\n";
            }
            else if ( character == '\\' )
            {
                code ~= character;

                if ( character_index + 1 < token.length )
                {
                    ++character_index;

                    code ~= token[ character_index ];
                }
            }
            else
            {
                code ~= character;
            }
        }

        return code;
    }

    // ~~

    dstring GetExpressionCode(
        dstring[] token_array
        )
    {
        long
            token_index;
        dstring
            code_token,
            token;
        dstring[]
            code_token_array;

        for ( token_index = 0;
              token_index < token_array.length;
              ++token_index )
        {
            token = token_array[ token_index ];

            if ( token == "=" )
            {
                code_token = "==";
            }
            else if ( token == "<>" )
            {
                code_token = "!=";
            }
            else if ( token == "not" )
            {
                code_token = "!";
            }
            else if ( token == "and" )
            {
                code_token = "&&";
            }
            else if ( token == "or" )
            {
                code_token = "||";
            }
            else if ( token == "~"
                      && ( CsOptionIsEnabled || DartOptionIsEnabled ) )
            {
                code_token = "+";
            }
            else if ( token == "false" )
            {
                code_token = "false";
            }
            else if ( token == "true" )
            {
                code_token = "true";
            }
            else if ( token == "zero" )
            {
                code_token = "PLURALITY.Zero";
            }
            else if ( token == "one" )
            {
                code_token = "PLURALITY.One";
            }
            else if ( token == "two" )
            {
                code_token = "PLURALITY.Two";
            }
            else if ( token == "few" )
            {
                code_token = "PLURALITY.Few";
            }
            else if ( token == "many" )
            {
                code_token = "PLURALITY.Many";
            }
            else if ( token == "other" )
            {
                code_token = "PLURALITY.Other";
            }
            else if ( token == "neutral" )
            {
                code_token = "GENRE.Neutral";
            }
            else if ( token == "male" )
            {
                code_token = "GENRE.Male";
            }
            else if ( token == "female" )
            {
                code_token = "GENRE.Female";
            }
            else if ( IsQuantity( token ) )
            {
                code_token = GetQuantityCode( token );
            }
            else if ( IsNumber( token ) )
            {
                code_token = GetNumberCode( token );
            }
            else if ( IsVariable( token ) )
            {
                code_token = GetVariableCode( token );
            }
            else if ( IsString( token ) )
            {
                code_token = GetStringCode( token );
            }
            else
            {
                code_token = token;
            }

            if ( code_token.length > 0 )
            {
                code_token_array ~= code_token;
            }
        }

        return GetCode( code_token_array );
    }

    // ~~

    dstring GetExpressionCode(
        int token_index
        )
    {
        return GetExpressionCode( TokenArray[ token_index .. $ ] );
    }

    // ~~

    dstring GetStringExpressionCode(
        )
    {
        dstring
            concatenated_code;

        foreach ( sub_rule_index, sub_rule; SubRuleArray )
        {
            if ( sub_rule_index > 0 )
            {
                if ( CsOptionIsEnabled || DartOptionIsEnabled )
                {
                    concatenated_code ~= " + ";
                }
                else if ( DOptionIsEnabled )
                {
                    concatenated_code ~= " ~ ";
                }
            }

            concatenated_code ~= sub_rule.GetExpressionCode( 0 );
        }

        return concatenated_code;
    }

    // ~~

    bool IsStringConstant(
        )
    {
        return
            Text.startsWith( '"' )
            && Text.endsWith( '"' );
    }

    // ~~

    bool IsStringExpression(
        )
    {
        return Text.startsWith( '"' );
    }

    // ~~

    bool ForbidsResultVariable(
        )
    {
        if ( Type == RULE_TYPE.Var )
        {
            foreach ( token; TokenArray[ 1 .. $ ] )
            {
                if ( GetVariableName( token ) == "result" )
                {
                    return true;
                }
            }
        }
        else if ( Type == RULE_TYPE.Return )
        {
            return true;
        }

        foreach ( sub_rule; SubRuleArray )
        {
            if ( sub_rule.ForbidsResultVariable() )
            {
                return true;
            }
        }

        return false;
    }

    // ~~

    bool RequiresResultVariable(
        )
    {
        if ( Type == RULE_TYPE.Expression )
        {
            return true;
        }
        else if ( Type == RULE_TYPE.Assignment
                  && GetVariableName( TokenArray[ 0 ] ) == "result" )
        {
            return true;
        }

        foreach ( sub_rule; SubRuleArray )
        {
            if ( sub_rule.RequiresResultVariable() )
            {
                return true;
            }
        }

        return false;
    }

    // ~~

    void FindDuplicateConstants(
        )
    {
        foreach ( constant_rule_index, constant_rule; SubRuleArray )
        {
            if ( constant_rule.IsStringConstant() )
            {
                foreach ( other_constant_rule_index, other_constant_rule; SubRuleArray )
                {
                    if ( other_constant_rule_index > constant_rule_index
                         && other_constant_rule.IsStringConstant()
                         && other_constant_rule.Text == constant_rule.Text )
                    {
                        Warn( "Duplicate " ~ TokenArray[ 0 ] ~ " constant : " ~ constant_rule.Text );
                    }
                }
            }
        }
    }

    // ~~

    void FindMissingConstants(
        )
    {
        bool
            constant_is_found;

        foreach ( constant_rule; SubRuleArray )
        {
            if ( constant_rule.IsStringConstant() )
            {
                foreach ( language_rule; SuperRule.SubRuleArray )
                {
                    if ( language_rule !is this
                         && language_rule.BaseLanguageRule == BaseLanguageRule )
                    {
                        constant_is_found = false;

                        foreach ( other_constant_rule; language_rule.SubRuleArray )
                        {
                            if ( other_constant_rule.Text == constant_rule.Text )
                            {
                                constant_is_found = true;

                                break;
                            }
                        }

                        if ( !constant_is_found )
                        {
                            Warn( "Missing " ~ TokenArray[ 0 ] ~ " constant in " ~ language_rule.TokenArray[ 0 ] ~ " : " ~ constant_rule.Text );
                        }
                    }
                }
            }
        }
    }

    // ~~

    void FindMissingFunctions(
        )
    {
        bool
            function_is_found;
        RULE
            base_language_rule;

        base_language_rule = BaseLanguageRule;

        while ( base_language_rule.BaseLanguageRule !is null )
        {
            base_language_rule = base_language_rule.BaseLanguageRule;
        }

        foreach ( base_function_rule; base_language_rule.SubRuleArray )
        {
            if ( !base_function_rule.IsStringConstant()
                 && !base_function_rule.IsNativeImport
                 && base_function_rule.SubRuleArray.length == 0 )
            {
                function_is_found = false;

                foreach ( function_rule; SubRuleArray )
                {
                    if ( !function_rule.IsStringConstant()
                         && !function_rule.IsNativeImport
                         && function_rule.Text == base_function_rule.Text )
                    {
                        function_is_found = true;

                        break;
                    }
                }

                if ( !function_is_found )
                {
                    Warn( "Missing " ~ base_language_rule.TokenArray[ 0 ] ~ " function in " ~ TokenArray[ 0 ] ~ " : " ~ base_function_rule.Text );
                }
            }
        }
    }

    // ~~

    bool FindConstant(
        dstring constant_name
        )
    {
        foreach ( language_rule; SubRuleArray )
        {
            foreach ( constant_rule; language_rule.SubRuleArray )
            {
                if ( constant_rule.IsStringConstant()
                     && constant_rule.Text == constant_name )
                {
                    return true;
                }
            }
        }

        return false;
    }

    // ~~

    void AddVarCode(
        CODE code
        )
    {
        dstring[]
            boolean_variable_name_array,
            integer_variable_name_array,
            real_variable_name_array,
            string_variable_name_array,
            translation_variable_name_array;

        foreach ( variable_name; VariableNameArray )
        {
            if ( variable_name.startsWith( '!' ) )
            {
                boolean_variable_name_array ~= variable_name[ 1 .. $ ];
            }
            else if ( variable_name.startsWith( '#' ) )
            {
                integer_variable_name_array ~= variable_name[ 1 .. $ ];
            }
            else if ( variable_name.startsWith( '%' ) )
            {
                real_variable_name_array ~= variable_name[ 1 .. $ ];
            }
            else if ( variable_name.startsWith( ':' ) )
            {
                translation_variable_name_array ~= variable_name[ 1 .. $ ];
            }
            else
            {
                string_variable_name_array ~= variable_name;
            }
        }

        if ( boolean_variable_name_array.length > 0 )
        {
            code.AddLine( "bool" );

            foreach ( boolean_variable_name_index, boolean_variable_name; boolean_variable_name_array )
            {
                code.AddLine( "    " ~ boolean_variable_name );

                if ( boolean_variable_name_index + 1 < boolean_variable_name_array.length )
                {
                    code.AddText( "," );
                }
                else
                {
                    code.AddText( ";" );
                }
            }
        }

        if ( integer_variable_name_array.length > 0 )
        {
            code.AddLine( "int" );

            foreach ( integer_variable_name_index, integer_variable_name; integer_variable_name_array )
            {
                code.AddLine( "    " ~ integer_variable_name );

                if ( integer_variable_name_index + 1 < integer_variable_name_array.length )
                {
                    code.AddText( "," );
                }
                else
                {
                    code.AddText( ";" );
                }
            }
        }

        if ( real_variable_name_array.length > 0 )
        {
            code.AddLine( GetRealType() );

            foreach ( real_variable_name_index, real_variable_name; real_variable_name_array )
            {
                code.AddLine( "    " ~ real_variable_name );

                if ( real_variable_name_index + 1 < real_variable_name_array.length )
                {
                    code.AddText( "," );
                }
                else
                {
                    code.AddText( ";" );
                }
            }
        }

        if ( string_variable_name_array.length > 0 )
        {
            if ( CsOptionIsEnabled )
            {
                code.AddLine( "string" );
            }
            else if ( DOptionIsEnabled )
            {
                code.AddLine( "dstring" );
            }
            else if ( DartOptionIsEnabled )
            {
                code.AddLine( "String" );
            }

            foreach ( string_variable_name_index, string_variable_name; string_variable_name_array )
            {
                code.AddLine( "    " ~ string_variable_name );

                if ( CsOptionIsEnabled || DartOptionIsEnabled )
                {
                    code.AddText( " = \"\"" );
                }

                if ( string_variable_name_index + 1 < string_variable_name_array.length )
                {
                    code.AddText( "," );
                }
                else
                {
                    code.AddText( ";" );
                }
            }
        }

        if ( translation_variable_name_array.length > 0 )
        {
            code.AddLine( "TRANSLATION" );

            foreach ( translation_variable_name_index, translation_variable_name; translation_variable_name_array )
            {
                code.AddLine( "    " ~ translation_variable_name ~ "_translation" );

                if ( CsOptionIsEnabled )
                {
                    code.AddText( " = new TRANSLATION()" );
                }
                else if ( DartOptionIsEnabled )
                {
                    code.AddText( " = TRANSLATION()" );
                }

                if ( translation_variable_name_index + 1 < translation_variable_name_array.length )
                {
                    code.AddText( "," );
                }
                else
                {
                    code.AddText( ";" );
                }
            }
        }

        if ( VariableNameArray.length > 0 )
        {
            code.AddLine( "" );
        }
    }

    // ~~

    void AddAssignmentCode(
        CODE code
        )
    {
        dstring
            variable_name;

        if ( TokenArray.length >= 3 )
        {
            variable_name = TokenArray[ 0 ];

            if ( variable_name.startsWith( "$" ) )
            {
                code.AddLine( variable_name[ 1 .. $ ] ~ "_translation.SetText( " ~ GetExpressionCode( 2 ) ~ " );" );
            }
            else if ( variable_name.startsWith( "*" ) )
            {
                code.AddLine( variable_name[ 1 .. $ ] ~ "_translation.SetQuantity( " ~ GetExpressionCode( 2 ) ~ " );" );
            }
            else if ( variable_name.startsWith( "&" ) )
            {
                code.AddLine( variable_name[ 1 .. $ ] ~ "_translation.SetGenre( " ~ GetExpressionCode( 2 ) ~ " );" );
            }
            else
            {
                code.AddLine( GetVariableCode( variable_name ) ~ " = " ~ GetExpressionCode( 2 ) ~ ";" );
            }
        }
        else
        {
            Abort( "Invalid arguments" );
        }
    }

    // ~~

    void AddStatementBlockCode(
        CODE code
        )
    {
        code.AddLine( "{" );

        foreach ( statement_rule; SubRuleArray )
        {
            statement_rule.AddStatementCode( code );
        }

        code.AddLine( "}" );
    }

    // ~~

    void AddStatementCode(
        CODE code
        )
    {
        if ( Type == RULE_TYPE.Return )
        {
            code.AddLine( "return " ~ GetExpressionCode( 1 ) ~ ";" );
        }
        else if ( Type == RULE_TYPE.If )
        {
            code.AddLine( "if ( " ~ GetExpressionCode( 1 ) ~ " )" );
            AddStatementBlockCode( code );
        }
        else if ( Type == RULE_TYPE.Elseif )
        {
            code.AddLine( "else if ( " ~ GetExpressionCode( 1 ) ~ " )" );
            AddStatementBlockCode( code );
        }
        else if ( Type == RULE_TYPE.Else )
        {
            if ( TokenArray.length == 1 )
            {
                code.AddLine( "else" );
            }
            else if ( TokenArray.length > 2
                      && TokenArray[ 1 ] == "if" )
            {
                code.AddLine( "else if ( " ~ GetExpressionCode( 2 ) ~ " )" );
            }
            else
            {
                Abort( "Invalid statement : " ~ Text );
            }

            AddStatementBlockCode( code );
        }
        else if ( Type == RULE_TYPE.Else )
        {
            AddStatementBlockCode( code );
        }
        else if ( Type == RULE_TYPE.Assignment )
        {
            AddAssignmentCode( code );
        }
        else if ( Type == RULE_TYPE.Expression )
        {
            code.AddLine( "result_translation.AddText( " ~ GetExpressionCode( 0 ) ~ " );" );
        }
    }

    // ~~

    void AddConstantCode(
        CODE code
        )
    {
        if ( CsOptionIsEnabled )
        {
            code.AddLine( "TranslationDictionary[ " ~ Text ~ " ] = " );
        }
        else if ( DOptionIsEnabled || DartOptionIsEnabled )
        {
            code.AddLine( "TranslationMap[ " ~ Text ~ " ] = " );
        }

        if ( SubRuleArray.length >= 1
             && SubRuleArray[ 0 ].Type == RULE_TYPE.Expression )
        {
            if ( SubRuleArray[ 0 ].IsStringExpression() )
            {
                if ( CsOptionIsEnabled )
                {
                    code.AddText( "new TRANSLATION( " ~ GetStringExpressionCode() ~ " );" );
                }
                else if ( DOptionIsEnabled || DartOptionIsEnabled )
                {
                    code.AddText( "TRANSLATION( " ~ GetStringExpressionCode() ~ " );" );
                }
            }
            else
            {
                code.AddText( GetStringExpressionCode() ~ ";" );
            }
        }
        else
        {
            Abort( "Invalid constant definition : " ~ Text );
        }
    }

    // ~~

    void AddNativeCode(
        CODE code,
        bool text_is_added
        )
    {
        if ( text_is_added )
        {
            code.AddLine( Text );
        }

        if ( SubRuleArray.length > 0 )
        {
            code.AddLine( "{" );

            foreach ( sub_rule; SubRuleArray )
            {
                sub_rule.AddNativeCode( code, true );
            }

            code.AddLine( "}" );
        }
    }

    // ~~

    void AddFunctionCode(
        CODE code
        )
    {
        bool
            function_has_result_variable;

        if ( IsNativeAttribute )
        {
            if ( CsOptionIsEnabled )
            {
                code.AddLine( "public " );
            }
            else
            {
                code.AddLine( "" );
            }
        }
        else
        {
            if ( CsOptionIsEnabled )
            {
                if ( IsBaseFunction )
                {
                    code.AddLine( "public virtual " );
                }
                else
                {
                    code.AddLine( "public override " );
                }
            }
            else if ( DOptionIsEnabled )
            {
                if ( IsBaseFunction )
                {
                    code.AddLine( "" );
                }
                else
                {
                    code.AddLine( "override " );
                }
            }
            else if ( DartOptionIsEnabled )
            {
                code.AddLine( "" );
            }
        }

        if ( IsNativeFunction )
        {
            code.AddText( Text );

            if ( SubRuleArray.length > 0 )
            {
                AddNativeCode( code, false );
            }
            else if ( !IsNativeAttribute )
            {
                code.AddLine( "{" );
                code.AddLine( "}" );
            }
        }
        else
        {
            if ( IsBooleanFunction )
            {
                code.AddText( "bool " );
            }
            else if ( IsIntegerFunction )
            {
                code.AddText( "int " );
            }
            else if ( IsRealFunction )
            {
                code.AddText( GetRealType() ~ " " );
            }
            else if ( IsStringFunction )
            {
                if ( CsOptionIsEnabled )
                {
                    code.AddText( "string " );
                }
                else if ( DOptionIsEnabled )
                {
                    code.AddText( "dstring " );
                }
                else if ( DartOptionIsEnabled )
                {
                    code.AddText( "String " );
                }
            }
            else
            {
                code.AddText( "TRANSLATION " );
            }

            code.AddText( FunctionName ~ "(" );

            foreach ( parameter_index, parameter_name; ParameterNameArray )
            {
                code.AddLine( "    " );

                if ( parameter_name.startsWith( ':' ) )
                {
                    code.AddText( "TRANSLATION " ~ parameter_name[ 1 .. $ ] ~ "_translation" );
                }
                else if ( parameter_name.startsWith( '!' ) )
                {
                    code.AddText( "bool " ~ parameter_name[ 1 .. $ ] );
                }
                else if ( parameter_name.startsWith( '#' ) )
                {
                    code.AddText( "int " ~ parameter_name[ 1 .. $ ] );
                }
                else if ( parameter_name.startsWith( '%' ) )
                {
                    code.AddText( GetRealType() ~ " " ~ parameter_name[ 1 .. $ ] );
                }
                else
                {
                    if ( CsOptionIsEnabled )
                    {
                        code.AddText( "string " ~ parameter_name );
                    }
                    else if ( DOptionIsEnabled )
                    {
                        code.AddText( "dstring " ~ parameter_name );
                    }
                    else if ( DartOptionIsEnabled )
                    {
                        code.AddText( "String " ~ parameter_name );
                    }
                }

                if ( parameter_index + 1 < ParameterNameArray.length )
                {
                    code.AddText( "," );
                }
            }

            code.AddLine( "    )" );
            code.AddLine( "{" );

            if ( SubRuleArray.length == 0 )
            {
                if ( IsBooleanFunction )
                {
                    code.AddLine( "return false;" );
                }
                else if ( IsIntegerFunction )
                {
                    code.AddLine( "return 0;" );
                }
                else if ( IsRealFunction )
                {
                    if ( FloatOptionIsEnabled )
                    {
                        code.AddLine( "return 0.0f;" );
                    }
                    else if ( DartOptionIsEnabled )
                    {
                        code.AddLine( "return 0.0;" );
                    }
                }
                else if ( IsStringFunction )
                {
                    code.AddLine( "return \"\";" );
                }
                else
                {
                    code.AddLine( "return TRANSLATION.Null;" );
                }
            }
            else if ( SubRuleArray.length == 1
                      && SubRuleArray[ 0 ].Type == RULE_TYPE.Expression
                      && SubRuleArray[ 0 ].IsStringExpression()
                      && ( IsStringFunction || IsTranslationFunction ) )
            {
                if ( IsStringFunction )
                {
                    code.AddLine( "return " ~ SubRuleArray[ 0 ].GetExpressionCode( 0 ) ~ ";" );
                }
                else if ( IsTranslationFunction )
                {
                    if ( CsOptionIsEnabled )
                    {
                        code.AddLine( "return new TRANSLATION( " ~ SubRuleArray[ 0 ].GetExpressionCode( 0 ) ~ " );" );
                    }
                    else if ( DOptionIsEnabled || DartOptionIsEnabled )
                    {
                        code.AddLine( "return TRANSLATION( " ~ SubRuleArray[ 0 ].GetExpressionCode( 0 ) ~ " );" );
                    }
                }
            }
            else
            {
                function_has_result_variable
                    = ( IsStringFunction || IsTranslationFunction )
                      && !ForbidsResultVariable()
                      && RequiresResultVariable();

                if ( function_has_result_variable )
                {
                    VariableNameArray ~= ":result";
                }

                AddVarCode( code );

                foreach ( sub_rule; SubRuleArray )
                {
                    sub_rule.AddStatementCode( code );
                }

                if ( function_has_result_variable )
                {
                    if ( IsStringFunction )
                    {
                        code.AddLine( "return result_translation.Text;" );
                    }
                    else if ( IsTranslationFunction )
                    {
                        code.AddLine( "return result_translation;" );
                    }
                }
            }

            code.AddLine( "}" );
        }

        if ( !IsLastSubRule() )
        {
            code.AddLine( "" );
            code.AddLine( "// ~~" );
            code.AddLine( "" );
        }
    }

    // ~~

    void AddImportCode(
        CODE code
        )
    {
        if ( CsOptionIsEnabled )
        {
            code.AddLine( "// -- IMPORTS" );
            code.AddLine( "" );

            if ( BaseNamespace != Namespace )
            {
                code.AddLine( "using " ~ BaseNamespace ~ ";" );
            }

            code.AddLine( "using " ~ Namespace ~ ";" );
        }
        else if ( DOptionIsEnabled )
        {
            code.AddLine( "module " ~ Namespace ~ "." ~ ClassName.toLower() ~ ";" );
            code.AddLine( "" );
            code.AddLine( "// -- IMPORTS" );
            code.AddLine( "" );

            if ( IsBaseLanguage )
            {
                code.AddLine( "import " ~ BaseNamespace ~ ".base_language;" );
            }
            else
            {
                code.AddLine( "import " ~ Namespace ~ "." ~ BaseLanguageRule.ClassName.toLower() ~ ";" );
            }

            code.AddLine( "import " ~ BaseNamespace ~ ".genre;" );
            code.AddLine( "import " ~ BaseNamespace ~ ".plurality;" );
            code.AddLine( "import " ~ BaseNamespace ~ ".translation;" );
        }
        else if ( DartOptionIsEnabled )
        {
            code.AddLine( "// -- IMPORTS" );
            code.AddLine( "" );

            if ( IsBaseLanguage )
            {
                code.AddLine( "import \"base_language.dart\";" );
            }
            else
            {
                code.AddLine( "import \"" ~ BaseLanguageRule.ClassName.toLower() ~ ".dart\";" );
            }

            code.AddLine( "import \"genre.dart\";" );
            code.AddLine( "import \"plurality.dart\";" );
            code.AddLine( "import \"translation.dart\";" );
        }

        foreach ( sub_rule; SubRuleArray )
        {
            if ( sub_rule.IsNativeImport )
            {
                code.AddLine( sub_rule.Text );
            }
        }
    }

    // ~~

    void AddLanguageCode(
        CODE code
        )
    {
        AddImportCode( code );

        code.AddLine( "" );
        code.AddLine( "// -- TYPES" );
        code.AddLine( "" );

        if ( CsOptionIsEnabled )
        {
            code.AddLine( "namespace " ~ Namespace );
            code.AddLine( "{" );
            code.AddLine( "public class " ~ ClassName ~ " : " );
        }
        else if ( DOptionIsEnabled )
        {
            code.AddLine( "class " ~ ClassName ~ " : " );
        }
        else if ( DartOptionIsEnabled )
        {
            code.AddLine( "class " ~ ClassName ~ " extends " );
        }

        if ( IsBaseLanguage )
        {
            code.AddText( "BASE_LANGUAGE" );
        }
        else
        {
            code.AddText( BaseLanguageRule.ClassName );
        }

        code.AddLine( "{" );
        code.AddLine( "// -- CONSTRUCTORS" );
        code.AddLine( "" );

        if ( CsOptionIsEnabled )
        {
            code.AddLine( "public " ~ ClassName ~ "(" );
        }
        else if ( DOptionIsEnabled )
        {
            code.AddLine( "this(" );
        }
        else if ( DartOptionIsEnabled )
        {
            code.AddLine( ClassName ~ "(" );
        }

        code.AddLine( "    )" );

        if ( CsOptionIsEnabled )
        {
            code.AddText( " : base()" );
        }
        else if ( DartOptionIsEnabled )
        {
            code.AddText( " : super()" );
        }

        code.AddLine( "{" );

        if ( DOptionIsEnabled )
        {
            code.AddLine( "super();" );
        }

        if ( !IsBaseLanguage )
        {
            code.AddLine( "Name = \"" ~ LanguageName ~ "\";" );
            code.AddLine( "DotCharacter = '"d ~ GetDotCharacter() ~ "';" );
        }

        foreach ( sub_rule; SubRuleArray )
        {
            if ( sub_rule.IsStringConstant() )
            {
                sub_rule.AddConstantCode( code );
            }
        }

        code.AddLine( "}" );
        code.AddLine( "" );
        code.AddLine( "// -- INQUIRIES" );
        code.AddLine( "" );

        if ( !IsBaseLanguage )
        {
            if ( CsOptionIsEnabled )
            {
                code.AddLine( "public override PLURALITY GetCardinalPlurality(" );
                code.AddLine( "    TRANSLATION translation" );
            }
            else if ( DOptionIsEnabled )
            {
                code.AddLine( "override PLURALITY GetCardinalPlurality(" );
                code.AddLine( "    ref TRANSLATION translation" );
            }
            else if ( DartOptionIsEnabled )
            {
                code.AddLine( "PLURALITY GetCardinalPlurality(" );
                code.AddLine( "    TRANSLATION translation" );
            }

            code.AddLine( "    )" );
            code.AddLine( "{" );
            code.AddLine( "return translation.Get" ~ LanguageName ~ "CardinalPlurality();" );
            code.AddLine( "}" );
            code.AddLine( "" );
            code.AddLine( "// ~~" );
            code.AddLine( "" );

            if ( CsOptionIsEnabled )
            {
                code.AddLine( "public override PLURALITY GetOrdinalPlurality(" );
                code.AddLine( "    TRANSLATION translation" );
            }
            else if ( DOptionIsEnabled )
            {
                code.AddLine( "override PLURALITY GetOrdinalPlurality(" );
                code.AddLine( "    ref TRANSLATION translation" );
            }
            else if ( DartOptionIsEnabled )
            {
                code.AddLine( "PLURALITY GetOrdinalPlurality(" );
                code.AddLine( "    TRANSLATION translation" );
            }

            code.AddLine( "    )" );
            code.AddLine( "{" );
            code.AddLine( "return translation.Get" ~ LanguageName ~ "OrdinalPlurality();" );
            code.AddLine( "}" );
            code.AddLine( "" );
            code.AddLine( "// ~~" );
            code.AddLine( "" );
        }

        foreach ( sub_rule; SubRuleArray )
        {
            if ( !sub_rule.IsStringConstant()
                 && !sub_rule.IsNativeImport )
            {
                sub_rule.AddFunctionCode( code );
            }
        }

        code.AddLine( "}" );

        if ( CsOptionIsEnabled )
        {
            code.AddLine( "}" );
        }
    }

    // ~~

    void WriteFile(
        )
    {
        dstring
            output_file_path;
        CODE
            code;

        code = new CODE();

        AddLanguageCode( code );

        output_file_path = OutputFolderPath;

        if ( UpperCaseOptionIsEnabled )
        {
            output_file_path ~= ClassName;
        }
        else
        {
            output_file_path ~= ClassName.toLower();
        }

        if ( CsOptionIsEnabled )
        {
            output_file_path ~= ".cs";
        }
        else if ( DOptionIsEnabled )
        {
            output_file_path ~= ".d";
        }
        else if ( DartOptionIsEnabled )
        {
            output_file_path ~= ".dart";
        }

        output_file_path.WriteText( code.GetText() );
    }

    // ~~

    void Dump(
        )
    {
        writeln( "    ".replicate( Level ), Text );

        foreach ( sub_rule; SubRuleArray )
        {
            sub_rule.Dump();
        }
    }

    // -- OPERATIONS

    void AddSubRule(
        RULE sub_rule
        )
    {
        SubRuleArray ~= sub_rule;

        sub_rule.Level = Level + 1;
        sub_rule.SuperRule = this;
    }

    // ~~

    void Tokenize(
        )
    {
        bool
            character_is_in_string_literal;
        dchar
            character,
            delimiter_character;
        long
            character_index;

        character_is_in_string_literal = false;

        TokenArray.length = 0;
        TokenArray ~= "";

        for ( character_index = 0;
              character_index < Text.length;
              ++character_index )
        {
            character = Text[ character_index ];

            if ( character_is_in_string_literal )
            {
                TokenArray[ $ - 1 ] ~= character;

                if ( character == '\\'
                     && character_index + 1 < Text.length )
                {
                    ++character_index;

                    TokenArray[ $ - 1 ] ~= Text[ character_index ];
                }
                else if ( character == delimiter_character )
                {
                    character_is_in_string_literal = false;
                }
            }
            else if ( character == ' ' )
            {
                if ( character_index > 0
                     && Text[ character_index - 1 ] != ' ' )
                {
                    TokenArray ~= "";
                }
            }
            else
            {
                if ( character == '\"'
                     || character == '\'' )
                {
                    delimiter_character = character;

                    character_is_in_string_literal = true;
                }
                else if ( character == ',' )
                {
                    TokenArray ~= "";
                }

                TokenArray[ $ - 1 ] ~= character;
            }
        }
    }

    // ~~

    void ParseLanguage(
        )
    {
        dstring
            base_class_name;

        Type = RULE_TYPE.Language;

        ClassName = TokenArray[ 0 ];
        LanguageName = ClassName.split( "_" )[ 0 ];
        LanguageName = LanguageName[ 0 ] ~ LanguageName[ 1 .. $ ].toLower();

        if ( TokenArray.length == 1 )
        {
            IsBaseLanguage = true;
        }
        else if ( TokenArray.length == 3
             && TokenArray[ 1 ] == ":" )
        {
            IsBaseLanguage = false;

            base_class_name = TokenArray[ 2 ];

            foreach ( language_rule; SuperRule.SubRuleArray )
            {
                if ( language_rule.ClassName == base_class_name )
                {
                    BaseLanguageRule = language_rule;
                    BaseLanguageRule.IsDerivedLanguage = true;

                    break;
                }
            }

            if ( BaseLanguageRule is null )
            {
                Abort( "Invalid base language : " ~ base_class_name );
            }
        }
        else
        {
            Abort( "Invalid syntax" );
        }
    }

    // ~~

    void ParseFunction(
        )
    {
        dstring
            first_token;
        RULE
            base_language_rule;

        first_token = TokenArray[ 0 ];

        Type = RULE_TYPE.Function;

        IsBooleanFunction = false;
        IsIntegerFunction = false;
        IsRealFunction = false;
        IsStringFunction = false;
        IsTranslationFunction = false;
        IsNativeFunction = false;
        IsNativeAttribute = false;

        if ( first_token.startsWith( "!" ) )
        {
            IsBooleanFunction = true;

            Text = Text[ 1 .. $ ];
            TokenArray[ 0 ] = first_token[ 1 .. $ ];
        }
        else if ( first_token.startsWith( '#' ) )
        {
            IsIntegerFunction = true;

            Text = Text[ 1 .. $ ];
            TokenArray[ 0 ] = first_token[ 1 .. $ ];
        }
        else if ( first_token.startsWith( '%' ) )
        {
            IsRealFunction = true;

            Text = Text[ 1 .. $ ];
            TokenArray[ 0 ] = first_token[ 1 .. $ ];
        }
        else if ( first_token.startsWith( ':' ) )
        {
            IsTranslationFunction = true;

            Text = Text[ 1 .. $ ];
            TokenArray[ 0 ] = first_token[ 1 .. $ ];
        }
        else if ( first_token.startsWith( '@' ) )
        {
            IsNativeFunction = true;
            IsNativeAttribute = !Text.endsWith( ')' );
            IsNativeImport = Text.startsWith( "@import " );

            Text = Text[ 1 .. $ ];
            TokenArray[ 0 ] = first_token[ 1 .. $ ];
        }
        else
        {
            IsStringFunction = true;
        }

        IsBaseFunction = true;

        for ( base_language_rule = SuperRule.BaseLanguageRule;
              base_language_rule !is null;
              base_language_rule = base_language_rule.BaseLanguageRule )
        {
            foreach ( base_function_rule; base_language_rule.SubRuleArray )
            {
                if ( base_function_rule.Text == Text )
                {
                    if ( base_function_rule.IsBooleanFunction != IsBooleanFunction
                         || base_function_rule.IsIntegerFunction != IsIntegerFunction
                         || base_function_rule.IsRealFunction != IsRealFunction
                         || base_function_rule.IsStringFunction != IsStringFunction
                         || base_function_rule.IsTranslationFunction != IsTranslationFunction
                         || base_function_rule.IsNativeFunction != IsNativeFunction )
                    {
                        Abort( "Invalid base function" );
                    }

                    IsBaseFunction = false;

                    break;
                }
            }
        }

        FunctionName = TokenArray[ 0 ];
        ParameterNameArray = TokenArray[ 1 .. $ ];
    }

    // ~~

    void Parse(
        )
    {
        dstring
            first_token,
            second_token;

        first_token = TokenArray[ 0 ];

        if ( Level == 1 )
        {
            ParseLanguage();
        }
        else if ( Level == 2 )
        {
            ParseFunction();
        }
        else if ( first_token == "var" )
        {
            Type = RULE_TYPE.Var;
        }
        else if ( first_token == "return" )
        {
            Type = RULE_TYPE.Return;
        }
        else if ( first_token == "if" )
        {
            Type = RULE_TYPE.If;
        }
        else if ( first_token == "elseif" )
        {
            Type = RULE_TYPE.Elseif;
        }
        else if ( first_token == "else" )
        {
            Type = RULE_TYPE.Else;
        }
        else if ( TokenArray.length >= 3
                  && TokenArray[ 1 ] == "=" )
        {
            Type = RULE_TYPE.Assignment;
        }
        else
        {
            Type = RULE_TYPE.Expression;
        }

        if ( Type == RULE_TYPE.Language )
        {
            LanguageRule = this;
        }
        else
        {
            LanguageRule = SuperRule.LanguageRule;
        }

        if ( Type == RULE_TYPE.Function )
        {
            FunctionRule = this;
        }
        else
        {
            FunctionRule = SuperRule.FunctionRule;
        }

        if ( Type == RULE_TYPE.Var
             && !FunctionRule.IsNativeFunction )
        {
            FunctionRule.VariableNameArray ~= TokenArray[ 1 .. $ ];
        }
    }
}

// ~~

class BLOCK
{
    // -- ATTRIBUTES

    long
        Level,
        IndentationSpaceCount;
    dstring[]
        LineArray;
    BLOCK
        SuperBlock;
    BLOCK[]
        SubBlockArray;

    // -- CONSTRUCTORS

    this(
        long indentation_space_count
        )
    {
        IndentationSpaceCount = indentation_space_count;
    }

    // -- INQUIRIES

    bool IsComment(
        )
    {
        return LineArray[ 0 ][ IndentationSpaceCount .. $ ].startsWith( "//" );
    }

    // ~~

    bool IsConstant(
        )
    {
        return LineArray[ 0 ][ IndentationSpaceCount .. $ ].startsWith( '"' );
    }

    // ~~

    void AddLineArray(
        ref dstring[] line_array
        )
    {
        line_array ~= LineArray;

        foreach ( sub_block; SubBlockArray )
        {
            sub_block.AddLineArray( line_array );
        }
    }

    // ~~

    dstring[] GetLineArray(
        )
    {
        dstring[]
            line_array;

        AddLineArray( line_array );

        return line_array;
    }

    // ~~

    dstring GetText(
        )
    {
        return GetLineArray().join( '\n' );
    }

    // ~~

    void Dump(
        )
    {
        writeln( Level, " / ", IndentationSpaceCount, " : " );
        writeln( LineArray.join( '\n' ) );

        foreach ( sub_block; SubBlockArray )
        {
            sub_block.Dump();
        }
    }

    // ~~

    dstring GetTargetDefinition(
        dstring source_definition,
        FILE source_definition_file,
        FILE target_definition_file
        )
    {
        dstring
            target_definition;
        long
            source_line_index;

        source_line_index = source_definition_file.LineArray.countUntil( source_definition );

        if ( source_line_index >= 0 )
        {
            if ( source_line_index < target_definition_file.LineArray.length
                 && target_definition_file.LineArray[ source_line_index ].length > 0 )
            {
                target_definition = target_definition_file.LineArray[ source_line_index ];
            }
            else
            {
                target_definition = "?" ~ source_definition;

                target_definition_file.MissingLineArray ~= source_definition;
            }
        }
        else
        {
            target_definition = "?" ~ source_definition;

            while ( source_definition_file.LineArray.length > 0
                    && source_definition_file.LineArray[ $ -1 ].length == 0 )
            {
                --source_definition_file.LineArray.length;
            }

            source_definition_file.LineArray ~= source_definition;
            source_definition_file.MissingLineArray ~= source_definition;
            target_definition_file.MissingLineArray ~= source_definition;
        }

        return target_definition;
    }

    // ~~

    dstring GetTargetLine(
        dstring source_line,
        FILE source_file,
        FILE target_file
        )
    {
        bool
            character_is_in_character_literal,
            character_is_in_string_literal;
        dchar
            source_character;
        dstring
            source_definition,
            target_line;
        long
            source_character_index;

        character_is_in_string_literal = false;
        character_is_in_character_literal = false;

        for ( source_character_index = 0;
              source_character_index < source_line.length;
              ++source_character_index )
        {
            source_character = source_line[ source_character_index ];

            if ( character_is_in_string_literal )
            {
                if ( source_character == '"' )
                {
                    source_definition ~= source_character;
                    target_line ~= GetTargetDefinition( source_definition, source_file.DefinitionFile, target_file.DefinitionFile );

                    character_is_in_string_literal = false;
                }
                else if ( source_character == '\\' )
                {
                    source_definition ~= source_character;

                    if ( source_character_index + 1 < source_line.length )
                    {
                        ++source_character_index;

                        source_definition ~= source_line[ source_character_index ];
                    }
                    else
                    {
                        target_line ~= source_definition;
                    }
                }
                else
                {
                    source_definition ~= source_character;
                }
            }
            else if ( character_is_in_character_literal )
            {
                target_line ~= source_character;

                if ( source_character == '\'' )
                {
                    character_is_in_character_literal = false;
                }
                else if ( source_character == '\\'
                          && source_character_index + 1 < source_line.length )
                {
                    ++source_character_index;

                    target_line ~= source_line[ source_character_index ];
                }
            }
            else if ( source_character == '"' )
            {
                source_definition = "";
                source_definition ~= source_character;

                character_is_in_string_literal = true;
            }
            else if ( source_character == '\'' )
            {
                target_line ~= source_character;

                character_is_in_character_literal = true;
            }
            else
            {
                target_line ~= source_character;
            }
        }

        return target_line;
    }

    // ~~

    BLOCK GetTargetBlock(
        BLOCK super_block,
        FILE source_file,
        FILE target_file
        )
    {
        BLOCK
            target_block;

        target_block = new BLOCK( IndentationSpaceCount );
        target_block.Level = Level;

        foreach ( line; LineArray )
        {
            if ( Level <= 1 )
            {
                target_block.LineArray ~= line;
            }
            else
            {
                target_block.LineArray ~= GetTargetLine( line, source_file, target_file );
            }
        }

        target_block.SuperBlock = super_block;

        foreach ( sub_block; SubBlockArray )
        {
            target_block.SubBlockArray ~= sub_block.GetTargetBlock( this, source_file, target_file );
        }

        return target_block;
    }

    // ~~

    void ExtractDefinitions(
        FILE definition_file
        )
    {
        bool
            character_is_in_character_literal,
            character_is_in_string_literal;
        dchar
            character;
        dstring
            definition;
        long
            character_index;

        character_is_in_string_literal = false;
        character_is_in_character_literal = false;

        foreach ( line; LineArray )
        {
            for ( character_index = 0;
                  character_index < line.length;
                  ++character_index )
            {
                character = line[ character_index ];

                if ( character_is_in_string_literal )
                {
                    if ( character == '"' )
                    {
                        definition ~= character;
                        definition_file.LineArray ~= definition;

                        character_is_in_string_literal = false;
                    }
                    else if ( character == '§' )
                    {
                        definition ~= "\"\n    \"";
                    }
                    else if ( character == '\\' )
                    {
                        definition ~= character;

                        if ( character_index + 1 < line.length )
                        {
                            ++character_index;

                            definition ~= line[ character_index ];
                        }
                    }
                    else
                    {
                        definition ~= character;
                    }
                }
                else if ( character_is_in_character_literal )
                {
                    if ( character == '\'' )
                    {
                        character_is_in_character_literal = false;
                    }
                    else if ( character == '\\'
                              && character_index + 1 < line.length )
                    {
                        ++character_index;
                    }
                }
                else if ( character == '"' )
                {
                    definition = "";
                    definition ~= character;

                    character_is_in_string_literal = true;
                }
                else if ( character == '\'' )
                {
                    character_is_in_character_literal = true;
                }
            }
        }

        foreach ( sub_block; SubBlockArray )
        {
            sub_block.ExtractDefinitions( definition_file );
        }
    }

    // -- OPERATIONS

    void AddSubBlock(
        BLOCK sub_block
        )
    {
        SubBlockArray ~= sub_block;

        sub_block.Level = Level + 1;
        sub_block.SuperBlock = this;
    }
}

// ~~

class DEFINITION
{
    dstring
        Name;
    dstring[]
        LineArray;
}

// ~~

class FILE
{
    // -- ATTRIBUTES

    dstring
        Path;
    dstring[]
        LineArray;
    FILE
        DefinitionFile,
        TranslationFile;
    BLOCK
        Block,
        LanguageBlock;
    dstring
        LanguageName,
        BaseLanguageName;
    dstring[]
        MissingLineArray;

    // -- INQUIRIES

    dstring GetText(
        )
    {
        return LineArray.join( '\n' );
    }

    // ~~

    void Write(
        )
    {
        Path.WriteText( GetText() );
    }

    // -- OPERATIONS

    void ParseBlocks(
        )
    {
        long
            indentation_space_count;
        BLOCK
            block,
            super_block;

        Block = new BLOCK( -1 );
        Block.Level = -1;

        block = Block;

        foreach ( line_index, line; LineArray )
        {
            indentation_space_count = line.GetIndentationSpaceCount();

            if ( indentation_space_count > block.IndentationSpaceCount )
            {
                super_block = block;

                block = new BLOCK( indentation_space_count );
                super_block.AddSubBlock( block );
            }
            else if ( line.length > 0 )
            {
                if ( indentation_space_count < block.IndentationSpaceCount )
                {
                    super_block = block;

                    while ( indentation_space_count <= super_block.IndentationSpaceCount )
                    {
                        super_block = super_block.SuperBlock;
                    }
                }
                else
                {
                    super_block = block.SuperBlock;
                }

                block = new BLOCK( indentation_space_count);
                super_block.AddSubBlock( block );
            }

            block.LineArray ~= line.stripRight();
        }

        assert( Block.GetText() == GetText() );
    }

    // ~~

    void JoinLines(
        )
    {
        long
            line_index;

        for ( line_index = 0;
              line_index < LineArray.length;
              ++line_index )
        {
            if ( LineArray[ line_index ].startsWith( "    \"" )
                 && line_index > 0
                 && LineArray[ line_index - 1 ].endsWith( "\"" ) )
            {
                LineArray[ line_index - 1 ]
                    = LineArray[ line_index - 1 ][ 0 .. $ - 1 ]
                      ~ "§"
                      ~ LineArray[ line_index ][ 5 .. $ ].strip();

                LineArray = LineArray[ 0 .. line_index ] ~ LineArray[ line_index + 1 .. $ ];

                --line_index;
            }
        }
    }

    // ~~

    void PickDefinitions(
        )
    {
        long
            picked_line_count,
            line_count,
            matched_line_index;
        dstring
            picked_line,
            matched_line;
        dstring[]
            line_array,
            picked_line_array;
        DEFINITION
            definition;
        DEFINITION[]
            definition_array,
            matched_definition_array;

        if ( Path.exists() )
        {
            LineArray = Path.ReadLineArray();

            foreach ( line_index, line; LineArray )
            {
                if ( line.length > 0 )
                {
                    if ( line.startsWith( '<' )
                         || line.startsWith( '>' ) )
                    {
                        definition = null;

                        foreach ( prior_definition; definition_array )
                        {
                            if ( prior_definition.Name == line )
                            {
                                definition = prior_definition;

                                break;
                            }
                        }

                        if ( definition is null )
                        {
                            definition = new DEFINITION();
                            definition.Name = line;
                            definition_array ~= definition;
                        }
                    }
                    else if ( ( line.startsWith( '"' )
                                || line.startsWith( "    \"" ) )
                              && line.endsWith( '"' ) )
                    {
                        if ( definition !is null )
                        {
                            definition.LineArray ~= line;
                        }
                        else
                        {
                            Abort( "Missing group : " ~ Path ~ "(" ~ ( line_index + 1 ).to!dstring() ~ ")" );
                        }
                    }
                    else
                    {
                        Abort( "Invalid syntax : " ~ Path ~ "(" ~ ( line_index + 1 ).to!dstring() ~ ")" );
                    }
                }
            }

            if ( definition_array.length > 0 )
            {
                foreach ( checked_definition; definition_array )
                {
                    writeln( checked_definition.Name, " (", checked_definition.LineArray.length, ")" );

                    if ( checked_definition.LineArray.length != definition_array[ 0 ].LineArray.length )
                    {
                        Abort( "Invalid line count : " ~ checked_definition.Name );
                    }
                }

                for ( matched_line_index = 0;
                      matched_line_index < definition_array[ 0 ].LineArray.length;
                      ++matched_line_index )
                {
                    line_array = null;

                    foreach ( matched_definition; definition_array )
                    {
                        if ( matched_line_index < matched_definition.LineArray.length )
                        {
                            matched_line = matched_definition.LineArray[ matched_line_index ];

                            if ( matched_definition.Name.startsWith( '<' ) )
                            {
                                writeln( matched_line.strip(), " :" );
                            }
                            else
                            {
                                line_array ~= matched_line;
                            }
                        }
                    }

                    if ( line_array.length > 0 )
                    {
                        picked_line = "";
                        picked_line_count = 0;

                        line_array.sort();
                        line_count = 0;

                        foreach ( line_index, line; line_array )
                        {
                            ++line_count;

                            if ( line_index + 1 >= line_array.length
                                 || line_array[ line_index + 1 ] != line )
                            {
                                writeln( "    ", line.strip(), " (", line_count, ")" );

                                if ( line_count > picked_line_count )
                                {
                                    picked_line_count = line_count;
                                    picked_line = line;
                                }

                                line_count = 0;
                            }
                        }

                        picked_line_array ~= picked_line;
                    }
                }

                writeln( "Picked definitions :" );
                writeln( picked_line_array.join( '\n' ) );
            }
        }
    }
}

// ~~

class SCRIPT
{
    // -- ATTRIBUTES

    FILE[]
        FileArray;
    FILE
        SourceFile;
    RULE
        Rule;

    // -- INQUIRIES

    void Check(
        )
    {
        foreach ( language_rule; Rule.SubRuleArray )
        {
            if ( language_rule.BaseLanguageRule !is null )
            {
                language_rule.FindDuplicateConstants();
                language_rule.FindMissingConstants();
                language_rule.FindMissingFunctions();
            }
        }
    }

    // -- OPERATIONS

    void ParseBlocks(
        )
    {
        dstring
            line;
        FILE
            file;

        FileArray = null;
        SourceFile = null;

        foreach ( file_path; FilePathArray )
        {
            file = new FILE();
            file.Path = file_path;
            file.LineArray = file.Path.ReadLineArray();
            file.ParseBlocks();
            file.DefinitionFile = new FILE();
            file.DefinitionFile.Path = file_path.replace( ".lg", ".ld" );

            if ( file.DefinitionFile.Path.exists() )
            {
                file.DefinitionFile.LineArray = file.DefinitionFile.Path.ReadLineArray();
                file.DefinitionFile.JoinLines();
            }

            foreach ( block; file.Block.SubBlockArray )
            {
                line = block.LineArray[ 0 ];

                if ( line.length > 0
                     && line[ 0 ] >= 'A'
                     && line[ 0 ] <= 'Z'
                     && line.indexOf( ':' ) > 0 )
                {
                    file.LanguageBlock = block;
                    file.LanguageName = line.split( ':' )[ 0 ].strip();
                    file.BaseLanguageName = line.split( ':' )[ 1 ].strip();

                    if ( file.LanguageName == SourceLanguageName )
                    {
                        SourceFile = file;
                    }

                    break;
                }
            }

            FileArray ~= file;
        }
    }

    // ~~

    void WriteMirroredFiles(
        )
    {
        foreach ( target_file; FileArray )
        {
            if ( target_file.BaseLanguageName == SourceFile.BaseLanguageName
                 && target_file.DefinitionFile.MissingLineArray.length > 0 )
            {
                PrintError( "Missing entries in definition file : " ~ target_file.DefinitionFile.Path );
                writeln( target_file.DefinitionFile.MissingLineArray.join( '\n' ) );
            }
        }

        foreach ( target_file; FileArray )
        {
            if ( target_file.BaseLanguageName == SourceFile.BaseLanguageName
                 && target_file.LanguageName != SourceFile.LanguageName )
            {
                if ( target_file.DefinitionFile.MissingLineArray.length == 0 )
                {
                    target_file.Write();
                }
                else
                {
                    PrintError( "Can't mirror file : " ~ target_file.Path );
                    writeln( target_file.GetText() );
                }
            }
        }
    }

    // ~~

    void MirrorFiles(
        )
    {
        long
            source_block_index,
            target_block_index;
        BLOCK
            source_language_block,
            source_block,
            target_language_block,
            target_block;

        ParseBlocks();

        if ( SourceFile !is null )
        {
            source_language_block = SourceFile.LanguageBlock;

            foreach ( target_file; FileArray )
            {
                if ( target_file.BaseLanguageName == SourceFile.BaseLanguageName
                     && target_file.LanguageName != SourceFile.LanguageName )
                {
                    target_language_block = target_file.LanguageBlock;

                    for ( source_block_index = 0;
                          source_block_index < source_language_block.SubBlockArray.length;
                          ++source_block_index )
                    {
                        source_block = source_language_block.SubBlockArray[ source_block_index ];

                        if ( source_block.IsComment()
                             || source_block.IsConstant() )
                        {
                            for ( target_block_index = source_block_index;
                                  target_block_index < target_language_block.SubBlockArray.length;
                                  ++target_block_index )
                            {
                                target_block = target_language_block.SubBlockArray[ target_block_index ];

                                if ( target_block.LineArray[ 0 ] == source_block.LineArray[ 0 ] )
                                {
                                    if ( target_block_index > source_block_index )
                                    {
                                        target_language_block.SubBlockArray
                                            = target_language_block.SubBlockArray[ 0 .. target_block_index ]
                                              ~ target_language_block.SubBlockArray[ target_block_index + 1 .. $ ];

                                         target_language_block.SubBlockArray
                                            = target_language_block.SubBlockArray[ 0 .. source_block_index ]
                                              ~ target_block
                                              ~ target_language_block.SubBlockArray[ source_block_index .. $ ];
                                    }

                                    break;
                                }
                            }

                            if ( target_block_index >= target_language_block.SubBlockArray.length )
                            {
                                 target_language_block.SubBlockArray
                                    = target_language_block.SubBlockArray[ 0 .. source_block_index ]
                                      ~ source_block.GetTargetBlock( target_language_block, SourceFile, target_file )
                                      ~ target_language_block.SubBlockArray[ source_block_index .. $ ];
                            }
                        }
                        else
                        {
                            break;
                        }
                    }

                    target_file.LineArray = target_file.Block.GetLineArray();
                }
            }

            WriteMirroredFiles();
        }
        else
        {
            Abort( "Source language not found : " ~ SourceLanguageName );
        }
    }

    // ~~

    void ExtractDefinitions(
        )
    {
        ParseBlocks();

        foreach ( file; FileArray )
        {
            if ( file.LanguageBlock !is null )
            {
                file.DefinitionFile.LineArray = null;

                foreach ( block; file.LanguageBlock.SubBlockArray )
                {
                    if ( block.IsConstant() )
                    {
                        foreach ( sub_block; block.SubBlockArray )
                        {
                            sub_block.ExtractDefinitions( file.DefinitionFile );
                        }
                    }
                    else if ( !block.IsComment() )
                    {
                        break;
                    }
                }

                file.DefinitionFile.Write();
            }
        }
    }

    // ~~

    void PickDefinitions(
        )
    {
        FILE
            file;

        foreach ( file_path; FilePathArray )
        {
            file = new FILE();
            file.Path = file_path.replace( ".lg", ".lt" );
            file.PickDefinitions();
        }
    }

    // ~~

    void ParseRules(
        )
    {
        dstring
            rule_text;
        dstring[]
            line_array;
        RULE
            prior_rule,
            rule;

        Rule = new RULE();

        prior_rule = null;

        foreach ( file_path; FilePathArray )
        {
            line_array = file_path.ReadLineArray();

            foreach ( line_index, line; line_array )
            {
                rule_text = line.strip();

                if ( !rule_text.startsWith( "//" ) )
                {
                    if ( rule_text.length > 0 )
                    {
                        rule = new RULE();
                        rule.FilePath = file_path;
                        rule.LineIndex = line_index;
                        rule.Text = rule_text;
                        rule.IndentationSpaceCount = line.GetIndentationSpaceCount();

                        if ( prior_rule is null )
                        {
                            Rule.AddSubRule( rule );
                        }
                        else
                        {
                            while ( rule.IndentationSpaceCount < prior_rule.IndentationSpaceCount )
                            {
                                prior_rule = prior_rule.SuperRule;
                            }

                            if ( rule.IndentationSpaceCount == prior_rule.IndentationSpaceCount )
                            {
                                prior_rule.SuperRule.AddSubRule( rule );
                            }
                            else
                            {
                                prior_rule.AddSubRule( rule );
                            }
                        }

                        rule.Tokenize();
                        rule.Parse();

                        prior_rule = rule;
                    }
                }
            }
        }

        if ( CheckOptionIsEnabled )
        {
            Check();
        }
    }

    // ~~

    void WriteBaseFile(
        dstring input_folder_path,
        dstring output_folder_path,
        dstring file_name
        )
    {
        dstring
            file_text,
            input_file_path,
            output_file_path;

        if ( UpperCaseOptionIsEnabled )
        {
            file_name = file_name.toUpper();
        }

        if ( CsOptionIsEnabled )
        {
            file_name ~= ".cs";
        }
        else if ( DOptionIsEnabled )
        {
            file_name ~= ".d";
        }
        else if ( DartOptionIsEnabled )
        {
            file_name ~= ".dart";
        }

        input_file_path = GetExecutablePath( input_folder_path ~ file_name );
        output_file_path = output_folder_path ~ file_name;

        if ( input_file_path == output_file_path )
        {
            Abort( "Invalid output folder path" );
        }

        file_text = input_file_path.ReadText();

        if ( CsOptionIsEnabled )
        {
            file_text = file_text.replace( "LINGUI", Namespace );
        }
        else if ( DOptionIsEnabled || DartOptionIsEnabled )
        {
            file_text = file_text.replace( "lingui", Namespace );
        }

        if ( FloatOptionIsEnabled )
        {
            file_text
                = file_text
                      .replace( "double", "float" )
                      .replace( "0.0", "0.0f" )
                      .replace( "0.1", "0.1f" )
                      .replace( "1.5", "1.5f" )
                      .replace( "1.6", "1.6f" )
                      .replace( "= 12,", "= 6," );
        }

        output_file_path.WriteText( file_text );
    }

    // ~~

    void WriteFiles(
        )
    {
        dstring
            input_folder_path;

        ParseRules();

        if ( Rule.SubRuleArray.length > 0 )
        {
            foreach( language_rule; Rule.SubRuleArray )
            {
                language_rule.WriteFile();
            }
        }
        else
        {
            Abort( "Language not found" );
        }

        if ( BaseOptionIsEnabled )
        {
            if ( CsOptionIsEnabled )
            {
                input_folder_path = "CS/";
            }
            else if ( DOptionIsEnabled )
            {
                input_folder_path = "D/";
            }
            else if ( DartOptionIsEnabled )
            {
                input_folder_path = "DART/";
            }

            WriteBaseFile( input_folder_path, OutputFolderPath, "base_language" );
            WriteBaseFile( input_folder_path, OutputFolderPath, "genre" );
            WriteBaseFile( input_folder_path, OutputFolderPath, "plurality" );
            WriteBaseFile( input_folder_path, OutputFolderPath, "translation" );
        }
    }

    // ~~

    void FindConstants(
        dstring text
        )
    {
        bool
            character_is_in_long_comment,
            character_is_in_short_comment,
            character_is_in_string_literal;
        dchar
            character,
            delimiter_character;
        dstring
            constant_name;
        long
            character_index,
            line_index,
            next_character_index;

        character_is_in_short_comment = false;
        character_is_in_long_comment = false;
        character_is_in_string_literal = false;

        for ( character_index = 0;
              character_index < text.length;
              ++character_index )
        {
            character = text[ character_index ];

            if ( character_is_in_short_comment )
            {
                if ( character == '\n' )
                {
                    character_is_in_short_comment = false;
                }
            }
            else if ( character_is_in_long_comment )
            {
                if ( character == '*'
                     && character_index + 1 < text.length
                     && text[ character_index + 1 ] == '/' )
                {
                    character_is_in_long_comment = false;
                    ++character_index;
                }
            }
            else if ( character_is_in_string_literal )
            {
                if ( character == delimiter_character )
                {
                    character_is_in_string_literal = false;
                }
                else if ( character == '\\' )
                {
                    ++character_index;
                }
            }
            else if ( character == '/'
                      && character_index + 1 < text.length
                      && text[ character_index + 1 ] == '/' )
            {
                character_is_in_short_comment = true;
                ++character_index;
            }
            else if ( character == '*'
                      && character_index + 1 < text.length
                      && text[ character_index + 1 ] == '/' )
            {
                character_is_in_long_comment = true;
                ++character_index;
            }
            else if ( character == '\''
                      || character == '"' )
            {
                character_is_in_string_literal = true;
                delimiter_character = character;
            }
            else
            {
                foreach ( prefix; [ "HasTranslation(", "GetTranslation(", "GetText(" ] )
                {
                    if ( text[ character_index .. $ ].startsWith( prefix ) )
                    {
                        character_index += prefix.length;

                        while ( character_index < text.length
                                && IsBlankCharacter( text[ character_index ] ) )
                        {
                            ++character_index;
                        }

                        if ( character_index < text.length )
                        {
                            delimiter_character = text[ character_index ];

                            if ( delimiter_character == '\''
                                 || delimiter_character == '"' )
                            {
                                constant_name = "\"";

                                ++character_index;

                                while ( character_index < text.length )
                                {
                                    character = text[ character_index ];

                                    if ( character == delimiter_character )
                                    {
                                        ++character_index;

                                        break;
                                    }
                                    else
                                    {
                                        constant_name ~= character;

                                        ++character_index;

                                        if ( character == '\\' )
                                        {
                                            if ( character_index < text.length )
                                            {
                                                constant_name ~= text[ character_index ];

                                                ++character_index;
                                            }
                                        }
                                    }
                                }

                                constant_name ~= "\"";

                                if ( !Rule.FindConstant( constant_name ) )
                                {
                                    Warn( "Unknown constant : " ~ constant_name );
                                }
                            }
                        }

                        --character_index;

                        break;
                    }
                }
            }
        }
    }

    // ~~

    void FindConstants(
        )
    {
        ParseRules();

        foreach ( folder_path; FolderPathArray )
        {
            foreach ( file_filter; [ "*.cs", "*.d", "*.dart" ] )
            {
                foreach ( folder_entry; dirEntries( folder_path.to!string(), file_filter, SpanMode.depth ) )
                {
                    if ( folder_entry.isFile() )
                    {
                        FindConstants( ReadText( folder_entry.name().to!dstring() ) );
                    }
                }
            }
        }
    }

    // -- OPERATIONS

    void Execute(
        )
    {
        if ( MirrorOptionIsEnabled )
        {
            MirrorFiles();
        }

        if ( ExtractOptionIsEnabled )
        {
            ExtractDefinitions();
        }

        if ( PickOptionIsEnabled )
        {
            PickDefinitions();
        }

        if ( CsOptionIsEnabled
             || DOptionIsEnabled
             || DartOptionIsEnabled )
        {
            WriteFiles();
        }

        if ( FindOptionIsEnabled )
        {
            FindConstants();
        }
    }
}

// -- VARIABLES

bool
    BaseOptionIsEnabled,
    CheckOptionIsEnabled,
    CsOptionIsEnabled,
    DOptionIsEnabled,
    DartOptionIsEnabled,
    ExtractOptionIsEnabled,
    FindOptionIsEnabled,
    FloatOptionIsEnabled,
    PreviewOptionIsEnabled,
    PickOptionIsEnabled,
    MirrorOptionIsEnabled,
    UpperCaseOptionIsEnabled;
dstring
    BaseNamespace,
    Namespace,
    OutputFolderPath,
    SourceLanguageName;
dstring[]
    FolderPathArray,
    FilePathArray;

// -- FUNCTIONS

void Warn(
    dstring message
    )
{
    writeln( "*** WARNING : ", message );
}

// ~~

void PrintError(
    dstring message
    )
{
    writeln( "*** ERROR : ", message );
}

// ~~

void Abort(
    dstring message
    )
{
    PrintError( message );

    exit( -1 );
}

// ~~

void Abort(
    dstring message,
    FileException file_exception
    )
{
    PrintError( message );
    PrintError( file_exception.msg.to!dstring() );

    exit( -1 );
}

// ~~

bool IsBlankCharacter(
    dchar character
    )
{
    return
        character == ' '
        || character == '\t'
        || character == '\r'
        || character == '\n';
}

// ~~

long GetIndentationSpaceCount(
    dstring text
    )
{
    long
        indentation_space_count;

    indentation_space_count = 0;

    while ( indentation_space_count < text.length
            && text[ indentation_space_count ] == ' ' )
    {
        ++indentation_space_count;
    }

    return indentation_space_count;
}

// ~~

void WriteText(
    dstring file_path,
    dstring file_text
    )
{
    writeln( "Writing file : ", file_path );

    if ( PreviewOptionIsEnabled )
    {
        writeln( file_text );
    }
    else
    {
        try
        {
            file_path.write( file_text.to!string() );
        }
        catch ( FileException file_exception )
        {
            Abort( "Can't write file : " ~ file_path, file_exception );
        }
    }
}

// ~~

dstring ReadText(
    dstring file_path
    )
{
    dstring
        file_text;

    writeln( "Reading file : ", file_path );

    try
    {
        file_text = file_path.readText().to!dstring();
    }
    catch ( FileException file_exception )
    {
        Abort( "Can't read file : " ~ file_path, file_exception );
    }

    return file_text;
}

// ~~

dstring[] ReadLineArray(
    dstring file_path
    )
{
    dstring
        file_text;
    dstring[]
        line_array;

    file_text = file_path.ReadText();
    line_array = file_text.replace( "\t", "    " ).replace( "\r", "" ).split( '\n' );

    foreach ( ref line; line_array )
    {
        line = line.stripRight();
    }

    return line_array;
}

// ~~

dstring GetExecutablePath(
    dstring file_name
    )
{
    return dirName( thisExePath() ).to!dstring() ~ "/" ~ file_name;
}

// ~~

dstring GetRealType(
    )
{
    if ( FloatOptionIsEnabled )
    {
        return "float";
    }
    else
    {
        return "double";
    }
}

// ~~

void main(
    string[] argument_array
    )
{
    dstring
        option;
    SCRIPT
        script;

    argument_array = argument_array[ 1 .. $ ];

    CsOptionIsEnabled = false;
    DOptionIsEnabled = false;
    DartOptionIsEnabled = false;
    BaseOptionIsEnabled = false;
    FloatOptionIsEnabled = false;
    BaseNamespace = "";
    Namespace = "";
    UpperCaseOptionIsEnabled = false;
    CheckOptionIsEnabled = false;
    PreviewOptionIsEnabled = false;
    FindOptionIsEnabled = false;
    FolderPathArray = null;
    MirrorOptionIsEnabled = false;
    ExtractOptionIsEnabled = false;
    SourceLanguageName = "";
    PickOptionIsEnabled = false;
    FilePathArray = null;
    OutputFolderPath = "";

    while ( argument_array.length >= 1
            && argument_array[ 0 ].startsWith( "--" ) )
    {
        option = argument_array[ 0 ].to!dstring();

        argument_array = argument_array[ 1 .. $ ];

        if ( option == "--cs"
                  && !DOptionIsEnabled
                  && !DartOptionIsEnabled )
        {
            CsOptionIsEnabled = true;
        }
        else if ( option == "--d"
                  && !CsOptionIsEnabled
                  && !DartOptionIsEnabled )
        {
            DOptionIsEnabled = true;
        }
        else if ( option == "--dart"
                  && !CsOptionIsEnabled
                  && !DOptionIsEnabled )
        {
            DartOptionIsEnabled = true;
        }
        else if ( option == "--base" )
        {
            BaseOptionIsEnabled = true;
        }
        else if ( option == "--float" )
        {
            FloatOptionIsEnabled = true;
        }
        else if ( option == "--namespace"
                  && argument_array.length >= 1 )
        {
            Namespace = argument_array[ 0 ].to!dstring();

            argument_array = argument_array[ 1 .. $ ];
        }
        else if ( option == "--uppercase" )
        {
            UpperCaseOptionIsEnabled = true;
        }
        else if ( option == "--check" )
        {
            CheckOptionIsEnabled = true;
        }
        else if ( option == "--preview" )
        {
            PreviewOptionIsEnabled = true;
        }
        else if ( option == "--find"
             && argument_array.length >= 1 )
        {
            FindOptionIsEnabled = true;
            FolderPathArray ~= argument_array[ 0 ].to!dstring();

            argument_array = argument_array[ 1 .. $ ];
        }
        else if ( option == "--mirror"
             && argument_array.length >= 1 )
        {
            MirrorOptionIsEnabled = true;
            SourceLanguageName = argument_array[ 0 ].to!dstring();

            argument_array = argument_array[ 1 .. $ ];
        }
        else if ( option == "--extract" )
        {
            ExtractOptionIsEnabled = true;
        }
        else if ( option == "--pick" )
        {
            PickOptionIsEnabled = true;
        }
        else
        {
            Abort( "Invalid option : " ~ option );
        }
    }

    if ( DartOptionIsEnabled )
    {
        FloatOptionIsEnabled = false;
    }

    if ( Namespace.length == 0 )
    {
        if ( CsOptionIsEnabled )
        {
            Namespace = "LINGUI";
        }
        else if ( DOptionIsEnabled || DartOptionIsEnabled )
        {
            Namespace = "lingui";
        }
    }

    if ( BaseOptionIsEnabled )
    {
        BaseNamespace = Namespace;
    }
    else if ( CsOptionIsEnabled )
    {
        BaseNamespace = "LINGUI";
    }
    else if ( DOptionIsEnabled || DartOptionIsEnabled )
    {
        BaseNamespace = "lingui";
    }

    while ( argument_array.length >= 1
            && argument_array[ 0 ].endsWith( ".lg" ) )
    {
        FilePathArray ~= argument_array[ 0 ].to!dstring();

        argument_array = argument_array[ 1 .. $ ];
    }

    if ( argument_array.length >= 1
         && argument_array[ 0 ].endsWith( "/" ) )
    {
        OutputFolderPath = argument_array[ 0 ].to!dstring();

        argument_array = argument_array[ 1 .. $ ];
    }

    if ( argument_array.length == 0
         && FilePathArray.length > 0
         && ( ( CsOptionIsEnabled || DOptionIsEnabled || DartOptionIsEnabled )
                && OutputFolderPath.length > 0 )
              || MirrorOptionIsEnabled
              || ExtractOptionIsEnabled
              || PickOptionIsEnabled
              || FindOptionIsEnabled )
    {
        script = new SCRIPT();
        script.Execute();
    }
    else
    {
        writeln( "Usage : lingui [options] language.lg first_language.lg second_language.lg ... OUTPUT_FOLDER/" );
        writeln( "Options :" );
        writeln( "    --cs" );
        writeln( "    --d" );
        writeln( "    --dart" );
        writeln( "    --base" );
        writeln( "    --float" );
        writeln( "    --namespace LINGUI" );
        writeln( "    --uppercase" );
        writeln( "    --check" );
        writeln( "    --preview" );
        writeln( "    --find CODE_FOLDER/" );
        writeln( "    --mirror ENGLISH_LANGUAGE" );
        writeln( "    --extract" );
        writeln( "    --pick" );
        writeln( "Examples :" );
        writeln( "    lingui --dart --check --base --namespace game language.lg english_language.lg german_language.lg DART/" );
        writeln( "    lingui --cs --float language.lg english_language.lg german_language.lg CS/" );
        writeln( "    lingui --find CODE_FOLDER/ language.lg english_language.lg french_language.lg spanish_language.lg" );
        writeln( "    lingui --mirror ENGLISH_LANGUAGE --preview language.lg english_language.lg french_language.lg spanish_language.lg" );
        writeln( "    lingui --extract --preview language.lg english_language.lg french_language.lg spanish_language.lg" );
        writeln( "    lingui --pick japanese_language.lg" );

        Abort( "Invalid arguments : " ~ argument_array.to!dstring() );
    }
}
