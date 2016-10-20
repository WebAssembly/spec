rem Auto-generated from Makefile!
set NAME=wasm
if '%1' neq '' set NAME=%1
ocamlc.opt -c -w +a-4-27-42-44-45 -warn-error +a -bin-annot -I spec -I text -I host -I aux -I host/import -o spec/numeric_error.cmo spec/numeric_error.ml
ocamlc.opt -c -w +a-4-27-42-44-45 -warn-error +a -bin-annot -I spec -I text -I host -I aux -I host/import -o spec/int.cmo spec/int.ml
ocamlc.opt -c -w +a-4-27-42-44-45 -warn-error +a -bin-annot -I spec -I text -I host -I aux -I host/import -o spec/i32.cmo spec/i32.ml
ocamlc.opt -c -w +a-4-27-42-44-45 -warn-error +a -bin-annot -I spec -I text -I host -I aux -I host/import -o spec/float.cmo spec/float.ml
ocamlc.opt -c -w +a-4-27-42-44-45 -warn-error +a -bin-annot -I spec -I text -I host -I aux -I host/import -o spec/types.cmo spec/types.ml
ocamlc.opt -c -w +a-4-27-42-44-45 -warn-error +a -bin-annot -I spec -I text -I host -I aux -I host/import -o spec/f32.cmo spec/f32.ml
ocamlc.opt -c -w +a-4-27-42-44-45 -warn-error +a -bin-annot -I spec -I text -I host -I aux -I host/import -o spec/f64.cmo spec/f64.ml
ocamlc.opt -c -w +a-4-27-42-44-45 -warn-error +a -bin-annot -I spec -I text -I host -I aux -I host/import -o spec/i64.cmo spec/i64.ml
ocamlc.opt -c -w +a-4-27-42-44-45 -warn-error +a -bin-annot -I spec -I text -I host -I aux -I host/import -o spec/values.cmo spec/values.ml
ocamlc.opt -c -w +a-4-27-42-44-45 -warn-error +a -bin-annot -I aux -I text -I spec -I host -I host/import -o aux/lib.cmi aux/lib.mli
ocamlc.opt -c -w +a-4-27-42-44-45 -warn-error +a -bin-annot -I spec -I text -I host -I aux -I host/import -o spec/memory.cmi spec/memory.mli
ocamlc.opt -c -w +a-4-27-42-44-45 -warn-error +a -bin-annot -I aux -I text -I spec -I host -I host/import -o aux/source.cmi aux/source.mli
ocamlc.opt -c -w +a-4-27-42-44-45 -warn-error +a -bin-annot -I spec -I text -I host -I aux -I host/import -o spec/ast.cmo spec/ast.ml
ocamlc.opt -c -w +a-4-27-42-44-45 -warn-error +a -bin-annot -I spec -I text -I host -I aux -I host/import -o spec/table.cmi spec/table.mli
ocamlc.opt -c -w +a-4-27-42-44-45 -warn-error +a -bin-annot -I spec -I text -I host -I aux -I host/import -o spec/instance.cmo spec/instance.ml
ocamlc.opt -c -w +a-4-27-42-44-45 -warn-error +a -bin-annot -I spec -I text -I host -I aux -I host/import -o spec/eval.cmi spec/eval.mli
ocamlc.opt -c -w +a-4-27-42-44-45 -warn-error +a -bin-annot -I spec -I text -I host -I aux -I host/import -o spec/encode.cmi spec/encode.mli
ocamlc.opt -c -w +a-4-27-42-44-45 -warn-error +a -bin-annot -I host/import -I text -I spec -I host -I aux -o host/import/env.cmo host/import/env.ml
ocamlc.opt -c -w +a-4-27-42-44-45 -warn-error +a -bin-annot -I host -I text -I spec -I aux -I host/import -o host/flags.cmo host/flags.ml
ocamlc.opt -c -w +a-4-27-42-44-45 -warn-error +a -bin-annot -I host -I text -I spec -I aux -I host/import -o host/import.cmi host/import.mli
ocamlc.opt -c -w +a-4-27-42-44-45 -warn-error +a -bin-annot -I host -I text -I spec -I aux -I host/import -o host/run.cmi host/run.mli
ocamlc.opt -c -w +a-4-27-42-44-45 -warn-error +a -bin-annot -I host/import -I text -I spec -I host -I aux -o host/import/spectest.cmo host/import/spectest.ml
ocamlc.opt -c -w +a-4-27-42-44-45 -warn-error +a -bin-annot -I host -I text -I spec -I aux -I host/import -o host/main.cmo host/main.ml
ocamlc.opt -c -w +a-4-27-42-44-45 -warn-error +a -g -bin-annot -I host -I text -I spec -I aux -I host/import -o host/main.d.cmo host/main.ml
ocamlc.opt -c -w +a-4-27-42-44-45 -warn-error +a -bin-annot -I aux -I text -I spec -I host -I host/import -o aux/error.cmi aux/error.mli
ocamlc.opt -c -w +a-4-27-42-44-45 -warn-error +a -bin-annot -I text -I spec -I host -I aux -I host/import -o text/script.cmo text/script.ml
ocamlc.opt -c -w +a-4-27-42-44-45 -warn-error +a -bin-annot -I spec -I text -I host -I aux -I host/import -o spec/decode.cmi spec/decode.mli
ocamlc.opt -c -w +a-4-27-42-44-45 -warn-error +a -bin-annot -I host -I text -I spec -I aux -I host/import -o host/js.cmi host/js.mli
ocamlc.opt -c -w +a-4-27-42-44-45 -warn-error +a -bin-annot -I text -I spec -I host -I aux -I host/import -o text/parse.cmi text/parse.mli
ocamlc.opt -c -w +a-4-27-42-44-45 -warn-error +a -bin-annot -I text -I spec -I host -I aux -I host/import -o text/print.cmi text/print.mli
ocamlc.opt -c -w +a-4-27-42-44-45 -warn-error +a -bin-annot -I spec -I text -I host -I aux -I host/import -o spec/valid.cmi spec/valid.mli
ocamlc.opt -c -w +a-4-27-42-44-45 -warn-error +a -g -bin-annot -I spec -I text -I host -I aux -I host/import -o spec/encode.d.cmo spec/encode.ml
ocamlc.opt -c -w +a-4-27-42-44-45 -warn-error +a -g -bin-annot -I host/import -I text -I spec -I host -I aux -o host/import/env.d.cmo host/import/env.ml
ocamlc.opt -c -w +a-4-27-42-44-45 -warn-error +a -g -bin-annot -I host -I text -I spec -I aux -I host/import -o host/flags.d.cmo host/flags.ml
ocamlc.opt -c -w +a-4-27-42-44-45 -warn-error +a -g -bin-annot -I host -I text -I spec -I aux -I host/import -o host/import.d.cmo host/import.ml
ocamlc.opt -c -w +a-4-27-42-44-45 -warn-error +a -g -bin-annot -I host -I text -I spec -I aux -I host/import -o host/run.d.cmo host/run.ml
ocamlc.opt -c -w +a-4-27-42-44-45 -warn-error +a -g -bin-annot -I host/import -I text -I spec -I host -I aux -o host/import/spectest.d.cmo host/import/spectest.ml
ocamlc.opt -c -w +a-4-27-42-44-45 -warn-error +a -g -bin-annot -I spec -I text -I host -I aux -I host/import -o spec/ast.d.cmo spec/ast.ml
ocamlc.opt -c -w +a-4-27-42-44-45 -warn-error +a -g -bin-annot -I aux -I text -I spec -I host -I host/import -o aux/error.d.cmo aux/error.ml
ocamlc.opt -c -w +a-4-27-42-44-45 -warn-error +a -g -bin-annot -I spec -I text -I host -I aux -I host/import -o spec/f32.d.cmo spec/f32.ml
ocamlc.opt -c -w +a-4-27-42-44-45 -warn-error +a -g -bin-annot -I spec -I text -I host -I aux -I host/import -o spec/f64.d.cmo spec/f64.ml
ocamlc.opt -c -w +a-4-27-42-44-45 -warn-error +a -g -bin-annot -I spec -I text -I host -I aux -I host/import -o spec/i32.d.cmo spec/i32.ml
ocamlc.opt -c -w +a-4-27-42-44-45 -warn-error +a -g -bin-annot -I aux -I text -I spec -I host -I host/import -o aux/lib.d.cmo aux/lib.ml
ocamlc.opt -c -w +a-4-27-42-44-45 -warn-error +a -g -bin-annot -I spec -I text -I host -I aux -I host/import -o spec/memory.d.cmo spec/memory.ml
ocamlc.opt -c -w +a-4-27-42-44-45 -warn-error +a -g -bin-annot -I aux -I text -I spec -I host -I host/import -o aux/source.d.cmo aux/source.ml
ocamlc.opt -c -w +a-4-27-42-44-45 -warn-error +a -g -bin-annot -I spec -I text -I host -I aux -I host/import -o spec/types.d.cmo spec/types.ml
ocamlc.opt -c -w +a-4-27-42-44-45 -warn-error +a -g -bin-annot -I spec -I text -I host -I aux -I host/import -o spec/values.d.cmo spec/values.ml
ocamlc.opt -c -w +a-4-27-42-44-45 -warn-error +a -g -bin-annot -I spec -I text -I host -I aux -I host/import -o spec/i64.d.cmo spec/i64.ml
ocamlc.opt -c -w +a-4-27-42-44-45 -warn-error +a -g -bin-annot -I spec -I text -I host -I aux -I host/import -o spec/float.d.cmo spec/float.ml
ocamlc.opt -c -w +a-4-27-42-44-45 -warn-error +a -g -bin-annot -I spec -I text -I host -I aux -I host/import -o spec/int.d.cmo spec/int.ml
ocamlc.opt -c -w +a-4-27-42-44-45 -warn-error +a -g -bin-annot -I spec -I text -I host -I aux -I host/import -o spec/numeric_error.d.cmo spec/numeric_error.ml
ocamlc.opt -c -w +a-4-27-42-44-45 -warn-error +a -bin-annot -I spec -I text -I host -I aux -I host/import -o spec/eval_numeric.cmi spec/eval_numeric.mli
ocamlc.opt -c -w +a-4-27-42-44-45 -warn-error +a -bin-annot -I spec -I text -I host -I aux -I host/import -o spec/i64_convert.cmi spec/i64_convert.mli
ocamlc.opt -c -w +a-4-27-42-44-45 -warn-error +a -g -bin-annot -I spec -I text -I host -I aux -I host/import -o spec/eval.d.cmo spec/eval.ml
ocamlc.opt -c -w +a-4-27-42-44-45 -warn-error +a -g -bin-annot -I spec -I text -I host -I aux -I host/import -o spec/instance.d.cmo spec/instance.ml
ocamlc.opt -c -w +a-4-27-42-44-45 -warn-error +a -bin-annot -I spec -I text -I host -I aux -I host/import -o spec/f32_convert.cmi spec/f32_convert.mli
ocamlc.opt -c -w +a-4-27-42-44-45 -warn-error +a -bin-annot -I spec -I text -I host -I aux -I host/import -o spec/f64_convert.cmi spec/f64_convert.mli
ocamlc.opt -c -w +a-4-27-42-44-45 -warn-error +a -bin-annot -I spec -I text -I host -I aux -I host/import -o spec/i32_convert.cmi spec/i32_convert.mli
ocamlc.opt -c -w +a-4-27-42-44-45 -warn-error +a -g -bin-annot -I spec -I text -I host -I aux -I host/import -o spec/eval_numeric.d.cmo spec/eval_numeric.ml
ocamlc.opt -c -w +a-4-27-42-44-45 -warn-error +a -g -bin-annot -I spec -I text -I host -I aux -I host/import -o spec/i64_convert.d.cmo spec/i64_convert.ml
ocamlc.opt -c -w +a-4-27-42-44-45 -warn-error +a -g -bin-annot -I spec -I text -I host -I aux -I host/import -o spec/table.d.cmo spec/table.ml
ocamlc.opt -c -w +a-4-27-42-44-45 -warn-error +a -g -bin-annot -I spec -I text -I host -I aux -I host/import -o spec/f32_convert.d.cmo spec/f32_convert.ml
ocamlc.opt -c -w +a-4-27-42-44-45 -warn-error +a -g -bin-annot -I spec -I text -I host -I aux -I host/import -o spec/f64_convert.d.cmo spec/f64_convert.ml
ocamlc.opt -c -w +a-4-27-42-44-45 -warn-error +a -g -bin-annot -I spec -I text -I host -I aux -I host/import -o spec/i32_convert.d.cmo spec/i32_convert.ml
ocamlc.opt -c -w +a-4-27-42-44-45 -warn-error +a -bin-annot -I spec -I text -I host -I aux -I host/import -o spec/operators.cmo spec/operators.ml
ocamlyacc text/parser.mly
ocamlc.opt -c -w +a-4-27-42-44-45 -warn-error +a -bin-annot -I text -I spec -I host -I aux -I host/import -o text/parser.cmi text/parser.mli
ocamlc.opt -c -w +a-4-27-42-44-45 -warn-error +a -bin-annot -I text -I spec -I host -I aux -I host/import -o text/lexer.cmi text/lexer.mli
ocamlc.opt -c -w +a-4-27-42-44-45 -warn-error +a -bin-annot -I aux -I text -I spec -I host -I host/import -o aux/sexpr.cmi aux/sexpr.mli
ocamlc.opt -c -w +a-4-27-42-44-45 -warn-error +a -bin-annot -I text -I spec -I host -I aux -I host/import -o text/arrange.cmi text/arrange.mli
ocamlc.opt -c -w +a-4-27-42-44-45 -warn-error +a -g -bin-annot -I spec -I text -I host -I aux -I host/import -o spec/decode.d.cmo spec/decode.ml
ocamlc.opt -c -w +a-4-27-42-44-45 -warn-error +a -g -bin-annot -I host -I text -I spec -I aux -I host/import -o host/js.d.cmo host/js.ml
ocamlc.opt -c -w +a-4-27-42-44-45 -warn-error +a -g -bin-annot -I text -I spec -I host -I aux -I host/import -o text/parse.d.cmo text/parse.ml
ocamlc.opt -c -w +a-4-27-42-44-45 -warn-error +a -g -bin-annot -I text -I spec -I host -I aux -I host/import -o text/print.d.cmo text/print.ml
ocamlc.opt -c -w +a-4-27-42-44-45 -warn-error +a -g -bin-annot -I text -I spec -I host -I aux -I host/import -o text/script.d.cmo text/script.ml
ocamlc.opt -c -w +a-4-27-42-44-45 -warn-error +a -g -bin-annot -I spec -I text -I host -I aux -I host/import -o spec/valid.d.cmo spec/valid.ml
ocamlc.opt -c -w +a-4-27-42-44-45 -warn-error +a -g -bin-annot -I spec -I text -I host -I aux -I host/import -o spec/operators.d.cmo spec/operators.ml
ocamllex.opt -q text/lexer.mll
ocamlc.opt -c -w +a-4-27-42-44-45 -warn-error +a -g -bin-annot -I text -I spec -I host -I aux -I host/import -o text/lexer.d.cmo text/lexer.ml
ocamlc.opt -c -w +a-4-27-42-44-45 -warn-error +a -g -bin-annot -I text -I spec -I host -I aux -I host/import -o text/parser.d.cmo text/parser.ml
ocamlc.opt -c -w +a-4-27-42-44-45 -warn-error +a -g -bin-annot -I text -I spec -I host -I aux -I host/import -o text/arrange.d.cmo text/arrange.ml
ocamlc.opt -c -w +a-4-27-42-44-45 -warn-error +a -g -bin-annot -I aux -I text -I spec -I host -I host/import -o aux/sexpr.d.cmo aux/sexpr.ml
ocamlc.opt str.cma bigarray.cma -g host/flags.d.cmo aux/source.d.cmo aux/error.d.cmo aux/lib.d.cmo spec/float.d.cmo spec/f32.d.cmo spec/f64.d.cmo spec/numeric_error.d.cmo spec/int.d.cmo spec/i32.d.cmo spec/i64.d.cmo spec/types.d.cmo spec/values.d.cmo spec/memory.d.cmo spec/ast.d.cmo spec/table.d.cmo spec/instance.d.cmo host/import.d.cmo spec/i32_convert.d.cmo spec/f32_convert.d.cmo spec/i64_convert.d.cmo spec/f64_convert.d.cmo spec/eval_numeric.d.cmo spec/eval.d.cmo host/import/env.d.cmo host/import/spectest.d.cmo spec/encode.d.cmo spec/operators.d.cmo spec/decode.d.cmo text/script.d.cmo host/js.d.cmo spec/valid.d.cmo text/parser.d.cmo text/lexer.d.cmo text/parse.d.cmo aux/sexpr.d.cmo text/arrange.d.cmo text/print.d.cmo host/run.d.cmo host/main.d.cmo -o %NAME%
