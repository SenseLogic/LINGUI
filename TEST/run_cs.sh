#!/bin/sh
set -x
cd CS/
mcs -out:test.exe test.cs english_language.cs french_language.cs game_language.cs genre.cs language.cs plurality.cs translation.cs
mono test.exe
