// -- IMPORTS

import "language.dart";
import "genre.dart";
import "plurality.dart";
import "translation.dart";

// -- TYPES

class ENGLISH_LANGUAGE extends LANGUAGE
{
    // -- CONSTRUCTORS

    ENGLISH_LANGUAGE(
        ) : super()
    {
        Name = "English";
        DotCharacter = '.';
        TranslationMap[ "Language:" ] = TRANSLATION( "Language:" );
        TranslationMap[ "English" ] = TRANSLATION( "English" );
        TranslationMap[ "French" ] = TRANSLATION( "French" );
        TranslationMap[ "Spanish" ] = TRANSLATION( "Spanish" );
        TranslationMap[ "Haiku" ] = TRANSLATION( "Evening light,\nthe blue transparency\nof a dragonfly." );
        TranslationMap[ "Poem" ] = TRANSLATION( "The butterfly is a thing to behold,\n" + "with colors more beautiful than gold.\n" + "How I enjoy your beauty, butterfly,\n" + "as I sit and watch you flutter by." );
    }

    // -- INQUIRIES

    PLURALITY GetCardinalPlurality(
        TRANSLATION translation
        )
    {
        return translation.GetEnglishCardinalPlurality();
    }

    // ~~

    PLURALITY GetOrdinalPlurality(
        TRANSLATION translation
        )
    {
        return translation.GetEnglishOrdinalPlurality();
    }

    // ~~

    String MainMenu(
        )
    {
        return "Main menu";
    }

    // ~~

    TRANSLATION Helmets(
        int count
        )
    {
        TRANSLATION
            result_translation = TRANSLATION();

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

    TRANSLATION Swords(
        TRANSLATION count_translation
        )
    {
        TRANSLATION
            result_translation = TRANSLATION();

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

    String TheItems(
        TRANSLATION items_translation
        )
    {
        TRANSLATION
            result_translation = TRANSLATION();

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

    String TheItemsHaveBeenFound(
        TRANSLATION items_translation
        )
    {
        TRANSLATION
            result_translation = TRANSLATION();

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
