# hash2slash
Tiny Nix utility to write nix shell scripts for `//` languages, like Go or Kotlin (make an issue if you would like more!).

Thanks to Nix magic,
- it allows you to pin the version of the language you want to the script (rather than to the system).
## Requirements: 

Just have Nix installed.

## How to

Just add the following preface to your script:

```go
#! /usr/bin/env nix
#! nix shell github:cottand/hash2slash/v0.1#go-run --quiet --command hash2slash-go-run

package main

import "os"

func main() {
	println("Hello world, I am a script!")
}
```

Congrats! You just made a Go script, without Go or Yaegi installed in your system.
You can run it as you would a bash script.

## Examples:

### Kotlin

```kotlin
#! /usr/bin/env nix
#! nix shell /home/cottand/dev/cottand/hash2slash#kotlin --quiet --command hash2slash-kotlin

fun greet(then: String) = "Hello, $then!"

println(greet("I am a script") + args[1])
```
### Go

```go
#! /usr/bin/env nix
#! nix shell github:cottand/hash2slash/v0.1#go-run --quiet --command hash2slash-go-run

package main

import "os"

func main() {
	println("Hello world, I am a script!")
}
```

See more at `example/`!

## FAQ

#### Can I use external libraries inside the scripts?

Yes, mostly. But hash2slash does not take care of that, so you have to look into how your language
of choice usually does that for scripts.

- For Kotlin, it means [annotations in a `*.main.kts` file](https://github.com/Kotlin/kotlin-script-examples/blob/master/jvm/main-kts/MainKts.md).

- For Go (with yaegi) it means [you have to set `GOPATH` and install your libs in there](https://github.com/traefik/yaegi/issues/656).

#### But what about other languages, like Python?
You do not need hash2slash to run those - you can just use `nix shell`.
[You can read more here](https://nixos.org/manual/nix/stable/command-ref/new-cli/nix3-shell#use-as-a--interpreter).

#### If I do not need hash2slash for Pyhon, why do I need it for Go or Kotlin?

Because Go and Kotlin (and even their compiled/interpreted variants, like Yaegi or native Kotlin scripting) do
not handle multi-line shebangs (`#!`) well, but `nix shell` requires them.
So what we do here is simply replace them with good old slash comments (`//`) before running the script.


#### But this utility is 0.x!!

That is not a question, but yes.
It still should not stop you from trying this out
'fearlessly' (as far as compatibility goes), because by pinning the version of hash2slash to your script, updates
to this utility will not break your scripts.

```
#! nix shell github:cottand/hash2slash/v0.1#go-run
                           this part   ^^^^
```

