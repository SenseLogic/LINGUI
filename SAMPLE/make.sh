#!/bin/sh
set -x
../lingui --cs --check language.lg english_language.lg german_language.lg french_language.lg CS/
../lingui --d --check language.lg english_language.lg german_language.lg french_language.lg D/
../lingui --dart --check --base language.lg english_language.lg german_language.lg french_language.lg DART/
