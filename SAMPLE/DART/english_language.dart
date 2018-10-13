// -- IMPORTS

import "genre.dart";
import "plurality.dart";
import "translation.dart";
import "game_language.dart";

// -- TYPES

class ENGLISH_LANGUAGE extends GAME_LANGUAGE
{
    // -- CONSTRUCTORS

    ENGLISH_LANGUAGE(
        )
    {
        Name = "English";
    }

    // -- INQUIRIES

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
        TRANSLATION
            result_translation = TRANSLATION();

        result_translation.AddText( "Welcome, " );
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
