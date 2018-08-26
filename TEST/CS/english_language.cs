// -- IMPORTS

using GAME;

// -- TYPES

namespace GAME
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

        public override string Main_menu(
            )
        {
            return "Main menu";
        }

        // ~~

        public override TRANSLATION Chests(
            TRANSLATION count_translation
            )
        {
            TRANSLATION
                result_translation = new TRANSLATION();

            if ( count_translation.IntegerQuantity == 1 )
            {
                result_translation.AddText( "chest" );
            }
            else
            {
                result_translation.AddText( "chests" );
            }

            result_translation.SetQuantity( count_translation.Quantity );

            return result_translation;
        }

        // ~~

        public override TRANSLATION Swords(
            TRANSLATION count_translation
            )
        {
            TRANSLATION
                result_translation = new TRANSLATION();

            if ( count_translation.GetEnglishCardinalPlurality() == PLURALITY.One )
            {
                result_translation.AddText( "sword" );
            }
            else
            {
                result_translation.AddText( "swords" );
            }

            result_translation.SetQuantity( count_translation.Quantity );

            return result_translation;
        }

        // ~~

        public override string The_items(
            TRANSLATION items_translation
            )
        {
            TRANSLATION
                result_translation = new TRANSLATION();

            if ( items_translation.IntegerQuantity == 0 )
            {
                result_translation.AddText( "No " );
            }
            else if ( items_translation.IntegerQuantity == 1 )
            {
                result_translation.AddText( "The " );
            }
            else
            {
                result_translation.AddText( "The " );
                result_translation.AddText( items_translation.Quantity );
                result_translation.AddText( " " );
            }

            result_translation.AddText( items_translation );

            return result_translation.Text;
        }

        // ~~

        public override string The_items_have_been_found(
            TRANSLATION items_translation
            )
        {
            TRANSLATION
                result_translation = new TRANSLATION();

            result_translation.AddText( The_items( items_translation ) );

            if ( items_translation.IntegerQuantity == 1 )
            {
                result_translation.AddText( " has" );
            }
            else
            {
                result_translation.AddText( " have" );
            }

            result_translation.AddText( " been found.\n" );

            return result_translation.Text;
        }
    }
}
