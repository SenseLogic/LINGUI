// -- IMPORTS

import std.stdio : write, writeln;
import english_language;
import french_language;
import game_language;
import translation;

// -- FUNCTIONS

void TestLanguage(
    GAME_LANGUAGE game_language
    )
{
    TRANSLATION
        swords_translation;

    swords_translation = game_language.Swords( TRANSLATION( 3 ) );

    write( game_language.Test() );
    writeln( game_language.The_items_have_been_found( swords_translation ) );
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
