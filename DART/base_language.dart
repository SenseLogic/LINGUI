// -- IMPORTS

import "genre.dart";
import "plurality.dart";
import "translation.dart";

// -- TYPES

class BASE_LANGUAGE
{
    // -- ATTRIBUTES

    String
        Name;
    Map<String, TRANSLATION>
        TranslationMap;
    String
        DotCharacter;

    // -- CONSTRUCTORS

    BASE_LANGUAGE(
        )
    {
        TranslationMap = Map<String, TRANSLATION>();
    }

    // -- INQUIRIES

    bool IsLowerCaseCharacter(
        String character
        )
    {
        return
            ( character.compareTo( 'a' ) >= 0
              && character.compareTo( 'z' ) <= 0 )
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
        String character
        )
    {
        return
            ( character.compareTo( 'A' ) >= 0
              && character.compareTo( 'Z' ) <= 0 )
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

    String GetLowerCaseCharacter(
        String character
        )
    {
        if ( character.compareTo( 'A' ) >= 0
             && character.compareTo( 'Z' ) <= 0 )
        {
            return character.toLowerCase();
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

    String GetUpperCaseCharacter(
        String character
        )
    {
        if ( character.compareTo( 'a' ) >= 0
             && character.compareTo( 'z' ) <= 0 )
        {
            return character.toUpperCase();
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

    String GetLowerCaseText(
        String text
        )
    {
        int
            character_index;
        List<String>
            lower_case_character_list;

        lower_case_character_list = text.split( "" );

        for ( character_index = 0;
              character_index < text.length;
              ++character_index )
        {
            lower_case_character_list[ character_index ] = GetLowerCaseCharacter( text[ character_index ] );
        }

        return lower_case_character_list.join();
    }

    // ~~

    String GetUpperCaseText(
        String text
        )
    {
        int
            character_index;
        List<String>
            upper_case_character_list;

        upper_case_character_list = text.split( "" );

        for ( character_index = 0;
              character_index < text.length;
              ++character_index )
        {
            upper_case_character_list[ character_index ] = GetUpperCaseCharacter( text[ character_index ] );
        }

        return upper_case_character_list.join();
    }

    // ~~

    String GetTitleCaseText(
        String text
        )
    {
        int
            character_index;
        List<String>
            title_case_character_list;
        String
            character,
            prior_character;

        prior_character = ' ';
        title_case_character_list = text.split( "" );

        for ( character_index = 0;
              character_index < text.length;
              ++character_index )
        {
            character = text[ character_index ];

            if ( prior_character == ' '
                 && IsLowerCaseCharacter( character ) )
            {
                title_case_character_list[ character_index ] = GetUpperCaseCharacter( character );
            }

            prior_character = character;
        }

        return title_case_character_list.join();
    }

    // ~~

    String GetSentenceCaseText(
        String text
        )
    {
        List<String>
            capital_case_character_list;

        if ( text.length > 0
             && !IsUpperCaseCharacter( text[ 0 ] ) )
        {
            capital_case_character_list = text.split( "" );
            capital_case_character_list[ 0 ] = GetUpperCaseCharacter( text[ 0 ] );

            return capital_case_character_list.join();
        }
        else
        {
            return text;
        }
    }

    // ~~

    bool HasFirstTextCharacter(
        String text,
        String first_characters
        )
    {
        return
            text.length > 0
            && first_characters.indexOf( text[ 0 ] ) >= 0;
    }

    // ~~

    bool HasTextPrefix(
        String text,
        String prefix
        )
    {
        return text.startsWith( prefix );
    }

    // ~~

    bool HasTextSuffix(
        String text,
        String suffix
        )
    {
        return text.endsWith( suffix );
    }

    // ~~

    TRANSLATION MakeTranslation(
        dynamic text,
        [
            dynamic quantity = "",
            GENRE genre = GENRE.Neutral
        ]
        )
    {
        return TRANSLATION( text, quantity, genre );
    }

    // ~~

    bool HasTranslation(
        String key
        )
    {
        return TranslationMap.containsKey( key );
    }

    // ~~

    TRANSLATION GetTranslation(
        String key
        )
    {
        return TranslationMap[ key ];
    }

    // ~~

    dynamic GetLowerCase(
        dynamic text
        )
    {
        if ( text is TRANSLATION )
        {
            return TRANSLATION( GetLowerCaseText( text.Text ), text.Quantity, text.Genre );
        }
        else
        {
            return GetLowerCaseText( text );
        }
    }

    // ~~

    dynamic GetUpperCase(
        dynamic text
        )
    {
        if ( text is TRANSLATION )
        {
            return TRANSLATION( GetUpperCaseText( text.Text ), text.Quantity, text.Genre );
        }
        else
        {
            return GetUpperCaseText( text );
        }
    }

    // ~~

    dynamic GetTitleCase(
        dynamic text
        )
    {
        if ( text is TRANSLATION )
        {
            return TRANSLATION( GetTitleCaseText( text.Text ), text.Quantity, text.Genre );
        }
        else
        {
            return GetTitleCaseText( text );
        }
    }

    // ~~

    dynamic GetSentenceCase(
        dynamic text
        )
    {
        if ( text is TRANSLATION )
        {
            return TRANSLATION( GetSentenceCaseText( text.Text ), text.Quantity, text.Genre );
        }
        else
        {
            return GetSentenceCaseText( text );
        }
    }

    // ~~

    bool HasFirstCharacter(
        dynamic text,
        String first_characters
        )
    {
        if ( text is TRANSLATION )
        {
            return HasFirstTextCharacter( text.Text, first_characters );
        }
        else
        {
            return HasFirstTextCharacter( text, first_characters );
        }
    }

    // ~~

    bool HasPrefix(
        dynamic text,
        String prefix
        )
    {
        if ( text is TRANSLATION )
        {
            return HasTextPrefix( text.Text, prefix );
        }
        else
        {
            return HasTextPrefix( text, prefix );
        }
    }

    // ~~

    bool HasSuffix(
        dynamic text,
        String suffix
        )
    {
        if ( text is TRANSLATION )
        {
            return HasTextSuffix( text.Text, suffix );
        }
        else
        {
            return HasTextSuffix( text, suffix );
        }
    }

    // ~~

    double GetIntegerReal(
        int integer
        )
    {
        return integer.toDouble();
    }

    // ~~

    int GetRealInteger(
        double real
        )
    {
        return real.toInt();
    }

    // ~~

    int GetTextInteger(
        String text
        )
    {
        return int.parse( text );
    }

    // ~~

    double GetTextReal(
        String text
        )
    {
        return double.parse( text );
    }

    // ~~

    String GetIntegerText(
        int integer,
        [
            int minimum_digit_count = 1
        ]
        )
    {
        int
            digit_count;
        String
            text;

        text = integer.toString();

        digit_count = text.length;

        if ( integer < 0 )
        {
            --digit_count;

            if ( digit_count < minimum_digit_count )
            {
                text = "-" + "00000000000000000000".substring( 0, minimum_digit_count - digit_count ) + text.substring( 1 );
            }
        }
        else
        {
            if ( digit_count < minimum_digit_count )
            {
                text = "00000000000000000000".substring( 0, minimum_digit_count - digit_count ) + text;
            }
        }

        return text;
    }

    // ~~

    String GetRealText(
        double real,
        [
            int minimum_fractional_digit_count = 1,
            int maximum_fractional_digit_count = 20,
            String dot_character = '\0'
        ]
        )
    {
        bool
            trailing_zeros_are_removed;
        int
            dot_character_index,
            fractional_digit_count;
        String
            text;

        text = real.toString();

        if ( dot_character == '\0' )
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

            text += dot_character;
            text += '0';
        }

        fractional_digit_count = text.length - dot_character_index - 1;

        if ( minimum_fractional_digit_count < 0 )
        {
            trailing_zeros_are_removed = true;
            minimum_fractional_digit_count = 0;
        }
        else
        {
            trailing_zeros_are_removed = false;
        }

        if ( fractional_digit_count < minimum_fractional_digit_count )
        {
            text += "00000000000000000000".substring( 0, minimum_fractional_digit_count - fractional_digit_count );

            fractional_digit_count = minimum_fractional_digit_count;
        }
        else if ( fractional_digit_count > maximum_fractional_digit_count )
        {
            text = text.substring( 0, dot_character_index + 1 + maximum_fractional_digit_count );

            fractional_digit_count = maximum_fractional_digit_count;
        }

        if ( trailing_zeros_are_removed )
        {
            while ( fractional_digit_count > minimum_fractional_digit_count
                    && text[ dot_character_index + fractional_digit_count ] == '0' )
            {
                --fractional_digit_count;
            }

            text = text.substring( 0, dot_character_index + fractional_digit_count );
        }

        if ( fractional_digit_count == 0 )
        {
            return text.substring( 0, dot_character_index );
        }
        else if ( text[ dot_character_index ] != dot_character )
        {
            return text.substring( 0, dot_character_index ) + dot_character + text.substring( dot_character_index + 1 );
        }
        else
        {
            return text;
        }
    }

    // ~~

    String GetGenreText(
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
            assert( genre == GENRE.Neutral );

            return "neutral";
        }
    }

    // ~~

    String GetPluralityText(
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
        TRANSLATION translation
        )
    {
        assert( false );

        return PLURALITY.Zero;
    }

    // ~~

    PLURALITY GetOrdinalPlurality(
        TRANSLATION translation
        )
    {
        assert( false );

        return PLURALITY.Zero;
    }
}
