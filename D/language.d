module lingui.language;

// -- IMPORTS

import lingui.genre;
import lingui.translation;
import std.conv : to;
import std.string : endsWith, indexOf, startsWith;

// -- TYPES

class LANGUAGE
{
    // -- ATTRIBUTES

    string
        Name;
    TRANSLATION[ string ]
        TranslationDictionary;
    char
        DecimalSeparator;

    // -- INQUIRIES

    bool IsLowerCaseCharacter(
        dchar character
        )
    {
        return
            ( character >= 'a' && character <= 'z' )
            || character == 'à'
            || character == 'â'
            || character == 'é'
            || character == 'è'
            || character == 'ê'
            || character == 'ë'
            || character == 'î'
            || character == 'ï'
            || character == 'ô'
            || character == 'ö'
            || character == 'û'
            || character == 'ü'
            || character == 'ç'
            || character == 'ñ';
    }

    // ~~

    bool IsUpperCaseCharacter(
        dchar character
        )
    {
        return
            ( character >= 'A' && character <= 'Z' )
            || character == 'À'
            || character == 'Â'
            || character == 'É'
            || character == 'È'
            || character == 'Ê'
            || character == 'Ë'
            || character == 'Î'
            || character == 'Ï'
            || character == 'Ô'
            || character == 'Ö'
            || character == 'Û'
            || character == 'Ü'
            || character == 'Ñ';
    }

    // ~~

    dchar GetLowerCaseCharacter(
        dchar character
        )
    {
        if ( character >= 'A' && character <= 'Z' )
        {
            return character + 32;
        }
        else
        {
            switch ( character )
            {
                case 'À' : return 'à';
                case 'Â' : return 'â';
                case 'É' : return 'é';
                case 'È' : return 'è';
                case 'Ê' : return 'ê';
                case 'Ë' : return 'ë';
                case 'Î' : return 'î';
                case 'Ï' : return 'ï';
                case 'Ô' : return 'ô';
                case 'Ö' : return 'ö';
                case 'Û' : return 'û';
                case 'Ü' : return 'ü';
                case 'Ñ' : return 'ñ';

                default : return character;
            }
        }
    }


    // ~~

    dchar GetUpperCaseCharacter(
        dchar character
        )
    {
        if ( character >= 'a' && character <= 'z' )
        {
            return character - 32;
        }
        else
        {
            switch ( character )
            {
                case 'à' : return 'À';
                case 'â' : return 'Â';
                case 'é' : return 'É';
                case 'è' : return 'È';
                case 'ê' : return 'Ê';
                case 'ë' : return 'Ë';
                case 'î' : return 'Î';
                case 'ï' : return 'Ï';
                case 'ô' : return 'Ô';
                case 'ö' : return 'Ö';
                case 'û' : return 'Û';
                case 'ü' : return 'Ü';
                case 'ç' : return 'C';
                case 'ñ' : return 'Ñ';

                default : return character;
            }
        }
    }

    // ~~

    string GetLowerCase(
        string text
        )
    {
        string
            lower_case_text;

        foreach ( dchar character; text )
        {
            lower_case_text ~= GetLowerCaseCharacter( character );
        }

        return lower_case_text;
    }

    // ~~

    string GetUpperCase(
        string text
        )
    {
        string
            upper_case_text;

        foreach ( dchar character; text )
        {
            upper_case_text ~= GetUpperCaseCharacter( character );
        }

        return upper_case_text;
    }

    // ~~

    string GetTitleCase(
        string text
        )
    {
        dchar
            prior_character;
        string
            title_case_text;

        prior_character = ' ';

        foreach ( dchar character; text )
        {
            if ( prior_character == ' '
                 && IsLowerCaseCharacter( character ) )
            {
                title_case_text ~= GetUpperCaseCharacter( character );
            }
            else
            {
                title_case_text ~= character;
            }

            prior_character = character;
        }

        return title_case_text;
    }

    // ~~

    string GetSentenceCase(
        string text
        )
    {
        if ( text.length > 0
             && !IsUpperCaseCharacter( text[ 0 ] ) )
        {
            return GetUpperCase( text[ 0 .. 1 ] ) ~ text[ 1 .. $ ];
        }
        else
        {
            return text;
        }
    }

    // ~~

