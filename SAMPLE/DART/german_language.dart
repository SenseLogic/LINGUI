library lingui;

// -- IMPORTS

import "genre.dart";
import "plurality.dart";
import "translation.dart";
import "game_language.dart";

// -- TYPES

class GERMAN_LANGUAGE extends GAME_LANGUAGE
{
    // -- CONSTRUCTORS

    GERMAN_LANGUAGE(
        )
    {
        Name = "German";
    }

    // -- INQUIRIES

    String NewGame(
        )
    {
        return "Neues Spiel";
    }

    // ~~

    String Welcome(
        TRANSLATION first_name_translation,
        TRANSLATION last_name_translation
        )
    {
        TRANSLATION
            result_translation = TRANSLATION();

        result_translation.AddText( "Willkommen, " );
        result_translation.AddText( first_name_translation );
        result_translation.AddText( " " );
        result_translation.AddText( last_name_translation );
        result_translation.AddText( "!" );

        return result_translation.Text;
    }

    // ~~

    String Pears(
        TRANSLATION count_translation
        )
    {
        TRANSLATION
            result_translation = TRANSLATION();

        result_translation.AddText( count_translation.Quantity );
        result_translation.AddText( " " );

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
