open Ast
open Source
open Printf


(* Types *)

open Types

let func_type m f =
  Lib.List.nth32 m.it.types f.it.ftype.it

let string_of_table_type = function
  | None -> "()"
  | Some t -> "(" ^ string_of_func_type t ^ ")*"


let print_var_sig prefix i t =
  printf "%s %d : %s\n" prefix i (string_of_value_type t.it)

let print_func_sig m prefix i f =
  printf "%s %d : %s\n" prefix i (string_of_func_type (func_type m f))

let print_export m i ex =
  let {name; kind} = ex.it in
  let ascription =
    match kind with
    | `Func x -> string_of_func_type (func_type m (Lib.List.nth32 m.it.funcs x.it))
    | `Memory -> "memory"
  in printf "export \"%s\" : %s\n" name ascription

let print_start start =
  Lib.Option.app (fun x -> printf "start = func %ld\n" x.it) start


(* Ast *)

let print_func m i f =
  print_func_sig m "func" i f

let print_module m =
  (* TODO: more complete print function *)
  let {funcs; start; exports; table; _} = m.it in
  List.iteri (print_func m) funcs;
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
