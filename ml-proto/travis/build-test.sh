#!/bin/bash

set -e
set -x

# Move to a location relative to the script so it runs
# from anywhere.
cd $(dirname ${BASH_SOURCE[0]})/..

export PATH=$PWD/ocaml/install/bin:$PATH

cd src

ocamlbuild -libs "bigarray, nums, str" main.native

cd ..

./runtests.py
