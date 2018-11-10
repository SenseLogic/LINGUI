// -- IMPORTS

import "base_language.dart";
import "genre.dart";
import "plurality.dart";
import "translation.dart";
import "dart:core";

// -- TYPES

class NATIVE_LANGUAGE extends BASE_LANGUAGE
{
    // -- CONSTRUCTORS

    NATIVE_LANGUAGE(
        ) : super()
    {
    }

    // -- INQUIRIES

    String Separator;

    // ~~

    String GetDate( int day, int month, int year )
    {
        if ( Separator == "" )
        {
            Separator = "-";
        }

        return "${day}${Separator}${month}${Separator}${year}";
    }

    // ~~

    String GetDate( DateTime date )
    {
        return GetCustomDate( date.day, date.month, date.year );
    }
}
