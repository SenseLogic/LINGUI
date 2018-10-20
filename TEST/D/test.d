// -- IMPORTS

import game.english_language;
import game.french_language;
import game.language;
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
    ENGLISH_LANGUAGE
        english_language;
    FRENCH_LANGUAGE
        french_language;

    english_language = new ENGLISH_LANGUAGE();
    french_language = new FRENCH_LANGUAGE();

    TestLanguage( english_language );
    TestLanguage( french_language );
}
