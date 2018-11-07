// -- IMPORTS

import "language.dart";
import "genre.dart";
import "plurality.dart";
import "translation.dart";

// -- TYPES

class SPANISH_LANGUAGE extends LANGUAGE
{
    // -- CONSTRUCTORS

    SPANISH_LANGUAGE(
        ) : super()
    {
        Name = "Spanish";
        DotCharacter = ',';
        TranslationMap[ "French" ] = TRANSLATION( "Francés" );
        TranslationMap[ "English" ] = TRANSLATION( "Inglés" );
    }

    // -- INQUIRIES

    PLURALITY GetCardinalPlurality(
        TRANSLATION translation
        )
    {
        return translation.GetSpanishCardinalPlurality();
    }

    // ~~

    PLURALITY GetOrdinalPlurality(
        TRANSLATION translation
        )
    {
        return translation.GetSpanishOrdinalPlurality();
    }

    // ~~

    String MainMenu(
        )
    {
        return "Menú principal";
    }

    // ~~

    TRANSLATION Helmets(
        int count
        )
    {
        TRANSLATION
            result_translation = TRANSLATION();

        if ( count <= 1 )
        {
            result_translation.AddText( "yelmo" );
        }
        else
        {
            result_translation.AddText( "yelmos" );
        }

        result_translation.SetQuantity( count );
        result_translation.SetGenre( GENRE.Male );

        return result_translation;
    }

    // ~~

    TRANSLATION Swords(
        TRANSLATION count_translation
        )
    {
        TRANSLATION
            result_translation = TRANSLATION();

        if ( count_translation.IntegerQuantity <= 1 )
        {
            result_translation.AddText( "espada" );
        }
        else
        {
            result_translation.AddText( "espadas" );
        }

        result_translation.SetQuantity( count_translation.Quantity );
        result_translation.SetGenre( GENRE.Female );

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
            if ( items_translation.Genre == GENRE.Female )
            {
                result_translation.AddText( "Ninguna " );
            }
            else
            {
                result_translation.AddText( "Ningún " );
            }
        }
        else if ( items_translation.IntegerQuantity == 1 )
        {
            if ( items_translation.Genre == GENRE.Female )
            {
                result_translation.AddText( "La " );
            }
            else
            {
                result_translation.AddText( "El " );
            }
        }
        else
        {
            if ( items_translation.Genre == GENRE.Female )
            {
                result_translation.AddText( "Las " );
            }
            else
            {
                result_translation.AddText( "Los " );
            }

            result_translation.AddText( items_translation.Quantity );
            result_translation.AddText( " " );
        }

        result_translation.AddText( items_translation );

        return result_translation.Text;
    }

    // ~~

    String Have(
        TRANSLATION items_translation
        )
    {
        TRANSLATION
            result_translation = TRANSLATION();

        if ( items_translation.IntegerQuantity <= 1 )
        {
            result_translation.AddText( " ha" );
        }
        else
        {
            result_translation.AddText( " han" );
        }

        return result_translation.Text;
    }

    // ~~

    String BeenFound(
        TRANSLATION items_translation
        )
    {
        TRANSLATION
            result_translation = TRANSLATION();

        result_translation.AddText( " sido encontrad" );

        if ( items_translation.Genre == GENRE.Female )
        {
            result_translation.AddText( "a" );
        }
        else
        {
            result_translation.AddText( "o" );
        }

        if ( items_translation.IntegerQuantity > 1 )
        {
            result_translation.AddText( "s" );
        }

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
        result_translation.AddText( Have( items_translation ) );
        result_translation.AddText( BeenFound( items_translation ) );
        result_translation.AddText( ".\n" );

        return result_translation.Text;
    }
}
