module game_language;

// -- IMPORTS

import genre;
import plurality;
import language;
import translation;

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
