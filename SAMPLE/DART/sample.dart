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
    Console.WriteLine( game_language.NewGame() );
    Console.WriteLine( game_language.Welcome( TRANSLATION( "Jack" ), TRANSLATION( "Sparrow" ) ) );
    Console.WriteLine( game_language.Pears( TRANSLATION( 0 ) ) );
    Console.WriteLine( game_language.Pears( TRANSLATION( 1 ) ) );
    Console.WriteLine( game_language.Pears( TRANSLATION( 2 ) ) );
}

// ~~

void Main(
    List<String> argument_list
    )
{
    TestLanguage( ENGLISH_LANGUAGE() );
    TestLanguage( GERMAN_LANGUAGE() );
    TestLanguage( FRENCH_LANGUAGE() );
}
