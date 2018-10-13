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

        public virtual string TestFunctions(
            )
        {
            TRANSLATION
                result_translation = new TRANSLATION();

            result_translation.AddText( GetText( -12 ) + " / " + GetText( -12.0f, 0 ) + " / " + GetText( -12.0f ) + " / " + GetText( -12.0f, 3, 3 ) + " \n" );
            result_translation.AddText( GetText( -12.3f, 3, 3, '_' ) + " / " + GetText( -12.345f ) + " / " + GetText( -12.3456789f, 0, 3, DecimalSeparator ) + "\n" );
            result_translation.AddText( GetLowerCase( "jack SPARROW" ) + " / " + GetUpperCase( "john MCLANE" ) + "\n" );
            result_translation.AddText( GetSentenceCase( "jason bourne" ) + " / " + GetTitleCase( "james kirk" ) + "\n" );

            return result_translation.Text;
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
            result_translation.AddText( TestFunctions() );

            return result_translation.Text;
        }
    }
}
