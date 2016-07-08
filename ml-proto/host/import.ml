open Source
open Kernel
open Values
open Types

module Unknown = Error.Make ()
exception Unknown = Unknown.Error  (* indicates unknown import name *)

module Registry = Map.Make(String)
let registry = ref Registry.empty

let register name lookup = registry := Registry.add name lookup !registry

let lookup m import =
  let {module_name; func_name; itype} = import.it in
  let ty = List.nth m.it.types itype.it in
  try Registry.find module_name !registry func_name ty with Not_found ->
    Unknown.error import.at
      ("no function \"" ^ module_name ^ "." ^ func_name ^
       "\" of requested type")

let link m = List.map (lookup m) m.it.imports
