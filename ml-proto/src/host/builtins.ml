open Source

let print vs =
  List.iter Print.print_value (List.map (fun v -> Some v) vs);
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
  | _ ->
    Error.error i.at ("no stdio." ^ func_name ^ "\"")

let match_imports (is : Ast.import list) =
  List.map match_import is
