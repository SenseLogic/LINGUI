#!/bin/sh
set -x
cd CS/
mcs -out:test.exe test.cs language.cs english_language.cs french_language.cs spanish_language.cs base_language.cs genre.cs plurality.cs translation.cs
mono test.exe
