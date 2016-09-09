open Ast
open Source
open Printf
open Types


(* Ast *)

let print_sig prefix i string_of_type t =
  printf "%s %d : %s\n" prefix i (string_of_type t)

let print_func m i f =
  print_sig "func" i string_of_func_type (List.nth m.it.types f.it.ftype.it)

let print_table m i tab =
  print_sig "table" i string_of_table_type tab.it.ttype

let print_memory m i mem =
  print_sig "memory" i string_of_memory_type mem.it.mtype

let print_global m i glob =
  print_sig "global" i string_of_global_type glob.it.gtype

let print_export m i ex =
  let {name; ekind; item} = ex.it in
  let kind =
    match ekind.it with
    | FuncExport -> "func"
    | TableExport -> "table"
    | MemoryExport -> "memory"
    | GlobalExport -> "global"
  in printf "export \"%s\" = %s %d\n" name kind item.it

let print_start start =
  Lib.Option.app (fun x -> printf "start = func %d\n" x.it) start

let print_module m =
  (* TODO: more complete print function *)
  let {funcs; globals; tables; memories; start; exports; _} = m.it in
  List.iteri (print_func m) funcs;
  List.iteri (print_global m) globals;
  List.iteri (print_table m) tables;
  List.iteri (print_memory m) memories;
  List.iteri (print_export m) exports;
  print_start start;
  flush_all ()

let print_module_sig m =
  List.iteri (print_export m) m.it.exports;
  flush_all ()


(* Values *)

let print_result vs =
  let ts = List.map Values.type_of vs in
  printf "%s : %s\n"
    (Values.string_of_values vs) (Types.string_of_value_types ts);
  flush_all ()
