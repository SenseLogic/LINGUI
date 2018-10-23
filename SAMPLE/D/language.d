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
        dstring first_name,
        dstring last_name
        )
    {
        return "";
    }

    // ~~

    dstring Pears(
        int count
        )
    {
        return "";
    }
}
