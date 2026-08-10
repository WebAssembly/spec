# Preview

```sh
$ ../src/exe-spectec/main.exe ../../../_specification/wasm-3.0/*.spectec -v -l --interpreter ../test-interpreter/sample.wat addTwo 30 12 2>&1
spectec 0.5 generator
== Parsing...
../../../_specification/wasm-3.0/*.spectec: No such file or directory
[2]
$ ../src/exe-spectec/main.exe ../../../_specification/wasm-3.0/*.spectec -v -l --interpreter ../test-interpreter/sample.wasm addTwo 40 2 2>&1
spectec 0.5 generator
== Parsing...
../../../_specification/wasm-3.0/*.spectec: No such file or directory
[2]
$ ../src/exe-spectec/main.exe ../../../_specification/wasm-3.0/*.spectec -v -l --interpreter ../test-interpreter/sample.wast 2>&1
spectec 0.5 generator
== Parsing...
../../../_specification/wasm-3.0/*.spectec: No such file or directory
[2]
$ for v in 1 2 3; do ( \
>   echo "Running test for Wasm $v.0..." && \
>   ../src/exe-spectec/main.exe ../../../_specification/wasm-$v.0/*.spectec -v -l --test-version $v --interpreter ../test-interpreter/spec-test-$v \
> ) done 2>&1
Running test for Wasm 1.0...
spectec 0.5 generator
== Parsing...
../../../_specification/wasm-1.0/*.spectec: No such file or directory
Running test for Wasm 2.0...
spectec 0.5 generator
== Parsing...
../../../_specification/wasm-2.0/*.spectec: No such file or directory
Running test for Wasm 3.0...
spectec 0.5 generator
== Parsing...
../../../_specification/wasm-3.0/*.spectec: No such file or directory
[2]
```
