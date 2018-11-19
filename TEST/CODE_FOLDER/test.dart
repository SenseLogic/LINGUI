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
    stdout.writeln( language.GetText( 'Language:' ) );

    stdout.writeln(
        language.GetText(
            'Unknown'
            )
        );
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
