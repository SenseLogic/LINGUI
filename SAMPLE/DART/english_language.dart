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
        ) : super()
    {
        Name = "English";
        DotCharacter = '.';
        TranslationMap[ "princess" ] = TRANSLATION( "princess", "1", GENRE.Female );
        TranslationMap[ "NewGame" ] = TRANSLATION( "New game" );
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

    String GameOver(
        )
    {
        return "Game over!";
    }

    // ~~

    String Welcome(
        String first_name,
        String last_name
        )
    {
        return "Welcome, " + first_name + " " + last_name + "!";
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
