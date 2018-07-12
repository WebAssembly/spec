#!/bin/bash

for i in {1..15}; do
  ./wasm -case 0 -step $i -m ../test/core/fac.wast > ~/onchain/tests/test$i.json;
done


