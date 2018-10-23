// -- IMPORTS

using System;
using LINGUI;

// -- TYPES

public class TEST
{
    // -- OPERATIONS

    public static void TestLanguage(
        LANGUAGE language
        )
    {
        Console.WriteLine( language.GetTranslation( "princess" ).Text );
        Console.WriteLine( language.GetTranslation( "NewGame" ).Text );
        Console.WriteLine( language.GameOver() );
        Console.WriteLine( language.Welcome( "Jack", "Sparrow" ) );
        Console.WriteLine( language.Pears( 0 ) );
        Console.WriteLine( language.Pears( 1 ) );
        Console.WriteLine( language.Pears( 2 ) );
    }

    // ~~

    public static void Main(
        string[] argument_array
        )
    {
        TestLanguage( new ENGLISH_LANGUAGE() );
        TestLanguage( new GERMAN_LANGUAGE() );
        TestLanguage( new FRENCH_LANGUAGE() );
    }
}
