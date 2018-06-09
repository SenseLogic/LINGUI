// -- IMPORTS

import lingui.english_language;
import lingui.french_language;
import lingui.game_language;
import lingui.german_language;
import lingui.translation;
import std.stdio : writeln;

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
