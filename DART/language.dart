library lingui;

// -- IMPORTS

import "genre.dart";
import "translation.dart";

// -- TYPES

class LANGUAGE
{
    // -- ATTRIBUTES

    String
        Name;
    Map<String, TRANSLATION>
        TranslationMap;
    String
        DecimalSeparator;

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
        String text,
        [
            String quantity = "",
            GENRE genre = GENRE.Neutral
        ]
        )
    {
        return TRANSLATION( text, quantity, genre );
    }

    // ~~

    TRANSLATION MakeQuantity(
        int integer_quantity,
        [ GENRE genre = GENRE.Neutral ]
        )
    {
        return TRANSLATION.FromQuantity( integer_quantity, genre );
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

    int GetInteger(
        double real
        )
    {
        return real.toInt();
    }

    // ~~

    double GetReal(
        int integer
        )
    {
        return integer.toDouble();
    }

    // ~~

    String GetText(
        dynamic number,
        [
            int minimum_fractional_digit_count = 1,
            int maximum_fractional_digit_count = 20,
            String decimal_separator = '\0'
        ]
        )
    {
        int
            decimal_separator_index,
            fractional_digit_count;
        String
            text;

        text = number.toString();
print( "IN : " + text );
        if ( number is double )
        {
            decimal_separator_index = text.indexOf( '.' );

            if ( decimal_separator_index < 0 )
            {
                text += '.';
                decimal_separator_index = text.length - 1;
            }

            fractional_digit_count = text.length - decimal_separator_index - 1;

            if ( fractional_digit_count < minimum_fractional_digit_count )
            {
                text = text + "00000000000000000000".substring( 0, minimum_fractional_digit_count - fractional_digit_count );
            }
            else if ( fractional_digit_count > maximum_fractional_digit_count )
            {
                text = text.substring( 0, decimal_separator_index + 1 + maximum_fractional_digit_count );
            }

            if ( decimal_separator == '\0' )
            {
                decimal_separator = DecimalSeparator;
            }

            if ( text[ decimal_separator_index ] != decimal_separator )
            {
                print( "TEXT : ", text );
                text
                    = text.substring( 0, decimal_separator_index )
                      + decimal_separator
                      + text.substring( decimal_separator_index + 1, text.length - decimal_separator_index - 1 );
            }

            if ( minimum_fractional_digit_count == 0
                 && fractional_digit_count == 0 )
            {
                text = text.substring( 0, text.length - 1 );
            }
        }
print( "OUT : " + text );
        return text;
    }
}
