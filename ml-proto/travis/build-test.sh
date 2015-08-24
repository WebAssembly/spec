#!/bin/bash

set -e
set -x

# Move to a location relative to the script so it runs
# from anywhere.
cd $(dirname ${BASH_SOURCE[0]})/..

export PATH=$PWD/ocaml/install/bin:$PATH

cd src

make clean
rm -f lexer.ml
rm -f parser.ml
rm -f parser.mli

ocamlbuild -libs bigarray main.native
make

cd ..

./runtests.py
