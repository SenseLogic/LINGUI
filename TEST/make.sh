#!/bin/sh
set -x
../lingui --cs --base --namespace GAME --verbose test.lingui CS/
../lingui --d --base --namespace game --verbose test.lingui D/
../lingui --dart --base --namespace game --verbose test.lingui DART/
