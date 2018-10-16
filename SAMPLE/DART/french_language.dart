// -- IMPORTS

import "genre.dart";
import "plurality.dart";
import "translation.dart";
import "game_language.dart";

// -- TYPES

class FRENCH_LANGUAGE extends GAME_LANGUAGE
{
    // -- CONSTRUCTORS

    FRENCH_LANGUAGE(
        )
    {
        Name = "French";
        DecimalSeparator = ',';
    }

    // -- INQUIRIES

    String NewGame(
        )
    {
        return "Nouveau jeu";
    }

    // ~~

    String Welcome(
        TRANSLATION first_name_translation,
        TRANSLATION last_name_translation
        )
    {
        TRANSLATION
            result_translation = TRANSLATION();

        result_translation.AddText( "Bienvenue, " );
        result_translation.AddText( first_name_translation );
        result_translation.AddText( " " );
        result_translation.AddText( last_name_translation );
        result_translation.AddText( " !" );

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

        if ( count_translation.GetFrenchCardinalPlurality() == PLURALITY.One )
        {
            result_translation.AddText( "poire" );
        }
        else
        {
            result_translation.AddText( "poires" );
        }

        return result_translation.Text;
    }
}
