// -- IMPORTS

import "base_language.dart";
import "genre.dart";
import "plurality.dart";
import "translation.dart";

// -- TYPES

class LANGUAGE extends BASE_LANGUAGE
{
    // -- INQUIRIES

    String MainMenu(
        )
    {
        return "";
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
        TRANSLATION
            result_translation = TRANSLATION();

        result_translation.AddText( Swords( TRANSLATION( "", "0" ) ) );

        return result_translation;
    }

    // ~~

    TRANSLATION OneSword(
        )
    {
        TRANSLATION
            result_translation = TRANSLATION();

        result_translation.AddText( Swords( TRANSLATION( "", "1" ) ) );

        return result_translation;
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

    String TestFunctions(
        )
    {
        TRANSLATION
            result_translation = TRANSLATION();

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

        return result_translation.Text;
    }

    // ~~

    String Test(
        )
    {
        TRANSLATION
            result_translation = TRANSLATION(),
            no_chests_translation = TRANSLATION(),
            one_chest_translation = TRANSLATION();

        no_chests_translation = Chests( TRANSLATION( "", "0" ) );
        one_chest_translation = Chests( TRANSLATION( "", "1" ) );
        result_translation.AddText( TheItemsHaveBeenFound( no_chests_translation ) );
        result_translation.AddText( TheItemsHaveBeenFound( one_chest_translation ) );
        result_translation.AddText( TheItemsHaveBeenFound( Chests( TRANSLATION( "", "2" ) ) ) );
        result_translation.AddText( TheItemsHaveBeenFound( NoSwords() ) );
        result_translation.AddText( TheItemsHaveBeenFound( OneSword() ) );
        result_translation.AddText( TheItemsHaveBeenFound( Swords( TRANSLATION( "", "2" ) ) ) );
        result_translation.AddText( TestFunctions() );

        return result_translation.Text;
    }
}
