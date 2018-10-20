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
import std.array : replicate;
import std.conv : to;
import std.file : readText, thisExePath, write;
import std.path : dirName;
import std.stdio : writeln;
import std.string : endsWith, indexOf, replace, startsWith, split, strip, stripRight, toLower, toUpper;

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
             && ( ( text.startsWith( "if " )
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
    If,
    Elseif,
    Else,
    Assignment,
    Call,
    Quantity,
    Variable,
    Text
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
        IsStringFunction,
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
        if ( ( CsOptionIsEnabled || DOptionIsEnabled )
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
            && "$*^#%:.@°&".indexOf( text[ 0 ] ) >= 0;
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

    void CheckVariableName(
        dstring variable_name
        )
    {
        RULE
            function_rule;

        foreach ( function_parameter_name; FunctionRule.ParameterNameArray )
        {
            if ( variable_name == function_parameter_name )
            {
                return;
            }
        }

        foreach ( function_variable_name; FunctionRule.VariableNameArray )
        {
            if ( variable_name == function_variable_name )
            {
                return;
            }
        }

        Abort( "Invalid variable : " ~ variable_name );
    }

    // ~~

    dstring GetVariableCode(
        dstring text
        )
    {
        dchar
            first_character;
        dstring
            variable_name;

        first_character = text[ 0 ];
        variable_name = GetVariableName( text );

        CheckVariableName( variable_name );

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
        else if ( first_character == ':' )
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

            return "";
        }
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

    void AddVarCode(
        CODE code
        )
    {
        code.AddLine( "TRANSLATION" );

        foreach ( variable_name_index, variable_name; VariableNameArray )
        {
            code.AddLine( "    " ~ variable_name ~ "_translation" );

            if ( CsOptionIsEnabled )
            {
                code.AddText( " = new TRANSLATION()" );
            }
            else if ( DartOptionIsEnabled )
            {
                code.AddText( " = TRANSLATION()" );
            }

            if ( variable_name_index + 1 < VariableNameArray.length )
            {
                code.AddText( "," );
            }
            else
            {
                code.AddText( ";" );
            }
        }

        code.AddLine( "" );
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
                code.AddLine( variable_name ~ "_translation = " ~ GetExpressionCode( 2 ) ~ ";" );
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
        if ( Type == RULE_TYPE.If )
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
            code.AddLine( "else" );
            AddStatementBlockCode( code );
        }
        else if ( Type == RULE_TYPE.Assignment )
        {
            AddAssignmentCode( code );
        }
        else if ( Type != RULE_TYPE.Var )
        {
            code.AddLine( "result_translation.AddText( " ~ GetExpressionCode( 0 ) ~ " );" );
        }
    }

    // ~~

    void AddFunctionCode(
        CODE code
        )
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

        if ( IsStringFunction )
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
            code.AddLine( "    TRANSLATION " ~ parameter_name ~ "_translation" );

            if ( parameter_index + 1 < ParameterNameArray.length )
            {
                code.AddText( "," );
            }
        }

        code.AddLine( "    )" );
        code.AddLine( "{" );

        if ( SubRuleArray.length == 0 )
        {
            if ( IsStringFunction )
            {
                code.AddLine( "return \"\";" );
            }
            else
            {
                code.AddLine( "return TRANSLATION.Null;" );
            }
        }
        else if ( SubRuleArray.length == 1
                  && SubRuleArray[ 0 ].Type == RULE_TYPE.Text )
        {
            if ( IsStringFunction )
            {
                code.AddLine( "return " ~ SubRuleArray[ 0 ].Text ~ ";" );
            }
            else if ( CsOptionIsEnabled )
            {
                code.AddLine( "return new TRANSLATION( " ~ SubRuleArray[ 0 ].Text ~ " );" );
            }
            else if ( DOptionIsEnabled || DartOptionIsEnabled )
            {
                code.AddLine( "return TRANSLATION( " ~ SubRuleArray[ 0 ].Text ~ " );" );
            }
        }
        else if ( SubRuleArray.length == 1
                  && ( SubRuleArray[ 0 ].Type == RULE_TYPE.Call
                       || ( SubRuleArray[ 0 ].Type == RULE_TYPE.Quantity
                            && !IsStringFunction ) ) )
        {
            code.AddLine( "return " ~ SubRuleArray[ 0 ].GetExpressionCode( 0 ) ~ ";" );
        }
        else
        {
            AddVarCode( code );

            foreach ( sub_rule; SubRuleArray )
            {
                sub_rule.AddStatementCode( code );
            }

            code.AddLine( "" );

            if ( IsStringFunction )
            {
                code.AddLine( "return result_translation.Text;" );
            }
            else
            {
                code.AddLine( "return result_translation;" );
            }
        }

        code.AddLine( "}" );

        if ( !IsLastSubRule() )
        {
            code.AddLine( "" );
            code.AddLine( "// ~~" );
            code.AddLine( "" );
        }
    }

    // ~~

    void AddLanguageCode(
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
            code.AddLine( "" );
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

            code.AddLine( "" );
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
            code.AddLine( "" );
        }

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

        if ( !IsBaseLanguage )
        {
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
            code.AddLine( "{" );
            code.AddLine( "Name = \"" ~ LanguageName ~ "\";" );
            code.AddLine( "DotCharacter = '"d ~ GetDotCharacter() ~ "';" );
            code.AddLine( "}" );
            code.AddLine( "" );
        }

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
            sub_rule.AddFunctionCode( code );
        }

        code.AddLine( "}" );

        if ( CsOptionIsEnabled )
        {
            code.AddLine( "}" );
        }
    }

    // ~~

    void WriteFile(
        dstring output_folder_path
        )
    {
        dstring
            output_file_path;
        CODE
            code;

        code = new CODE();

        AddLanguageCode( code );

        output_file_path = output_folder_path;

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

        if ( VerboseOptionIsEnabled )
        {
            writeln( "Writing file : ", output_file_path );
        }

        output_file_path.write( code.GetText().to!string() );
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
            it_is_in_string_literal;
        dchar
            character,
            delimiter_character;
        long
            character_index;

        it_is_in_string_literal = false;

        TokenArray.length = 0;
        TokenArray ~= "";

        for ( character_index = 0;
              character_index < Text.length;
              ++character_index )
        {
            character = Text[ character_index ];

            if ( it_is_in_string_literal )
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
                    it_is_in_string_literal = false;
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

                    it_is_in_string_literal = true;
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

        if ( first_token.startsWith( ":" ) )
        {
            IsStringFunction = false;

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
                    if ( base_function_rule.IsStringFunction != IsStringFunction )
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
        VariableNameArray ~= "result";
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
        else if ( IsFunction( first_token ) )
        {
            Type = RULE_TYPE.Call;
        }
        else if ( IsQuantity( first_token ) )
        {
            Type = RULE_TYPE.Quantity;
        }
        else if ( IsVariable( first_token ) )
        {
            Type = RULE_TYPE.Variable;
        }
        else if ( first_token.startsWith( "\"" ) )
        {
            Type = RULE_TYPE.Text;
        }
        else
        {
            Abort( "Invalid statement : " ~ Text );
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

        if ( Type == RULE_TYPE.Var )
        {
            FunctionRule.VariableNameArray ~= TokenArray[ 1 .. $ ];
        }
    }
}

// ~~

class SCRIPT
{
    // -- ATTRIBUTES

    RULE
        Rule;

    // -- OPERATIONS

    void ReadFile(
        dstring script_file_path
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
        line_array = script_file_path.ReadLineArray();

        foreach ( line_index, line; line_array )
        {
            if ( !line.startsWith( "#" ) )
            {
                rule_text = line.strip();

                if ( rule_text.length > 0 )
                {
                    rule = new RULE();
                    rule.FilePath = script_file_path;
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

        file_text = input_file_path.readText().to!dstring();

        if ( CsOptionIsEnabled )
        {
            file_text = file_text.replace( "LINGUI", Namespace );
        }
        else if ( DOptionIsEnabled || DartOptionIsEnabled )
        {
            file_text = file_text.replace( "lingui", Namespace );
        }

        if ( VerboseOptionIsEnabled )
        {
            writeln( "Writing file : ", output_file_path );
        }

        output_file_path.write( file_text.to!string() );
    }

    // ~~

    void WriteFiles(
        dstring output_folder_path
        )
    {
        dstring
            input_folder_path;

        if ( Rule.SubRuleArray.length > 0 )
        {
            foreach( language_rule; Rule.SubRuleArray )
            {
                language_rule.WriteFile( output_folder_path );
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

            WriteBaseFile( input_folder_path, output_folder_path, "base_language" );
            WriteBaseFile( input_folder_path, output_folder_path, "genre" );
            WriteBaseFile( input_folder_path, output_folder_path, "plurality" );
            WriteBaseFile( input_folder_path, output_folder_path, "translation" );
        }
    }

    // -- OPERATIONS

    void ExecuteScript(
        dstring script_file_path,
        dstring output_folder_path
        )
    {
        SCRIPT
            script;

        script = new SCRIPT();
        script.ReadFile( script_file_path );
        script.WriteFiles( output_folder_path );
    }
}

// -- VARIABLES

bool
    BaseOptionIsEnabled,
    CsOptionIsEnabled,
    DOptionIsEnabled,
    DartOptionIsEnabled,
    UpperCaseOptionIsEnabled,
    VerboseOptionIsEnabled;
dstring
    BaseNamespace,
    Namespace;

// -- FUNCTIONS

void Abort(
    dstring message
    )
{
    writeln( "*** ERROR : ", message );

    exit( -1 );
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

dstring[] ReadLineArray(
    dstring file_path
    )
{
    dstring
        file_text;

    if ( VerboseOptionIsEnabled )
    {
        writeln( "Reading file : ", file_path );
    }

    file_text = file_path.readText().to!dstring();

    return file_text.replace( "\t", "    " ).replace( "\r", "" ).split( '\n' );
}

// ~~

dstring GetExecutablePath(
    dstring file_name
    )
{
    return dirName( thisExePath() ).to!dstring() ~ "/" ~ file_name;
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
    BaseNamespace = "";
    Namespace = "";
    UpperCaseOptionIsEnabled = false;
    VerboseOptionIsEnabled = false;

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
        else if ( option == "--verbose" )
        {
            VerboseOptionIsEnabled = true;
        }
        else
        {
            Abort( "Invalid option : " ~ option );
        }
    }

    if ( Namespace == "" )
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

    if ( argument_array.length == 2
         && ( CsOptionIsEnabled
              || DOptionIsEnabled
              || DartOptionIsEnabled ) )
    {
        script = new SCRIPT();
        script.ExecuteScript( argument_array[ 0 ].to!dstring(), argument_array[ 1 ].to!dstring() );
    }
    else
    {
        writeln( "Usage : lingui [options] script_file.lingui OUTPUT_FOLDER/" );
        writeln( "Options :" );
        writeln( "    --cs" );
        writeln( "    --d" );
        writeln( "    --dart" );
        writeln( "    --base" );
        writeln( "    --namespace LINGUI" );
        writeln( "    --uppercase" );
        writeln( "    --verbose" );
        writeln( "Examples :" );
        writeln( "    lingui --cs --base --namespace GAME --verbose test.lingui CS/" );
        writeln( "    lingui --d --verbose test.lingui D/" );

        Abort( "Invalid arguments : " ~ argument_array.to!dstring() );
    }
}
