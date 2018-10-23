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
            string first_name,
            string last_name
            )
        {
            return "";
        }

        // ~~

        public virtual string Pears(
            int count
            )
        {
            return "";
        }
    }
}
