// -- IMPORTS

using LINGUI;

// -- TYPES

namespace LINGUI
{
    public class GERMAN_LANGUAGE : LANGUAGE
    {
        // -- CONSTRUCTORS

        public GERMAN_LANGUAGE(
            )
        {
            Name = "German";
            DotCharacter = ',';
        }

        // -- INQUIRIES

        public override PLURALITY GetCardinalPlurality(
            TRANSLATION translation
            )
        {
            return translation.GetGermanCardinalPlurality();
        }

        // ~~

        public override PLURALITY GetOrdinalPlurality(
            TRANSLATION translation
            )
        {
            return translation.GetGermanOrdinalPlurality();
        }

        // ~~

        public override string NewGame(
            )
        {
            return "Neues Spiel";
        }

        // ~~

        public override string Welcome(
            TRANSLATION first_name_translation,
            TRANSLATION last_name_translation
            )
        {
            return "Willkommen, " + first_name_translation.Text + " " + last_name_translation.Text + "!";
        }

        // ~~

        public override string Pears(
            TRANSLATION count_translation
            )
        {
            TRANSLATION
                result_translation = new TRANSLATION();

            result_translation.AddText( count_translation.Quantity + " " );

            if ( count_translation.GetGermanCardinalPlurality() == PLURALITY.One )
            {
                result_translation.AddText( "Birne" );
            }
            else
            {
                result_translation.AddText( "Birnen" );
            }

            return result_translation.Text;
        }
    }
}
