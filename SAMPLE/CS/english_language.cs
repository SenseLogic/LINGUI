// -- IMPORTS

using LINGUI;

// -- TYPES

namespace LINGUI
{
    public class ENGLISH_LANGUAGE : GAME_LANGUAGE
    {
        // -- CONSTRUCTORS

        public ENGLISH_LANGUAGE(
            )
        {
            Name = "English";
        }

        // -- INQUIRIES

        public override string NewGame(
            )
        {
            return "New game";
        }

        // ~~

        public override string Welcome(
            TRANSLATION first_name_translation,
            TRANSLATION last_name_translation
            )
        {
            TRANSLATION
                result_translation = new TRANSLATION();

            result_translation.AddText( "Welcome, " );
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

            if ( count_translation.GetEnglishCardinalPlurality() == PLURALITY.One )
            {
                result_translation.AddText( "pear" );
            }
            else
            {
                result_translation.AddText( "pears" );
            }

            return result_translation.Text;
        }
    }
}
