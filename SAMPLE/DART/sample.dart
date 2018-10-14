// -- IMPORTS

import "english_language.dart";
import "french_language.dart";
import "game_language.dart";
import "german_language.dart";
import "translation.dart";

// -- FUNCTIONS

void TestLanguage(
    GAME_LANGUAGE game_language
    )
{
    print( game_language.NewGame() );
    print( game_language.Welcome( TRANSLATION( "Jack" ), TRANSLATION( "Sparrow" ) ) );
    print( game_language.Pears( TRANSLATION( 0 ) ) );
    print( game_language.Pears( TRANSLATION( 1 ) ) );
    print( game_language.Pears( TRANSLATION( 2 ) ) );
}

// ~~

void main(
    List<String> argument_list
    )
{
    TestLanguage( ENGLISH_LANGUAGE() );
    TestLanguage( GERMAN_LANGUAGE() );
    TestLanguage( FRENCH_LANGUAGE() );
}
