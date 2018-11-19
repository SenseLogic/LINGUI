// -- IMPORTS

import game.english_language;
import game.french_language;
import game.language;
import game.spanish_language;
import game.translation;
import std.stdio : writeln;

// -- FUNCTIONS

void TestLanguage(
    LANGUAGE language
    )
{
    writeln( language.GetText( "Language:" );

    writeln(
        language.GetText(
            "Unknown"
            )
        );
}

// ~~

void main(
    string[] argument_array
    )
{
    TestLanguage( new ENGLISH_LANGUAGE() );
    TestLanguage( new FRENCH_LANGUAGE() );
    TestLanguage( new SPANISH_LANGUAGE() );
}
