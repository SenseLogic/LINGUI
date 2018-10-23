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
            return "Fin du jeu !";
        }

        // ~~

        public override string Welcome(
            string first_name,
            string last_name
            )
        {
            return "Bienvenue, " + first_name + " " + last_name + " !";
        }

        // ~~

        public override string Pears(
            int count
            )
        {
            TRANSLATION
                result_translation = new TRANSLATION();

            result_translation.AddText( GetIntegerText( count ) + " " );

            if ( count == 0 || count == 1 )
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
