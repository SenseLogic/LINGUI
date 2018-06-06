// -- IMPORTS

import std.stdio : writeln;
import ENGLISH_LANGUAGE_MODULE;
import FRENCH_LANGUAGE_MODULE;
import GAME_LANGUAGE_MODULE;
import GERMAN_LANGUAGE_MODULE;
import TRANSLATION_MODULE;

// -- FUNCTIONS

void TestLanguage(
    GAME_LANGUAGE game_language
    )
{
    writeln( game_language.New_game() );
    writeln( game_language.Welcome( TRANSLATION( "Jack" ), TRANSLATION( "Sparrow" ) ) );
    writeln( game_language.Pears( TRANSLATION( 0 ) ) );
    writeln( game_language.Pears( TRANSLATION( 1 ) ) );
    writeln( game_language.Pears( TRANSLATION( 2 ) ) );
}

// ~~

void main(
    string[] argument_array
    )
{
    TestLanguage( new ENGLISH_LANGUAGE() );
    TestLanguage( new GERMAN_LANGUAGE() );
    TestLanguage( new FRENCH_LANGUAGE() );
}
