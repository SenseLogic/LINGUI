#!/bin/sh
set -x
../lingui --cs --check --base --namespace GAME --verbose language.lingui english_language.lingui french_language.lingui CS/
../lingui --d --check --base --namespace game --verbose language.lingui english_language.lingui french_language.lingui D/
../lingui --dart --check --base --namespace game --verbose language.lingui english_language.lingui french_language.lingui DART/
