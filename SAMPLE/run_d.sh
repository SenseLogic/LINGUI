#!/bin/sh
set -x
cd D/
dmd -ofsample sample.d english_language.d french_language.d german_language.d language.d ../../D/base_language.d ../../D/genre.d ../../D/plurality.d ../../D/translation.d
./sample
