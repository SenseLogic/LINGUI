// -- IMPORTS

import "dart:io";
import "english_language.dart";
import "french_language.dart";
import "language.dart";
import "translation.dart";

// -- FUNCTIONS

void TestLanguage(
    LANGUAGE language
    )
{
    TRANSLATION
        swords_translation;

    swords_translation = language.Swords( TRANSLATION( 3 ) );

    stdout.write( language.Test() );
    stdout.writeln( language.TheItemsHaveBeenFound( swords_translation ) );
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
