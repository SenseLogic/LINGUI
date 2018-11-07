#!/bin/sh
set -x
cd D/
dmd -oftest test.d language.d english_language.d french_language.d spanish_language.d base_language.d genre.d plurality.d translation.d
./test
