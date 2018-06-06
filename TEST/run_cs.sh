#!/bin/sh
set -x
cd CS/
mcs -out:test.exe test.cs english_language.cs french_language.cs game_language.cs ../../CS/genre.cs ../../CS/language.cs ../../CS/plurality.cs ../../CS/translation.cs
mono test.exe
