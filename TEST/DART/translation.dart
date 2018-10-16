// -- IMPORTS

import "genre.dart";
import "plurality.dart";

// -- TYPES

class TRANSLATION
{
    // -- ATTRIBUTES

    String
        Text,
        Quantity;
    bool
        HasIntegerQuantity,
        HasRealQuantity;
    int
        IntegerQuantity;
    double
        RealQuantity;
    GENRE
        Genre;
    static TRANSLATION
        Null;

    // -- CONSTRUCTORS

    TRANSLATION(
        [
            dynamic text = "",
            dynamic quantity = "",
            GENRE genre = GENRE.Neutral
        ]
        )
    {
        if ( text is int )
        {
            Text = "";

            SetQuantity( text );

            if ( quantity is String )
            {
                Genre = GENRE.Neutral;
            }
            else
            {
                Genre = quantity;
            }
        }
        else
        {
            assert( text is String );

            Text = text;
            Quantity = "";
            HasIntegerQuantity = false;
            HasRealQuantity = false;
            IntegerQuantity = 0;
            RealQuantity = 0.0;
            Genre = genre;

            if ( quantity.length > 0 )
            {
                SetQuantity( quantity );
            }
        }
    }

    // -- INQUIRIES

    String GetQuantityFirstCharacter(
        )
    {
        if ( Quantity.length == 0 )
        {
            return '\0';
        }
        else
        {
            return Quantity[ 0 ];
        }
    }

    // ~~

    PLURALITY GetEnglishCardinalPlurality(
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

    PLURALITY GetEnglishOrdinalPlurality(
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

    PLURALITY GetJapaneseCardinalPlurality(
        )
    {
        return PLURALITY.Other;
    }

    // ~~

    PLURALITY GetJapaneseOrdinalPlurality(
        )
    {
        return PLURALITY.Other;
    }

    // ~~

    PLURALITY GetKoreanCardinalPlurality(
        )
    {
        return PLURALITY.Other;
    }

    // ~~

    PLURALITY GetKoreanOrdinalPlurality(
        )
    {
        return PLURALITY.Other;
    }

    // ~~

    PLURALITY GetChineseCardinalPlurality(
        )
    {
        return PLURALITY.Other;
    }

    // ~~

    PLURALITY GetChineseOrdinalPlurality(
        )
    {
        return PLURALITY.Other;
    }

    // ~~

    PLURALITY GetGermanCardinalPlurality(
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

    PLURALITY GetGermanOrdinalPlurality(
        )
    {
        return PLURALITY.Other;
    }

    // ~~

    PLURALITY GetFrenchCardinalPlurality(
        )
    {
        if ( RealQuantity >= 0.0
             && RealQuantity <= 1.5 )
        {
            return PLURALITY.One;
        }
        else
        {
            return PLURALITY.Other;
        }
    }

    // ~~

    PLURALITY GetFrenchOrdinalPlurality(
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

    PLURALITY GetItalianCardinalPlurality(
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

    PLURALITY GetItalianOrdinalPlurality(
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

    PLURALITY GetSpanishCardinalPlurality(
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

    PLURALITY GetSpanishOrdinalPlurality(
        )
    {
        return PLURALITY.Other;
    }

    // ~~

    PLURALITY GetPortugueseCardinalPlurality(
        )
    {
        if ( RealQuantity >= 0.0
             && RealQuantity <= 1.5 )
        {
            return PLURALITY.One;
        }
        else
        {
            return PLURALITY.Other;
        }
    }

    // ~~

    PLURALITY GetPortugueseOrdinalPlurality(
        )
    {
        return PLURALITY.Other;
    }

    // ~~

    PLURALITY GetRussianCardinalPlurality(
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

    PLURALITY GetRussianOrdinalPlurality(
        )
    {
        return PLURALITY.Other;
    }

    // ~~

    PLURALITY GetTurquishCardinalPlurality(
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

    PLURALITY GetTurquishOrdinalPlurality(
        )
    {
        return PLURALITY.Other;
    }

    // ~~

    PLURALITY GetDutchCardinalPlurality(
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

    PLURALITY GetDutchOrdinalPlurality(
        )
    {
        return PLURALITY.Other;
    }

    // ~~

    PLURALITY GetSwedishCardinalPlurality(
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

    PLURALITY GetSwedishOrdinalPlurality(
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

    PLURALITY GetNorwegianCardinalPlurality(
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

    PLURALITY GetNorwegianOrdinalPlurality(
        )
    {
        return PLURALITY.Other;
    }

    // ~~

    PLURALITY GetDanishCardinalPlurality(
        )
    {
        if ( RealQuantity >= 0.1
             && RealQuantity <= 1.6 )
        {
            return PLURALITY.One;
        }
        else
        {
            return PLURALITY.Other;
        }
    }

    // ~~

    PLURALITY GetDanishOrdinalPlurality(
        )
    {
        return PLURALITY.Other;
    }

    // ~~

    PLURALITY GetArabicCardinalPlurality(
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

    PLURALITY GetArabicOrdinalPlurality(
        )
    {
        return PLURALITY.Other;
    }

    // -- OPERATIONS

    void SetText(
        String text
        )
    {
        Text = text;
    }

    // ~~

    void AddText(
        Object text_object
        )
    {
        String
            text;
        TRANSLATION
            translation;

        if ( text_object is TRANSLATION )
        {
            translation = text_object;

            if ( Text == null
                 || Text.length == 0 )
            {
                Text = translation.Text;
            }
            else
            {
                Text = Text + translation.Text;
            }
        }
        else
        {
            text = text_object;

            if ( Text == null
                 || Text.length == 0 )
            {
                Text = text;
            }
            else
            {
                Text = Text + text;
            }
        }
    }

    // ~~

    void SetQuantity(
        dynamic quantity
        )
    {
        int
            character_index;
        String
            character,
            integer_text;

        if ( quantity is int )
        {
            Quantity = quantity.toString();
            HasIntegerQuantity = true;
            HasRealQuantity = false;
            IntegerQuantity = quantity;
            RealQuantity = quantity.toDouble();
        }
        else
        {
            assert( quantity is double );

            Quantity = quantity;
            HasIntegerQuantity = true;
            HasRealQuantity = false;

            integer_text = quantity;

            for ( character_index = 0;
                  character_index < quantity.length;
                  ++character_index )
            {
                character = quantity[ character_index ];

                if ( character == '.'
                     || character == ',' )
                {
                    HasRealQuantity = true;
                    integer_text = quantity.substring( 0, character_index );
                }
                else if ( HasRealQuantity
                          && character.compareTo( '1' ) >= 0
                          && character.compareTo( '9' ) <= 0 )
                {
                    HasIntegerQuantity = false;
                }
            }

            IntegerQuantity = int.parse( integer_text );
            RealQuantity = double.parse( quantity );
        }
    }

    // ~~

    void SetGenre(
        GENRE genre
        )
    {
        Genre = genre;
    }
}
