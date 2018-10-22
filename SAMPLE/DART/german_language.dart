// -- IMPORTS

import "language.dart";
import "genre.dart";
import "plurality.dart";
import "translation.dart";

// -- TYPES

class GERMAN_LANGUAGE extends LANGUAGE
{
    // -- CONSTRUCTORS

    GERMAN_LANGUAGE(
        ) : super()
    {
        Name = "German";
        DotCharacter = ',';
        TranslationMap[ "princess" ] = TRANSLATION( "Prinzessin", "1", GENRE.Female );
        TranslationMap[ "NewGame" ] = TRANSLATION( "Neues Spiel" );
    }

    // -- INQUIRIES

    PLURALITY GetCardinalPlurality(
        TRANSLATION translation
        )
    {
        return translation.GetGermanCardinalPlurality();
    }

    // ~~

    PLURALITY GetOrdinalPlurality(
        TRANSLATION translation
        )
    {
        return translation.GetGermanOrdinalPlurality();
    }

    // ~~

    String GameOver(
        )
    {
        return "Spiel vorbei!";
    }

    // ~~

    String Welcome(
        String first_name,
        String last_name
        )
    {
        return "Willkommen, " + first_name + " " + last_name + "!";
    }

    // ~~

    String Pears(
        TRANSLATION count_translation
        )
    {
        TRANSLATION
            result_translation = TRANSLATION();

        result_translation.AddText( count_translation.Quantity + " " );

        if ( count_translation.GetGermanCardinalPlurality() == PLURALITY.One )
        {
            result_translation.AddText( "Birne" );
        }
        else
        {
            result_translation.AddText( "Birnen" );
        }

        return result_translation.Text;
    }
}
