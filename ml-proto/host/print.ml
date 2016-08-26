open Kernel
open Source
open Printf


(* Types *)

open Types

let print_no_sig prefix i =
  printf "%s %d\n" prefix i

let print_var_sig prefix i t =
  printf "%s %d : %s\n" prefix i (string_of_value_type t)

let print_elem_sig prefix i t =
  printf "%s %d : %s\n" prefix i (string_of_elem_type t)

let print_func_sig m prefix i x =
  let t = List.nth m.it.types x.it in
  printf "%s %d : %s\n" prefix i (string_of_func_type t)

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


(* Ast *)

let print_func m i f =
  print_func_sig m "func" i f.it.ftype

let print_global m i glob =
  print_var_sig "global" i glob.it.gtype

let print_table m i tab =
  print_elem_sig "table" i tab.it.etype

let print_memory m i mem =
  print_no_sig "memory" i

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


let print_value vo =
  match vo with
  | Some v ->
      let t = Values.type_of v in
      printf "%s : %s\n"
        (Values.string_of_value v) (Types.string_of_value_type t);
      flush_all ()
  | None ->
      printf "()\n";
      flush_all ()

