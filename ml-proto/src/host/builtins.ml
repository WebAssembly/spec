open Source

let print vs =
  List.iter Print.print_value vs;
  None

let match_import r =
  let {Ast.module_name; func_name; func_params; func_result} = r.it in
  if module_name <> "stdio" then
    Error.error r.at ("no builtin module \"" ^ module_name ^ "\"");
  match func_name with
  | "print" ->
    if func_result <> None then
      Error.error r.at "stdio.print has no result";
    print
  | _ ->
    Error.error r.at ("no stdio." ^ func_name ^ "\"")

let match_imports (rs : Ast.import list) =
  List.map match_import rs
