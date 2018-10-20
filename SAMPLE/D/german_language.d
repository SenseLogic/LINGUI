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
        Name = "German";
        DotCharacter = ',';
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

    override dstring NewGame(
        )
    {
        return "Neues Spiel";
    }

    // ~~

    override dstring Welcome(
        TRANSLATION first_name_translation,
        TRANSLATION last_name_translation
        )
    {
        TRANSLATION
            result_translation;

        result_translation.AddText( "Willkommen, " );
        result_translation.AddText( first_name_translation );
        result_translation.AddText( " " );
        result_translation.AddText( last_name_translation );
        result_translation.AddText( "!" );

        return result_translation.Text;
    }

    // ~~

    override dstring Pears(
        TRANSLATION count_translation
        )
    {
        TRANSLATION
            result_translation;

        result_translation.AddText( count_translation.Quantity );
        result_translation.AddText( " " );

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
