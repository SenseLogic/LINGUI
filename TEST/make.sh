#!/bin/sh
set -x
../lingui --cs --check --base --namespace GAME language.lg english_language.lg french_language.lg spanish_language.lg CS/
../lingui --d --check --base --namespace game language.lg english_language.lg french_language.lg spanish_language.lg D/
../lingui --dart --check --base --namespace game language.lg english_language.lg french_language.lg spanish_language.lg DART/
../lingui --dart native_language.lg DART/
