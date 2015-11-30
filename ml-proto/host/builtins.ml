open Source
open Kernel
open Types

module Unknown = Error.Make ()
exception Unknown = Unknown.Error  (* indicates unknown import name *)

let print vs =
  List.iter Print.print_value (List.map (fun v -> Some v) vs);
  None

let match_import m i =
  let {module_name; func_name; itype} = i.it in
  let {ins; out} = List.nth m.it.types itype.it in
  if module_name <> "spectest" then
    Unknown.error i.at ("no module \"" ^ module_name ^ "\"");
  match func_name with
  | "print" ->
    if out <> None then
      Unknown.error i.at "spectest.print has no result";
    print
  | _ ->
    Unknown.error i.at ("no function \"spectest." ^ func_name ^ "\"")

let match_imports m =
  List.map (match_import m) m.it.imports
