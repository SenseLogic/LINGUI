// -- IMPORTS

import "language.dart";
import "genre.dart";
import "plurality.dart";
import "translation.dart";

// -- TYPES

class FRENCH_LANGUAGE extends LANGUAGE
{
    // -- CONSTRUCTORS

    FRENCH_LANGUAGE(
        ) : super()
    {
        Name = "French";
        DotCharacter = ',';
        TranslationMap[ "French" ] = TRANSLATION( "Français" );
        TranslationMap[ "English" ] = TRANSLATION( "Anglais" );
        TranslationMap[ "Language:" ] = TRANSLATION( "Langue :" );
        TranslationMap[ "Poem" ] = TRANSLATION( "Le papillon est une chose à contempler,\navec des couleurs plus belles que l'or.\n" + "Que j'apprécie ta beauté, papillon,\nalors que je suis assis et te regarde flotter." );
    }

    // -- INQUIRIES

    PLURALITY GetCardinalPlurality(
        TRANSLATION translation
        )
    {
        return translation.GetFrenchCardinalPlurality();
    }

    // ~~

    PLURALITY GetOrdinalPlurality(
        TRANSLATION translation
        )
    {
        return translation.GetFrenchOrdinalPlurality();
    }

    // ~~

    String MainMenu(
        )
    {
        return "Menu principal";
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
            result_translation.AddText( "heaume" );
        }
        else
        {
            result_translation.AddText( "heaumes" );
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

        if ( count_translation.GetFrenchCardinalPlurality() == PLURALITY.One )
        {
            result_translation.AddText( "épée" );
        }
        else
        {
            result_translation.AddText( "épées" );
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
                result_translation.AddText( "Aucune " );
            }
            else
            {
                result_translation.AddText( "Aucun " );
            }
        }
        else if ( items_translation.IntegerQuantity == 1 )
        {
            if ( HasFirstCharacter( GetLowerCase( items_translation.Text ), "aâeéêèiîoôuû" ) )
            {
                result_translation.AddText( "L'" );
            }
            else if ( items_translation.Genre == GENRE.Female )
            {
                result_translation.AddText( "La " );
            }
            else
            {
                result_translation.AddText( "Le " );
            }
        }
        else
        {
            result_translation.AddText( "Les " );
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

        if ( items_translation.IntegerQuantity == 0 )
        {
            result_translation.AddText( " n'a" );
        }
        else if ( items_translation.IntegerQuantity <= 1 )
        {
            result_translation.AddText( " a" );
        }
        else
        {
            result_translation.AddText( " ont" );
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

        result_translation.AddText( " été trouvé" );

        if ( items_translation.Genre == GENRE.Female )
        {
            result_translation.AddText( "e" );
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
