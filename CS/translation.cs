// -- IMPORTS

using System;
using LINGUI;

// -- TYPES

namespace LINGUI
{
    public struct TRANSLATION
    {
        // -- ATTRIBUTES

        public string
            Text,
            Quantity;
        public bool
            HasIntegerQuantity,
            HasRealQuantity;
        public int
            IntegerQuantity;
        public float
            RealQuantity;
        public GENRE
            Genre;
        public static TRANSLATION
            Null;

        // -- CONSTRUCTORS

        public TRANSLATION(
            string text,
            string quantity,
            GENRE genre = GENRE.Neutral
            )
        {
            Text = text;
            Quantity = "";
            HasIntegerQuantity = false;
            HasRealQuantity = false;
            IntegerQuantity = 0;
            RealQuantity = 0.0f;
            Genre = genre;

            if ( quantity.Length > 0 )
            {
                SetQuantity( quantity );
            }
        }

        // ~~

        public TRANSLATION(
            string text,
            GENRE genre = GENRE.Neutral
            )
        {
            Text = text;
            Quantity = "";
            HasIntegerQuantity = false;
            HasRealQuantity = false;
            IntegerQuantity = 0;
            RealQuantity = 0.0f;
            Genre = genre;
        }

        // ~~

        public TRANSLATION(
            int integer_quantity,
            GENRE genre = GENRE.Neutral
            )
        {
            Text = "";
            Quantity = integer_quantity.ToString();
            HasIntegerQuantity = true;
            HasRealQuantity = false;
            IntegerQuantity = integer_quantity;
            RealQuantity = ( float )integer_quantity;
            Genre = genre;
        }

        // -- INQUIRIES

        public char GetQuantityFirstCharacter(
            )
        {
            if ( Quantity.Length == 0 )
            {
                return '\0';
            }
            else
            {
                return Quantity[ 0 ];
            }
        }

        // ~~

        public PLURALITY GetEnglishCardinalPlurality(
            )
        {
            if ( !HasRealQuantity
                 && IntegerQuantity == 1 )
            {
                return PLURALITY.One;
            }
            else
            {
                return PLURALITY.Other;
            }
        }

        // ~~

        public PLURALITY GetEnglishOrdinalPlurality(
            )
        {
            int
                integer_quantity_modulo_10;

            integer_quantity_modulo_10 = IntegerQuantity % 10;

            if ( !HasRealQuantity
                 && integer_quantity_modulo_10 == 1 )
            {
                return PLURALITY.One;
            }
            else if ( !HasRealQuantity
                      && integer_quantity_modulo_10 == 2 )
            {
                return PLURALITY.Two;
            }
            else if ( !HasRealQuantity
                      && integer_quantity_modulo_10 == 3 )
            {
                return PLURALITY.Few;
            }
            else
            {
                return PLURALITY.Other;
            }
        }

        // ~~

        public PLURALITY GetJapaneseCardinalPlurality(
            )
        {
            return PLURALITY.Other;
        }

        // ~~

        public PLURALITY GetJapaneseOrdinalPlurality(
            )
        {
            return PLURALITY.Other;
        }

        // ~~

        public PLURALITY GetKoreanCardinalPlurality(
            )
        {
            return PLURALITY.Other;
        }

        // ~~

        public PLURALITY GetKoreanOrdinalPlurality(
            )
        {
            return PLURALITY.Other;
        }

        // ~~

        public PLURALITY GetChineseCardinalPlurality(
            )
        {
            return PLURALITY.Other;
        }

        // ~~

        public PLURALITY GetChineseOrdinalPlurality(
            )
        {
            return PLURALITY.Other;
        }

        // ~~

        public PLURALITY GetGermanCardinalPlurality(
            )
        {
            if ( !HasRealQuantity
                 && IntegerQuantity == 1 )
            {
                return PLURALITY.One;
            }
            else
            {
                return PLURALITY.Other;
            }
        }

        // ~~

        public PLURALITY GetGermanOrdinalPlurality(
            )
        {
            return PLURALITY.Other;
        }

        // ~~

        public PLURALITY GetFrenchCardinalPlurality(
            )
        {
            if ( RealQuantity >= 0.0f
                 && RealQuantity <= 1.5f )
            {
                return PLURALITY.One;
            }
            else
            {
                return PLURALITY.Other;
            }
        }

