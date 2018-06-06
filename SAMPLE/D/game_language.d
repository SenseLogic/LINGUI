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

    string New_game(
        )
    {
        return "";
    }

    // ~~

    string Welcome(
        TRANSLATION first_name_translation,
        TRANSLATION last_name_translation
        )
    {
        return "";
    }

    // ~~

    string Pears(
        TRANSLATION count_translation
        )
    {
        return "";
    }
}
