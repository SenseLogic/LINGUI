// -- IMPORTS

using GAME;

// -- TYPES

namespace GAME
{
    public class LANGUAGE : BASE_LANGUAGE
    {
        // -- CONSTRUCTORS

        public LANGUAGE(
            ) : base()
        {
        }

        // -- INQUIRIES

        public virtual string MainMenu(
            )
        {
            return "";
        }

        // ~~

        public virtual string GetDate(
            string day,
            string month,
            string year
            )
        {
            return day + "/" + month + "/" + year;
        }

        // ~~

        public virtual TRANSLATION Chests(
            int count
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

            result_translation.AddText( GetPluralityText( GetCardinalPlurality( this_translation ) ) + " / " + GetPluralityText( GetOrdinalPlurality( this_translation ) ) + " / " + GetGenreText( this_translation.Genre ) + "\n" );

            return result_translation.Text;
        }

        // ~~

        public virtual bool GetOppositeBoolean(
            bool value
            )
        {
            bool
                result;

            result = ! value;

            return result;
        }

        // ~~

        public virtual int GetOppositeInteger(
            int value
            )
        {
            int
                result;

            result = - value;

            return result;
        }

        // ~~

        public virtual float GetOppositeReal(
            float value
            )
        {
            float
                result;

            result = - value;

            return result;
        }

        // ~~

        public virtual string GetOppositeString(
            string value
            )
        {
            string
                result = "";

            result = "not " + value;

            return result;
        }

        // ~~

        public virtual TRANSLATION GetOppositeTranslation(
            TRANSLATION value_translation
            )
        {
            TRANSLATION
                result_translation = new TRANSLATION();

            result_translation.SetQuantity( value_translation.Quantity );
            result_translation.SetText( "not " + value_translation.Text );
            result_translation.SetGenre( value_translation.Genre );

            return result_translation;
        }

        // ~~

        public virtual TRANSLATION GetInverseTranslation(
            TRANSLATION value_translation
            )
        {
            TRANSLATION
                result_translation = new TRANSLATION();

            result_translation.SetQuantity( value_translation.Quantity );
            result_translation.SetText( "one over " + value_translation.Text );
            result_translation.SetGenre( value_translation.Genre );

            return result_translation;
        }

        // ~~

        public virtual string TestConditions(
            int value
            )
        {
            TRANSLATION
                result_translation = new TRANSLATION();

            result_translation.AddText( GetIntegerText( value ) );

            if ( value < 0 )
            {
                if ( value < -20 )
                {
                    result_translation.AddText( " < -20" );
                }
                else if ( value < -10 )
                {
                    result_translation.AddText( " < -10" );
                }
                else
                {
                    result_translation.AddText( " < 0" );
                }
            }
            else if ( value > 0 )
            {
                if ( value > 20 )
                {
                    result_translation.AddText( " > 20" );
                }
                else if ( value > 10 )
                {
                    result_translation.AddText( " > 10" );
                }
                else
                {
                    result_translation.AddText( " > 0" );
                }
            }
            else
            {
                result_translation.AddText( " = 0" );
            }

            result_translation.AddText( "\n" );

            return result_translation.Text;
        }

        // ~~

