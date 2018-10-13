#!/bin/sh
set -x
../lingui --cs --verbose sample.lingui CS/
../lingui --d --verbose sample.lingui D/
../lingui --dart --base --verbose sample.lingui DART/
