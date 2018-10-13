// -- IMPORTS

using GAME;

// -- TYPES

namespace GAME
{
    public class GAME_LANGUAGE : LANGUAGE
    {
        // -- INQUIRIES

        public virtual string MainMenu(
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

        public virtual TRANSLATION NoSwords(
            )
        {
            return Swords( new TRANSLATION( "", "0" ) );
        }

        // ~~

        public virtual TRANSLATION OneSword(
            )
        {
            return Swords( new TRANSLATION( "", "1" ) );
        }

        // ~~

        public virtual string TheItems(
            TRANSLATION items_translation
            )
        {
            return "";
        }

        // ~~

        public virtual string TheItemsHaveBeenFound(
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
            result_translation.AddText( TheItemsHaveBeenFound( no_chests_translation ) );
            result_translation.AddText( TheItemsHaveBeenFound( one_chest_translation ) );
            result_translation.AddText( TheItemsHaveBeenFound( Chests( new TRANSLATION( "", "2" ) ) ) );
            result_translation.AddText( TheItemsHaveBeenFound( NoSwords() ) );
            result_translation.AddText( TheItemsHaveBeenFound( OneSword() ) );
            result_translation.AddText( TheItemsHaveBeenFound( Swords( new TRANSLATION( "", "2" ) ) ) );

            return result_translation.Text;
        }
    }
}
