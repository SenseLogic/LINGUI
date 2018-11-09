module game.english_language;

// -- IMPORTS

import game.language;
import game.genre;
import game.plurality;
import game.translation;

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
        TranslationMap[ "Language:" ] = TRANSLATION( "Language:" );
        TranslationMap[ "English" ] = TRANSLATION( "English" );
        TranslationMap[ "French" ] = TRANSLATION( "French" );
        TranslationMap[ "Spanish" ] = TRANSLATION( "Spanish" );
        TranslationMap[ "Haiku" ] = TRANSLATION( "Limits are created by mind.\nImagination can take you to the heavens.\nNow imagine something." );
        TranslationMap[ "Poem" ] = TRANSLATION( "The butterfly is a thing to behold,\nwith colors more beautiful than gold.\n" ~ "How I enjoy your beauty, butterfly,\nas I sit and watch you flutter by." );
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

    override dstring MainMenu(
        )
    {
        return "Main menu";
    }

    // ~~

    override TRANSLATION Helmets(
        int count
        )
    {
        TRANSLATION
            result_translation;

        if ( count == 1 )
        {
            result_translation.AddText( "helmet" );
        }
        else
        {
            result_translation.AddText( "helmets" );
        }

        result_translation.SetQuantity( count );

        return result_translation;
    }

    // ~~

    override TRANSLATION Swords(
        TRANSLATION count_translation
        )
    {
        TRANSLATION
            result_translation;

        if ( count_translation.GetEnglishCardinalPlurality() == PLURALITY.One )
        {
            result_translation.AddText( "sword" );
        }
        else
        {
            result_translation.AddText( "swords" );
        }

        result_translation.SetQuantity( count_translation.Quantity );

        return result_translation;
    }

    // ~~

    override dstring TheItems(
        TRANSLATION items_translation
        )
    {
        TRANSLATION
            result_translation;

        if ( items_translation.IntegerQuantity == 0 )
        {
            result_translation.AddText( "No " );
        }
        else if ( items_translation.IntegerQuantity == 1 )
        {
            result_translation.AddText( "The " );
        }
        else
        {
            result_translation.AddText( "The " );
            result_translation.AddText( items_translation.Quantity );
            result_translation.AddText( " " );
        }

        result_translation.AddText( items_translation );

        return result_translation.Text;
    }

    // ~~

    override dstring TheItemsHaveBeenFound(
        TRANSLATION items_translation
        )
    {
        TRANSLATION
            result_translation;

        result_translation.AddText( TheItems( items_translation ) );

        if ( items_translation.IntegerQuantity == 1 )
        {
            result_translation.AddText( " has" );
        }
        else
        {
            result_translation.AddText( " have" );
        }

        result_translation.AddText( " been found.\n" );

        return result_translation.Text;
    }
}
