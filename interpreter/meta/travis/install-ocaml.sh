#!/bin/bash

set -e

download_from_gh_archive() {
  local project=$1;
  local version=$2;
  local sha=$3;

  curl https://github.com/ocaml/${project}/archive/${version}.tar.gz -OL
  CHECKSUM=$(shasum -a 256 ${version}.tar.gz | awk '{ print $1 }')
  if [ ${CHECKSUM} != ${sha} ]; then
    echo "Bad checksum ${project} download checksum!"
    exit 1
  fi
  tar xfz ${version}.tar.gz
}

# Move to a location relative to the script so it runs
# from anywhere. Go three levels down to get out of interpreter/
# and into the top-level dir, since we'll run ocamlbuild
# inside of interpreter/ and it goes pear-shaped if it
# encounters ocaml's own build directory.
cd $(dirname ${BASH_SOURCE[0]})/../../..

PREFIX=$PWD/ocaml/install

rm -rf ocaml
mkdir ocaml
cd ocaml
mkdir install

download_from_gh_archive ocaml 4.05.0 e5d8a6f629020c580473d8afcfcb06c3966d01929f7b734f41dc0c737cd8ea3f
cd ocaml-4.05.0
./configure -prefix ${PREFIX}
make world.opt
make install
cd ..

PATH=${PREFIX}/bin:${PATH}

download_from_gh_archive ocamlbuild 0.11.0 1717edc841c9b98072e410f1b0bc8b84444b4b35ed3b4949ce2bec17c60103ee
cd ocamlbuild-0.11.0
make configure
make
make install
