// -- IMPORTS

using LINGUI;

// -- TYPES

namespace LINGUI
{
    public class LANGUAGE : BASE_LANGUAGE
    {
        // -- INQUIRIES

        public virtual string NewGame(
            )
        {
            return "";
        }

        // ~~

        public virtual string Welcome(
            TRANSLATION first_name_translation,
            TRANSLATION last_name_translation
            )
        {
            return "";
        }

        // ~~

        public virtual string Pears(
            TRANSLATION count_translation
            )
        {
            return "";
        }
    }
}
