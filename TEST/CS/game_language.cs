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

        public virtual string DumpPlurality(
            TRANSLATION this_translation
            )
        {
            return "";
        }

        // ~~

        public virtual string Dump(
            TRANSLATION this_translation
            )
        {
            TRANSLATION
                result_translation = new TRANSLATION();

            result_translation.AddText( "\"" + this_translation.Text + "\" / \"" + this_translation.Quantity + "\" / '" + this_translation.GetQuantityFirstCharacter() + "' / " );

            if ( this_translation.HasIntegerQuantity )
            {
                result_translation.AddText( GetIntegerText( this_translation.IntegerQuantity ) + " / " );
            }

            if ( this_translation.HasRealQuantity )
            {
                result_translation.AddText( GetRealText( this_translation.RealQuantity ) + " / " );
            }

            result_translation.AddText( DumpPlurality( this_translation ) );
            result_translation.AddText( GetGenreText( this_translation.Genre ) + "\n" );

            return result_translation.Text;
        }

        // ~~

        public virtual string TestFunctions(
            )
        {
            TRANSLATION
                result_translation = new TRANSLATION();

            result_translation.AddText( GetIntegerText( -12 ) + " / " + GetRealText( -12.0f, 0 ) + " / " + GetRealText( -12.0f ) + " / " + GetRealText( -12.0f, 3, 3 ) + " \n" );
            result_translation.AddText( GetRealText( -12.3f, 3, 3, '_' ) + " / " + GetRealText( -12.345f ) + " / " + GetRealText( -12.3456789f, 0, 3, DecimalSeparator ) + "\n" );
            result_translation.AddText( GetLowerCase( "jack SPARROW" ) + " / " + GetUpperCase( "john MCLANE" ) + "\n" );
            result_translation.AddText( GetSentenceCase( "jason bourne" ) + " / " + GetTitleCase( "james kirk" ) + "\n" );
            result_translation.AddText( Dump( MakeTranslation( "cm" ) ) );
            result_translation.AddText( Dump( MakeTranslation( "cm", "-12.345" ) ) );
            result_translation.AddText( Dump( MakeTranslation( "cm", "-12.345", GENRE.Male ) ) );
            result_translation.AddText( Dump( MakeTranslation( 12 ) ) );
            result_translation.AddText( Dump( MakeTranslation( 12, GENRE.Female ) ) );
            result_translation.AddText( Dump( new TRANSLATION( "", "3" ) ) );
            result_translation.AddText( Dump( new TRANSLATION( "perros", "4" ) ) );
            result_translation.AddText( Dump( new TRANSLATION( "fiestas", "5", GENRE.Female ) ) );
            result_translation.AddText( Dump( new TRANSLATION( "", "6.5" ) ) );
            result_translation.AddText( Dump( new TRANSLATION( "metros", "7.5" ) ) );
            result_translation.AddText( Dump( new TRANSLATION( "vueltas", "8.5", GENRE.Female ) ) );

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
