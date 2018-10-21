module lingui.german_language;

// -- IMPORTS

import lingui.language;
import lingui.genre;
import lingui.plurality;
import lingui.translation;

// -- TYPES

class GERMAN_LANGUAGE : LANGUAGE
{
    // -- CONSTRUCTORS

    this(
        )
    {
        super();
        Name = "German";
        DotCharacter = ',';
        TranslationMap[ "princess" ] = TRANSLATION( "Prinzessin", "1", GENRE.Female );
        TranslationMap[ "NewGame" ] = TRANSLATION( "Neues Spiel" );
    }

    // -- INQUIRIES

    override PLURALITY GetCardinalPlurality(
        ref TRANSLATION translation
        )
    {
        return translation.GetGermanCardinalPlurality();
    }

    // ~~

    override PLURALITY GetOrdinalPlurality(
        ref TRANSLATION translation
        )
    {
        return translation.GetGermanOrdinalPlurality();
    }

    // ~~

    override dstring GameOver(
        )
    {
        return "Spiel vorbei!";
    }

    // ~~

    override dstring Welcome(
        TRANSLATION first_name_translation,
        TRANSLATION last_name_translation
        )
    {
        return "Willkommen, " ~ first_name_translation.Text ~ " " ~ last_name_translation.Text ~ "!";
    }

    // ~~

    override dstring Pears(
        TRANSLATION count_translation
        )
    {
        TRANSLATION
            result_translation;

        result_translation.AddText( count_translation.Quantity ~ " " );

        if ( count_translation.GetGermanCardinalPlurality() == PLURALITY.One )
        {
            result_translation.AddText( "Birne" );
        }
        else
        {
            result_translation.AddText( "Birnen" );
        }

        return result_translation.Text;
    }
}
