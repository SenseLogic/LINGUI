// -- IMPORTS

using System;
using GAME;

// -- TYPES

public class TEST
{
    // -- OPERATIONS

    public static void TestLanguage(
        GAME_LANGUAGE game_language
        )
    {
        TRANSLATION
            swords_translation;

        swords_translation = game_language.Swords( new TRANSLATION( 3 ) );

        Console.Write( game_language.Test() );
        Console.WriteLine( game_language.The_items_have_been_found( swords_translation ) );
    }

    // ~~

    public static void Main(
        string[] argument_array
        )
    {
        ENGLISH_LANGUAGE
            english_language;
        FRENCH_LANGUAGE
            french_language;

        english_language = new ENGLISH_LANGUAGE();
        french_language = new FRENCH_LANGUAGE();

        TestLanguage( english_language );
        TestLanguage( french_language );
    }
}
