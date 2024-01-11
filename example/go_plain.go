#! /usr/bin/env nix
#! nix shell github:cottand/hash2slash/v0.1#go-run --quiet --command hash2slash-go-run

package main

import "os"

func main() {
	println("Hello world, I am a script!")
	if len(os.Args) > 1 {
		println(os.Args[1])
	}
}