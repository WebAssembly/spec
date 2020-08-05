#!/bin/bash

set -e
set -x

# Move to a location relative to the script so it runs
# from anywhere.
cd $(dirname ${BASH_SOURCE[0]})/../..

make all
