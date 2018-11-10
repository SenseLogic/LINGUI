![](https://github.com/senselogic/LINGUI/blob/master/LOGO/lingui.png)

# Lingui

Internationalization code generator for C#, D and Dart applications.

## Description

Lingui converts translator-friendly scripts into C#, D and Dart code which can be directly integrated into the localized application.

Its minimalistic and concise syntax is designed to allow professional translators to provide their static and dynamic translations through simple scripts.

## Sample

### Lingui

```lua
LANGUAGE

    GameOver

    Welcome first_name last_name

    Pears #count

ENGLISH_LANGUAGE : LANGUAGE

    "princess"
        1*"princess":female

    "NewGame"
        "New game"

    GameOver
        "Game over!"

    Welcome first_name last_name
        "Welcome, " ~ first_name ~ " " ~ last_name ~ "!"

    Pears #count
        $count ~ " "
        if count = 1
            "pear"
        else
            "pears"

GERMAN_LANGUAGE : LANGUAGE

    "princess"
        1*"Prinzessin":female

    "NewGame"
        "Neues Spiel"

    GameOver
        "Spiel vorbei!"

    Welcome first_name last_name
        "Willkommen, " ~ first_name ~ " " ~ last_name ~ "!"

    Pears #count
        $count ~ " "
        if count = 1
            "Birne"
        else
            "Birnen"

FRENCH_LANGUAGE : LANGUAGE

    "princess"
        1*"princesse":female

    "NewGame"
        "Nouveau jeu"

    GameOver
        "Fin du jeu !"

    Welcome first_name last_name
        "Bienvenue, " ~ first_name ~ " " ~ last_name ~ " !"

    Pears #count
        $count ~ " "
        if count = 0 or count = 1
            "poire"
        else
            "poires"
```

### C&#35;

```cs
// -- IMPORTS

using System;
using LINGUI;

// -- TYPES

public class TEST
{
    // -- OPERATIONS

    public static void TestLanguage(
        LANGUAGE language
        )
    {
        Console.WriteLine( language.GetText( "princess" ) );
        Console.WriteLine( language.GetText( "NewGame" ) );
        Console.WriteLine( language.GameOver() );
        Console.WriteLine( language.Welcome( "Jack", "Sparrow" ) );
        Console.WriteLine( language.Pears( 0 ) );
        Console.WriteLine( language.Pears( 1 ) );
        Console.WriteLine( language.Pears( 2 ) );
    }

    // ~~

    public static void Main(
        string[] argument_array
        )
    {
        TestLanguage( new ENGLISH_LANGUAGE() );
        TestLanguage( new GERMAN_LANGUAGE() );
        TestLanguage( new FRENCH_LANGUAGE() );
    }
}
```

### D

```d
// -- IMPORTS

import lingui.english_language;
import lingui.french_language;
import lingui.german_language;
import lingui.language;
import lingui.translation;
import std.stdio : writeln;

// -- FUNCTIONS

void TestLanguage(
    LANGUAGE language
    )
{
    writeln( language.GetText( "princess" ) );
    writeln( language.GetText( "NewGame" ) );
    writeln( language.GameOver() );
    writeln( language.Welcome( "Jack", "Sparrow" ) );
    writeln( language.Pears( 0 ) );
    writeln( language.Pears( 1 ) );
    writeln( language.Pears( 2 ) );
}

// ~~

void main(
    string[] argument_array
    )
{
    TestLanguage( new ENGLISH_LANGUAGE() );
    TestLanguage( new GERMAN_LANGUAGE() );
    TestLanguage( new FRENCH_LANGUAGE() );
}
```

### Dart

```dart
// -- IMPORTS

import "english_language.dart";
import "french_language.dart";
import "german_language.dart";
import "language.dart";
import "translation.dart";

// -- FUNCTIONS

void TestLanguage(
    LANGUAGE language
    )
{
    print( language.GetText( "princess" ) );
    print( language.GetText( "NewGame" ) );
    print( language.GameOver() );
    print( language.Welcome( "Jack", "Sparrow" ) );
    print( language.Pears( 0 ) );
    print( language.Pears( 1 ) );
    print( language.Pears( 2 ) );
}

// ~~

void main(
    List<String> argument_list
    )
{
    TestLanguage( ENGLISH_LANGUAGE() );
    TestLanguage( GERMAN_LANGUAGE() );
    TestLanguage( FRENCH_LANGUAGE() );
}
```

### Result

```
princess
New game
Game over!
Welcome, Jack Sparrow!
0 pears
1 pear
2 pears
Prinzessin
Neues Spiel
Spiel vorbei!
Willkommen, Jack Sparrow!
0 Birnen
1 Birne
2 Birnen
princesse
Nouveau jeu
Fin du jeu !
Bienvenue, Jack Sparrow !
0 poire
1 poire
2 poires
```

## Syntax

### Indentation

Lingui scripts are indentation-based.

The first level contains the language class names, and the second level contains the translation constants and functions.

### Language classes

A language class can extend another one, by specifying the base language after a colon (`:`).

A base language must be declared before its derived languages.

The first language (often named `LANGUAGE`) is generally used to declare all the translation functions that the localized application code will use.

The next languages then extend it, in order to provide their language-specific implementations.

### Translation functions

Functions can have parameters and declare local variables.

The type of the functions, function parameters and local variables is defined through their declaration prefix :

*   none : string
*   `!` : boolean
*   `#` : integer
*   `%` : real
*   `:` : translation
*   `@` : native

Native imports, attributes and methods are written in the target programming language, using indentations for blocks.

```lua
@import "dart:core";

@String Separator;

@String GetDate( int day, int month, int year )
    if ( Separator == "" )
        Separator = "-";
    return "${day}${Separator}${month}${Separator}${year}";

@String GetDate( DateTime date )
    return GetCustomDate( date.day, date.month, date.year );
```

### Translation value

A translation value is a data structure which provides one or several of the following properties :

*   a text (`$`);
*   a quantity text (`*`), with an integer (`#`) or real (`%`) value;
*   a genre (`&`).

### Translation constants

A translation constant is a quoted string.

It is only declared in actual language classes.

Its definition is made of a list of expressions which are evaluated and concatenated only once.

The result of this concatenation is stored inside the translation dictionary of its language.

### Quoted strings

A quoted string is enclosed in double quote characters.

The new line character is `§`.

Prefixing a character with `\` escapes it.

### Function statements

*   Textual expressions

    ```lua
    "Some text...§"
    GetTitleCase( Swords( 2* ) )
    ```

*   Conditions

    ```lua
    if @person = one
        if &person = female
            ...
        else if &person = male
            ...
        else
            ...
    else if #person <= 3
        ...
    else
        ...
    ```

*   Returns

    ```lua
    return count + 1
    ```

*   Variable declarations and assignments

    ```lua
    var :kings :queens :princes
    kings = Kings( 1* )
    $queens = "reinas"
    *queens = "2"
    &queens = female
    princes = 3*"príncipes":male
    ```

### Result variable

A `result` translation variable is implicitly declared to
accumulate the textual expressions of each translation function which :

*   actually uses textual expressions;
*   doesn't explicitly declare a `result` variable;
*   doesn't use any `return` statement;
*   hasn't a single-line definition starting with a quoted string (`"`).

### Variable accessors

Boolean, integer and real variable names can be prefixed by the following accessor :

```lua
$    text
```

Translation variable names can be prefixed by the following accessors :

```lua
$    text
*    quantity text
^    quantity first character
#    quantity integer value
%    quantity real value
!    quantity is integer
.    quantity is real
@    cardinal plurality (zero, one, two, few, many, other)
°    ordinal plurality (zero, one, two, few, many, other)
&    genre (neutral, male, female)
```

### Operators

```lua
~      text concatenation
+      addition
-      substraction
*      multiplication
/      division
%      division remainder
not    logical not
and    logical and
or     logical or
<      lower
>      higher
<=     lower equal
>=     higher equal
=      equal
<>     not equal
( )    grouping parentheses
```

### Literals

```lua
"Some text.§"          text
'.'                     character
1                       integer
2.5                     real
3*                      integer quantity
4*"perros"              integer quantity and text
5*"fiestas":female      integer quantity, text and genre
6.5*                    real quantity
7.5*"metros"            real quantity and text
8.5*"vueltas":female    real quantity, text and genre
```

### Predefined constants

```lua
false
true

zero
one
two
few
many
other

neutral
male
female
```

### Predefined functions

```lua
MakeTranslation( text, quantity, genre )
MakeTranslation( text, quantity )
MakeTranslation( text, genre )
MakeTranslation( text )
MakeTranslation( integer_quantity, genre )
MakeTranslation( integer_quantity )
HasTranslation( key )
GetTranslation( key )
GetText( key )
GetLowerCase( text )
GetLowerCase( translation )
GetUpperCase( text )
GetUpperCase( translation )
GetTitleCase( text )
GetTitleCase( translation )
GetSentenceCase( text )
GetSentenceCase( translation )
HasFirstCharacter( text, first_characters )
HasFirstCharacter( translation, first_characters )
HasPrefix( text, prefix )
HasPrefix( translation, prefix )
HasSuffix( text, suffix )
HasSuffix( translation, suffix )
GetIntegerReal( integer )
GetRealInteger( real )
GetTextBoolean( text )
GetTextInteger( text )
GetTextReal( text )
GetBooleanText( boolean )
GetIntegerText( integer, minimum_digit_count )
GetIntegerText( integer )
GetRealText( real, minimum_fractional_digit_count, maximum_fractional_digit_count, dot_character )
GetRealText( real, minimum_fractional_digit_count, maximum_fractional_digit_count )
GetRealText( real, minimum_fractional_digit_count )
GetRealText( real )
GetGenreText( genre )
GetPluralityText( plurality )
GetCardinalPlurality( translation )
GetOrdinalPlurality( translation )
```

### Comments

```
// This is a comment.
```

### Constant mirroring

When the `--mirror` option is used :

*   all constants declared before the first function are sorted in the same order as in the source language;
*   any missing constant is automatically added, using the translations of the definition files.

### Definition extraction

When the `--extract` option is used, all constants definitions declared before the first function of each `.ld` file
are extracted into their `.ld` definition files.

Matching definitions have the same line number.

An empty line is considered as a missing entry.

Multiline definitions are split over several lines prefixed with four spaces.

Definition files are compatible with most online translation services :

*   [Bing](https://www.bing.com/translator)
*   [Google](https://translate.google.com)
*   [Promt](https://www.online-translator.com)
*   [Reverso](http://www.reverso.net/text_translation.aspx)
*   [Yandex](https://translate.yandex.com)

### Definition picking

When the `--pick` option is used, the constants definitions stored in the `.lt` translation files are matched
with each other.

They are sorted by frequency, and the most used are automatically selected.

Definitions are provided in groups.

Source groups start by `<`, while target groups start by `>`.

Only target definitions will be picked.

```lua
< English

"Spanish language"
"Limits are created by mind."
    "Imagination can take you to the heavens."
    "Now imagine something."

> Yandex/English

"スペイン語"
"制限は心によって作成されます。"
    "想像力は天に連れて行くことができます。"
    "今何かを想像してみてください。"

> Google/English

"スペイン語"
"限界は心で作られている。"
    "想像力はあなたを天に連れて行くことができます。"
    "今、何かを想像してください。"

> Reverso/English

"スペインの言語"
"限度が心によって作られます。"
    "想像力があなたを天に導くことができます。"
    "今何かを想像してください。"
```

### Case conventions

*   Class names : `UPPER_CASE`;
*   Function names : `PascalCase`;
*   Parameter and variable names : `snake_case`.

### Limitations

Operators and variables must be separated by spaces.

### Installation

Install the [DMD 2 compiler](https://dlang.org/download.html) appropriate to your system (Linux, Windows or macOS).

Then build the executable with the following command line :

```bash
dmd -m64 lingui.d
```

### Command line

```bash
lingui [options] language.lg language.lg first_language.lg second_language.lg ... OUTPUT_FOLDER/
```

### Options

```
--mirror SOURCE_LANGUAGE : mirror the translation constants of this language
--extract : extract the language definitions
--pick : pick the best translations
--cs : generate C# files
--d : generate D files
--dart : generate Dart files
--base : generate the base classes
--float : use single precision numbers
--namespace LINGUI : use this namespace
--uppercase : generate uppercase filenames
--check : check for missing constants or functions
--preview : preview the changes without applying them
```

The `--cs`, `--d` and `--dart` options are mutually exclusive.

### Examples

```bash
lingui --dart --check --base --namespace game language.lg english_language.lg german_language.lg DART/
```

Converts Lingui files to Dart source code files, generating the base classes too, using "game" as namespace, and
checking for missing constants or functions.

```bash
lingui --cs --float language.lg english_language.lg german_language.lg CS/
```

Converts Lingui files to C# source code files, using single precision numbers.

```bash
lingui --mirror ENGLISH_LANGUAGE --preview language.lg english_language.lg french_language.lg spanish_language.lg
```

Mirrors the translation constants of `english_language.lg` into `french_language.lg` and `spanish_language.lg`.

```bash
lingui --extract --preview language.lg english_language.lg french_language.lg spanish_language.lg
```

Extract the constant definitions from these `.lg` files into their matching `.ld` files.

```bash
lingui --pick japanese_language.lg
```

Pick the best translations for this `.lg` file using its matching `.lt` file.


## Limitations

*   The cardinal and ordinaly pluralities are provided only for the following languages :
    *   English
    *   Japanese
    *   Korean
    *   Chinese
    *   German
    *   French
    *   Italian
    *   Spanish
    *   Portuguese
    *   Russian
    *   Turquish
    *   Dutch
    *   Swedish
    *   Norwegian
    *   Danish
    *   Arabic

## Version

3.1

## Author

Eric Pelzer (ecstatic.coder@gmail.com).

## License

This project is licensed under the GNU Lesser General Public License version 3.

See the [LICENSE.md](LICENSE.md) file for details.
