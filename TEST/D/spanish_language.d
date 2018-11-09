module game.spanish_language;

// -- IMPORTS

import game.language;
import game.genre;
import game.plurality;
import game.translation;

// -- TYPES

class SPANISH_LANGUAGE : LANGUAGE
{
    // -- CONSTRUCTORS

    this(
        )
    {
        super();
        Name = "Spanish";
        DotCharacter = ',';
        TranslationMap[ "French" ] = TRANSLATION( "Francés" );
        TranslationMap[ "English" ] = TRANSLATION( "Inglés" );
        TranslationMap[ "Poem" ] = TRANSLATION( "La mariposa es una cosa para contemplar,\ncon colores más hermosos que el oro.\n" ~ "Que me gusta tu belleza, mariposa,\nmientras me siento y te veo revolotear." );
    }

    // -- INQUIRIES

    override PLURALITY GetCardinalPlurality(
        ref TRANSLATION translation
        )
    {
        return translation.GetSpanishCardinalPlurality();
    }

    // ~~

    override PLURALITY GetOrdinalPlurality(
        ref TRANSLATION translation
        )
    {
        return translation.GetSpanishOrdinalPlurality();
    }

    // ~~

    override dstring MainMenu(
        )
    {
        return "Menú principal";
    }

    // ~~

    override TRANSLATION Helmets(
        int count
        )
    {
        TRANSLATION
            result_translation;

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

    override TRANSLATION Swords(
        TRANSLATION count_translation
        )
    {
        TRANSLATION
            result_translation;

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

    override dstring TheItems(
        TRANSLATION items_translation
        )
    {
        TRANSLATION
            result_translation;

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

    dstring Have(
        TRANSLATION items_translation
        )
    {
        TRANSLATION
            result_translation;

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

    dstring BeenFound(
        TRANSLATION items_translation
        )
    {
        TRANSLATION
            result_translation;

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

    override dstring TheItemsHaveBeenFound(
        TRANSLATION items_translation
        )
    {
        TRANSLATION
            result_translation;

        result_translation.AddText( TheItems( items_translation ) );
        result_translation.AddText( Have( items_translation ) );
        result_translation.AddText( BeenFound( items_translation ) );
        result_translation.AddText( ".\n" );

        return result_translation.Text;
    }
}
