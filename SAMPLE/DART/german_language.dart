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
        int count
        )
    {
        TRANSLATION
            result_translation = TRANSLATION();

        result_translation.AddText( GetIntegerText( count ) + " " );

        if ( count == 1 )
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
