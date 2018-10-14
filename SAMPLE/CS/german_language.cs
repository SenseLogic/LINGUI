// -- IMPORTS

using LINGUI;

// -- TYPES

namespace LINGUI
{
    public class GERMAN_LANGUAGE : GAME_LANGUAGE
    {
        // -- CONSTRUCTORS

        public GERMAN_LANGUAGE(
            )
        {
            Name = "German";
            DecimalSeparator = ',';
        }

        // -- INQUIRIES

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
            TRANSLATION
                result_translation = new TRANSLATION();

            result_translation.AddText( "Willkommen, " );
            result_translation.AddText( first_name_translation );
            result_translation.AddText( " " );
            result_translation.AddText( last_name_translation );
            result_translation.AddText( "!" );

            return result_translation.Text;
        }

        // ~~

        public override string Pears(
            TRANSLATION count_translation
            )
        {
            TRANSLATION
                result_translation = new TRANSLATION();

            result_translation.AddText( count_translation.Quantity );
            result_translation.AddText( " " );

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
