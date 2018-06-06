#!/bin/sh
set -x
cd D/
dmd -oftest test.d english_language.d french_language.d game_language.d ../../D/genre.d ../../D/language.d ../../D/plurality.d ../../D/translation.d
./test
