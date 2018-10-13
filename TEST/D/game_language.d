module game.game_language;

// -- IMPORTS

import game.genre;
import game.plurality;
import game.translation;
import game.language;

// -- TYPES

class GAME_LANGUAGE : LANGUAGE
{
    // -- INQUIRIES

    string MainMenu(
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

    string TheItems(
        TRANSLATION items_translation
        )
    {
        return "";
    }

    // ~~

    string TheItemsHaveBeenFound(
        TRANSLATION items_translation
        )
    {
        return "";
    }

    // ~~

    string TestFunctions(
        )
    {
        TRANSLATION
            result_translation;

        result_translation.AddText( GetText( -12 ) ~ " / " ~ GetText( -12.0f, 0 ) ~ " / " ~ GetText( -12.0f ) ~ " / " ~ GetText( -12.0f, 3, 3 ) ~ " \n" );
        result_translation.AddText( GetText( -12.3f, 3, 3, '_' ) ~ " / " ~ GetText( -12.345f ) ~ " / " ~ GetText( -12.3456789f, 0, 3, DecimalSeparator ) ~ "\n" );
        result_translation.AddText( GetLowerCase( "jack SPARROW" ) ~ " / " ~ GetUpperCase( "john MCLANE" ) ~ "\n" );
        result_translation.AddText( GetSentenceCase( "jason bourne" ) ~ " / " ~ GetTitleCase( "james kirk" ) ~ "\n" );

        return result_translation.Text;
    }

    // ~~

    string Test(
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
