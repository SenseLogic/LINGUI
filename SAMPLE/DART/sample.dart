// -- IMPORTS

import "english_language.dart";
import "french_language.dart";
import "german_language.dart";
import "language.dart";
import "translation.dart";

// -- FUNCTIONS

void TestLanguage(
    LANGUAGE language
    )
{
    print( language.NewGame() );
    print( language.Welcome( TRANSLATION( "Jack" ), TRANSLATION( "Sparrow" ) ) );
    print( language.Pears( TRANSLATION( 0 ) ) );
    print( language.Pears( TRANSLATION( 1 ) ) );
    print( language.Pears( TRANSLATION( 2 ) ) );
}

// ~~

void main(
    List<String> argument_list
    )
{
    TestLanguage( ENGLISH_LANGUAGE() );
    TestLanguage( GERMAN_LANGUAGE() );
    TestLanguage( FRENCH_LANGUAGE() );
}
