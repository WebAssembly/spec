open Source
open Kernel
open Values
open Types

module Unknown = Error.Make ()
exception Unknown = Unknown.Error  (* indicates unknown import name *)


let error msg = raise (Eval.Crash (Source.no_region, msg))

let type_error v t =
  error
    ("type error, expected " ^ string_of_value_type t ^
    ", got " ^ string_of_value_type (type_of v))

let empty = function
  | [] -> ()
  | vs -> error "type error, too many arguments"

let single = function
  | [] -> error "type error, missing arguments"
  | [v] -> v
  | vs -> error "type error, too many arguments"

let int = function
  | Int32 i -> Int32.to_int i
  | v -> type_error v Int32Type


module Env =
struct
  let exit vs = exit (int (single vs))

  let abort vs =
    empty vs;
    print_endline "Abort!";
    Unix.kill (Unix.getpid ()) Sys.sigabrt;
    None
end

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
  | "env", "abort", [], None -> Env.abort
  | "env", "exit", [Int32Type], None -> Env.exit
  | "spectest", "print", _, None -> Spectest.print
  | _ ->
    Unknown.error i.at
      ("no import \"" ^ module_name ^ "." ^ func_name ^ "\" of requested type")

let match_imports m = List.map (match_import m) m.it.imports

