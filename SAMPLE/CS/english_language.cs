// -- IMPORTS

using LINGUI;

// -- TYPES

namespace LINGUI
{
    public class ENGLISH_LANGUAGE : LANGUAGE
    {
        // -- CONSTRUCTORS

        public ENGLISH_LANGUAGE(
            ) : base()
        {
            Name = "English";
            DotCharacter = '.';
            TranslationDictionary[ "princess" ] = new TRANSLATION( "princess", "1", GENRE.Female );
            TranslationDictionary[ "NewGame" ] = new TRANSLATION( "New game" );
        }

        // -- INQUIRIES

        public override PLURALITY GetCardinalPlurality(
            TRANSLATION translation
            )
        {
            return translation.GetEnglishCardinalPlurality();
        }

        // ~~

        public override PLURALITY GetOrdinalPlurality(
            TRANSLATION translation
            )
        {
            return translation.GetEnglishOrdinalPlurality();
        }

        // ~~

        public override string GameOver(
            )
        {
            return "Game over!";
        }

        // ~~

        public override string Welcome(
            string first_name,
            string last_name
            )
        {
            return "Welcome, " + first_name + " " + last_name + "!";
        }

        // ~~

        public override string Pears(
            TRANSLATION count_translation
            )
        {
            TRANSLATION
                result_translation = new TRANSLATION();

            result_translation.AddText( count_translation.Quantity + " " );

            if ( count_translation.GetEnglishCardinalPlurality() == PLURALITY.One )
            {
                result_translation.AddText( "pear" );
            }
            else
            {
                result_translation.AddText( "pears" );
            }

            return result_translation.Text;
        }
    }
}
