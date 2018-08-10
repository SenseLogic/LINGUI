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
    string
        Text;
}

// ~~

enum CODE_LANGUAGE
{
    D,
    Cs
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

    string GetText(
        )
    {
        string
            line_text,
            text;

        foreach ( line; LineArray )
        {
            line_text = stripRight( line.Text );

            if ( line_text.length > 0 )
            {
                text ~= " ".replicate( line.IndentationSpaceCount ) ~ line.Text;
            }

            text ~= '\n';
        }

        return text;
    }

    // -- OPERATIONS

    void AddLine(
        string text,
        bool indentation_is_applied = true
        )
    {
        string
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
        string text
        )
    {
        LineArray[ $ - 1 ].Text ~= text;
    }

    // ~~

    void AddFile(
        string file_path
        )
    {
        string[]
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

    string
        FilePath;
    long
        LineIndex,
        IndentationSpaceCount;
    string
        Text;
    long
        Level;
    RULE
        SuperRule;
    RULE[]
        SubRuleArray;
    RULE_TYPE
        Type;
    string[]
        TokenArray;
    string
        LanguageName;
    bool
        IsBaseLanguage;
    RULE
        LanguageRule,
        BaseLanguageRule;
    string
        FunctionName;
    string[]
        ParameterNameArray,
        VariableNameArray;
    bool
        IsStringFunction,
        IsBaseFunction;
    RULE
        FunctionRule;

    // -- INQUIRIES

    void Abort(
        string message
        )
    {
        writeln( FilePath, "(", ( LineIndex + 1 ), ") : ",Text );
        writeln( "*** ERROR : ", message );

        exit( -1 );
    }

    // ~~

    string GetClassName(
        )
    {
        return LanguageName.toUpper() ~ "_LANGUAGE";
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
        string text
        )
    {
        return
            text.length > 0
            && text[ 0 ] >= 'A'
            && text[ 0 ] <= 'Z';
    }

    // ~~

    bool IsNumber(
        string text
        )
    {
        return
            text.length > 0
            && ( ( text[ 0 ] >= '0'
                   && text[ 0 ] <= '9' )
                 || text[ 0 ] == '-' );
    }

    // ~~

    string GetNumberCode(
        string text
        )
    {
        if ( text.indexOf( '.' ) >= 0 )
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
        string text
        )
    {
        return
            IsNumber( text )
            && text.indexOf( '*' ) >= 0;
    }

    // ~~

    string GetQuantityCode(
        string text
        )
    {
        long
            asterisk_character_index;
        string
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
        string text
        )
    {
        return
            text.length > 0
            && "$*^#%:.@°&".indexOf( text[ 0 ] ) >= 0;
    }

    // ~~

    bool IsVariableName(
        string text
        )
    {
        return
            text.length > 0
            && text[ 0 ] >= 'a'
            && text[ 0 ] <= 'z';
    }

    // ~~

    bool IsVariable(
        string text
        )
    {
        return
            IsVariableName( text )
            || ( HasVariablePrefix( text )
                 && IsVariableName( text[ 1 .. $ ] ) );
    }

    // ~~

    string GetVariableName(
        string text
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
        string variable_name
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

    string GetVariableCode(
        string text
        )
    {
        char
            first_character;
        string
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
            return variable_name ~ "_translation.Get" ~ LanguageRule.TokenArray[ 0 ] ~ "CardinalPlurality()";
        }
        else if ( first_character == '°' )
        {
            return variable_name ~ "_translation.Get" ~ LanguageRule.TokenArray[ 0 ] ~ "OrdinalPlurality()";
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

    string GetCode(
        string[] code_token_array
        )
    {
        string
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

    string GetExpressionCode(
        string[] token_array
        )
    {
        long
            token_index;
        string
            code_token,
            token;
        string[]
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
                      && CsOptionIsEnabled )
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

    string GetExpressionCode(
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
        string
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

        if ( IsStringFunction )
        {
            code.AddText( "string " );
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
            else if ( DOptionIsEnabled )
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
        if ( DOptionIsEnabled )
        {
            code.AddLine( "module lingui." ~ GetClassName().toLower() ~ ";" );
            code.AddLine( "" );
            code.AddLine( "// -- IMPORTS" );
            code.AddLine( "" );
            code.AddLine( "import lingui.genre;" );
            code.AddLine( "import lingui.plurality;" );

            if ( IsBaseLanguage )
            {
                code.AddLine( "import lingui.language;" );
            }
            else
            {
                code.AddLine( "import lingui." ~ BaseLanguageRule.GetClassName().toLower() ~ ";" );
            }

            code.AddLine( "import lingui.translation;" );
            code.AddLine( "" );
        }

        code.AddLine( "// -- TYPES" );
        code.AddLine( "" );

        if ( CsOptionIsEnabled )
        {
            code.AddLine( "public class " ~ GetClassName() ~ " : " );
        }
        else if ( DOptionIsEnabled )
        {
            code.AddLine( "class " ~ GetClassName() ~ " : " );
        }

        if ( IsBaseLanguage )
        {
            code.AddText( "LANGUAGE" );
        }
        else
        {
            code.AddText( BaseLanguageRule.GetClassName() );
        }

        code.AddLine( "{" );

        if ( !IsBaseLanguage )
        {
            code.AddLine( "// -- CONSTRUCTORS" );
            code.AddLine( "" );

            if ( CsOptionIsEnabled )
            {
                code.AddLine( "public " ~ GetClassName() ~ "(" );
            }
            else if ( DOptionIsEnabled )
            {
                code.AddLine( "this(" );
            }

            code.AddLine( "    )" );
            code.AddLine( "{" );
            code.AddLine( "Name = \"" ~ LanguageName ~ "\";" );
            code.AddLine( "}" );
            code.AddLine( "" );
        }

        code.AddLine( "// -- INQUIRIES" );
        code.AddLine( "" );

        foreach ( sub_rule; SubRuleArray )
        {
            sub_rule.AddFunctionCode( code );
        }

        code.AddLine( "}" );
    }

    // ~~

    void WriteFile(
        string output_folder_path
        )
    {
        string
            output_file_path;
        CODE
            code;

        code = new CODE();

        AddLanguageCode( code );

        output_file_path = output_folder_path;

        if ( UpperCaseOptionIsEnabled )
        {
            output_file_path ~= GetClassName();
        }
        else
        {
            output_file_path ~= GetClassName().toLower();
        }

        if ( CsOptionIsEnabled )
        {
            output_file_path ~= ".cs";
        }
        else if ( DOptionIsEnabled )
        {
            output_file_path ~= ".d";
        }

        if ( VerboseOptionIsEnabled )
        {
            writeln( "Writing file : ", output_file_path );
        }

        output_file_path.write( code.GetText() );
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
        char
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
        string
            base_langage_name;

        Type = RULE_TYPE.Language;
        LanguageName = TokenArray[ 0 ];

        if ( TokenArray.length == 1 )
        {
            IsBaseLanguage = true;
        }
        else if ( TokenArray.length == 3
             && TokenArray[ 1 ] == ":" )
        {
            IsBaseLanguage = false;

            base_langage_name = TokenArray[ 2 ];

            foreach ( language_rule; SuperRule.SubRuleArray )
            {
                if ( language_rule.LanguageName == base_langage_name )
                {
                    BaseLanguageRule = language_rule;

                    break;
                }
            }

            if ( BaseLanguageRule is null )
            {
                Abort( "Invalid base language : " ~ base_langage_name );
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
        string
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
        string
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
        string script_file_path
        )
    {
        string
            rule_text;
        string[]
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

    void WriteFiles(
        string output_folder_path
        )
    {
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
    }

    // -- OPERATIONS

    void ExecuteScript(
        string script_file_path,
        string output_folder_path
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
    CsOptionIsEnabled,
    DOptionIsEnabled,
    UpperCaseOptionIsEnabled,
    VerboseOptionIsEnabled;

// -- FUNCTIONS

void Abort(
    string message
    )
{
    writeln( "*** ERROR : ", message );

    exit( -1 );
}

// ~~

long GetIndentationSpaceCount(
    string text
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

string[] ReadLineArray(
    string file_path
    )
{
    string
        file_text;

    if ( VerboseOptionIsEnabled )
    {
        writeln( "Reading file : ", file_path );
    }

    file_text = file_path.readText();

    return file_text.replace( "\t", "    " ).replace( "\r", "" ).split( '\n' );
}

// ~~

string GetExecutablePath(
    string file_name
    )
{
    return dirName( thisExePath() ) ~ "/" ~ file_name;
}

// ~~

void main(
    string[] argument_array
    )
{
    string
        option;
    SCRIPT
        script;

    argument_array = argument_array[ 1 .. $ ];

    CsOptionIsEnabled = false;
    DOptionIsEnabled = false;
    UpperCaseOptionIsEnabled = false;
    VerboseOptionIsEnabled = false;

    while ( argument_array.length >= 1
            && argument_array[ 0 ].startsWith( "--" ) )
    {
        option = argument_array[ 0 ];

        argument_array = argument_array[ 1 .. $ ];

        if ( option == "--cs"
             && !DOptionIsEnabled )
        {
            CsOptionIsEnabled = true;
        }
        else if ( option == "--d"
                  && !CsOptionIsEnabled )
        {
            DOptionIsEnabled = true;
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

    if ( argument_array.length == 2 )
    {
        script = new SCRIPT();
        script.ExecuteScript( argument_array[ 0 ], argument_array[ 1 ] );
    }
    else
    {
        writeln( "Usage : lingui [options] script_file.lingui OUTPUT_FOLDER/" );
        writeln( "Options :" );
        writeln( "    --cs" );
        writeln( "    --d" );
        writeln( "    --uppercase" );
        writeln( "    --verbose" );
        writeln( "Examples :" );
        writeln( "    lingui --cs --verbose test.lingui CS/" );
        writeln( "    lingui --d --verbose test.lingui D/" );

        Abort( "Invalid arguments : " ~ argument_array.to!string() );
    }
}
