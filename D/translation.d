module lingui.translation;

// -- IMPORTS

import lingui.genre;
import lingui.plurality;
import std.conv : to;

// -- TYPES

struct TRANSLATION
{
    // -- ATTRIBUTES

    string
        Text,
        Quantity;
    bool
        HasIntegerQuantity,
        HasRealQuantity;
    int
        IntegerQuantity;
    float
        RealQuantity;
    GENRE
        Genre;
    static TRANSLATION
        Null;

    // -- CONSTRUCTORS

    this(
        string text,
        string quantity,
        GENRE genre = GENRE.Neutral
        )
    {
        Text = text;
        Genre = genre;

        if ( quantity.length > 0 )
        {
            SetQuantity( quantity );
        }
    }

    // ~~

    this(
        string text,
        GENRE genre = GENRE.Neutral
        )
    {
        Text = text;
        Genre = genre;
    }

    // ~~

    this(
        int integer_quantity,
        GENRE genre = GENRE.Neutral
        )
    {
        Quantity = integer_quantity.to!string();
        HasIntegerQuantity = true;
        HasRealQuantity = false;
        IntegerQuantity = integer_quantity;
        RealQuantity = integer_quantity.to!float();
        Genre = genre;
    }

    // -- INQUIRIES

    public char GetQuantityFirstCharacter(
        )
    {
        if ( Quantity.length == 0 )
        {
            return 0;
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
        if ( RealQuantity >= 0
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
        string text
        )
    {
        Text = text;
    }

    // ~~

    void AddText(
        string text
        )
    {
        if ( Text.length == 0 )
        {
            Text = text;
        }
        else
        {
            Text ~= text;
        }
    }

    // ~~

    void AddText(
        TRANSLATION translation
        )
    {
        if ( Text.length == 0 )
        {
            Text = translation.Text;
        }
        else
        {
            Text ~= translation.Text;
        }
    }

    // ~~

    void SetQuantity(
        string quantity
        )
    {
        string
            integer_text;

        Quantity = quantity;
        HasIntegerQuantity = true;
        HasRealQuantity = false;

        integer_text = quantity;

        foreach ( character_index, character; quantity )
        {
            if ( character == '.'
                 || character == ',' )
            {
                HasRealQuantity = true;
                integer_text = quantity[ 0 .. character_index ];
            }
            else if ( HasRealQuantity
                      && character >= '1'
                      && character <= '9' )
            {
                HasIntegerQuantity = false;
            }
        }

        IntegerQuantity = integer_text.to!int();
        RealQuantity = quantity.to!float();
    }

    // ~~

    void SetQuantity(
        int integer_quantity
        )
    {
        Quantity = integer_quantity.to!string();
        HasIntegerQuantity = true;
        HasRealQuantity = false;
        IntegerQuantity = integer_quantity;
        RealQuantity = integer_quantity.to!float();
    }

    // ~~

    void SetGenre(
        GENRE genre
        )
    {
        Genre = genre;
    }
}
