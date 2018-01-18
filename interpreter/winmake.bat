rem Auto-generated from Makefile!
set NAME=wasm
if '%1' neq '' set NAME=%1
ocamlc.opt -c -w +a-4-27-42-44-45 -warn-error +a -I exec -I valid -I util -I text -I syntax -I script -I runtime -I main -I host -I binary -o exec/numeric_error.cmo exec/numeric_error.ml
ocamlc.opt -c -w +a-4-27-42-44-45 -warn-error +a -I exec -I valid -I util -I text -I syntax -I script -I runtime -I main -I host -I binary -o exec/int.cmo exec/int.ml
ocamlc.opt -c -w +a-4-27-42-44-45 -warn-error +a -I util -I valid -I text -I syntax -I script -I runtime -I main -I host -I exec -I binary -o util/lib.cmi util/lib.mli
ocamlc.opt -c -w +a-4-27-42-44-45 -warn-error +a -I exec -I valid -I util -I text -I syntax -I script -I runtime -I main -I host -I binary -o exec/i32.cmo exec/i32.ml
ocamlc.opt -c -w +a-4-27-42-44-45 -warn-error +a -I exec -I valid -I util -I text -I syntax -I script -I runtime -I main -I host -I binary -o exec/float.cmo exec/float.ml
ocamlc.opt -c -w +a-4-27-42-44-45 -warn-error +a -I syntax -I valid -I util -I text -I script -I runtime -I main -I host -I exec -I binary -o syntax/types.cmo syntax/types.ml
ocamlc.opt -c -w +a-4-27-42-44-45 -warn-error +a -I exec -I valid -I util -I text -I syntax -I script -I runtime -I main -I host -I binary -o exec/f32.cmo exec/f32.ml
ocamlc.opt -c -w +a-4-27-42-44-45 -warn-error +a -I exec -I valid -I util -I text -I syntax -I script -I runtime -I main -I host -I binary -o exec/f64.cmo exec/f64.ml
ocamlc.opt -c -w +a-4-27-42-44-45 -warn-error +a -I exec -I valid -I util -I text -I syntax -I script -I runtime -I main -I host -I binary -o exec/i64.cmo exec/i64.ml
ocamlc.opt -c -w +a-4-27-42-44-45 -warn-error +a -I syntax -I valid -I util -I text -I script -I runtime -I main -I host -I exec -I binary -o syntax/values.cmo syntax/values.ml
ocamlc.opt -c -w +a-4-27-42-44-45 -warn-error +a -I runtime -I valid -I util -I text -I syntax -I script -I main -I host -I exec -I binary -o runtime/mem.cmi runtime/mem.mli
ocamlc.opt -c -w +a-4-27-42-44-45 -warn-error +a -I util -I valid -I text -I syntax -I script -I runtime -I main -I host -I exec -I binary -o util/source.cmi util/source.mli
ocamlc.opt -c -w +a-4-27-42-44-45 -warn-error +a -I syntax -I valid -I util -I text -I script -I runtime -I main -I host -I exec -I binary -o syntax/ast.cmo syntax/ast.ml
ocamlc.opt -c -w +a-4-27-42-44-45 -warn-error +a -I runtime -I valid -I util -I text -I syntax -I script -I main -I host -I exec -I binary -o runtime/func.cmi runtime/func.mli
ocamlc.opt -c -w +a-4-27-42-44-45 -warn-error +a -I runtime -I valid -I util -I text -I syntax -I script -I main -I host -I exec -I binary -o runtime/global.cmi runtime/global.mli
ocamlc.opt -c -w +a-4-27-42-44-45 -warn-error +a -I runtime -I valid -I util -I text -I syntax -I script -I main -I host -I exec -I binary -o runtime/table.cmi runtime/table.mli
ocamlc.opt -c -w +a-4-27-42-44-45 -warn-error +a -I runtime -I valid -I util -I text -I syntax -I script -I main -I host -I exec -I binary -o runtime/instance.cmo runtime/instance.ml
ocamlc.opt -c -w +a-4-27-42-44-45 -warn-error +a -I exec -I valid -I util -I text -I syntax -I script -I runtime -I main -I host -I binary -o exec/eval.cmi exec/eval.mli
ocamlc.opt -c -w +a-4-27-42-44-45 -warn-error +a -I binary -I valid -I util -I text -I syntax -I script -I runtime -I main -I host -I exec -o binary/utf8.cmi binary/utf8.mli
ocamlc.opt -c -w +a-4-27-42-44-45 -warn-error +a -I host -I valid -I util -I text -I syntax -I script -I runtime -I main -I exec -I binary -o host/env.cmo host/env.ml
ocamlc.opt -c -w +a-4-27-42-44-45 -warn-error +a -I main -I valid -I util -I text -I syntax -I script -I runtime -I host -I exec -I binary -o main/flags.cmo main/flags.ml
ocamlc.opt -c -w +a-4-27-42-44-45 -warn-error +a -I script -I valid -I util -I text -I syntax -I runtime -I main -I host -I exec -I binary -o script/import.cmi script/import.mli
ocamlc.opt -c -w +a-4-27-42-44-45 -warn-error +a -I script -I valid -I util -I text -I syntax -I runtime -I main -I host -I exec -I binary -o script/run.cmi script/run.mli
ocamlc.opt -c -w +a-4-27-42-44-45 -warn-error +a -I host -I valid -I util -I text -I syntax -I script -I runtime -I main -I exec -I binary -o host/spectest.cmo host/spectest.ml
ocamlc.opt -c -w +a-4-27-42-44-45 -warn-error +a -I main -I valid -I util -I text -I syntax -I script -I runtime -I host -I exec -I binary -o main/main.cmo main/main.ml
ocamlc.opt -c -w +a-4-27-42-44-45 -warn-error +a -g -I main -I valid -I util -I text -I syntax -I script -I runtime -I host -I exec -I binary -o main/main.d.cmo main/main.ml
ocamlc.opt -c -w +a-4-27-42-44-45 -warn-error +a -I util -I valid -I text -I syntax -I script -I runtime -I main -I host -I exec -I binary -o util/error.cmi util/error.mli
ocamlc.opt -c -w +a-4-27-42-44-45 -warn-error +a -I script -I valid -I util -I text -I syntax -I runtime -I main -I host -I exec -I binary -o script/script.cmo script/script.ml
ocamlc.opt -c -w +a-4-27-42-44-45 -warn-error +a -I binary -I valid -I util -I text -I syntax -I script -I runtime -I main -I host -I exec -o binary/decode.cmi binary/decode.mli
ocamlc.opt -c -w +a-4-27-42-44-45 -warn-error +a -I binary -I valid -I util -I text -I syntax -I script -I runtime -I main -I host -I exec -o binary/encode.cmi binary/encode.mli
ocamlc.opt -c -w +a-4-27-42-44-45 -warn-error +a -I script -I valid -I util -I text -I syntax -I runtime -I main -I host -I exec -I binary -o script/js.cmi script/js.mli
ocamlc.opt -c -w +a-4-27-42-44-45 -warn-error +a -I text -I valid -I util -I syntax -I script -I runtime -I main -I host -I exec -I binary -o text/parse.cmi text/parse.mli
ocamlc.opt -c -w +a-4-27-42-44-45 -warn-error +a -I text -I valid -I util -I syntax -I script -I runtime -I main -I host -I exec -I binary -o text/print.cmi text/print.mli
ocamlc.opt -c -w +a-4-27-42-44-45 -warn-error +a -I valid -I util -I text -I syntax -I script -I runtime -I main -I host -I exec -I binary -o valid/valid.cmi valid/valid.mli
ocamlc.opt -c -w +a-4-27-42-44-45 -warn-error +a -g -I host -I valid -I util -I text -I syntax -I script -I runtime -I main -I exec -I binary -o host/env.d.cmo host/env.ml
ocamlc.opt -c -w +a-4-27-42-44-45 -warn-error +a -g -I main -I valid -I util -I text -I syntax -I script -I runtime -I host -I exec -I binary -o main/flags.d.cmo main/flags.ml
ocamlc.opt -c -w +a-4-27-42-44-45 -warn-error +a -g -I script -I valid -I util -I text -I syntax -I runtime -I main -I host -I exec -I binary -o script/import.d.cmo script/import.ml
ocamlc.opt -c -w +a-4-27-42-44-45 -warn-error +a -g -I script -I valid -I util -I text -I syntax -I runtime -I main -I host -I exec -I binary -o script/run.d.cmo script/run.ml
ocamlc.opt -c -w +a-4-27-42-44-45 -warn-error +a -g -I host -I valid -I util -I text -I syntax -I script -I runtime -I main -I exec -I binary -o host/spectest.d.cmo host/spectest.ml
ocamlc.opt -c -w +a-4-27-42-44-45 -warn-error +a -g -I binary -I valid -I util -I text -I syntax -I script -I runtime -I main -I host -I exec -o binary/utf8.d.cmo binary/utf8.ml
ocamlc.opt -c -w +a-4-27-42-44-45 -warn-error +a -I exec -I valid -I util -I text -I syntax -I script -I runtime -I main -I host -I binary -o exec/eval_numeric.cmi exec/eval_numeric.mli
ocamlc.opt -c -w +a-4-27-42-44-45 -warn-error +a -I exec -I valid -I util -I text -I syntax -I script -I runtime -I main -I host -I binary -o exec/i64_convert.cmi exec/i64_convert.mli
ocamlc.opt -c -w +a-4-27-42-44-45 -warn-error +a -g -I exec -I valid -I util -I text -I syntax -I script -I runtime -I main -I host -I binary -o exec/eval.d.cmo exec/eval.ml
ocamlc.opt -c -w +a-4-27-42-44-45 -warn-error +a -g -I runtime -I valid -I util -I text -I syntax -I script -I main -I host -I exec -I binary -o runtime/func.d.cmo runtime/func.ml
ocamlc.opt -c -w +a-4-27-42-44-45 -warn-error +a -g -I runtime -I valid -I util -I text -I syntax -I script -I main -I host -I exec -I binary -o runtime/instance.d.cmo runtime/instance.ml
ocamlc.opt -c -w +a-4-27-42-44-45 -warn-error +a -g -I util -I valid -I text -I syntax -I script -I runtime -I main -I host -I exec -I binary -o util/source.d.cmo util/source.ml
ocamlc.opt -c -w +a-4-27-42-44-45 -warn-error +a -g -I syntax -I valid -I util -I text -I script -I runtime -I main -I host -I exec -I binary -o syntax/types.d.cmo syntax/types.ml
ocamlc.opt -c -w +a-4-27-42-44-45 -warn-error +a -g -I syntax -I valid -I util -I text -I script -I runtime -I main -I host -I exec -I binary -o syntax/values.d.cmo syntax/values.ml
ocamlc.opt -c -w +a-4-27-42-44-45 -warn-error +a -I exec -I valid -I util -I text -I syntax -I script -I runtime -I main -I host -I binary -o exec/f32_convert.cmi exec/f32_convert.mli
ocamlc.opt -c -w +a-4-27-42-44-45 -warn-error +a -I exec -I valid -I util -I text -I syntax -I script -I runtime -I main -I host -I binary -o exec/f64_convert.cmi exec/f64_convert.mli
ocamlc.opt -c -w +a-4-27-42-44-45 -warn-error +a -I exec -I valid -I util -I text -I syntax -I script -I runtime -I main -I host -I binary -o exec/i32_convert.cmi exec/i32_convert.mli
ocamlc.opt -c -w +a-4-27-42-44-45 -warn-error +a -g -I syntax -I valid -I util -I text -I script -I runtime -I main -I host -I exec -I binary -o syntax/ast.d.cmo syntax/ast.ml
ocamlc.opt -c -w +a-4-27-42-44-45 -warn-error +a -g -I util -I valid -I text -I syntax -I script -I runtime -I main -I host -I exec -I binary -o util/error.d.cmo util/error.ml
ocamlc.opt -c -w +a-4-27-42-44-45 -warn-error +a -g -I exec -I valid -I util -I text -I syntax -I script -I runtime -I main -I host -I binary -o exec/eval_numeric.d.cmo exec/eval_numeric.ml
ocamlc.opt -c -w +a-4-27-42-44-45 -warn-error +a -g -I runtime -I valid -I util -I text -I syntax -I script -I main -I host -I exec -I binary -o runtime/global.d.cmo runtime/global.ml
ocamlc.opt -c -w +a-4-27-42-44-45 -warn-error +a -g -I exec -I valid -I util -I text -I syntax -I script -I runtime -I main -I host -I binary -o exec/i32.d.cmo exec/i32.ml
ocamlc.opt -c -w +a-4-27-42-44-45 -warn-error +a -g -I exec -I valid -I util -I text -I syntax -I script -I runtime -I main -I host -I binary -o exec/i64.d.cmo exec/i64.ml
ocamlc.opt -c -w +a-4-27-42-44-45 -warn-error +a -g -I exec -I valid -I util -I text -I syntax -I script -I runtime -I main -I host -I binary -o exec/i64_convert.d.cmo exec/i64_convert.ml
ocamlc.opt -c -w +a-4-27-42-44-45 -warn-error +a -g -I util -I valid -I text -I syntax -I script -I runtime -I main -I host -I exec -I binary -o util/lib.d.cmo util/lib.ml
ocamlc.opt -c -w +a-4-27-42-44-45 -warn-error +a -g -I runtime -I valid -I util -I text -I syntax -I script -I main -I host -I exec -I binary -o runtime/mem.d.cmo runtime/mem.ml
ocamlc.opt -c -w +a-4-27-42-44-45 -warn-error +a -g -I exec -I valid -I util -I text -I syntax -I script -I runtime -I main -I host -I binary -o exec/numeric_error.d.cmo exec/numeric_error.ml
ocamlc.opt -c -w +a-4-27-42-44-45 -warn-error +a -g -I runtime -I valid -I util -I text -I syntax -I script -I main -I host -I exec -I binary -o runtime/table.d.cmo runtime/table.ml
ocamlc.opt -c -w +a-4-27-42-44-45 -warn-error +a -g -I exec -I valid -I util -I text -I syntax -I script -I runtime -I main -I host -I binary -o exec/f32.d.cmo exec/f32.ml
ocamlc.opt -c -w +a-4-27-42-44-45 -warn-error +a -g -I exec -I valid -I util -I text -I syntax -I script -I runtime -I main -I host -I binary -o exec/f64.d.cmo exec/f64.ml
ocamlc.opt -c -w +a-4-27-42-44-45 -warn-error +a -g -I exec -I valid -I util -I text -I syntax -I script -I runtime -I main -I host -I binary -o exec/float.d.cmo exec/float.ml
ocamlc.opt -c -w +a-4-27-42-44-45 -warn-error +a -g -I exec -I valid -I util -I text -I syntax -I script -I runtime -I main -I host -I binary -o exec/int.d.cmo exec/int.ml
ocamlc.opt -c -w +a-4-27-42-44-45 -warn-error +a -g -I exec -I valid -I util -I text -I syntax -I script -I runtime -I main -I host -I binary -o exec/f32_convert.d.cmo exec/f32_convert.ml
ocamlc.opt -c -w +a-4-27-42-44-45 -warn-error +a -g -I exec -I valid -I util -I text -I syntax -I script -I runtime -I main -I host -I binary -o exec/f64_convert.d.cmo exec/f64_convert.ml
ocamlc.opt -c -w +a-4-27-42-44-45 -warn-error +a -g -I exec -I valid -I util -I text -I syntax -I script -I runtime -I main -I host -I binary -o exec/i32_convert.d.cmo exec/i32_convert.ml
ocamlc.opt -c -w +a-4-27-42-44-45 -warn-error +a -I syntax -I valid -I util -I text -I script -I runtime -I main -I host -I exec -I binary -o syntax/operators.cmo syntax/operators.ml
ocamlyacc text/parser.mly
ocamlc.opt -c -w +a-4-27-42-44-45 -warn-error +a -I text -I valid -I util -I syntax -I script -I runtime -I main -I host -I exec -I binary -o text/parser.cmi text/parser.mli
ocamlc.opt -c -w +a-4-27-42-44-45 -warn-error +a -I text -I valid -I util -I syntax -I script -I runtime -I main -I host -I exec -I binary -o text/lexer.cmi text/lexer.mli
ocamlc.opt -c -w +a-4-27-42-44-45 -warn-error +a -I util -I valid -I text -I syntax -I script -I runtime -I main -I host -I exec -I binary -o util/sexpr.cmi util/sexpr.mli
ocamlc.opt -c -w +a-4-27-42-44-45 -warn-error +a -I text -I valid -I util -I syntax -I script -I runtime -I main -I host -I exec -I binary -o text/arrange.cmi text/arrange.mli
ocamlc.opt -c -w +a-4-27-42-44-45 -warn-error +a -g -I binary -I valid -I util -I text -I syntax -I script -I runtime -I main -I host -I exec -o binary/decode.d.cmo binary/decode.ml
ocamlc.opt -c -w +a-4-27-42-44-45 -warn-error +a -g -I binary -I valid -I util -I text -I syntax -I script -I runtime -I main -I host -I exec -o binary/encode.d.cmo binary/encode.ml
ocamlc.opt -c -w +a-4-27-42-44-45 -warn-error +a -g -I script -I valid -I util -I text -I syntax -I runtime -I main -I host -I exec -I binary -o script/js.d.cmo script/js.ml
ocamlc.opt -c -w +a-4-27-42-44-45 -warn-error +a -g -I text -I valid -I util -I syntax -I script -I runtime -I main -I host -I exec -I binary -o text/parse.d.cmo text/parse.ml
ocamlc.opt -c -w +a-4-27-42-44-45 -warn-error +a -g -I text -I valid -I util -I syntax -I script -I runtime -I main -I host -I exec -I binary -o text/print.d.cmo text/print.ml
ocamlc.opt -c -w +a-4-27-42-44-45 -warn-error +a -g -I script -I valid -I util -I text -I syntax -I runtime -I main -I host -I exec -I binary -o script/script.d.cmo script/script.ml
ocamlc.opt -c -w +a-4-27-42-44-45 -warn-error +a -g -I valid -I util -I text -I syntax -I script -I runtime -I main -I host -I exec -I binary -o valid/valid.d.cmo valid/valid.ml
ocamlc.opt -c -w +a-4-27-42-44-45 -warn-error +a -g -I syntax -I valid -I util -I text -I script -I runtime -I main -I host -I exec -I binary -o syntax/operators.d.cmo syntax/operators.ml
ocamllex.opt -q text/lexer.mll
ocamlc.opt -c -w +a-4-27-42-44-45 -warn-error +a -g -I text -I valid -I util -I syntax -I script -I runtime -I main -I host -I exec -I binary -o text/lexer.d.cmo text/lexer.ml
ocamlc.opt -c -w +a-4-27-42-44-45 -warn-error +a -g -I text -I valid -I util -I syntax -I script -I runtime -I main -I host -I exec -I binary -o text/parser.d.cmo text/parser.ml
ocamlc.opt -c -w +a-4-27-42-44-45 -warn-error +a -g -I text -I valid -I util -I syntax -I script -I runtime -I main -I host -I exec -I binary -o text/arrange.d.cmo text/arrange.ml
ocamlc.opt -c -w +a-4-27-42-44-45 -warn-error +a -g -I util -I valid -I text -I syntax -I script -I runtime -I main -I host -I exec -I binary -o util/sexpr.d.cmo util/sexpr.ml
ocamlc.opt bigarray.cma -g util/lib.d.cmo binary/utf8.d.cmo exec/float.d.cmo exec/f32.d.cmo exec/f64.d.cmo exec/numeric_error.d.cmo exec/int.d.cmo exec/i32.d.cmo exec/i64.d.cmo exec/i32_convert.d.cmo exec/f32_convert.d.cmo exec/i64_convert.d.cmo exec/f64_convert.d.cmo syntax/types.d.cmo syntax/values.d.cmo runtime/mem.d.cmo util/source.d.cmo syntax/ast.d.cmo exec/eval_numeric.d.cmo runtime/func.d.cmo runtime/global.d.cmo runtime/table.d.cmo runtime/instance.d.cmo util/error.d.cmo exec/eval.d.cmo host/env.d.cmo host/spectest.d.cmo main/flags.d.cmo script/import.d.cmo binary/encode.d.cmo syntax/operators.d.cmo binary/decode.d.cmo script/script.d.cmo text/parser.d.cmo text/lexer.d.cmo text/parse.d.cmo script/js.d.cmo util/sexpr.d.cmo text/arrange.d.cmo text/print.d.cmo valid/valid.d.cmo script/run.d.cmo main/main.d.cmo -o main/main.d.byte
