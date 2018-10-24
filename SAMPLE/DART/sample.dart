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
    print( language.GetText( "princess" ) );
    print( language.GetText( "NewGame" ) );
    print( language.GameOver() );
    print( language.Welcome( "Jack", "Sparrow" ) );
    print( language.Pears( 0 ) );
    print( language.Pears( 1 ) );
    print( language.Pears( 2 ) );
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
