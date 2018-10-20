// -- IMPORTS

import lingui.english_language;
import lingui.french_language;
import lingui.german_language;
import lingui.language;
import lingui.translation;
import std.stdio : writeln;

// -- FUNCTIONS

void TestLanguage(
    LANGUAGE language
    )
{
    writeln( language.NewGame() );
    writeln( language.Welcome( TRANSLATION( "Jack" ), TRANSLATION( "Sparrow" ) ) );
    writeln( language.Pears( TRANSLATION( 0 ) ) );
    writeln( language.Pears( TRANSLATION( 1 ) ) );
    writeln( language.Pears( TRANSLATION( 2 ) ) );
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
