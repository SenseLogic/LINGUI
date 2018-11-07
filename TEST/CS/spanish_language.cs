// -- IMPORTS

using GAME;

// -- TYPES

namespace GAME
{
    public class SPANISH_LANGUAGE : LANGUAGE
    {
        // -- CONSTRUCTORS

        public SPANISH_LANGUAGE(
            ) : base()
        {
            Name = "Spanish";
            DotCharacter = ',';
            TranslationDictionary[ "French" ] = new TRANSLATION( "Francés" );
            TranslationDictionary[ "English" ] = new TRANSLATION( "Inglés" );
        }

        // -- INQUIRIES

        public override PLURALITY GetCardinalPlurality(
            TRANSLATION translation
            )
        {
            return translation.GetSpanishCardinalPlurality();
        }

        // ~~

        public override PLURALITY GetOrdinalPlurality(
            TRANSLATION translation
            )
        {
            return translation.GetSpanishOrdinalPlurality();
        }

        // ~~

        public override string MainMenu(
            )
        {
            return "Menú principal";
        }

        // ~~

        public override TRANSLATION Helmets(
            int count
            )
        {
            TRANSLATION
                result_translation = new TRANSLATION();

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

        public override TRANSLATION Swords(
            TRANSLATION count_translation
            )
        {
            TRANSLATION
                result_translation = new TRANSLATION();

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

        public override string TheItems(
            TRANSLATION items_translation
            )
        {
            TRANSLATION
                result_translation = new TRANSLATION();

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

        public virtual string Have(
            TRANSLATION items_translation
            )
        {
            TRANSLATION
                result_translation = new TRANSLATION();

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

        public virtual string BeenFound(
            TRANSLATION items_translation
            )
        {
            TRANSLATION
                result_translation = new TRANSLATION();

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

        public override string TheItemsHaveBeenFound(
            TRANSLATION items_translation
            )
        {
            TRANSLATION
                result_translation = new TRANSLATION();

            result_translation.AddText( TheItems( items_translation ) );
            result_translation.AddText( Have( items_translation ) );
            result_translation.AddText( BeenFound( items_translation ) );
            result_translation.AddText( ".\n" );

            return result_translation.Text;
        }
    }
}
