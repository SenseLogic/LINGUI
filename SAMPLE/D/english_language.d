module ENGLISH_LANGUAGE_MODULE;

// -- IMPORTS

import GENRE_MODULE;
import PLURALITY_MODULE;
import GAME_LANGUAGE_MODULE;
import TRANSLATION_MODULE;

// -- TYPES

class ENGLISH_LANGUAGE : GAME_LANGUAGE
{
    // -- CONSTRUCTORS

    this(
        )
    {
        Name = "English";
    }

    // -- INQUIRIES

    override string New_game(
        )
    {
        return "New game";
    }

    // ~~

    override string Welcome(
        TRANSLATION first_name_translation,
        TRANSLATION last_name_translation
        )
    {
        TRANSLATION
            result_translation;

        result_translation.AddText( "Welcome, " );
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
