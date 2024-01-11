#! /usr/bin/env bash
cat $1 | sed 's/#!/\/\//g' | EXEC ${@:2}

exit $?
