// -- IMPORTS

import std.stdio : writeln;
import english_language;
import french_language;
import game_language;
import german_language;
import translation;

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
