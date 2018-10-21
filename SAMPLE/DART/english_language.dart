// -- IMPORTS

import "language.dart";
import "genre.dart";
import "plurality.dart";
import "translation.dart";

// -- TYPES

class ENGLISH_LANGUAGE extends LANGUAGE
{
    // -- CONSTRUCTORS

    ENGLISH_LANGUAGE(
        )
    {
        Name = "English";
        DotCharacter = '.';
    }

    // -- INQUIRIES

    PLURALITY GetCardinalPlurality(
        TRANSLATION translation
        )
    {
        return translation.GetEnglishCardinalPlurality();
    }

    // ~~

    PLURALITY GetOrdinalPlurality(
        TRANSLATION translation
        )
    {
        return translation.GetEnglishOrdinalPlurality();
    }

    // ~~

    String NewGame(
        )
    {
        return "New game";
    }

    // ~~

    String Welcome(
        TRANSLATION first_name_translation,
        TRANSLATION last_name_translation
        )
    {
        return "Welcome, " + first_name_translation.Text + " " + last_name_translation.Text + "!";
    }

    // ~~

    String Pears(
        TRANSLATION count_translation
        )
    {
        TRANSLATION
            result_translation = TRANSLATION();

        result_translation.AddText( count_translation.Quantity + " " );

        if ( count_translation.GetEnglishCardinalPlurality() == PLURALITY.One )
        {
            result_translation.AddText( "pear" );
        }
        else
        {
            result_translation.AddText( "pears" );
        }

        return result_translation.Text;
    }
}
