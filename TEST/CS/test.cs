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
        TRANSLATION
            swords_translation;

        swords_translation = language.Swords( new TRANSLATION( 3 ) );

        Console.Write( language.Test() );
        Console.WriteLine( language.TheItemsHaveBeenFound( swords_translation ) );
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
