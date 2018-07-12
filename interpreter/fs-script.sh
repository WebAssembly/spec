#!/bin/zsh

emcc -c filesystem.c
emcc -o filesystem.wasm -s EXPORTED_FUNCTIONS="['_env____syscall5', '_env____syscall140', '_env____syscall6', '_env____syscall3', '_env____syscall195', '_env____syscall146', \
'_env____syscall4', '_env____syscall41', '_env____syscall63', '_env____syscall330', '_env____syscall145', '_env____syscall333', '_env____syscall197', '_env____syscall221', \
'_env____syscall334', '_env____syscall180', '_env____syscall181', '_env____syscall295', '_env____lock', '_env____unlock', '_env__getenv', \
'_env____syscall54', '_env__pthread_mutex_lock', '_env__pthread_mutex_unlock', '_env__pthread_cond_broadcast', '_env____cxa_atexit', \
'_initSystem', '_finalizeSystem', '_callArguments', '_callReturns', '_getReturn', '_callMemory', '_env__getInternalFile', \
'_env__internalSync', '_env__internalSync2']" -s BINARYEN=1 -s BINARYEN_ROOT="'/usr/local/'" -s SIDE_MODULE=2 filesystem.o

rm filesystem.o
./wasm -underscore filesystem.wasm

# node ~/wasdk/dist/wasdk.js ez filesystem.json && ./wasm -merge ~/ocamlrun-wasm/build/ocamlrun.wasm filesystem.wasm

# ./wasm -m -t -file filesystem.wasm -table-size 1024 -memory-size $[16*1024*2] -wasm merge.wasm

