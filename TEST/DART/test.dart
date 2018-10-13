// -- IMPORTS

import "dart:io";
import "english_language.dart";
import "french_language.dart";
import "game_language.dart";
import "translation.dart";

// -- FUNCTIONS

void TestLanguage(
    GAME_LANGUAGE game_language
    )
{
    TRANSLATION
        swords_translation;

    swords_translation = game_language.Swords( TRANSLATION.FromQuantity( 3 ) );

    stdout.write( game_language.Test() );
    stdout.writeln( game_language.TheItemsHaveBeenFound( swords_translation ) );
}

// ~~

void main(
    List<String> argument_list
    )
{
    ENGLISH_LANGUAGE
        english_language;
    FRENCH_LANGUAGE
        french_language;

    english_language = ENGLISH_LANGUAGE();
    french_language = FRENCH_LANGUAGE();

    TestLanguage( english_language );
    TestLanguage( french_language );
}
