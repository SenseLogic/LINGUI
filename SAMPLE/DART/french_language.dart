// -- IMPORTS

import "language.dart";
import "genre.dart";
import "plurality.dart";
import "translation.dart";

// -- TYPES

class FRENCH_LANGUAGE extends LANGUAGE
{
    // -- CONSTRUCTORS

    FRENCH_LANGUAGE(
        ) : super()
    {
        Name = "French";
        DotCharacter = ',';
        TranslationMap[ "princess" ] = TRANSLATION( "princesse", "1", GENRE.Female );
        TranslationMap[ "NewGame" ] = TRANSLATION( "Nouveau jeu" );
    }

    // -- INQUIRIES

    PLURALITY GetCardinalPlurality(
        TRANSLATION translation
        )
    {
        return translation.GetFrenchCardinalPlurality();
    }

    // ~~

    PLURALITY GetOrdinalPlurality(
        TRANSLATION translation
        )
    {
        return translation.GetFrenchOrdinalPlurality();
    }

    // ~~

    String GameOver(
        )
    {
        return "Fin du jeu!";
    }

    // ~~

    String Welcome(
        String first_name,
        String last_name
        )
    {
        return "Bienvenue, " + first_name + " " + last_name + " !";
    }

    // ~~

    String Pears(
        TRANSLATION count_translation
        )
    {
        TRANSLATION
            result_translation = TRANSLATION();

        result_translation.AddText( count_translation.Quantity + " " );

        if ( count_translation.GetFrenchCardinalPlurality() == PLURALITY.One )
        {
            result_translation.AddText( "poire" );
        }
        else
        {
            result_translation.AddText( "poires" );
        }

        return result_translation.Text;
    }
}