        // ~~

        public PLURALITY GetFrenchOrdinalPlurality(
            )
        {
            if ( !HasRealQuantity
                 && IntegerQuantity == 1 )
            {
                return PLURALITY.One;
            }
            else
            {
                return PLURALITY.Other;
            }
        }

        // ~~

        public PLURALITY GetItalianCardinalPlurality(
            )
        {
            if ( !HasRealQuantity
                 && IntegerQuantity == 1 )
            {
                return PLURALITY.One;
            }
            else
            {
                return PLURALITY.Other;
            }
        }

        // ~~

        public PLURALITY GetItalianOrdinalPlurality(
            )
        {
            if ( !HasRealQuantity
                 && ( IntegerQuantity == 11
                      || GetQuantityFirstCharacter() == '8' ) )
            {
                return PLURALITY.Many;
            }
            else
            {
                return PLURALITY.Other;
            }
        }

        // ~~

        public PLURALITY GetSpanishCardinalPlurality(
            )
        {
            if ( HasIntegerQuantity
                 && IntegerQuantity == 1 )
            {
                return PLURALITY.One;
            }
            else
            {
                return PLURALITY.Other;
            }
        }

        // ~~

        public PLURALITY GetSpanishOrdinalPlurality(
            )
        {
            return PLURALITY.Other;
        }

        // ~~

        public PLURALITY GetPortugueseCardinalPlurality(
            )
        {
            if ( RealQuantity >= 0.0f
                 && RealQuantity <= 1.5f )
            {
                return PLURALITY.One;
            }
            else
            {
                return PLURALITY.Other;
            }
        }

        // ~~

        public PLURALITY GetPortugueseOrdinalPlurality(
            )
        {
            return PLURALITY.Other;
        }

        // ~~

        public PLURALITY GetRussianCardinalPlurality(
            )
        {
            int
                integer_quantity_modulo_10,
                integer_quantity_modulo_100;

            integer_quantity_modulo_10 = IntegerQuantity % 10;
            integer_quantity_modulo_100 = IntegerQuantity % 100;

            if ( !HasRealQuantity
                 && integer_quantity_modulo_10 == 1
                 && integer_quantity_modulo_100 != 11 )
            {
                return PLURALITY.One;
            }
            else if ( !HasRealQuantity
                      && integer_quantity_modulo_10 >= 2
                      && integer_quantity_modulo_10 <= 4
                      && ( integer_quantity_modulo_100 < 12
                           || integer_quantity_modulo_100 > 14 ) )
            {
                return PLURALITY.Few;
            }
            else if ( !HasRealQuantity
                      && ( integer_quantity_modulo_10 == 0
                           || ( IntegerQuantity >= 5
                                && IntegerQuantity <= 19 ) ) )
            {
                return PLURALITY.Many;
            }
            else
            {
                return PLURALITY.Other;
            }
        }

        // ~~

        public PLURALITY GetRussianOrdinalPlurality(
            )
        {
            return PLURALITY.Other;
        }

        // ~~

        public PLURALITY GetTurquishCardinalPlurality(
            )
        {
            if ( HasIntegerQuantity
                 && IntegerQuantity == 1 )
            {
                return PLURALITY.One;
            }
            else
            {
                return PLURALITY.Other;
            }
        }

        // ~~

        public PLURALITY GetTurquishOrdinalPlurality(
            )
        {
            return PLURALITY.Other;
        }

        // ~~

        public PLURALITY GetDutchCardinalPlurality(
            )
        {
            if ( !HasRealQuantity
                 && IntegerQuantity == 1 )
            {
                return PLURALITY.One;
            }
            else
            {
                return PLURALITY.Other;
            }
        }

        // ~~

        public PLURALITY GetDutchOrdinalPlurality(
            )
        {
            return PLURALITY.Other;
        }

        // ~~

        public PLURALITY GetSwedishCardinalPlurality(
            )
        {
            if ( !HasRealQuantity
                 && IntegerQuantity == 1 )
            {
                return PLURALITY.One;
            }
            else
            {
                return PLURALITY.Other;
            }
        }

        // ~~

