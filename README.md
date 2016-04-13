# Elm Build

A build tool for Elm projects, that covers all the extras you need
like Less compilation, minification, static file copying, etc.

## Commands

`elm build` - Build the current project. Must be run from the top-level directory.

`elm build --new foo` - Create a skeleton project in the directory `foo`.

## Installation

You must build from source, and you'll need [stack](https://github.com/commercialhaskell/stack).

```sh
git clone https://github.com/krisajenkins/elm-build.git
cd elm-build
stack install
```

## Status

It's a sketch. I'm actively using, it; you're welcome to use it; but I
can't promise it will flourish into the tool you'll be using two years
from now...