        public virtual string TestFunctions(
            )
        {
            bool
                opposite_boolean;
            int
                opposite_integer;
            float
                opposite_real;
            string
                opposite_string = "";
            TRANSLATION
                opposite_translation_translation = new TRANSLATION(),
                inverse_translation_translation = new TRANSLATION(),
                result_translation = new TRANSLATION();

            opposite_boolean = GetOppositeBoolean( true );
            opposite_integer = GetOppositeInteger( 1 );
            opposite_real = GetOppositeReal( 1.0f );
            opposite_string = GetOppositeString( "one" );
            opposite_translation_translation = GetOppositeTranslation( new TRANSLATION( "one", "1" ) );
            inverse_translation_translation = GetInverseTranslation( new TRANSLATION( "x", "1" ) );
            result_translation.AddText( GetBooleanText( opposite_boolean ) + " / " + GetIntegerText( opposite_integer ) + " / " + GetRealText( opposite_real ) + " / " + opposite_string + " / " + opposite_translation_translation.Text + " / " + inverse_translation_translation.Text + "\n" );
            result_translation.AddText( GetBooleanText( false ) + " / " + GetBooleanText( true ) + "\n" );
            result_translation.AddText( GetIntegerText( -12, 4 ) + " / " + GetIntegerText( 12, 4 ) + "\n" );
            result_translation.AddText( GetIntegerText( -12 ) + " / " + GetRealText( -12.0f, -1 ) + " / " + GetRealText( -12.0f ) + " / " + GetRealText( -12.0f, 3 ) + " \n" );
            result_translation.AddText( GetRealText( -12.3f, 3, 3, '_' ) + " / " + GetRealText( -12.345f ) + " / " + GetRealText( -12.3456789f, 0, 3, DotCharacter ) + "\n" );
            result_translation.AddText( GetLowerCase( "jack SPARROW" ) + " / " + GetUpperCase( "john MCLANE" ) + "\n" );
            result_translation.AddText( GetSentenceCase( "jason bourne" ) + " / " + GetTitleCase( "james kirk" ) + "\n" );
            result_translation.AddText( Dump( MakeTranslation( "cm" ) ) );
            result_translation.AddText( Dump( MakeTranslation( "cm", "0" ) ) );
            result_translation.AddText( Dump( MakeTranslation( "cm", "1" ) ) );
            result_translation.AddText( Dump( MakeTranslation( "cm", "2" ) ) );
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
            result_translation.AddText( GetText( "English" ) + " / " + GetText( "French" ) + " / " + GetDate( "18", "2", "2018" ) + "\n" );

            return result_translation.Text;
        }

        // ~~

        public virtual TRANSLATION Kings(
            TRANSLATION count_translation
            )
        {
            TRANSLATION
                result_translation = new TRANSLATION();

            result_translation.SetText( "reyes" );
            result_translation.SetQuantity( count_translation.Quantity );
            result_translation.SetGenre( GENRE.Male );

            return result_translation;
        }

        // ~~

        public virtual string Test(
            )
        {
            TRANSLATION
                no_chests_translation = new TRANSLATION(),
                one_chest_translation = new TRANSLATION(),
                kings_translation = new TRANSLATION(),
                queens_translation = new TRANSLATION(),
                princes_translation = new TRANSLATION(),
                result_translation = new TRANSLATION();

            no_chests_translation = Chests( 0 );
            one_chest_translation = Chests( 1 );
            result_translation.AddText( TheItemsHaveBeenFound( no_chests_translation ) );
            result_translation.AddText( TheItemsHaveBeenFound( one_chest_translation ) );
            result_translation.AddText( TheItemsHaveBeenFound( Chests( 2 ) ) );
            result_translation.AddText( TheItemsHaveBeenFound( NoSwords() ) );
            result_translation.AddText( TheItemsHaveBeenFound( OneSword() ) );
            result_translation.AddText( TheItemsHaveBeenFound( Swords( new TRANSLATION( "", "2" ) ) ) );
            result_translation.AddText( TestFunctions() );
            result_translation.AddText( TestConditions( -25 ) );
            result_translation.AddText( TestConditions( -15 ) );
            result_translation.AddText( TestConditions( -5 ) );
            result_translation.AddText( TestConditions( 0 ) );
            result_translation.AddText( TestConditions( 5 ) );
            result_translation.AddText( TestConditions( 15 ) );
            result_translation.AddText( TestConditions( 25 ) );
            kings_translation = Kings( new TRANSLATION( "", "1" ) );
            queens_translation.SetText( "reinas" );
            queens_translation.SetQuantity( "2" );
            queens_translation.SetGenre( GENRE.Female );
            princes_translation = new TRANSLATION( "príncipes", "3", GENRE.Male );
            result_translation.AddText( kings_translation.Text + " " + queens_translation.Text + " " + princes_translation.Text + "\n" );

            return result_translation.Text;
        }
    }
}
