open Kernel
open Source
open Printf


(* Types *)

open Types

module ImportMap = Map.Make(String)

let module_count = ref 0

let prepare_func_names funcs exports =
  let func_names =
    Array.init (List.length funcs) (fun i -> ("$" ^ string_of_int i)) in
  let rename_function e =
    match e.it with
    | ExportFunc (name, func) ->
      Array.set func_names func.it ("\"" ^ name ^ "\"")
    | ExportMemory _ -> ()
  in
  List.iter rename_function exports;
  func_names

let print_memory_info = function
  | Some mem ->
    printf "  Memory:\n    Initial: %d\n    Maximum: %d\n"
      (Int64.to_int mem.it.initial) (Int64.to_int mem.it.max)
  | None -> ()

let print_funcs types funcs start func_names =
  let is_start i =
    match start with
    | Some s -> (s.it = i)
    | None -> false
  in
  let print_func i func =
    printf "    %s : %s %s\n"
      (Array.get func_names i)
      (string_of_func_type (Array.get types func.it.ftype.it))
      (if is_start i then "[ENTRY]" else "")
  in
  printf "  Functions:\n";
  List.iteri print_func funcs

let print_imports types imports =
  let add_import map i =
    try
      ImportMap.add i.it.module_name
        (List.append (ImportMap.find i.it.module_name map) [i.it]) map
    with
      Not_found -> ImportMap.add i.it.module_name [i.it] map
  in
  let print_import_line s =
    printf "      %s : %s\n" s.func_name
      (string_of_func_type (Array.get types s.itype.it))
  in
  let print_import module_name import_list =
    printf "    %s\n" module_name;
    List.iter print_import_line import_list
  in
  let import_Map = List.fold_left add_import ImportMap.empty imports in
  printf "  Imports:\n";
  ImportMap.iter print_import import_Map

let print_table table func_names =
  let print_import_line i t =
    printf "    [%d] : %s\n" i (Array.get func_names t.it)
  in
  printf "  Table:\n";
  List.iteri print_import_line table

let print_module m =
  let {memory; funcs; start; imports; exports; table} = m.it in
  let types = Array.of_list m.it.types in (* Because Array.get is O(1) *)
  let func_names = prepare_func_names funcs exports in
  printf "Module #%d\n" !module_count;
  print_memory_info memory;
  if (List.length funcs) <> 0 then print_funcs types funcs start func_names;
  if (List.length imports) <> 0 then print_imports types imports;
  if (List.length table) <> 0 then print_table table func_names;
  printf "\n";
  module_count := !module_count + 1

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
