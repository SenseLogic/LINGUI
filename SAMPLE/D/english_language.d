module lingui.english_language;

// -- IMPORTS

import lingui.language;
import lingui.genre;
import lingui.plurality;
import lingui.translation;

// -- TYPES

class ENGLISH_LANGUAGE : LANGUAGE
{
    // -- CONSTRUCTORS

    this(
        )
    {
        super();
        Name = "English";
        DotCharacter = '.';
        TranslationMap[ "princess" ] = TRANSLATION( "princess", "1", GENRE.Female );
        TranslationMap[ "NewGame" ] = TRANSLATION( "New game" );
    }

    // -- INQUIRIES

    override PLURALITY GetCardinalPlurality(
        ref TRANSLATION translation
        )
    {
        return translation.GetEnglishCardinalPlurality();
    }

    // ~~

    override PLURALITY GetOrdinalPlurality(
        ref TRANSLATION translation
        )
    {
        return translation.GetEnglishOrdinalPlurality();
    }

    // ~~

    override dstring GameOver(
        )
    {
        return "Game over!";
    }

    // ~~

    override dstring Welcome(
        TRANSLATION first_name_translation,
        TRANSLATION last_name_translation
        )
    {
        return "Welcome, " ~ first_name_translation.Text ~ " " ~ last_name_translation.Text ~ "!";
    }

    // ~~

    override dstring Pears(
        TRANSLATION count_translation
        )
    {
        TRANSLATION
            result_translation;

        result_translation.AddText( count_translation.Quantity ~ " " );

        if ( count_translation.GetEnglishCardinalPlurality() == PLURALITY.One )
        {
            result_translation.AddText( "pear" );
        }
        else
        {
            result_translation.AddText( "pears" );
        }

        return result_translation.Text;
    }
}
