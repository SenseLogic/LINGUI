module lingui.game_language;

// -- IMPORTS

import lingui.genre;
import lingui.plurality;
import lingui.language;
import lingui.translation;

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
