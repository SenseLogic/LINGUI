// -- IMPORTS

using LINGUI;

// -- TYPES

namespace LINGUI
{
    public class LANGUAGE : BASE_LANGUAGE
    {
        // -- CONSTRUCTORS

        public LANGUAGE(
            ) : base()
        {
        }

        // -- INQUIRIES

        public virtual string GameOver(
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
