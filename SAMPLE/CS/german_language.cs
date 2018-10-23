// -- IMPORTS

using LINGUI;

// -- TYPES

namespace LINGUI
{
    public class GERMAN_LANGUAGE : LANGUAGE
    {
        // -- CONSTRUCTORS

        public GERMAN_LANGUAGE(
            ) : base()
        {
            Name = "German";
            DotCharacter = ',';
            TranslationDictionary[ "princess" ] = new TRANSLATION( "Prinzessin", "1", GENRE.Female );
            TranslationDictionary[ "NewGame" ] = new TRANSLATION( "Neues Spiel" );
        }

        // -- INQUIRIES

        public override PLURALITY GetCardinalPlurality(
            TRANSLATION translation
            )
        {
            return translation.GetGermanCardinalPlurality();
        }

        // ~~

        public override PLURALITY GetOrdinalPlurality(
            TRANSLATION translation
            )
        {
            return translation.GetGermanOrdinalPlurality();
        }

        // ~~

        public override string GameOver(
            )
        {
            return "Spiel vorbei!";
        }

        // ~~

        public override string Welcome(
            string first_name,
            string last_name
            )
        {
            return "Willkommen, " + first_name + " " + last_name + "!";
        }

        // ~~

        public override string Pears(
            int count
            )
        {
            TRANSLATION
                result_translation = new TRANSLATION();

            result_translation.AddText( GetIntegerText( count ) + " " );

            if ( count == 1 )
            {
                result_translation.AddText( "Birne" );
            }
            else
            {
                result_translation.AddText( "Birnen" );
            }

            return result_translation.Text;
        }
    }
}
