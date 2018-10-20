#!/bin/sh
set -x
cd CS/
mcs -out:test.exe test.cs english_language.cs french_language.cs language.cs base_language.cs genre.cs plurality.cs translation.cs
mono test.exe
