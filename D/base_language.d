module lingui.base_language;

// -- IMPORTS

import lingui.genre;
import lingui.plurality;
import lingui.translation;
import std.conv : to;
import std.format : format;
import std.string : endsWith, indexOf, startsWith;

// -- TYPES

class BASE_LANGUAGE
{
    // -- ATTRIBUTES

    dstring
        Name;
    TRANSLATION[ dstring ]
        TranslationMap;
    dchar
        DotCharacter;

    // -- CONSTRUCTORS

    this(
        )
    {
    }

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

    dstring GetLowerCase(
        dstring text
        )
    {
        dstring
            lower_case_text;

        foreach ( dchar character; text )
        {
            lower_case_text ~= GetLowerCaseCharacter( character );
        }

        return lower_case_text;
    }

    // ~~

    dstring GetUpperCase(
        dstring text
        )
    {
        dstring
            upper_case_text;

        foreach ( dchar character; text )
        {
            upper_case_text ~= GetUpperCaseCharacter( character );
        }

        return upper_case_text;
    }

    // ~~

    dstring GetTitleCase(
        dstring text
        )
    {
        dchar
            prior_character;
        dstring
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

    dstring GetSentenceCase(
        dstring text
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
        dstring text,
        dstring prefix
        )
    {
        return text.startsWith( prefix );
    }

    // ~~

    bool HasSuffix(
        dstring text,
        dstring suffix
        )
    {
        return text.endsWith( suffix );
    }

    // ~~

    bool HasFirstCharacter(
        dstring text,
        dstring first_characters
        )
    {
        return
            text.length > 0
            && first_characters.indexOf( text[ 0 ] ) >= 0;
    }

    // ~~

    TRANSLATION MakeTranslation(
        dstring text,
        dstring quantity,
        GENRE genre = GENRE.Neutral
        )
    {
        return TRANSLATION( text, quantity, genre );
    }

    // ~~

    TRANSLATION MakeTranslation(
        dstring text,
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
        dstring key
        )
    {
        return ( key in TranslationMap ) !is null;
    }

    // ~~

    TRANSLATION GetTranslation(
        dstring key
        )
    {
        return TranslationMap[ key ];
    }

    // ~~

    bool HasText(
        dstring key
        )
    {
        return ( key in TranslationMap ) !is null;
    }

    // ~~

    dstring GetText(
        dstring key
        )
    {
        return TranslationMap[ key ].Text;
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
        dstring first_characters
        )
    {
        return HasFirstCharacter( translation.Text, first_characters );
    }

    // ~~

    bool HasPrefix(
        TRANSLATION translation,
        dstring prefix
        )
    {
        return HasPrefix( translation.Text, prefix );
    }

    // ~~

    bool HasSuffix(
        TRANSLATION translation,
        dstring suffix
        )
    {
        return HasSuffix( translation.Text, suffix );
    }

    // ~~

    double GetIntegerReal(
        int integer
        )
    {
        return integer.to!double();
    }

    // ~~

    int GetRealInteger(
        double real_
        )
    {
        return real_.to!int();
    }

    // ~~

    bool GetTextBoolean(
        dstring text
        )
    {
        return text == "true";
    }

    // ~~

    int GetTextInteger(
        dstring text
        )
    {
        return text.to!int();
    }

    // ~~

    double GetTextReal(
        dstring text
        )
    {
        return text.to!double();
    }

    // ~~

    dstring GetBooleanText(
        bool boolean
        )
    {
        if ( boolean )
        {
            return "true";
        }
        else
        {
            return "false";
        }
    }

    // ~~

    dstring GetIntegerText(
        int integer,
        int minimum_digit_count = 1
        )
    {
        int
            digit_count;
        dstring
            text;

        text = integer.to!dstring();

        digit_count = text.length.to!int();

        if ( integer < 0 )
        {
            --digit_count;

            if ( digit_count < minimum_digit_count )
            {
                text = "-" ~ "0000000000000000000000000000000000000000"d[ 0 .. minimum_digit_count - digit_count ] ~ text[ 1 .. $ ];
            }
        }
        else
        {
            if ( digit_count < minimum_digit_count )
            {
                text = "0000000000000000000000000000000000000000"d[ 0 .. minimum_digit_count - digit_count ] ~ text;
            }
        }

        return text;
    }

    // ~~

    dstring GetRealText(
        double real_,
        int minimum_fractional_digit_count = 1,
        int maximum_fractional_digit_count = 12,
        dchar dot_character = 0
        )
    {
        long
            dot_character_index,
            fractional_digit_count;
        dstring
            text;

        text = format( "%.*f", maximum_fractional_digit_count, real_ ).to!dstring();

        if ( dot_character == 0 )
        {
            dot_character = DotCharacter;
        }

        dot_character_index = text.indexOf( '.' );

        if ( dot_character_index < 0 )
        {
            dot_character_index = text.indexOf( ',' );
        }

        if ( dot_character_index < 0 )
        {
            dot_character_index = text.length;

            text ~= dot_character;
            text ~= '0';
        }

        fractional_digit_count = text.length - dot_character_index - 1;

        if ( fractional_digit_count < minimum_fractional_digit_count )
        {
            text ~= "0000000000000000000000000000000000000000"d[ 0 .. minimum_fractional_digit_count - fractional_digit_count ];

            fractional_digit_count = minimum_fractional_digit_count;
        }
        else if ( fractional_digit_count > maximum_fractional_digit_count )
        {
            text = text[ 0 .. dot_character_index + 1 + maximum_fractional_digit_count ];

            fractional_digit_count = maximum_fractional_digit_count;
        }

        if ( minimum_fractional_digit_count < maximum_fractional_digit_count )
        {
            while ( fractional_digit_count > minimum_fractional_digit_count
                    && text[ dot_character_index + fractional_digit_count ] == '0' )
            {
                --fractional_digit_count;
            }

            text = text[ 0 .. dot_character_index + fractional_digit_count + 1 ];
        }

        if ( fractional_digit_count == 0 )
        {
            return text[ 0 .. dot_character_index ];
        }
        else if ( text[ dot_character_index ] != dot_character )
        {
            return text[ 0 .. dot_character_index ] ~ dot_character ~ text[ dot_character_index + 1 .. $ ];
        }
        else
        {
            return text;
        }
    }

    // ~~

    dstring GetGenreText(
        GENRE genre
        )
    {
        if ( genre == GENRE.Male )
        {
            return "male";
        }
        else if ( genre == GENRE.Female )
        {
            return "female";
        }
        else
        {
            return "neutral";
        }
    }

    // ~~

    dstring GetPluralityText(
        PLURALITY plurality
        )
    {
        if ( plurality == PLURALITY.Zero )
        {
            return "zero";
        }
        else if ( plurality == PLURALITY.One )
        {
            return "one";
        }
        else if ( plurality == PLURALITY.Two )
        {
            return "two";
        }
        else if ( plurality == PLURALITY.Few )
        {
            return "few";
        }
        else if ( plurality == PLURALITY.Many )
        {
            return "many";
        }
        else
        {
            assert( plurality == PLURALITY.Other );

            return "other";
        }
    }

    // ~~

    PLURALITY GetCardinalPlurality(
        ref TRANSLATION translation
        )
    {
        assert( 0 );

        return PLURALITY.Zero;
    }

    // ~~

    PLURALITY GetOrdinalPlurality(
        ref TRANSLATION translation
        )
    {
        assert( 0 );

        return PLURALITY.Zero;
    }
}
