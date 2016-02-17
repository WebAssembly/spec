open Kernel
open Source
open Printf


(* Types *)

open Types

let func_type m f =
  List.nth m.it.types f.it.ftype.it

let string_of_table_type = function
  | None -> "()"
  | Some t -> "(" ^ string_of_func_type t ^ ")*"


let print_var_sig prefix i t =
  printf "%s %d : %s\n" prefix i (string_of_value_type t.it)

let print_func_sig m prefix i f =
  printf "%s %d : %s\n" prefix i (string_of_func_type (func_type m f))

let print_export_sig m n f =
  printf "export \"%s\" : %s\n" n (string_of_func_type (func_type m f))

let print_export_mem n =
  printf "export \"%s\" : memory\n" n

let print_table_elem i x =
  printf "table [%d] = func %d\n" i x.it

let print_start start =
  Lib.Option.app (fun x -> printf "start = func %d\n" x.it) start

(* Ast *)

let print_func m i f =
  print_func_sig m "func" i f

let print_export m i ex =
  match ex.it with
  | ExportFunc (n, x) -> print_export_sig m n (List.nth m.it.funcs x.it)
  | ExportMemory n -> print_export_mem n

let print_module m =
  let {funcs; start; exports; table} = m.it in
  List.iteri (print_func m) funcs;
  List.iteri (print_export m) exports;
  List.iteri print_table_elem table;
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

