// -- IMPORTS

import game.english_language;
import game.french_language;
import game.language;
import game.spanish_language;
import game.translation;
import std.stdio : write, writeln;

// -- FUNCTIONS

void TestLanguage(
    LANGUAGE language
    )
{
    TRANSLATION
        swords_translation;

    swords_translation = language.Swords( TRANSLATION( 3 ) );

    write( language.Test() );
    writeln( language.TheItemsHaveBeenFound( swords_translation ) );
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
