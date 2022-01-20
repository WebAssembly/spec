set NAME=wasm
if '%1' neq '' set NAME=%1
dune build main/main.byte
