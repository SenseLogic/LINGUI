module lingui.french_language;

// -- IMPORTS

import lingui.language;
import lingui.genre;
import lingui.plurality;
import lingui.translation;

// -- TYPES

class FRENCH_LANGUAGE : LANGUAGE
{
    // -- CONSTRUCTORS

    this(
        )
    {
        super();
        Name = "French";
        DotCharacter = ',';
        TranslationMap[ "princess" ] = TRANSLATION( "princesse", "1", GENRE.Female );
        TranslationMap[ "NewGame" ] = TRANSLATION( "Nouveau jeu" );
    }

    // -- INQUIRIES

    override PLURALITY GetCardinalPlurality(
        ref TRANSLATION translation
        )
    {
        return translation.GetFrenchCardinalPlurality();
    }

    // ~~

    override PLURALITY GetOrdinalPlurality(
        ref TRANSLATION translation
        )
    {
        return translation.GetFrenchOrdinalPlurality();
    }

    // ~~

    override dstring GameOver(
        )
    {
        return "Fin du jeu !";
    }

    // ~~

    override dstring Welcome(
        dstring first_name,
        dstring last_name
        )
    {
        return "Bienvenue, " ~ first_name ~ " " ~ last_name ~ " !";
    }

    // ~~

    override dstring Pears(
        int count
        )
    {
        TRANSLATION
            result_translation;

        result_translation.AddText( GetIntegerText( count ) ~ " " );

        if ( count == 0 || count == 1 )
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
