#!/bin/sh
set -x
../lingui --cs --verbose language.lingui english_language.lingui german_language.lingui french_language.lingui CS/
../lingui --d --verbose language.lingui english_language.lingui german_language.lingui french_language.lingui D/
../lingui --dart --base --verbose language.lingui english_language.lingui german_language.lingui french_language.lingui DART/
