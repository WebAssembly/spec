open Source
open Eval
open Memory
open Types

let print m vs =
  List.iter Print.print_value (List.map (fun v -> Some v) vs);
  None

let rec stdout_write_inner at mem offset count i =
  let load_result = Memory.load_extend mem (Int64.add offset i) Mem8 ZX Int32Type in

  begin
    match load_result with
    | Values.Int32 byte ->
      print_char (Char.chr (Int32.to_int byte))
    | _ ->
      ignore (Error.error at "load_extend returned wrong type")
  end;

  let next = Int64.succ i in
  let should_iterate = (Int64.compare next count) < 0 in

  if should_iterate then
    ignore (stdout_write_inner at mem offset count next)
  else
    ();

and stdout_write at m vs =
  if List.length vs != 2 then
    Error.error at "stdio.write expects 2 arguments (offset, count)";

  let mem = Eval.memory_for_module at m in
  match vs with
  | [Values.Int32 _offset; Values.Int32 _count] ->
    let offset = (Int64.of_int32 _offset) in
    let count  = (Int64.of_int32 _count) in

    set_binary_mode_out stdout false;
    ignore (stdout_write_inner at mem offset count Int64.zero);
    set_binary_mode_out stdout true;
    None

  | _ -> 
    ignore (Error.error at "stdio.write expected i32 offset, i32 count");
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
