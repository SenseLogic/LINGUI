// -- IMPORTS

using GAME;

// -- TYPES

namespace GAME
{
    public class GAME_LANGUAGE : LANGUAGE
    {
        // -- INQUIRIES

        public virtual string Main_menu(
            )
        {
            return "";
        }

        // ~~

        public virtual TRANSLATION Chests(
            TRANSLATION count_translation
            )
        {
            return TRANSLATION.Null;
        }

        // ~~

        public virtual TRANSLATION Swords(
            TRANSLATION count_translation
            )
        {
            return TRANSLATION.Null;
        }

        // ~~

        public virtual TRANSLATION No_swords(
            )
        {
            return Swords( new TRANSLATION( "", "0" ) );
        }

        // ~~

        public virtual TRANSLATION One_sword(
            )
        {
            return Swords( new TRANSLATION( "", "1" ) );
        }

        // ~~

        public virtual string The_items(
            TRANSLATION items_translation
            )
        {
            return "";
        }

        // ~~

        public virtual string The_items_have_been_found(
            TRANSLATION items_translation
            )
        {
            return "";
        }

        // ~~

        public virtual string Test(
            )
        {
            TRANSLATION
                result_translation = new TRANSLATION(),
                no_chests_translation = new TRANSLATION(),
                one_chest_translation = new TRANSLATION();

            no_chests_translation = Chests( new TRANSLATION( "", "0" ) );
            one_chest_translation = Chests( new TRANSLATION( "", "1" ) );
            result_translation.AddText( The_items_have_been_found( no_chests_translation ) );
            result_translation.AddText( The_items_have_been_found( one_chest_translation ) );
            result_translation.AddText( The_items_have_been_found( Chests( new TRANSLATION( "", "2" ) ) ) );
            result_translation.AddText( The_items_have_been_found( No_swords() ) );
            result_translation.AddText( The_items_have_been_found( One_sword() ) );
            result_translation.AddText( The_items_have_been_found( Swords( new TRANSLATION( "", "2" ) ) ) );

            return result_translation.Text;
        }
    }
}
