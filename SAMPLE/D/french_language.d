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
        Name = "French";
        DotCharacter = ',';
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

    override dstring NewGame(
        )
    {
        return "Nouveau jeu";
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
