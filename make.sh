#!/bin/sh
set -x
dmd -m64 lingui.d
rm *.o
