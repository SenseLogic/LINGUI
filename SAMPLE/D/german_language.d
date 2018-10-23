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
        dstring first_name,
        dstring last_name
        )
    {
        return "Willkommen, " ~ first_name ~ " " ~ last_name ~ "!";
    }

    // ~~

    override dstring Pears(
        int count
        )
    {
        TRANSLATION
            result_translation;

        result_translation.AddText( GetIntegerText( count ) ~ " " );

        if ( count == 1 )
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
