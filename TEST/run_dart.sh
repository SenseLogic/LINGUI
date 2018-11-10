#!/bin/sh
set -x
cd DART/
dart test.dart language.dart english_language.dart french_language.dart spanish_language.dart native_language.dart base_language.dart genre.dart plurality.dart translation.dart
