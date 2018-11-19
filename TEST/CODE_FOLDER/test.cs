// -- IMPORTS

using System;
using GAME;

// -- TYPES

public class TEST
{
    // -- OPERATIONS

    public static void TestLanguage(
        LANGUAGE language
        )
    {
        Console.WriteLine( language.GetText( "Language:" ) );

        Console.WriteLine(
            language.GetText(
                "Unknown"
                )
            );
    }

    // ~~

    public static void Main(
        string[] argument_array
        )
    {
        TestLanguage( new ENGLISH_LANGUAGE() );
        TestLanguage( new FRENCH_LANGUAGE() );
        TestLanguage( new SPANISH_LANGUAGE() );
    }
}
