(*
 * A subset of the `env` module as used by Binaryen.
 *)

open Values
open Types


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


let abort vs =
  empty vs;
  print_endline "Abort!";
  exit (-1)

let exit vs =
  exit (int (single vs))


let lookup name ty =
  match name, ty.ins, ty.out with
  | "abort", [], None -> abort
  | "exit", [Int32Type], None -> exit
  | _ -> raise Not_found
