module lingui.language;

// -- IMPORTS

import lingui.base_language;
import lingui.genre;
import lingui.plurality;
import lingui.translation;

// -- TYPES

class LANGUAGE : BASE_LANGUAGE
{
    // -- CONSTRUCTORS

    this(
        )
    {
        super();
    }

    // -- INQUIRIES

    dstring GameOver(
        )
    {
        return "";
    }

    // ~~

    dstring Welcome(
        TRANSLATION first_name_translation,
        TRANSLATION last_name_translation
        )
    {
        return "";
    }

    // ~~

    dstring Pears(
        TRANSLATION count_translation
        )
    {
        return "";
    }
}
