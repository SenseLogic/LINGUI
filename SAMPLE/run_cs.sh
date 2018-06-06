#!/bin/sh
set -x
cd CS/
mcs -out:sample.exe sample.cs english_language.cs french_language.cs game_language.cs german_language.cs ../../CS/genre.cs ../../CS/language.cs ../../CS/plurality.cs ../../CS/translation.cs
mono sample.exe
