// -- IMPORTS

import "base_language.dart";
import "genre.dart";
import "plurality.dart";
import "translation.dart";

// -- TYPES

class LANGUAGE extends BASE_LANGUAGE
{
    // -- CONSTRUCTORS

    LANGUAGE(
        ) : super()
    {
    }

    // -- INQUIRIES

    String MainMenu(
        )
    {
        return "";
    }

    // ~~

    String GetDate(
        String day,
        String month,
        String year
        )
    {
        return day + "/" + month + "/" + year;
    }

    // ~~

    TRANSLATION Chests(
        TRANSLATION count_translation
        )
    {
        return TRANSLATION.Null;
    }

    // ~~

    TRANSLATION Swords(
        TRANSLATION count_translation
        )
    {
        return TRANSLATION.Null;
    }

    // ~~

    TRANSLATION NoSwords(
        )
    {
        return Swords( TRANSLATION( "", "0" ) );
    }

    // ~~

    TRANSLATION OneSword(
        )
    {
        return Swords( TRANSLATION( "", "1" ) );
    }

    // ~~

    String TheItems(
        TRANSLATION items_translation
        )
    {
        return "";
    }

    // ~~

    String TheItemsHaveBeenFound(
        TRANSLATION items_translation
        )
    {
        return "";
    }

    // ~~

    String Dump(
        TRANSLATION this_translation
        )
    {
        TRANSLATION
            result_translation = TRANSLATION();

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

    bool GetOppositeBoolean(
        bool value
        )
    {
        bool
            result;

        result = ! value;

        return result;
    }

    // ~~

    int GetOppositeInteger(
        int value
        )
    {
        int
            result;

        result = - value;

        return result;
    }

    // ~~

    double GetOppositeReal(
        double value
        )
    {
        double
            result;

        result = - value;

        return result;
    }

    // ~~

    String GetOppositeString(
        String value
        )
    {
        String
            result = "";

        result = "not " + value;

        return result;
    }

    // ~~

    TRANSLATION GetOppositeTranslation(
        TRANSLATION value_translation
        )
    {
        TRANSLATION
            result_translation = TRANSLATION();

        result_translation.SetQuantity( value_translation.Quantity );
        result_translation.SetText( "not " + value_translation.Text );
        result_translation.SetGenre( value_translation.Genre );

        return result_translation;
    }

    // ~~

    TRANSLATION GetInverseTranslation(
        TRANSLATION value_translation
        )
    {
        TRANSLATION
            result_translation = TRANSLATION();

        result_translation.SetQuantity( value_translation.Quantity );
        result_translation.SetText( "one over " + value_translation.Text );
        result_translation.SetGenre( value_translation.Genre );

        return result_translation;
    }

    // ~~

    String TestFunctions(
        )
    {
        bool
            opposite_boolean;
        int
            opposite_integer;
        double
            opposite_real;
        String
            opposite_string = "";
        TRANSLATION
            opposite_translation_translation = TRANSLATION(),
            inverse_translation_translation = TRANSLATION(),
            result_translation = TRANSLATION();

        opposite_boolean = GetOppositeBoolean( true );
        opposite_integer = GetOppositeInteger( 1 );
        opposite_real = GetOppositeReal( 1.0 );
        opposite_string = GetOppositeString( "one" );
        opposite_translation_translation = GetOppositeTranslation( TRANSLATION( "one", "1" ) );
        inverse_translation_translation = GetInverseTranslation( TRANSLATION( "x", "1" ) );
        result_translation.AddText( GetBooleanText( opposite_boolean ) + " / " + GetIntegerText( opposite_integer ) + " / " + GetRealText( opposite_real ) + " / " + opposite_string + " / " + opposite_translation_translation.Text + " / " + inverse_translation_translation.Text + "\n" );
        result_translation.AddText( GetBooleanText( false ) + " / " + GetBooleanText( true ) + "\n" );
        result_translation.AddText( GetIntegerText( -12, 4 ) + " / " + GetIntegerText( 12, 4 ) + "\n" );
        result_translation.AddText( GetIntegerText( -12 ) + " / " + GetRealText( -12.0, -1 ) + " / " + GetRealText( -12.0 ) + " / " + GetRealText( -12.0, 3 ) + " \n" );
        result_translation.AddText( GetRealText( -12.3, 3, 3, '_' ) + " / " + GetRealText( -12.345 ) + " / " + GetRealText( -12.3456789, 0, 3, DotCharacter ) + "\n" );
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
        result_translation.AddText( Dump( TRANSLATION( "", "3" ) ) );
        result_translation.AddText( Dump( TRANSLATION( "perros", "4" ) ) );
        result_translation.AddText( Dump( TRANSLATION( "fiestas", "5", GENRE.Female ) ) );
        result_translation.AddText( Dump( TRANSLATION( "", "6.5" ) ) );
        result_translation.AddText( Dump( TRANSLATION( "metros", "7.5" ) ) );
        result_translation.AddText( Dump( TRANSLATION( "vueltas", "8.5", GENRE.Female ) ) );
        result_translation.AddText( GetText( "English" ) + " / " + GetText( "French" ) + " / " + GetDate( "18", "2", "2018" ) + "\n" );

        return result_translation.Text;
    }

    // ~~

    TRANSLATION Kings(
        TRANSLATION count_translation
        )
    {
        TRANSLATION
            result_translation = TRANSLATION();

        result_translation.SetText( "reyes" );
        result_translation.SetQuantity( count_translation.Quantity );
        result_translation.SetGenre( GENRE.Male );

        return result_translation;
    }

    // ~~

    String Test(
        )
    {
        TRANSLATION
            no_chests_translation = TRANSLATION(),
            one_chest_translation = TRANSLATION(),
            kings_translation = TRANSLATION(),
            queens_translation = TRANSLATION(),
            princes_translation = TRANSLATION(),
            result_translation = TRANSLATION();

        no_chests_translation = Chests( TRANSLATION( "", "0" ) );
        one_chest_translation = Chests( TRANSLATION( "", "1" ) );
        result_translation.AddText( TheItemsHaveBeenFound( no_chests_translation ) );
        result_translation.AddText( TheItemsHaveBeenFound( one_chest_translation ) );
        result_translation.AddText( TheItemsHaveBeenFound( Chests( TRANSLATION( "", "2" ) ) ) );
        result_translation.AddText( TheItemsHaveBeenFound( NoSwords() ) );
        result_translation.AddText( TheItemsHaveBeenFound( OneSword() ) );
        result_translation.AddText( TheItemsHaveBeenFound( Swords( TRANSLATION( "", "2" ) ) ) );
        result_translation.AddText( TestFunctions() );
        kings_translation = Kings( TRANSLATION( "", "1" ) );
        queens_translation.SetText( "reinas" );
        queens_translation.SetQuantity( "2" );
        queens_translation.SetGenre( GENRE.Female );
        princes_translation = TRANSLATION( "príncipes", "3", GENRE.Male );
        result_translation.AddText( kings_translation.Text + " " + queens_translation.Text + " " + princes_translation.Text + "\n" );

        return result_translation.Text;
    }
}
