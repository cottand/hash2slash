#! /usr/bin/env sh

cat $1 | sed 's/#!/\/\//g' | yaegi $@

exit $?
