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

let assert_nan_pat n nan =
  let open Value in
  match n, nan.it with
  | F32 z, F32 CanonicalNan -> z = F32.pos_nan || z = F32.neg_nan
  | F64 z, F64 CanonicalNan -> z = F64.pos_nan || z = F64.neg_nan
  | F32 z, F32 ArithmeticNan ->
    let pos_nan = F32.to_bits F32.pos_nan in
    Int32.logand (F32.to_bits z) pos_nan = pos_nan
  | F64 z, F64 ArithmeticNan ->
    let pos_nan = F64.to_bits F64.pos_nan in
    Int64.logand (F64.to_bits z) pos_nan = pos_nan
  | _, _ -> false

let assert_num_pat n np =
  match np with
    | NumPat n' -> n = n'.it
    | NanPat nanop -> assert_nan_pat n nanop

let assert_vec_pat v p =
  let open Value in
  match v, p with
  | V128 v, VecPat (V128 (shape, ps)) ->
    let extract = match shape with
      | V128.I8x16 () -> fun v i -> I32 (V128.I8x16.extract_lane_s i v)
      | V128.I16x8 () -> fun v i -> I32 (V128.I16x8.extract_lane_s i v)
      | V128.I32x4 () -> fun v i -> I32 (V128.I32x4.extract_lane_s i v)
      | V128.I64x2 () -> fun v i -> I64 (V128.I64x2.extract_lane_s i v)
      | V128.F32x4 () -> fun v i -> F32 (V128.F32x4.extract_lane i v)
      | V128.F64x2 () -> fun v i -> F64 (V128.F64x2.extract_lane i v)
    in
    List.for_all2 assert_num_pat
      (List.init (V128.num_lanes shape) (extract v)) ps

let assert_ref_pat r p =
  match p, r with
  | RefPat r', r -> Value.eq_ref r r'.it
  | RefTypePat Types.AnyHT, Instance.FuncRef _ -> false
  | RefTypePat Types.AnyHT, _
  | RefTypePat Types.EqHT, (I31.I31Ref _ | Aggr.StructRef _ | Aggr.ArrayRef _)
  | RefTypePat Types.I31HT, I31.I31Ref _
  | RefTypePat Types.StructHT, Aggr.StructRef _
  | RefTypePat Types.ArrayHT, Aggr.ArrayRef _ -> true
  | RefTypePat Types.FuncHT, Instance.FuncRef _
  | RefTypePat Types.ExternHT, _ -> true
  | NullPat, Value.NullRef _ -> true
  | _ -> false

let assert_pat v r =
  let open Value in
  match v, r with
  | Num n, NumResult np -> assert_num_pat n np
  | Vec v, VecResult vp -> assert_vec_pat v vp
  | Ref r, RefResult rp -> assert_ref_pat r rp
  | _, _ -> false

module Assert = Error.Make ()

let assert_result at got expect =
  if
    List.length got <> List.length expect ||
    List.exists2 (fun v r -> not (assert_pat v r)) got expect
  then begin
    print_string "Result: "; print_values got;
    print_string "Expect: "; print_results expect;
    Assert.error at "wrong return values"
  end

let assert_message at name msg re =
  if
    String.length msg < String.length re ||
    String.sub msg 0 (String.length re) <> re
  then begin
    print_endline ("Result: \"" ^ msg ^ "\"");
    print_endline ("Expect: \"" ^ re ^ "\"");
    Assert.error at ("wrong " ^ name ^ " error")
  end
