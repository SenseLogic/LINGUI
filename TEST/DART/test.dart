// -- IMPORTS

import "dart:io";
import "english_language.dart";
import "french_language.dart";
import "spanish_language.dart";
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
    TestLanguage( ENGLISH_LANGUAGE() );
    TestLanguage( FRENCH_LANGUAGE() );
    TestLanguage( SPANISH_LANGUAGE() );
}
