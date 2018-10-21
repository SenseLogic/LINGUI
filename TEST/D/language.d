module game.language;

// -- IMPORTS

import game.base_language;
import game.genre;
import game.plurality;
import game.translation;

// -- TYPES

class LANGUAGE : BASE_LANGUAGE
{
    // -- INQUIRIES

    dstring MainMenu(
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
        return TRANSLATION( Swords( TRANSLATION( "", "0" ) ) );
    }

    // ~~

    TRANSLATION OneSword(
        )
    {
        return TRANSLATION( Swords( TRANSLATION( "", "1" ) ) );
    }

    // ~~

    dstring TheItems(
        TRANSLATION items_translation
        )
    {
        return "";
    }

    // ~~

    dstring TheItemsHaveBeenFound(
        TRANSLATION items_translation
        )
    {
        return "";
    }

    // ~~

    dstring Dump(
        TRANSLATION this_translation
        )
    {
        TRANSLATION
            result_translation;

        result_translation.AddText( "\"" ~ this_translation.Text ~ "\" / \"" ~ this_translation.Quantity ~ "\" / '" ~ this_translation.GetQuantityFirstCharacter() ~ "' / " );

        if ( this_translation.HasIntegerQuantity )
        {
            result_translation.AddText( GetIntegerText( this_translation.IntegerQuantity ) ~ " / " );
        }

        if ( this_translation.HasRealQuantity )
        {
            result_translation.AddText( GetRealText( this_translation.RealQuantity ) ~ " / " );
        }

        result_translation.AddText( GetPluralityText( GetCardinalPlurality( this_translation ) ) ~ " / " ~ GetPluralityText( GetOrdinalPlurality( this_translation ) ) ~ " / " ~ GetGenreText( this_translation.Genre ) ~ "\n" );

        return result_translation.Text;
    }

    // ~~

    dstring TestFunctions(
        )
    {
        TRANSLATION
            result_translation;

        result_translation.AddText( GetIntegerText( -12 ) ~ " / " ~ GetRealText( -12.0f, -1 ) ~ " / " ~ GetRealText( -12.0f ) ~ " / " ~ GetRealText( -12.0f, 3 ) ~ " \n" );
        result_translation.AddText( GetRealText( -12.3f, 3, 3, '_' ) ~ " / " ~ GetRealText( -12.345f ) ~ " / " ~ GetRealText( -12.3456789f, 0, 3, DotCharacter ) ~ "\n" );
        result_translation.AddText( GetLowerCase( "jack SPARROW" ) ~ " / " ~ GetUpperCase( "john MCLANE" ) ~ "\n" );
        result_translation.AddText( GetSentenceCase( "jason bourne" ) ~ " / " ~ GetTitleCase( "james kirk" ) ~ "\n" );
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

    dstring Test(
        )
    {
        TRANSLATION
            result_translation,
            no_chests_translation,
            one_chest_translation;

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
