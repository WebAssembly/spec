# System for Merkle proofs

Parts
 * `merkle.ml`: Converting WebAssembly to "microcode"
 * `mrun.ml`: Executing microcode
 * `mbinary.ml`: Generating hashes for the execution state
 * `mproof.ml`: Generating proofs for state changes
 * `mproof.ml` & `instruction.sol`: Checking proofs
 * `interactive.sol`: Interactive proofs

Building (in the `interpreter` directory):
```
opam install cryptokit
make
```

For testing, use `-m` option. `-t` will turn on tracing.

For example:
```
./wasm -t -m ../test/core/fac.wast
```


