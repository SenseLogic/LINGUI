module GERMAN_LANGUAGE_MODULE;

// -- IMPORTS

import GENRE_MODULE;
import PLURALITY_MODULE;
import GAME_LANGUAGE_MODULE;
import TRANSLATION_MODULE;

// -- TYPES

class GERMAN_LANGUAGE : GAME_LANGUAGE
{
    // -- CONSTRUCTORS

    this(
        )
    {
        Name = "German";
    }

    // -- INQUIRIES

    override string New_game(
        )
    {
        return "Neues Spiel";
    }

    // ~~

    override string Welcome(
        TRANSLATION first_name_translation,
        TRANSLATION last_name_translation
        )
    {
        TRANSLATION
            result_translation;

        result_translation.AddText( "Willkommen, " );
        result_translation.AddText( first_name_translation );
        result_translation.AddText( " " );
        result_translation.AddText( last_name_translation );
        result_translation.AddText( "!" );

        return result_translation.Text;
    }

    // ~~

    override string Pears(
        TRANSLATION count_translation
        )
    {
        TRANSLATION
            result_translation;

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
