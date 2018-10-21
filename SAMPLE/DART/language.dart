// -- IMPORTS

import "base_language.dart";
import "genre.dart";
import "plurality.dart";
import "translation.dart";

// -- TYPES

class LANGUAGE extends BASE_LANGUAGE
{
    // -- CONSTRUCTORS

    LANGUAGE(
        ) : super()
    {
    }

    // -- INQUIRIES

    String GameOver(
        )
    {
        return "";
    }

    // ~~

    String Welcome(
        TRANSLATION first_name_translation,
        TRANSLATION last_name_translation
        )
    {
        return "";
    }

    // ~~

    String Pears(
        TRANSLATION count_translation
        )
    {
        return "";
    }
}
