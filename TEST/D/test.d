// -- IMPORTS

import game.english_language;
import game.french_language;
import game.game_language;
import game.translation;
import std.stdio : write, writeln;

// -- FUNCTIONS

void TestLanguage(
    GAME_LANGUAGE game_language
    )
{
    TRANSLATION
        swords_translation;

    swords_translation = game_language.Swords( TRANSLATION( 3 ) );

    write( game_language.Test() );
    writeln( game_language.TheItemsHaveBeenFound( swords_translation ) );
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
writeln( english_language.DecimalSeparator );
writeln( french_language.DecimalSeparator );
    TestLanguage( english_language );
    TestLanguage( french_language );
}
