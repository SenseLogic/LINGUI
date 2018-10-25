#!/bin/sh
set -x
../lingui --cs --check --verbose language.lingui english_language.lingui german_language.lingui french_language.lingui CS/
../lingui --d --check --verbose language.lingui english_language.lingui german_language.lingui french_language.lingui D/
../lingui --dart --check --base --verbose language.lingui english_language.lingui german_language.lingui french_language.lingui DART/
