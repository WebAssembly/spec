open Source
open Types
open Ast

let print vs =
  List.iter Print.print_value (List.map (fun v -> Some v) vs);
  None

let match_import m i =
  let {module_name; func_name; itype} = i.it in
  let {ins; out} = List.nth m.it.types itype.it in
  if module_name <> "stdio" then
    Error.error i.at ("no builtin module \"" ^ module_name ^ "\"");
  match func_name with
  | "print" ->
    if out <> None then
      Error.error i.at "stdio.print has no result";
    print
  | _ ->
    Error.error i.at ("no \"stdio." ^ func_name ^ "\"")

let match_imports m =
  List.map (match_import m) m.it.imports
