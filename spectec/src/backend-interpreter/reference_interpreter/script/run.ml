open Script
open Source

(* Printing *)

let indent s =
  let lines = List.filter ((<>) "") (String.split_on_char '\n' s) in
  String.concat "\n" (List.map ((^) "  ") lines) ^ "\n"

let print_module x_opt m =
  Printf.printf "module%s :\n%s%!"
    (match x_opt with None -> "" | Some x -> " " ^ x.it)
    (indent (Types.string_of_module_type (Ast.module_type_of m)))

let print_values vs =
  let ts = List.map Value.type_of_value vs in
  Printf.printf "%s : %s\n%!"
    (Value.string_of_values vs) (Types.string_of_result_type ts)

let string_of_nan = function
  | CanonicalNan -> "nan:canonical"
  | ArithmeticNan -> "nan:arithmetic"

let type_of_result r =
  let open Types in
  match r with
  | NumResult (NumPat n) -> NumT (Value.type_of_num n.it)
  | NumResult (NanPat n) -> NumT (Value.type_of_num n.it)
  | VecResult (VecPat v) -> VecT (Value.type_of_vec v)
  | RefResult (RefPat r) -> RefT (Value.type_of_ref r.it)
  | RefResult (RefTypePat t) -> RefT (NoNull, t)  (* assume closed *)
  | RefResult (NullPat) -> RefT (Null, ExternHT)

let string_of_num_pat (p : num_pat) =
  match p with
  | NumPat n -> Value.string_of_num n.it
  | NanPat nanop ->
    match nanop.it with
    | Value.I32 _ | Value.I64 _ -> assert false
    | Value.F32 n | Value.F64 n -> string_of_nan n

let string_of_vec_pat (p : vec_pat) =
  match p with
  | VecPat (Value.V128 (shape, ns)) ->
    String.concat " " (List.map string_of_num_pat ns)

let string_of_ref_pat (p : ref_pat) =
  match p with
  | RefPat r -> Value.string_of_ref r.it
  | RefTypePat t -> Types.string_of_heap_type t
  | NullPat -> "null"

let string_of_result r =
  match r with
  | NumResult np -> string_of_num_pat np
  | VecResult vp -> string_of_vec_pat vp
  | RefResult rp -> string_of_ref_pat rp

let string_of_results = function
  | [r] -> string_of_result r
  | rs -> "[" ^ String.concat " " (List.map string_of_result rs) ^ "]"

let print_results rs =
  let ts = List.map type_of_result rs in
  Printf.printf "%s : %s\n%!"
    (string_of_results rs) (Types.string_of_result_type ts)
