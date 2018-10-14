// -- IMPORTS

using LINGUI;

// -- TYPES

namespace LINGUI
{
    public class FRENCH_LANGUAGE : GAME_LANGUAGE
    {
        // -- CONSTRUCTORS

        public FRENCH_LANGUAGE(
            )
        {
            Name = "French";
            DecimalSeparator = ',';
        }

        // -- INQUIRIES

        public override string NewGame(
            )
        {
            return "Nouveau jeu";
        }

        // ~~

        public override string Welcome(
            TRANSLATION first_name_translation,
            TRANSLATION last_name_translation
            )
        {
            TRANSLATION
                result_translation = new TRANSLATION();

            result_translation.AddText( "Bienvenue, " );
            result_translation.AddText( first_name_translation );
            result_translation.AddText( " " );
            result_translation.AddText( last_name_translation );
            result_translation.AddText( " !" );

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

            if ( count_translation.GetFrenchCardinalPlurality() == PLURALITY.One )
            {
                result_translation.AddText( "poire" );
            }
            else
            {
                result_translation.AddText( "poires" );
            }

            return result_translation.Text;
        }
    }
}
