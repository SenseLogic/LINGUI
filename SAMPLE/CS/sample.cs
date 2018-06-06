// -- IMPORTS

using System;

// -- TYPES

public class TEST
{
    // -- OPERATIONS

    public static void TestLanguage(
        GAME_LANGUAGE game_language
        )
    {
        Console.WriteLine( game_language.New_game() );
        Console.WriteLine( game_language.Welcome( new TRANSLATION( "Jack" ), new TRANSLATION( "Sparrow" ) ) );
        Console.WriteLine( game_language.Pears( new TRANSLATION( 0 ) ) );
        Console.WriteLine( game_language.Pears( new TRANSLATION( 1 ) ) );
        Console.WriteLine( game_language.Pears( new TRANSLATION( 2 ) ) );
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
