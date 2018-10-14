library game;

// -- IMPORTS

import "genre.dart";
import "plurality.dart";
import "translation.dart";
import "language.dart";

// -- TYPES

class GAME_LANGUAGE extends LANGUAGE
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

    String TestFunctions(
        )
    {
        TRANSLATION
            result_translation = TRANSLATION();

        result_translation.AddText( GetText( -12 ) + " / " + GetText( -12.0, 0 ) + " / " + GetText( -12.0 ) + " / " + GetText( -12.0, 3, 3 ) + " \n" );
        result_translation.AddText( GetText( -12.3, 3, 3, '_' ) + " / " + GetText( -12.345 ) + " / " + GetText( -12.3456789, 0, 3, DecimalSeparator ) + "\n" );
        result_translation.AddText( GetLowerCase( "jack SPARROW" ) + " / " + GetUpperCase( "john MCLANE" ) + "\n" );
        result_translation.AddText( GetSentenceCase( "jason bourne" ) + " / " + GetTitleCase( "james kirk" ) + "\n" );

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