#!/bin/bash

rm -f ./"$1"
ghc "$1.hs"
if [ -f "./$1" ]; then
  ./"$1"
fi
