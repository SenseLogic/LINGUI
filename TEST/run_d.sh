#!/bin/sh
set -x
cd D/
dmd -oftest test.d english_language.d french_language.d game_language.d genre.d language.d plurality.d translation.d
./test
