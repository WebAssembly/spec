open Source
open Kernel
open Types

module Unknown = Error.Make ()
exception Unknown = Unknown.Error  (* indicates unknown import name *)

module Spectest =
struct
  let print vs =
    List.iter Print.print_value (List.map (fun v -> Some v) vs);
    None
end

let match_import m i =
  let {module_name; func_name; itype} = i.it in
  let {ins; out} = List.nth m.it.types itype.it in
  match module_name, func_name, ins, out with
  | "spectest", "print", _, None -> Spectest.print
  | _ ->
    Unknown.error i.at
      ("no import \"" ^ module_name ^ "." ^ func_name ^ "\" of requested type")

let match_imports m = List.map (match_import m) m.it.imports

