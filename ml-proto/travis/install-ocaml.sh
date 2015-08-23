#!/bin/bash

set -e

# Move to a location relative to the script so it runs
# from anywhere.
cd $(dirname ${BASH_SOURCE[0]})/..

rm -rf ocaml
mkdir ocaml
cd ocaml
curl http://caml.inria.fr/pub/distrib/ocaml-4.02/ocaml-4.02.2.tar.gz -O
tar xfz ocaml-4.02.2.tar.gz
cd ocaml-4.02.2
./configure -prefix $PWD/../install
make world.opt
mkdir ../install
make install
