// -- IMPORTS

using LINGUI;

// -- TYPES

namespace LINGUI
{
    public class FRENCH_LANGUAGE : LANGUAGE
    {
        // -- CONSTRUCTORS

        public FRENCH_LANGUAGE(
            ) : base()
        {
            Name = "French";
            DotCharacter = ',';
            TranslationDictionary[ "princess" ] = new TRANSLATION( "princesse", "1", GENRE.Female );
            TranslationDictionary[ "NewGame" ] = new TRANSLATION( "Nouveau jeu" );
        }

        // -- INQUIRIES

        public override PLURALITY GetCardinalPlurality(
            TRANSLATION translation
            )
        {
            return translation.GetFrenchCardinalPlurality();
        }

        // ~~

        public override PLURALITY GetOrdinalPlurality(
            TRANSLATION translation
            )
        {
            return translation.GetFrenchOrdinalPlurality();
        }

        // ~~

        public override string GameOver(
            )
        {
            return "Fin du jeu!";
        }

        // ~~

        public override string Welcome(
            TRANSLATION first_name_translation,
            TRANSLATION last_name_translation
            )
        {
            return "Bienvenue, " + first_name_translation.Text + " " + last_name_translation.Text + " !";
        }

        // ~~

        public override string Pears(
            TRANSLATION count_translation
            )
        {
            TRANSLATION
                result_translation = new TRANSLATION();

            result_translation.AddText( count_translation.Quantity + " " );

            if ( count_translation.GetFrenchCardinalPlurality() == PLURALITY.One )
            {
                result_translation.AddText( "poire" );
            }
            else
            {
                result_translation.AddText( "poires" );
            }

            return result_translation.Text;
        }
    }
}