        public PLURALITY GetSwedishOrdinalPlurality(
            )
        {
            int
                integer_quantity_modulo_10;

            integer_quantity_modulo_10 = IntegerQuantity % 10;

            if ( !HasRealQuantity
                 && integer_quantity_modulo_10 >= 1
                 && integer_quantity_modulo_10 <= 2 )
            {
                return PLURALITY.One;
            }
            else
            {
                return PLURALITY.Other;
            }
        }

        // ~~

        public PLURALITY GetNorwegianCardinalPlurality(
            )
        {
            if ( HasIntegerQuantity
                 && IntegerQuantity == 1 )
            {
                return PLURALITY.One;
            }
            else
            {
                return PLURALITY.Other;
            }
        }

        // ~~

        public PLURALITY GetNorwegianOrdinalPlurality(
            )
        {
            return PLURALITY.Other;
        }

        // ~~

        public PLURALITY GetDanishCardinalPlurality(
            )
        {
            if ( RealQuantity >= 0.1f
                 && RealQuantity <= 1.6f )
            {
                return PLURALITY.One;
            }
            else
            {
                return PLURALITY.Other;
            }
        }

        // ~~

        public PLURALITY GetDanishOrdinalPlurality(
            )
        {
            return PLURALITY.Other;
        }

        // ~~

        public PLURALITY GetArabicCardinalPlurality(
            )
        {
            int
                integer_quantity_modulo_100;

            if ( HasIntegerQuantity
                 && IntegerQuantity == 0 )
            {
                return PLURALITY.Zero;
            }
            else if ( HasIntegerQuantity
                      && IntegerQuantity == 1 )
            {
                return PLURALITY.One;
            }
            else if ( HasIntegerQuantity
                      && IntegerQuantity == 2 )
            {
                return PLURALITY.Two;
            }
            else
            {
                integer_quantity_modulo_100 = IntegerQuantity % 100;

                if ( HasIntegerQuantity
                      && integer_quantity_modulo_100 >= 3
                      && integer_quantity_modulo_100 <= 10 )
                {
                    return PLURALITY.Few;
                }
                else if ( HasIntegerQuantity
                          && integer_quantity_modulo_100 >= 11
                          && integer_quantity_modulo_100 <= 26 )
                {
                    return PLURALITY.Many;
                }
                else
                {
                    return PLURALITY.Other;
                }
            }
        }

        // ~~

        public PLURALITY GetArabicOrdinalPlurality(
            )
        {
            return PLURALITY.Other;
        }

        // -- OPERATIONS

        public void SetText(
            string text
            )
        {
            Text = text;
        }

        // ~~

        public void AddText(
            string text
            )
        {
            if ( Text == null
                 || Text.Length == 0 )
            {
                Text = text;
            }
            else
            {
                Text = Text + text;
            }
        }

        // ~~

        public void AddText(
            TRANSLATION translation
            )
        {
            if ( Text == null
                 || Text.Length == 0 )
            {
                Text = translation.Text;
            }
            else
            {
                Text = Text + translation.Text;
            }
        }

        // ~~

        public void SetQuantity(
            string quantity
            )
        {
            char
                character;
            int
                character_index;
            string
                integer_text;

            Quantity = quantity;
            HasIntegerQuantity = true;
            HasRealQuantity = false;

            integer_text = quantity;

            for ( character_index = 0;
                  character_index < quantity.Length;
                  ++character_index )
            {
                character = quantity[ character_index ];

                if ( character == '.'
                     || character == ',' )
                {
                    HasRealQuantity = true;
                    integer_text = quantity.Substring( 0, character_index );
                }
                else if ( HasRealQuantity
                          && character >= '1'
                          && character <= '9' )
                {
                    HasIntegerQuantity = false;
                }
            }

            IntegerQuantity = int.Parse( integer_text );
            RealQuantity = float.Parse( quantity );
        }

        // ~~

        public void SetQuantity(
            int integer_quantity
            )
        {
            Quantity = integer_quantity.ToString();
            HasIntegerQuantity = true;
            HasRealQuantity = false;
            IntegerQuantity = integer_quantity;
            RealQuantity = ( float )integer_quantity;
        }

        // ~~

        public void SetGenre(
            GENRE genre
            )
        {
            Genre = genre;
        }
    }
}
