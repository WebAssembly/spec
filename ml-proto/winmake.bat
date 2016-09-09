rem Auto-generated from Makefile!
set NAME=wasm
if '%1' neq '' set NAME=%1
ocamlc.opt -c -bin-annot -I spec -I host -I given -I host/import -o spec/numeric_error.cmo spec/numeric_error.ml
ocamlc.opt -c -bin-annot -I spec -I host -I given -I host/import -o spec/int.cmo spec/int.ml
ocamlc.opt -c -bin-annot -I spec -I host -I given -I host/import -o spec/i32.cmo spec/i32.ml
ocamlc.opt -c -bin-annot -I spec -I host -I given -I host/import -o spec/float.cmo spec/float.ml
ocamlc.opt -c -bin-annot -I spec -I host -I given -I host/import -o spec/types.cmo spec/types.ml
ocamlc.opt -c -bin-annot -I spec -I host -I given -I host/import -o spec/f32.cmo spec/f32.ml
ocamlc.opt -c -bin-annot -I spec -I host -I given -I host/import -o spec/f64.cmo spec/f64.ml
ocamlc.opt -c -bin-annot -I spec -I host -I given -I host/import -o spec/i64.cmo spec/i64.ml
ocamlc.opt -c -bin-annot -I spec -I host -I given -I host/import -o spec/values.cmo spec/values.ml
ocamlc.opt -c -bin-annot -I spec -I host -I given -I host/import -o spec/memory.cmi spec/memory.mli
ocamlc.opt -c -bin-annot -I given -I spec -I host -I host/import -o given/source.cmi given/source.mli
ocamlc.opt -c -bin-annot -I spec -I host -I given -I host/import -o spec/ast.cmo spec/ast.ml
ocamlc.opt -c -bin-annot -I spec -I host -I given -I host/import -o spec/table.cmi spec/table.mli
ocamlc.opt -c -bin-annot -I spec -I host -I given -I host/import -o spec/instance.cmo spec/instance.ml
ocamlc.opt -c -bin-annot -I spec -I host -I given -I host/import -o spec/eval.cmi spec/eval.mli
ocamlc.opt -c -bin-annot -I host -I spec -I given -I host/import -o host/print.cmi host/print.mli
ocamlc.opt -c -bin-annot -I host -I spec -I given -I host/import -o host/encode.cmi host/encode.mli
ocamlc.opt -c -bin-annot -I host/import -I spec -I host -I given -o host/import/env.cmo host/import/env.ml
ocamlc.opt -c -bin-annot -I host -I spec -I given -I host/import -o host/flags.cmo host/flags.ml
ocamlc.opt -c -bin-annot -I host -I spec -I given -I host/import -o host/import.cmi host/import.mli
ocamlc.opt -c -bin-annot -I host -I spec -I given -I host/import -o host/run.cmi host/run.mli
ocamlc.opt -c -bin-annot -I host/import -I spec -I host -I given -o host/import/spectest.cmo host/import/spectest.ml
ocamlc.opt -c -bin-annot -I host -I spec -I given -I host/import -o host/main.cmo host/main.ml
ocamlc.opt -c -g -bin-annot -I host -I spec -I given -I host/import -o host/main.d.cmo host/main.ml
ocamlc.opt -c -bin-annot -I given -I spec -I host -I host/import -o given/lib.cmi given/lib.mli
ocamlc.opt -c -bin-annot -I spec -I host -I given -I host/import -o spec/error.cmi spec/error.mli
ocamlc.opt -c -bin-annot -I host -I spec -I given -I host/import -o host/sexpr.cmi host/sexpr.mli
ocamlc.opt -c -bin-annot -I host -I spec -I given -I host/import -o host/script.cmi host/script.mli
ocamlc.opt -c -bin-annot -I host -I spec -I given -I host/import -o host/arrange.cmi host/arrange.mli
ocamlc.opt -c -bin-annot -I spec -I host -I given -I host/import -o spec/check.cmi spec/check.mli
ocamlc.opt -c -bin-annot -I spec -I host -I given -I host/import -o spec/decode.cmi spec/decode.mli
ocamlc.opt -c -bin-annot -I host -I spec -I given -I host/import -o host/parse.cmi host/parse.mli
ocamlc.opt -c -g -bin-annot -I host -I spec -I given -I host/import -o host/encode.d.cmo host/encode.ml
ocamlc.opt -c -g -bin-annot -I host/import -I spec -I host -I given -o host/import/env.d.cmo host/import/env.ml
ocamlc.opt -c -g -bin-annot -I host -I spec -I given -I host/import -o host/flags.d.cmo host/flags.ml
ocamlc.opt -c -g -bin-annot -I host -I spec -I given -I host/import -o host/import.d.cmo host/import.ml
ocamlc.opt -c -g -bin-annot -I host -I spec -I given -I host/import -o host/run.d.cmo host/run.ml
ocamlc.opt -c -g -bin-annot -I host/import -I spec -I host -I given -o host/import/spectest.d.cmo host/import/spectest.ml
ocamlc.opt -c -g -bin-annot -I spec -I host -I given -I host/import -o spec/ast.d.cmo spec/ast.ml
ocamlc.opt -c -g -bin-annot -I spec -I host -I given -I host/import -o spec/f32.d.cmo spec/f32.ml
ocamlc.opt -c -g -bin-annot -I spec -I host -I given -I host/import -o spec/f64.d.cmo spec/f64.ml
ocamlc.opt -c -g -bin-annot -I spec -I host -I given -I host/import -o spec/i32.d.cmo spec/i32.ml
ocamlc.opt -c -g -bin-annot -I given -I spec -I host -I host/import -o given/lib.d.cmo given/lib.ml
ocamlc.opt -c -g -bin-annot -I spec -I host -I given -I host/import -o spec/memory.d.cmo spec/memory.ml
ocamlc.opt -c -g -bin-annot -I given -I spec -I host -I host/import -o given/source.d.cmo given/source.ml
ocamlc.opt -c -g -bin-annot -I spec -I host -I given -I host/import -o spec/types.d.cmo spec/types.ml
ocamlc.opt -c -g -bin-annot -I spec -I host -I given -I host/import -o spec/values.d.cmo spec/values.ml
ocamlc.opt -c -g -bin-annot -I spec -I host -I given -I host/import -o spec/i64.d.cmo spec/i64.ml
ocamlc.opt -c -g -bin-annot -I spec -I host -I given -I host/import -o spec/float.d.cmo spec/float.ml
ocamlc.opt -c -g -bin-annot -I spec -I host -I given -I host/import -o spec/int.d.cmo spec/int.ml
ocamlc.opt -c -g -bin-annot -I spec -I host -I given -I host/import -o spec/numeric_error.d.cmo spec/numeric_error.ml
ocamlc.opt -c -bin-annot -I spec -I host -I given -I host/import -o spec/eval_numeric.cmi spec/eval_numeric.mli
ocamlc.opt -c -bin-annot -I spec -I host -I given -I host/import -o spec/i64_convert.cmi spec/i64_convert.mli
ocamlc.opt -c -g -bin-annot -I spec -I host -I given -I host/import -o spec/eval.d.cmo spec/eval.ml
+ ocamlc.opt -c -g -bin-annot -I spec -I host -I given -I host/import -o spec/eval.d.cmo spec/eval.ml
File "spec/eval.ml", line 488, characters 56-58:
Warning 20: this argument will not be used by the function.
File "spec/eval.ml", line 488, characters 59-63:
Warning 20: this argument will not be used by the function.
File "spec/eval.ml", line 492, characters 22-24:
Warning 20: this argument will not be used by the function.
File "spec/eval.ml", line 492, characters 25-34:
Warning 20: this argument will not be used by the function.
ocamlc.opt -c -g -bin-annot -I spec -I host -I given -I host/import -o spec/instance.d.cmo spec/instance.ml
ocamlc.opt -c -bin-annot -I spec -I host -I given -I host/import -o spec/f32_convert.cmi spec/f32_convert.mli
ocamlc.opt -c -bin-annot -I spec -I host -I given -I host/import -o spec/f64_convert.cmi spec/f64_convert.mli
ocamlc.opt -c -bin-annot -I spec -I host -I given -I host/import -o spec/i32_convert.cmi spec/i32_convert.mli
ocamlc.opt -c -g -bin-annot -I spec -I host -I given -I host/import -o spec/error.d.cmo spec/error.ml
ocamlc.opt -c -g -bin-annot -I spec -I host -I given -I host/import -o spec/eval_numeric.d.cmo spec/eval_numeric.ml
ocamlc.opt -c -g -bin-annot -I spec -I host -I given -I host/import -o spec/i64_convert.d.cmo spec/i64_convert.ml
ocamlc.opt -c -g -bin-annot -I spec -I host -I given -I host/import -o spec/table.d.cmo spec/table.ml
ocamlc.opt -c -g -bin-annot -I spec -I host -I given -I host/import -o spec/f32_convert.d.cmo spec/f32_convert.ml
ocamlc.opt -c -g -bin-annot -I spec -I host -I given -I host/import -o spec/f64_convert.d.cmo spec/f64_convert.ml
ocamlc.opt -c -g -bin-annot -I spec -I host -I given -I host/import -o spec/i32_convert.d.cmo spec/i32_convert.ml
ocamlc.opt -c -bin-annot -I spec -I host -I given -I host/import -o spec/operators.cmo spec/operators.ml
ocamlyacc host/parser.mly
ocamlc.opt -c -bin-annot -I host -I spec -I given -I host/import -o host/parser.cmi host/parser.mli
ocamlc.opt -c -bin-annot -I host -I spec -I given -I host/import -o host/lexer.cmi host/lexer.mli
ocamlc.opt -c -g -bin-annot -I host -I spec -I given -I host/import -o host/arrange.d.cmo host/arrange.ml
ocamlc.opt -c -g -bin-annot -I spec -I host -I given -I host/import -o spec/check.d.cmo spec/check.ml
ocamlc.opt -c -g -bin-annot -I spec -I host -I given -I host/import -o spec/decode.d.cmo spec/decode.ml
ocamlc.opt -c -g -bin-annot -I host -I spec -I given -I host/import -o host/parse.d.cmo host/parse.ml
ocamlc.opt -c -g -bin-annot -I host -I spec -I given -I host/import -o host/script.d.cmo host/script.ml
+ ocamlc.opt -c -g -bin-annot -I host -I spec -I given -I host/import -o host/script.d.cmo host/script.ml
File "host/script.ml", line 16, characters 36-50:
Error: Unbound module Kernel
Command exited with code 2.
