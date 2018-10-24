// -- IMPORTS

using System;
using System.Collections.Generic;
using System.Globalization;
using GAME;

// -- TYPES

namespace GAME
{
    public class BASE_LANGUAGE
    {
        // -- ATTRIBUTES

        public string
            Name;
        public Dictionary<string, TRANSLATION>
            TranslationDictionary;
        public char
            DotCharacter;

        // -- CONSTRUCTORS

        public BASE_LANGUAGE(
            )
        {
            TranslationDictionary = new Dictionary<string, TRANSLATION>();
        }

        // -- INQUIRIES

        public bool IsLowerCaseCharacter(
            char character
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

        public bool IsUpperCaseCharacter(
            char character
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

        public char GetLowerCaseCharacter(
            char character
            )
        {
            if ( character >= 'A' && character <= 'Z' )
            {
                return ( char )( ( int )character + 32 );
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

        public char GetUpperCaseCharacter(
            char character
            )
        {
            if ( character >= 'a' && character <= 'z' )
            {
                return ( char )( ( int )character - 32 );
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

        public string GetLowerCase(
            string text
            )
        {
            char[]
                lower_case_character_array;
            int
                character_index;

            lower_case_character_array = text.ToCharArray();

            for ( character_index = 0;
                  character_index < text.Length;
                  ++character_index )
            {
                lower_case_character_array[ character_index ] = GetLowerCaseCharacter( text[ character_index ] );
            }

            return new string( lower_case_character_array );
        }

        // ~~

        public string GetUpperCase(
            string text
            )
        {
            char[]
                upper_case_character_array;
            int
                character_index;

            upper_case_character_array = text.ToCharArray();

            for ( character_index = 0;
                  character_index < text.Length;
                  ++character_index )
            {
                upper_case_character_array[ character_index ] = GetUpperCaseCharacter( text[ character_index ] );
            }

            return new string( upper_case_character_array );
        }

        // ~~

        public string GetTitleCase(
            string text
            )
        {
            char
                character,
                prior_character;
            char[]
                title_case_character_array;
            int
                character_index;

            prior_character = ' ';
            title_case_character_array = text.ToCharArray();

            for ( character_index = 0;
                  character_index < text.Length;
                  ++character_index )
            {
                character = text[ character_index ];

                if ( prior_character == ' '
                     && IsLowerCaseCharacter( character ) )
                {
                    title_case_character_array[ character_index ] = GetUpperCaseCharacter( character );
                }

                prior_character = character;
            }

            return new string( title_case_character_array );
        }

        // ~~

        public string GetSentenceCase(
            string text
            )
        {
            char[]
                capital_case_character_array;

            if ( text.Length > 0
                 && !IsUpperCaseCharacter( text[ 0 ] ) )
            {
                capital_case_character_array = text.ToCharArray();
                capital_case_character_array[ 0 ] = GetUpperCaseCharacter( text[ 0 ] );

                return new string( capital_case_character_array );
            }
            else
            {
                return text;
            }
        }

        // ~~

        public bool HasFirstCharacter(
            string text,
            string first_characters
            )
        {
            return
                text.Length > 0
                && first_characters.IndexOf( text[ 0 ] ) >= 0;
        }

        // ~~

        public bool HasPrefix(
            string text,
            string prefix
            )
        {
            return text.StartsWith( prefix );
        }

        // ~~

        public bool HasSuffix(
            string text,
            string suffix
            )
        {
            return text.EndsWith( suffix );
        }

        // ~~

        public TRANSLATION MakeTranslation(
            string text,
            string quantity,
            GENRE genre = GENRE.Neutral
            )
        {
            return new TRANSLATION( text, quantity, genre );
        }

        // ~~

        public TRANSLATION MakeTranslation(
            string text,
            GENRE genre = GENRE.Neutral
            )
        {
            return new TRANSLATION( text, genre );
        }

        // ~~

        public TRANSLATION MakeTranslation(
            int integer_quantity,
            GENRE genre = GENRE.Neutral
            )
        {
            return new TRANSLATION( integer_quantity, genre );
        }

        // ~~

        public bool HasTranslation(
            string key
            )
        {
            return TranslationDictionary.ContainsKey( key );
        }

        // ~~

        public TRANSLATION GetTranslation(
            string key
            )
        {
            return TranslationDictionary[ key ];
        }

        // ~~

        public string GetText(
            string key
            )
        {
            return TranslationDictionary[ key ].Text;
        }

        // ~~

        public TRANSLATION GetLowerCase(
            TRANSLATION translation
            )
        {
            translation.Text = GetLowerCase( translation.Text );

            return translation;
        }

        // ~~

        public TRANSLATION GetUpperCase(
            TRANSLATION translation
            )
        {
            translation.Text = GetUpperCase( translation.Text );

            return translation;
        }

        // ~~

        public TRANSLATION GetTitleCase(
            TRANSLATION translation
            )
        {
            translation.Text = GetTitleCase( translation.Text );

            return translation;
        }

        // ~~

        public TRANSLATION GetSentenceCase(
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

        public bool HasPrefix(
            TRANSLATION translation,
            string prefix
            )
        {
            return HasPrefix( translation.Text, prefix );
        }

        // ~~

        public bool HasSuffix(
            TRANSLATION translation,
            string suffix
            )
        {
            return HasSuffix( translation.Text, suffix );
        }

        // ~~

        public float GetIntegerReal(
            int integer
            )
        {
            return ( int )integer;
        }

        // ~~

        public int GetRealInteger(
            float real
            )
        {
            return ( int )real;
        }

        // ~~

        public bool GetTextBoolean(
            String text
            )
        {
            return text == "true";
        }

        // ~~

        public int GetTextInteger(
            String text
            )
        {
            return int.Parse( text );
        }

        // ~~

        public float GetTextReal(
            String text
            )
        {
            return float.Parse( text.Replace( ',', '.' ), CultureInfo.InvariantCulture );
        }

        // ~~

        public string GetBooleanText(
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

        public string GetIntegerText(
            int integer,
            int minimum_digit_count = 1
            )
        {
            int
                digit_count;
            string
                text;

            text = integer.ToString();

            digit_count = text.Length;

            if ( integer < 0 )
            {
                --digit_count;

                if ( digit_count < minimum_digit_count )
                {
                    text = "-" + "00000000000000000000".Substring( 0, minimum_digit_count - digit_count ) + text.Substring( 1 );
                }
            }
            else
            {
                if ( digit_count < minimum_digit_count )
                {
                    text = "00000000000000000000".Substring( 0, minimum_digit_count - digit_count ) + text;
                }
            }

            return text;
        }

        // ~~

        public string GetRealText(
            float real,
            int minimum_fractional_digit_count = 1,
            int maximum_fractional_digit_count = 20,
            char dot_character = '\0'
            )
        {
            bool
                trailing_zeros_are_removed;
            int
                dot_character_index,
                fractional_digit_count;
            string
                text;

            text = real.ToString();

            if ( dot_character == '\0' )
            {
                dot_character = DotCharacter;
            }

            dot_character_index = text.IndexOf( '.' );

            if ( dot_character_index < 0 )
            {
                dot_character_index = text.IndexOf( ',' );
            }

            if ( dot_character_index < 0 )
            {
                dot_character_index = text.Length;

                text += dot_character;
                text += '0';
            }

            fractional_digit_count = text.Length - dot_character_index - 1;

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
                text += "00000000000000000000".Substring( 0, minimum_fractional_digit_count - fractional_digit_count );

                fractional_digit_count = minimum_fractional_digit_count;
            }
            else if ( fractional_digit_count > maximum_fractional_digit_count )
            {
                text = text.Substring( 0, dot_character_index + 1 + maximum_fractional_digit_count );

                fractional_digit_count = maximum_fractional_digit_count;
            }

            if ( trailing_zeros_are_removed )
            {
                while ( fractional_digit_count > minimum_fractional_digit_count
                        && text[ dot_character_index + fractional_digit_count ] == '0' )
                {
                    --fractional_digit_count;
                }

                text = text.Substring( 0, dot_character_index + fractional_digit_count );
            }

            if ( fractional_digit_count == 0 )
            {
                return text.Substring( 0, dot_character_index );
            }
            else if ( text[ dot_character_index ] != dot_character )
            {
                return text.Substring( 0, dot_character_index ) + dot_character + text.Substring( dot_character_index + 1 );
            }
            else
            {
                return text;
            }
        }

        // ~~

        public string GetGenreText(
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

        public string GetPluralityText(
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
                return "other";
            }
        }

        // ~~

        public virtual PLURALITY GetCardinalPlurality(
            TRANSLATION translation
            )
        {
            return PLURALITY.Zero;
        }

        // ~~

        public virtual PLURALITY GetOrdinalPlurality(
            TRANSLATION translation
            )
        {
            return PLURALITY.Zero;
        }
    }
}
