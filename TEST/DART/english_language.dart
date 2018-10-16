// -- IMPORTS

import "genre.dart";
import "plurality.dart";
import "translation.dart";
import "game_language.dart";

// -- TYPES

class ENGLISH_LANGUAGE extends GAME_LANGUAGE
{
    // -- CONSTRUCTORS

    ENGLISH_LANGUAGE(
        )
    {
        Name = "English";
        DecimalSeparator = '.';
    }

    // -- INQUIRIES

    String MainMenu(
        )
    {
        return "Main menu";
    }

    // ~~

    TRANSLATION Chests(
        TRANSLATION count_translation
        )
    {
        TRANSLATION
            result_translation = TRANSLATION();

        if ( count_translation.IntegerQuantity == 1 )
        {
            result_translation.AddText( "chest" );
        }
        else
        {
            result_translation.AddText( "chests" );
        }

        result_translation.SetQuantity( count_translation.Quantity );

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

    // ~~

    String DumpPlurality(
        TRANSLATION this_translation
        )
    {
        return GetPluralityText( this_translation.GetEnglishCardinalPlurality() ) + " / ";
    }
}