    bool HasPrefix(
        string text,
        string prefix
        )
    {
        return text.startsWith( prefix );
    }

    // ~~

    bool HasSuffix(
        string text,
        string suffix
        )
    {
        return text.endsWith( suffix );
    }

    // ~~

    bool HasFirstCharacter(
        string text,
        string first_characters
        )
    {
        return
            text.length > 0
            && first_characters.indexOf( text[ 0 ] ) >= 0;
    }

    // ~~

    TRANSLATION MakeTranslation(
        string text,
        string quantity,
        GENRE genre = GENRE.Neutral
        )
    {
        return TRANSLATION( text, quantity, genre );
    }

    // ~~

    TRANSLATION MakeTranslation(
        string text,
        GENRE genre = GENRE.Neutral
        )
    {
        return TRANSLATION( text, genre );
    }
    // ~~

    TRANSLATION MakeTranslation(
        int integer_quantity,
        GENRE genre = GENRE.Neutral
        )
    {
        return TRANSLATION( integer_quantity, genre );
    }

    // ~~

    bool HasTranslation(
        string key
        )
    {
        return ( key in TranslationDictionary ) !is null;
    }

    // ~~

    TRANSLATION GetTranslation(
        string key
        )
    {
        return TranslationDictionary[ key ];
    }

    // ~~

    TRANSLATION GetLowerCase(
        TRANSLATION translation
        )
    {
        translation.Text = GetLowerCase( translation.Text );

        return translation;
    }

    // ~~

    TRANSLATION GetUpperCase(
        TRANSLATION translation
        )
    {
        translation.Text = GetUpperCase( translation.Text );

        return translation;
    }

    // ~~

    TRANSLATION GetTitleCase(
        TRANSLATION translation
        )
    {
        translation.Text = GetTitleCase( translation.Text );

        return translation;
    }

    // ~~

    TRANSLATION GetSentenceCase(
        TRANSLATION translation
        )
    {
        translation.Text = GetSentenceCase( translation.Text );

        return translation;
    }

    // ~~

    bool HasFirstCharacter(
        TRANSLATION translation,
        string first_characters
        )
    {
        return HasFirstCharacter( translation.Text, first_characters );
    }

    // ~~

    bool HasPrefix(
        TRANSLATION translation,
        string prefix
        )
    {
        return HasPrefix( translation.Text, prefix );
    }

    // ~~

    bool HasSuffix(
        TRANSLATION translation,
        string suffix
        )
    {
        return HasSuffix( translation.Text, suffix );
    }

    // ~~

    int GetInteger(
        float real_
        )
    {
        return real_.to!int();
    }

    // ~~

    float GetReal(
        int integer
        )
    {
        return integer.to!float();
    }

    // ~~

    string GetText(
        int integer
        )
    {
        return integer.to!string();
    }

    // ~~

    string GetText(
        float real_,
        int minimum_fractional_digit_count = 1,
        int maximum_fractional_digit_count = 20,
        char decimal_separator = 0
        )
    {
        long
            decimal_separator_index,
            fractional_digit_count;
        string
            text;

        text = real_.to!string();

        if ( decimal_separator == 0 )
        {
            decimal_separator = DecimalSeparator;
        }

        decimal_separator_index = text.indexOf( '.' );

        if ( decimal_separator_index < 0 )
        {
            text ~= decimal_separator;
            decimal_separator_index = text.length - 1;
        }

        fractional_digit_count = text.length - decimal_separator_index - 1;

        if ( fractional_digit_count < minimum_fractional_digit_count )
        {
            text ~= "00000000000000000000"[ 0 .. minimum_fractional_digit_count - fractional_digit_count ];
        }
        else if ( fractional_digit_count > maximum_fractional_digit_count )
        {
            text = text[ 0 .. decimal_separator_index + 1 + maximum_fractional_digit_count ];
        }

        if ( text[ decimal_separator_index ] != decimal_separator )
        {
            text = text[ 0 .. decimal_separator_index ] ~ decimal_separator ~ text[ decimal_separator_index + 1 .. $ ];
        }

        if ( minimum_fractional_digit_count == 0
             && fractional_digit_count == 0 )
        {
            text = text[ 0 .. $ - 1 ];
        }

        return text;
    }
}
