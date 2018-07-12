rem Auto-generated from Makefile!
set NAME=wasm
if '%1' neq '' set NAME=%1
ocamlc.opt -c -w +a-4-27-42-44-45 -warn-error +a -bin-annot -I exec -I util -I binary -I valid -I syntax -I host -I script -I text -I main -o exec/numeric_error.cmo exec/numeric_error.ml
ocamlc.opt -c -w +a-4-27-42-44-45 -warn-error +a -bin-annot -I exec -I util -I binary -I valid -I syntax -I host -I script -I text -I main -o exec/int.cmo exec/int.ml
ocamlc.opt -c -w +a-4-27-42-44-45 -warn-error +a -bin-annot -I exec -I util -I binary -I valid -I syntax -I host -I script -I text -I main -o exec/i32.cmo exec/i32.ml
ocamlc.opt -c -w +a-4-27-42-44-45 -warn-error +a -bin-annot -I exec -I util -I binary -I valid -I syntax -I host -I script -I text -I main -o exec/float.cmo exec/float.ml
ocamlc.opt -c -w +a-4-27-42-44-45 -warn-error +a -bin-annot -I syntax -I util -I binary -I valid -I host -I script -I text -I main -I exec -o syntax/types.cmo syntax/types.ml
ocamlc.opt -c -w +a-4-27-42-44-45 -warn-error +a -bin-annot -I exec -I util -I binary -I valid -I syntax -I host -I script -I text -I main -o exec/f32.cmo exec/f32.ml
ocamlc.opt -c -w +a-4-27-42-44-45 -warn-error +a -bin-annot -I exec -I util -I binary -I valid -I syntax -I host -I script -I text -I main -o exec/f64.cmo exec/f64.ml
ocamlc.opt -c -w +a-4-27-42-44-45 -warn-error +a -bin-annot -I exec -I util -I binary -I valid -I syntax -I host -I script -I text -I main -o exec/i64.cmo exec/i64.ml
ocamlc.opt -c -w +a-4-27-42-44-45 -warn-error +a -bin-annot -I syntax -I util -I binary -I valid -I host -I script -I text -I main -I exec -o syntax/values.cmo syntax/values.ml
ocamlc.opt -c -w +a-4-27-42-44-45 -warn-error +a -bin-annot -I util -I binary -I valid -I syntax -I host -I script -I text -I main -I exec -o util/lib.cmi util/lib.mli
ocamlc.opt -c -w +a-4-27-42-44-45 -warn-error +a -bin-annot -I exec -I util -I binary -I valid -I syntax -I host -I script -I text -I main -o exec/memory.cmi exec/memory.mli
ocamlc.opt -c -w +a-4-27-42-44-45 -warn-error +a -bin-annot -I util -I binary -I valid -I syntax -I host -I script -I text -I main -I exec -o util/source.cmi util/source.mli
ocamlc.opt -c -w +a-4-27-42-44-45 -warn-error +a -bin-annot -I syntax -I util -I binary -I valid -I host -I script -I text -I main -I exec -o syntax/ast.cmo syntax/ast.ml
ocamlc.opt -c -w +a-4-27-42-44-45 -warn-error +a -bin-annot -I exec -I util -I binary -I valid -I syntax -I host -I script -I text -I main -o exec/table.cmi exec/table.mli
ocamlc.opt -c -w +a-4-27-42-44-45 -warn-error +a -bin-annot -I exec -I util -I binary -I valid -I syntax -I host -I script -I text -I main -o exec/instance.cmo exec/instance.ml
ocamlc.opt -c -w +a-4-27-42-44-45 -warn-error +a -bin-annot -I exec -I util -I binary -I valid -I syntax -I host -I script -I text -I main -o exec/eval.cmi exec/eval.mli
ocamlc.opt -c -w +a-4-27-42-44-45 -warn-error +a -bin-annot -I binary -I util -I valid -I syntax -I host -I script -I text -I main -I exec -o binary/utf8.cmi binary/utf8.mli
ocamlc.opt -c -w +a-4-27-42-44-45 -warn-error +a -bin-annot -I host -I util -I binary -I valid -I syntax -I script -I text -I main -I exec -o host/env.cmo host/env.ml
ocamlc.opt -c -w +a-4-27-42-44-45 -warn-error +a -bin-annot -I main -I util -I binary -I valid -I syntax -I host -I script -I text -I exec -o main/flags.cmo main/flags.ml
ocamlc.opt -c -w +a-4-27-42-44-45 -warn-error +a -bin-annot -I script -I util -I binary -I valid -I syntax -I host -I text -I main -I exec -o script/import.cmi script/import.mli
ocamlc.opt -c -w +a-4-27-42-44-45 -warn-error +a -bin-annot -I script -I util -I binary -I valid -I syntax -I host -I text -I main -I exec -o script/run.cmi script/run.mli
ocamlc.opt -c -w +a-4-27-42-44-45 -warn-error +a -bin-annot -I host -I util -I binary -I valid -I syntax -I script -I text -I main -I exec -o host/spectest.cmo host/spectest.ml
ocamlc.opt -c -w +a-4-27-42-44-45 -warn-error +a -bin-annot -I main -I util -I binary -I valid -I syntax -I host -I script -I text -I exec -o main/main.cmo main/main.ml
ocamlc.opt -c -w +a-4-27-42-44-45 -warn-error +a -g -bin-annot -I main -I util -I binary -I valid -I syntax -I host -I script -I text -I exec -o main/main.d.cmo main/main.ml
ocamlc.opt -c -w +a-4-27-42-44-45 -warn-error +a -bin-annot -I util -I binary -I valid -I syntax -I host -I script -I text -I main -I exec -o util/error.cmi util/error.mli
ocamlc.opt -c -w +a-4-27-42-44-45 -warn-error +a -bin-annot -I script -I util -I binary -I valid -I syntax -I host -I text -I main -I exec -o script/script.cmo script/script.ml
ocamlc.opt -c -w +a-4-27-42-44-45 -warn-error +a -bin-annot -I binary -I util -I valid -I syntax -I host -I script -I text -I main -I exec -o binary/decode.cmi binary/decode.mli
ocamlc.opt -c -w +a-4-27-42-44-45 -warn-error +a -bin-annot -I binary -I util -I valid -I syntax -I host -I script -I text -I main -I exec -o binary/encode.cmi binary/encode.mli
ocamlc.opt -c -w +a-4-27-42-44-45 -warn-error +a -bin-annot -I script -I util -I binary -I valid -I syntax -I host -I text -I main -I exec -o script/js.cmi script/js.mli
ocamlc.opt -c -w +a-4-27-42-44-45 -warn-error +a -bin-annot -I text -I util -I binary -I valid -I syntax -I host -I script -I main -I exec -o text/parse.cmi text/parse.mli
ocamlc.opt -c -w +a-4-27-42-44-45 -warn-error +a -bin-annot -I text -I util -I binary -I valid -I syntax -I host -I script -I main -I exec -o text/print.cmi text/print.mli
ocamlc.opt -c -w +a-4-27-42-44-45 -warn-error +a -bin-annot -I valid -I util -I binary -I syntax -I host -I script -I text -I main -I exec -o valid/valid.cmi valid/valid.mli
ocamlc.opt -c -w +a-4-27-42-44-45 -warn-error +a -g -bin-annot -I host -I util -I binary -I valid -I syntax -I script -I text -I main -I exec -o host/env.d.cmo host/env.ml
ocamlc.opt -c -w +a-4-27-42-44-45 -warn-error +a -g -bin-annot -I main -I util -I binary -I valid -I syntax -I host -I script -I text -I exec -o main/flags.d.cmo main/flags.ml
ocamlc.opt -c -w +a-4-27-42-44-45 -warn-error +a -g -bin-annot -I script -I util -I binary -I valid -I syntax -I host -I text -I main -I exec -o script/import.d.cmo script/import.ml
ocamlc.opt -c -w +a-4-27-42-44-45 -warn-error +a -g -bin-annot -I script -I util -I binary -I valid -I syntax -I host -I text -I main -I exec -o script/run.d.cmo script/run.ml
ocamlc.opt -c -w +a-4-27-42-44-45 -warn-error +a -g -bin-annot -I host -I util -I binary -I valid -I syntax -I script -I text -I main -I exec -o host/spectest.d.cmo host/spectest.ml
ocamlc.opt -c -w +a-4-27-42-44-45 -warn-error +a -g -bin-annot -I binary -I util -I valid -I syntax -I host -I script -I text -I main -I exec -o binary/utf8.d.cmo binary/utf8.ml
ocamlc.opt -c -w +a-4-27-42-44-45 -warn-error +a -bin-annot -I exec -I util -I binary -I valid -I syntax -I host -I script -I text -I main -o exec/eval_numeric.cmi exec/eval_numeric.mli
ocamlc.opt -c -w +a-4-27-42-44-45 -warn-error +a -bin-annot -I exec -I util -I binary -I valid -I syntax -I host -I script -I text -I main -o exec/i64_convert.cmi exec/i64_convert.mli
ocamlc.opt -c -w +a-4-27-42-44-45 -warn-error +a -g -bin-annot -I exec -I util -I binary -I valid -I syntax -I host -I script -I text -I main -o exec/eval.d.cmo exec/eval.ml
ocamlc.opt -c -w +a-4-27-42-44-45 -warn-error +a -g -bin-annot -I exec -I util -I binary -I valid -I syntax -I host -I script -I text -I main -o exec/instance.d.cmo exec/instance.ml
ocamlc.opt -c -w +a-4-27-42-44-45 -warn-error +a -g -bin-annot -I util -I binary -I valid -I syntax -I host -I script -I text -I main -I exec -o util/source.d.cmo util/source.ml
ocamlc.opt -c -w +a-4-27-42-44-45 -warn-error +a -g -bin-annot -I syntax -I util -I binary -I valid -I host -I script -I text -I main -I exec -o syntax/types.d.cmo syntax/types.ml
ocamlc.opt -c -w +a-4-27-42-44-45 -warn-error +a -g -bin-annot -I syntax -I util -I binary -I valid -I host -I script -I text -I main -I exec -o syntax/values.d.cmo syntax/values.ml
ocamlc.opt -c -w +a-4-27-42-44-45 -warn-error +a -bin-annot -I exec -I util -I binary -I valid -I syntax -I host -I script -I text -I main -o exec/f32_convert.cmi exec/f32_convert.mli
ocamlc.opt -c -w +a-4-27-42-44-45 -warn-error +a -bin-annot -I exec -I util -I binary -I valid -I syntax -I host -I script -I text -I main -o exec/f64_convert.cmi exec/f64_convert.mli
ocamlc.opt -c -w +a-4-27-42-44-45 -warn-error +a -bin-annot -I exec -I util -I binary -I valid -I syntax -I host -I script -I text -I main -o exec/i32_convert.cmi exec/i32_convert.mli
ocamlc.opt -c -w +a-4-27-42-44-45 -warn-error +a -g -bin-annot -I syntax -I util -I binary -I valid -I host -I script -I text -I main -I exec -o syntax/ast.d.cmo syntax/ast.ml
ocamlc.opt -c -w +a-4-27-42-44-45 -warn-error +a -g -bin-annot -I util -I binary -I valid -I syntax -I host -I script -I text -I main -I exec -o util/error.d.cmo util/error.ml
ocamlc.opt -c -w +a-4-27-42-44-45 -warn-error +a -g -bin-annot -I exec -I util -I binary -I valid -I syntax -I host -I script -I text -I main -o exec/eval_numeric.d.cmo exec/eval_numeric.ml
ocamlc.opt -c -w +a-4-27-42-44-45 -warn-error +a -g -bin-annot -I exec -I util -I binary -I valid -I syntax -I host -I script -I text -I main -o exec/i32.d.cmo exec/i32.ml
ocamlc.opt -c -w +a-4-27-42-44-45 -warn-error +a -g -bin-annot -I exec -I util -I binary -I valid -I syntax -I host -I script -I text -I main -o exec/i64.d.cmo exec/i64.ml
ocamlc.opt -c -w +a-4-27-42-44-45 -warn-error +a -g -bin-annot -I exec -I util -I binary -I valid -I syntax -I host -I script -I text -I main -o exec/i64_convert.d.cmo exec/i64_convert.ml
ocamlc.opt -c -w +a-4-27-42-44-45 -warn-error +a -g -bin-annot -I util -I binary -I valid -I syntax -I host -I script -I text -I main -I exec -o util/lib.d.cmo util/lib.ml
ocamlc.opt -c -w +a-4-27-42-44-45 -warn-error +a -g -bin-annot -I exec -I util -I binary -I valid -I syntax -I host -I script -I text -I main -o exec/memory.d.cmo exec/memory.ml
ocamlc.opt -c -w +a-4-27-42-44-45 -warn-error +a -g -bin-annot -I exec -I util -I binary -I valid -I syntax -I host -I script -I text -I main -o exec/numeric_error.d.cmo exec/numeric_error.ml
ocamlc.opt -c -w +a-4-27-42-44-45 -warn-error +a -g -bin-annot -I exec -I util -I binary -I valid -I syntax -I host -I script -I text -I main -o exec/table.d.cmo exec/table.ml
ocamlc.opt -c -w +a-4-27-42-44-45 -warn-error +a -g -bin-annot -I exec -I util -I binary -I valid -I syntax -I host -I script -I text -I main -o exec/f32.d.cmo exec/f32.ml
ocamlc.opt -c -w +a-4-27-42-44-45 -warn-error +a -g -bin-annot -I exec -I util -I binary -I valid -I syntax -I host -I script -I text -I main -o exec/f64.d.cmo exec/f64.ml
ocamlc.opt -c -w +a-4-27-42-44-45 -warn-error +a -g -bin-annot -I exec -I util -I binary -I valid -I syntax -I host -I script -I text -I main -o exec/float.d.cmo exec/float.ml
ocamlc.opt -c -w +a-4-27-42-44-45 -warn-error +a -g -bin-annot -I exec -I util -I binary -I valid -I syntax -I host -I script -I text -I main -o exec/int.d.cmo exec/int.ml
ocamlc.opt -c -w +a-4-27-42-44-45 -warn-error +a -g -bin-annot -I exec -I util -I binary -I valid -I syntax -I host -I script -I text -I main -o exec/f32_convert.d.cmo exec/f32_convert.ml
ocamlc.opt -c -w +a-4-27-42-44-45 -warn-error +a -g -bin-annot -I exec -I util -I binary -I valid -I syntax -I host -I script -I text -I main -o exec/f64_convert.d.cmo exec/f64_convert.ml
ocamlc.opt -c -w +a-4-27-42-44-45 -warn-error +a -g -bin-annot -I exec -I util -I binary -I valid -I syntax -I host -I script -I text -I main -o exec/i32_convert.d.cmo exec/i32_convert.ml
ocamlc.opt -c -w +a-4-27-42-44-45 -warn-error +a -bin-annot -I syntax -I util -I binary -I valid -I host -I script -I text -I main -I exec -o syntax/operators.cmo syntax/operators.ml
ocamlyacc text/parser.mly
ocamlc.opt -c -w +a-4-27-42-44-45 -warn-error +a -bin-annot -I text -I util -I binary -I valid -I syntax -I host -I script -I main -I exec -o text/parser.cmi text/parser.mli
ocamlc.opt -c -w +a-4-27-42-44-45 -warn-error +a -bin-annot -I text -I util -I binary -I valid -I syntax -I host -I script -I main -I exec -o text/lexer.cmi text/lexer.mli
ocamlc.opt -c -w +a-4-27-42-44-45 -warn-error +a -bin-annot -I util -I binary -I valid -I syntax -I host -I script -I text -I main -I exec -o util/sexpr.cmi util/sexpr.mli
ocamlc.opt -c -w +a-4-27-42-44-45 -warn-error +a -bin-annot -I text -I util -I binary -I valid -I syntax -I host -I script -I main -I exec -o text/arrange.cmi text/arrange.mli
ocamlc.opt -c -w +a-4-27-42-44-45 -warn-error +a -g -bin-annot -I binary -I util -I valid -I syntax -I host -I script -I text -I main -I exec -o binary/decode.d.cmo binary/decode.ml
ocamlc.opt -c -w +a-4-27-42-44-45 -warn-error +a -g -bin-annot -I binary -I util -I valid -I syntax -I host -I script -I text -I main -I exec -o binary/encode.d.cmo binary/encode.ml
ocamlc.opt -c -w +a-4-27-42-44-45 -warn-error +a -g -bin-annot -I script -I util -I binary -I valid -I syntax -I host -I text -I main -I exec -o script/js.d.cmo script/js.ml
ocamlc.opt -c -w +a-4-27-42-44-45 -warn-error +a -g -bin-annot -I text -I util -I binary -I valid -I syntax -I host -I script -I main -I exec -o text/parse.d.cmo text/parse.ml
ocamlc.opt -c -w +a-4-27-42-44-45 -warn-error +a -g -bin-annot -I text -I util -I binary -I valid -I syntax -I host -I script -I main -I exec -o text/print.d.cmo text/print.ml
ocamlc.opt -c -w +a-4-27-42-44-45 -warn-error +a -g -bin-annot -I script -I util -I binary -I valid -I syntax -I host -I text -I main -I exec -o script/script.d.cmo script/script.ml
ocamlc.opt -c -w +a-4-27-42-44-45 -warn-error +a -g -bin-annot -I valid -I util -I binary -I syntax -I host -I script -I text -I main -I exec -o valid/valid.d.cmo valid/valid.ml
ocamlc.opt -c -w +a-4-27-42-44-45 -warn-error +a -g -bin-annot -I syntax -I util -I binary -I valid -I host -I script -I text -I main -I exec -o syntax/operators.d.cmo syntax/operators.ml
ocamllex.opt -q text/lexer.mll
ocamlc.opt -c -w +a-4-27-42-44-45 -warn-error +a -g -bin-annot -I text -I util -I binary -I valid -I syntax -I host -I script -I main -I exec -o text/lexer.d.cmo text/lexer.ml
ocamlc.opt -c -w +a-4-27-42-44-45 -warn-error +a -g -bin-annot -I text -I util -I binary -I valid -I syntax -I host -I script -I main -I exec -o text/parser.d.cmo text/parser.ml
ocamlc.opt -c -w +a-4-27-42-44-45 -warn-error +a -g -bin-annot -I text -I util -I binary -I valid -I syntax -I host -I script -I main -I exec -o text/arrange.d.cmo text/arrange.ml
ocamlc.opt -c -w +a-4-27-42-44-45 -warn-error +a -g -bin-annot -I util -I binary -I valid -I syntax -I host -I script -I text -I main -I exec -o util/sexpr.d.cmo util/sexpr.ml
ocamlc.opt bigarray.cma -g util/lib.d.cmo binary/utf8.d.cmo exec/float.d.cmo exec/f32.d.cmo exec/f64.d.cmo exec/numeric_error.d.cmo exec/int.d.cmo exec/i32.d.cmo exec/i64.d.cmo exec/i32_convert.d.cmo exec/f32_convert.d.cmo exec/i64_convert.d.cmo exec/f64_convert.d.cmo syntax/types.d.cmo syntax/values.d.cmo exec/memory.d.cmo util/source.d.cmo syntax/ast.d.cmo exec/eval_numeric.d.cmo exec/table.d.cmo exec/instance.d.cmo util/error.d.cmo exec/eval.d.cmo host/env.d.cmo host/spectest.d.cmo main/flags.d.cmo script/import.d.cmo binary/encode.d.cmo syntax/operators.d.cmo binary/decode.d.cmo script/script.d.cmo text/parser.d.cmo text/lexer.d.cmo text/parse.d.cmo script/js.d.cmo util/sexpr.d.cmo text/arrange.d.cmo text/print.d.cmo valid/valid.d.cmo script/run.d.cmo main/main.d.cmo -o main/main.d.byte
