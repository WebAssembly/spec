#!/bin/bash

set -e

# Move to a location relative to the script so it runs
# from anywhere. Go three levels down to get out of interpreter/
# and into the top-level dir, since we'll run ocamlbuild
# inside of interpreter/ and it goes pear-shaped if it
# encounters ocaml's own build directory.
cd $(dirname ${BASH_SOURCE[0]})/../../..

rm -rf ocaml
mkdir ocaml
cd ocaml
curl https://wasm.storage.googleapis.com/ocaml-4.05.0.tar.gz -O
CHECKSUM=$(shasum -a 256 ocaml-4.05.0.tar.gz | awk '{ print $1 }')
if [ ${CHECKSUM} != \
  7039bf3325bae8936c55f41b0e05df4a53d0f957cf1adc3d44aa0154c88b104e]; then
  echo "Bad checksum ocaml download checksum!"
  exit 1
fi
tar xfz ocaml-4.05.0.tar.gz
cd ocaml-4.05.0
./configure -prefix $PWD/../install
make world.opt
mkdir ../install
make install

cd ..
curl https://github.com/ocaml/ocamlbuild/archive/0.11.0.tar.gz -OL
CHECKSUM=$(shasum -a 256 0.11.0.tar.gz | awk '{ print $1 }')
if [ ${CHECKSUM} != \
  1717edc841c9b98072e410f1b0bc8b84444b4b35ed3b4949ce2bec17c60103ee ]; then
  echo "Bad checksum ocaml download checksum!"
  exit 1
fi
tar xfz 0.11.0.tar.gz
cd ocamlbuild-0.11.0
make configure
make install
