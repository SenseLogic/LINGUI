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
    writeln( language.GetText( "princess" ) );
    writeln( language.GetText( "NewGame" ) );
    writeln( language.GameOver() );
    writeln( language.Welcome( "Jack", "Sparrow" ) );
    writeln( language.Pears( 0 ) );
    writeln( language.Pears( 1 ) );
    writeln( language.Pears( 2 ) );
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
