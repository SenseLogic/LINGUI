#!/bin/sh
set -x
../lingui --cs --base --namespace GAME --verbose language.lingui english_language.lingui french_language.lingui CS/
../lingui --d --base --namespace game --verbose language.lingui english_language.lingui french_language.lingui D/
../lingui --dart --base --namespace game --verbose language.lingui english_language.lingui french_language.lingui DART/
