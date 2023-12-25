#! /usr/bin/env nix
#! nix shell /home/cottand/dev/cottand/hash2slash#kotlin --quiet --command hash2slash-kotlin

fun greet(then: String) = "Hello, $then!"

println(greet("I am a script"))
