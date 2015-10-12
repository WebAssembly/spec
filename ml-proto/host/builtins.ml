open Source
open Eval
open Memory
open Types

let print m vs =
  List.iter Print.print_value (List.map (fun v -> Some v) vs);
  None

let stdout_write at m vs =
  if List.length vs != 2 then
    Error.error at "stdio.write expects 2 arguments (offset, count)";

  let mem = Eval.memory_for_module at m in
  let offset_arg = List.nth vs 0 in
  let offset = match offset_arg with
    | Values.Int32 i ->
      Int32.to_int i
    | _ ->
      Error.error at "stdio.write offset was wrong type";
  in
  let count_arg = List.nth vs 1 in
  let count = match count_arg with
    | Values.Int32 i ->
      Int32.to_int i
    | _ ->
      Error.error at "stdio.write count was wrong type";
  in

  for i=0 to (count-1) do
    let load_result = Memory.load_extend mem (Int64.of_int (offset + i)) Mem8 ZX Int32Type in
    match load_result with
    | Values.Int32 i ->
      print_bytes (Bytes.make 1 (Char.chr (Int32.to_int i)));
    | _ ->
      Error.error at "load_extend returned wrong type";

  done;

  None

let match_import i =
  let {Ast.module_name; func_name; func_params; func_result} = i.it in
  if module_name <> "stdio" then
    Error.error i.at ("no builtin module \"" ^ module_name ^ "\"");
  match func_name with
  | "print" ->
    if func_result <> None then
      Error.error i.at "stdio.print has no result";
    print
  | "write" ->
    if func_result <> None then
      Error.error i.at "stdio.write has no result";  
    stdout_write i.at
  | _ ->
    Error.error i.at ("no stdio." ^ func_name ^ "\"")

let match_imports (is : Ast.import list) =
  List.map match_import is
