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
        return "Fin du jeu!";
    }

    // ~~

    override dstring Welcome(
        TRANSLATION first_name_translation,
        TRANSLATION last_name_translation
        )
    {
        return "Bienvenue, " ~ first_name_translation.Text ~ " " ~ last_name_translation.Text ~ " !";
    }

    // ~~

    override dstring Pears(
        TRANSLATION count_translation
        )
    {
        TRANSLATION
            result_translation;

        result_translation.AddText( count_translation.Quantity ~ " " );

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
