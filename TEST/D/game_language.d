module GAME_LANGUAGE_MODULE;

// -- IMPORTS

import GENRE_MODULE;
import PLURALITY_MODULE;
import LANGUAGE_MODULE;
import TRANSLATION_MODULE;

// -- TYPES

class GAME_LANGUAGE : LANGUAGE
{
    // -- INQUIRIES

    string Main_menu(
        )
    {
        return "";
    }

    // ~~

    TRANSLATION Chests(
        TRANSLATION count_translation
        )
    {
        return TRANSLATION.Null;
    }

    // ~~

    TRANSLATION Swords(
        TRANSLATION count_translation
        )
    {
        return TRANSLATION.Null;
    }

    // ~~

    TRANSLATION No_swords(
        )
    {
        return Swords( TRANSLATION( "", "0" ) );
    }

    // ~~

    TRANSLATION One_sword(
        )
    {
        return Swords( TRANSLATION( "", "1" ) );
    }

    // ~~

    string The_items(
        TRANSLATION items_translation
        )
    {
        return "";
    }

    // ~~

    string The_items_have_been_found(
        TRANSLATION items_translation
        )
    {
        return "";
    }

    // ~~

    string Test(
        )
    {
        TRANSLATION
            result_translation,
            no_chests_translation,
            one_chest_translation;

        no_chests_translation = Chests( TRANSLATION( "", "0" ) );
        one_chest_translation = Chests( TRANSLATION( "", "1" ) );
        result_translation.AddText( The_items_have_been_found( no_chests_translation ) );
        result_translation.AddText( The_items_have_been_found( one_chest_translation ) );
        result_translation.AddText( The_items_have_been_found( Chests( TRANSLATION( "", "2" ) ) ) );
        result_translation.AddText( The_items_have_been_found( No_swords() ) );
        result_translation.AddText( The_items_have_been_found( One_sword() ) );
        result_translation.AddText( The_items_have_been_found( Swords( TRANSLATION( "", "2" ) ) ) );

        return result_translation.Text;
    }
}
