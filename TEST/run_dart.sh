#!/bin/sh
set -x
cd DART/
dart test.dart english_language.dart french_language.dart language.dart base_language.dart genre.dart plurality.dart translation.dart
