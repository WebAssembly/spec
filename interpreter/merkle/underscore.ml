
open Ast
open Source

let do_it x f = {x with it=f x.it}

let is_func_export e = match e.edesc.it with
 | FuncExport _ -> true
 | _ -> false

let is_func_import e = match e.idesc.it with
 | FuncImport _ -> true
 | _ -> false

let add_underscore name =
  let str = "_" ^ Utf8.encode name in
  Utf8.decode str

let process_export e =
  do_it e (fun e ->
     if is_func_export e then {e with name=add_underscore e.name}
     else e)

let process_import e =
  do_it e (fun e ->
     if is_func_import e then {e with item_name=add_underscore e.item_name}
     else e)

(* add underscores to function imports and exports *)
let process m =
  do_it m (fun m -> {m with imports=List.map process_import m.imports; exports=List.map process_export m.exports})

