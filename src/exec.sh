#! /usr/bin/env bash
cat $1 | sed 's/#!/\/\//g' | yaegi ${@:2}

exit $?
