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
