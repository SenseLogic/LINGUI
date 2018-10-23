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
        dstring first_name,
        dstring last_name
        )
    {
        return "Welcome, " ~ first_name ~ " " ~ last_name ~ "!";
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
            result_translation.AddText( "pear" );
        }
        else
        {
            result_translation.AddText( "pears" );
        }

        return result_translation.Text;
    }
}
