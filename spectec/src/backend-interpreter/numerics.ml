open Reference_interpreter
open Al
open Al.Ast
open Construct

type numerics = { name : string; f : value list -> value }

(* Helper functions *)
let i32_to_const i = CaseV ("CONST", [ singleton "I32"; al_of_int32 i ])
let i64_to_const i = CaseV ("CONST", [ singleton "I64"; al_of_int64 i ])
let f32_to_const f = CaseV ("CONST", [ singleton "F32"; al_of_float32 f ])
let f64_to_const f = CaseV ("CONST", [ singleton "F64"; al_of_float64 f ])

let wrap1
  (destruct: value -> 'a)
  (construct: 'b -> value)
  (op: 'a -> 'b)
  (v: value): value =
    destruct v |> op |> construct
let wrap2
  (destruct: value -> 'a)
  (construct: 'b -> value)
  (op: 'a -> 'a -> 'b)
  (v1: value)
  (v2: value): value =
    op (destruct v1) (destruct v2) |> construct

let wrap3
  (destruct: value -> 'a)
  (construct: 'b -> value)
  (op: 'a -> 'a -> 'a -> 'b)
  (v1: value)
  (v2: value)
  (v3: value): value =
    op (destruct v1) (destruct v2) (destruct v3) |> construct


let wrap_i32_unop = wrap1 al_to_int32 (fun i32 -> listV [| al_of_int32 i32 |])
let wrap_i64_unop = wrap1 al_to_int64 (fun i64 -> listV [| al_of_int64 i64 |])
let wrap_f32_unop = wrap1 al_to_float32 (fun f32 -> listV [| al_of_float32 f32 |])
let wrap_f64_unop = wrap1 al_to_float64 (fun f64 -> listV [| al_of_float64 f64 |])
let unop: numerics =
  {
    name = "unop";
    f =
      (function
      | [ op; CaseV (t, []); v ] -> (
        match t with
        | "I32" -> (
          match op with
          | TextV "Clz" -> wrap_i32_unop I32.clz v
          | TextV "Ctz" -> wrap_i32_unop I32.ctz v
          | TextV "Popcnt" -> wrap_i32_unop I32.popcnt v
          | TextV "Extend8S" -> wrap_i32_unop (I32.extend_s 8) v
          | TextV "Extend16S" -> wrap_i32_unop (I32.extend_s 16) v
          | TextV "Extend32S" -> wrap_i32_unop (I32.extend_s 32) v
          | TextV "Extend64S" -> wrap_i32_unop (I32.extend_s 64) v
          | _ -> failwith ("Invalid unop: " ^ (Print.string_of_value op)))
        | "I64" -> (
          match op with
          | TextV "Clz" -> wrap_i64_unop I64.clz v
          | TextV "Ctz" -> wrap_i64_unop I64.ctz v
          | TextV "Popcnt" -> wrap_i64_unop I64.popcnt v
          | TextV "Extend8S" -> wrap_i64_unop (I64.extend_s 8) v
          | TextV "Extend16S" -> wrap_i64_unop (I64.extend_s 16) v
          | TextV "Extend32S" -> wrap_i64_unop (I64.extend_s 32) v
          | TextV "Extend64S" -> wrap_i64_unop (I64.extend_s 64) v
          | _ -> failwith ("Invalid unop: " ^ (Print.string_of_value op)))
        | "F32"  -> (
          match op with
          | TextV "Neg" -> wrap_f32_unop (F32.neg) v
          | TextV "Abs" -> wrap_f32_unop (F32.abs) v
          | TextV "Ceil" -> wrap_f32_unop (F32.ceil) v
          | TextV "Floor" -> wrap_f32_unop (F32.floor) v
          | TextV "Trunc" -> wrap_f32_unop (F32.trunc) v
          | TextV "Nearest" -> wrap_f32_unop (F32.nearest) v
          | TextV "Sqrt" -> wrap_f32_unop (F32.sqrt) v
          | _ -> failwith ("Invalid unop: " ^ (Print.string_of_value op)))
        | "F64" -> (
          match op with
          | TextV "Neg" -> wrap_f64_unop (F64.neg) v
          | TextV "Abs" -> wrap_f64_unop (F64.abs) v
          | TextV "Ceil" -> wrap_f64_unop (F64.ceil) v
          | TextV "Floor" -> wrap_f64_unop (F64.floor) v
          | TextV "Trunc" -> wrap_f64_unop (F64.trunc) v
          | TextV "Nearest" -> wrap_f64_unop (F64.nearest) v
          | TextV "Sqrt" -> wrap_f64_unop (F64.sqrt) v
          | _ -> failwith ("Invalid unop: " ^ (Print.string_of_value op)))
        | _ -> failwith "Invalid type for unop")
      | _ -> failwith "Invalid unop")
  }

let wrap_i32_binop = wrap2 al_to_int32 (fun i32 -> listV [| al_of_int32 i32 |])
let wrap_i64_binop = wrap2 al_to_int64 (fun i64 -> listV [| al_of_int64 i64 |])
let wrap_f32_binop = wrap2 al_to_float32 (fun f32 -> listV [| al_of_float32 f32 |])
let wrap_f64_binop = wrap2 al_to_float64 (fun f64 -> listV [| al_of_float64 f64 |])
let catch_ixx_exception f = try f() with
  | Ixx.DivideByZero
  | Ixx.Overflow
  | Ixx.InvalidConversion -> raise Exception.Trap
let wrap_i32_binop_with_trap op i1 i2 = catch_ixx_exception (fun _ -> wrap_i32_binop op i1 i2)
let wrap_i64_binop_with_trap op i1 i2 = catch_ixx_exception (fun _ -> wrap_i64_binop op i1 i2)
let binop : numerics =
  {
    name = "binop";
    f =
      (function
      | [ op; CaseV (t, []); v1; v2 ] -> (
        match t with
        | "I32"  -> (
          match op with
          | TextV "Add"  -> wrap_i32_binop I32.add v1 v2
          | TextV "Sub"  -> wrap_i32_binop I32.sub v1 v2
          | TextV "Mul"  -> wrap_i32_binop I32.mul v1 v2
          | TextV "DivS" -> wrap_i32_binop_with_trap I32.div_s v1 v2
          | TextV "DivU" -> wrap_i32_binop_with_trap I32.div_u v1 v2
          | TextV "RemS" -> wrap_i32_binop_with_trap I32.rem_s v1 v2
          | TextV "RemU" -> wrap_i32_binop_with_trap I32.rem_u v1 v2
          | TextV "And"  -> wrap_i32_binop I32.and_ v1 v2
          | TextV "Or"   -> wrap_i32_binop I32.or_ v1 v2
          | TextV "Xor"  -> wrap_i32_binop I32.xor v1 v2
          | TextV "Shl"  -> wrap_i32_binop I32.shl v1 v2
          | TextV "ShrS" -> wrap_i32_binop I32.shr_s v1 v2
          | TextV "ShrU" -> wrap_i32_binop I32.shr_u v1 v2
          | TextV "Rotl" -> wrap_i32_binop I32.rotl v1 v2
          | TextV "Rotr" -> wrap_i32_binop I32.rotr v1 v2
          | _ -> failwith ("Invalid binop: " ^ (Print.string_of_value op)))
        | "I64" -> (
          match op with
          | TextV "Add"  -> wrap_i64_binop I64.add v1 v2
          | TextV "Sub"  -> wrap_i64_binop I64.sub v1 v2
          | TextV "Mul"  -> wrap_i64_binop I64.mul v1 v2
          | TextV "DivS" -> wrap_i64_binop_with_trap I64.div_s v1 v2
          | TextV "DivU" -> wrap_i64_binop_with_trap I64.div_u v1 v2
          | TextV "RemS" -> wrap_i64_binop_with_trap I64.rem_s v1 v2
          | TextV "RemU" -> wrap_i64_binop_with_trap I64.rem_u v1 v2
          | TextV "And"  -> wrap_i64_binop I64.and_ v1 v2
          | TextV "Or"   -> wrap_i64_binop I64.or_ v1 v2
          | TextV "Xor"  -> wrap_i64_binop I64.xor v1 v2
          | TextV "Shl"  -> wrap_i64_binop I64.shl v1 v2
          | TextV "ShrS" -> wrap_i64_binop I64.shr_s v1 v2
          | TextV "ShrU" -> wrap_i64_binop I64.shr_u v1 v2
          | TextV "Rotl" -> wrap_i64_binop I64.rotl v1 v2
          | TextV "Rotr" -> wrap_i64_binop I64.rotr v1 v2
          | _ -> failwith ("Invalid binop: " ^ (Print.string_of_value op)))
        | "F32" -> (
          match op with
          | TextV "Add" -> wrap_f32_binop F32.add v1 v2
          | TextV "Sub" -> wrap_f32_binop F32.sub v1 v2
          | TextV "Mul" -> wrap_f32_binop F32.mul v1 v2
          | TextV "Div" -> wrap_f32_binop F32.div v1 v2
          | TextV "Min" -> wrap_f32_binop F32.min v1 v2
          | TextV "Max" -> wrap_f32_binop F32.max v1 v2
          | TextV "CopySign" -> wrap_f32_binop F32.copysign v1 v2
          | _ -> failwith ("Invalid binop: " ^ (Print.string_of_value op)))
        | "F64" -> (
          match op with
          | TextV "Add" -> wrap_f64_binop F64.add v1 v2
          | TextV "Sub" -> wrap_f64_binop F64.sub v1 v2
          | TextV "Mul" -> wrap_f64_binop F64.mul v1 v2
          | TextV "Div" -> wrap_f64_binop F64.div v1 v2
          | TextV "Min" -> wrap_f64_binop F64.min v1 v2
          | TextV "Max" -> wrap_f64_binop F64.max v1 v2
          | TextV "CopySign" -> wrap_f64_binop F64.copysign v1 v2
          | _ -> failwith ("Invalid binop: " ^ (Print.string_of_value op)))
        | _ -> failwith "Invalid type for binop")
      | _ -> failwith "Invalid binop");
  }

let wrap_i32_testop = wrap1 al_to_int32 al_of_bool
let wrap_i64_testop = wrap1 al_to_int64 al_of_bool
let testop : numerics =
  {
    name = "testop";
    f =
      (function
      | [ TextV "Eqz"; CaseV (t, []); i ] -> (
          match t with
          | "I32" -> wrap_i32_testop I32.eqz i
          | "I64" -> wrap_i64_testop I64.eqz i
          | _ -> failwith "Invalid type for testop")
      | _ -> failwith "Invalid testop");
  }

let wrap_i32_relop = wrap2 al_to_int32 al_of_bool
let wrap_i64_relop = wrap2 al_to_int64 al_of_bool
let wrap_f32_relop = wrap2 al_to_float32 al_of_bool
let wrap_f64_relop = wrap2 al_to_float64 al_of_bool
let relop : numerics =
  {
    name = "relop";
    f =
      (function
      | [ op; CaseV (t, []); v1; v2 ] -> (
        match t with
        | "I32"  -> (
          match op with
          | TextV "Eq" -> wrap_i32_relop I32.eq v1 v2
          | TextV "Ne" -> wrap_i32_relop I32.ne v1 v2
          | TextV "LtS" -> wrap_i32_relop I32.lt_s v1 v2
          | TextV "LtU" -> wrap_i32_relop I32.lt_u v1 v2
          | TextV "LeS" -> wrap_i32_relop I32.le_s v1 v2
          | TextV "LeU" -> wrap_i32_relop I32.le_u v1 v2
          | TextV "GtS" -> wrap_i32_relop I32.gt_s v1 v2
          | TextV "GtU" -> wrap_i32_relop I32.gt_u v1 v2
          | TextV "GeS" -> wrap_i32_relop I32.ge_s v1 v2
          | TextV "GeU" -> wrap_i32_relop I32.ge_u v1 v2
          | _ -> failwith ("Invalid relop: " ^ (Print.string_of_value op)))
        | "I64" -> (
          match op with
          | TextV "Eq" -> wrap_i64_relop I64.eq v1 v2
          | TextV "Ne" -> wrap_i64_relop I64.ne v1 v2
          | TextV "LtS" -> wrap_i64_relop I64.lt_s v1 v2
          | TextV "LtU" -> wrap_i64_relop I64.lt_u v1 v2
          | TextV "LeS" -> wrap_i64_relop I64.le_s v1 v2
          | TextV "LeU" -> wrap_i64_relop I64.le_u v1 v2
          | TextV "GtS" -> wrap_i64_relop I64.gt_s v1 v2
          | TextV "GtU" -> wrap_i64_relop I64.gt_u v1 v2
          | TextV "GeS" -> wrap_i64_relop I64.ge_s v1 v2
          | TextV "GeU" -> wrap_i64_relop I64.ge_u v1 v2
          | _ -> failwith ("Invalid relop: " ^ (Print.string_of_value op)))
        | "F32" -> (
          match op with
          | TextV "Eq" -> wrap_f32_relop F32.eq v1 v2
          | TextV "Ne" -> wrap_f32_relop F32.ne v1 v2
          | TextV "Lt" -> wrap_f32_relop F32.lt v1 v2
          | TextV "Gt" -> wrap_f32_relop F32.gt v1 v2
          | TextV "Le" -> wrap_f32_relop F32.le v1 v2
          | TextV "Ge" -> wrap_f32_relop F32.ge v1 v2
          | _ -> failwith ("Invalid relop: " ^ (Print.string_of_value op)))
        | "F64" -> (
          match op with
          | TextV "Eq" -> wrap_f64_relop F64.eq v1 v2
          | TextV "Ne" -> wrap_f64_relop F64.ne v1 v2
          | TextV "Lt" -> wrap_f64_relop F64.lt v1 v2
          | TextV "Gt" -> wrap_f64_relop F64.gt v1 v2
          | TextV "Le" -> wrap_f64_relop F64.le v1 v2
          | TextV "Ge" -> wrap_f64_relop F64.ge v1 v2
          | _ -> failwith ("Invalid relop: " ^ (Print.string_of_value op)))
        | _ -> failwith "Invalid type for relop" )
      | _ -> failwith "Invalid relop");
  }

(* conversion from i32 *)
let wrap_i64_cvtop_i32 = wrap1 al_to_int32 al_of_int64
let wrap_f32_cvtop_i32 = wrap1 al_to_int32 al_of_float32
let wrap_f64_cvtop_i32 = wrap1 al_to_int32 al_of_float64
(* conversion from i64 *)
let wrap_i32_cvtop_i64 = wrap1 al_to_int64 al_of_int32
let wrap_f32_cvtop_i64 = wrap1 al_to_int64 al_of_float32
let wrap_f64_cvtop_i64 = wrap1 al_to_int64 al_of_float64
(* conversion from f32 *)
let wrap_i32_cvtop_f32 = wrap1 al_to_float32 al_of_int32
let wrap_i64_cvtop_f32 = wrap1 al_to_float32 al_of_int64
let wrap_f64_cvtop_f32 = wrap1 al_to_float32 al_of_float64
(* conversion from i64 *)
let wrap_i32_cvtop_f64 = wrap1 al_to_float64 al_of_int32
let wrap_i64_cvtop_f64 = wrap1 al_to_float64 al_of_int64
let wrap_f32_cvtop_f64 = wrap1 al_to_float64 al_of_float32

let cvtop : numerics =
  {
    name = "cvtop";
    f =
      (function
      | [ TextV op; CaseV (t_from, []); CaseV (t_to, []); OptV sx_opt; v ] -> (
        let sx = match sx_opt with
          | None -> ""
          | Some (CaseV (sx, [])) -> sx
          | _ -> failwith "invalid cvtop" in
        listV ([| catch_ixx_exception (fun _ -> match op, t_to, t_from, sx with
        (* Conversion to I32 *)
        | "Wrap", "I32", "I64", "" -> wrap_i32_cvtop_i64 I32_convert.wrap_i64 v
        | "Trunc", "I32", "F32", "S" -> wrap_i32_cvtop_f32 I32_convert.trunc_f32_s v
        | "Trunc", "I32", "F32", "U" -> wrap_i32_cvtop_f32 I32_convert.trunc_f32_u v
        | "Trunc", "I32", "F64", "S" -> wrap_i32_cvtop_f64 I32_convert.trunc_f64_s v
        | "Trunc", "I32", "F64", "U" -> wrap_i32_cvtop_f64 I32_convert.trunc_f64_u v
        | "TruncSat", "I32", "F32", "S" -> wrap_i32_cvtop_f32 I32_convert.trunc_sat_f32_s v
        | "TruncSat", "I32", "F32", "U" -> wrap_i32_cvtop_f32 I32_convert.trunc_sat_f32_u v
        | "TruncSat", "I32", "F64", "S" -> wrap_i32_cvtop_f64 I32_convert.trunc_sat_f64_s v
        | "TruncSat", "I32", "F64", "U" -> wrap_i32_cvtop_f64 I32_convert.trunc_sat_f64_u v
        | "Reinterpret", "I32", "F32", "" -> wrap_i32_cvtop_f32 I32_convert.reinterpret_f32 v
        (* Conversion to I64 *)
        | "Extend", "I64", "I32", "S" -> wrap_i64_cvtop_i32 I64_convert.extend_i32_s v
        | "Extend", "I64", "I32", "U" -> wrap_i64_cvtop_i32 I64_convert.extend_i32_u v
        | "Trunc", "I64", "F32", "S" -> wrap_i64_cvtop_f32 I64_convert.trunc_f32_s v
        | "Trunc", "I64", "F32", "U" -> wrap_i64_cvtop_f32 I64_convert.trunc_f32_u v
        | "Trunc", "I64", "F64", "S" -> wrap_i64_cvtop_f64 I64_convert.trunc_f64_s v
        | "Trunc", "I64", "F64", "U" -> wrap_i64_cvtop_f64 I64_convert.trunc_f64_u v
        | "TruncSat", "I64", "F32", "S" -> wrap_i64_cvtop_f32 I64_convert.trunc_sat_f32_s v
        | "TruncSat", "I64", "F32", "U" -> wrap_i64_cvtop_f32 I64_convert.trunc_sat_f32_u v
        | "TruncSat", "I64", "F64", "S" -> wrap_i64_cvtop_f64 I64_convert.trunc_sat_f64_s v
        | "TruncSat", "I64", "F64", "U" -> wrap_i64_cvtop_f64 I64_convert.trunc_sat_f64_u v
        | "Reinterpret", "I64", "F64", "" -> wrap_i64_cvtop_f64 I64_convert.reinterpret_f64 v
        (* Conversion to F32 *)
        | "Demote", "F32", "F64", "" -> wrap_f32_cvtop_f64 F32_convert.demote_f64 v
        | "Convert", "F32", "I32", "S" -> wrap_f32_cvtop_i32 F32_convert.convert_i32_s v
        | "Convert", "F32", "I32", "U" -> wrap_f32_cvtop_i32 F32_convert.convert_i32_u v
        | "Convert", "F32", "I64", "S" -> wrap_f32_cvtop_i64 F32_convert.convert_i64_s v
        | "Convert", "F32", "I64", "U" -> wrap_f32_cvtop_i64 F32_convert.convert_i64_u v
        | "Reinterpret", "F32", "I32", "" -> wrap_f32_cvtop_i32 F32_convert.reinterpret_i32 v
        (* Conversion to F64 *)
        | "Promote", "F64", "F32", "" -> wrap_f64_cvtop_f32 F64_convert.promote_f32 v
        | "Convert", "F64", "I32", "S" -> wrap_f64_cvtop_i32 F64_convert.convert_i32_s v
        | "Convert", "F64", "I32", "U" -> wrap_f64_cvtop_i32 F64_convert.convert_i32_u v
        | "Convert", "F64", "I64", "S" -> wrap_f64_cvtop_i64 F64_convert.convert_i64_s v
        | "Convert", "F64", "I64", "U" -> wrap_f64_cvtop_i64 F64_convert.convert_i64_u v
        | "Reinterpret", "F64", "I64", "" -> wrap_f64_cvtop_i64 F64_convert.reinterpret_i64 v
        | _ -> failwith ("Invalid cvtop: " ^ op ^ t_to ^ t_from ^ sx) ) |]))
      | _ -> failwith "Invalid cvtop");
  }

let ext : numerics =
  {
    name = "ext";
    f =
      (function
      | [ _; _; CaseV ("U", []); v ] -> v
      | [ NumV n1; NumV n2; CaseV ("S", []); NumV n3 ] ->
        let i1 = Int64.to_int n1 in
        let i2 = Int64.to_int n2 in
        if Int64.shift_right n3 (i1 - 1) = 0L then NumV n3 else
          let mask = Int64.sub (if i2 = 64 then 0L else Int64.shift_left 1L i2) (Int64.shift_left 1L i1) in
          NumV (Int64.logor n3 mask)
      | _ -> failwith "Invalid argument fot ext"
      );
  }

let ibytes : numerics =
  {
    name = "ibytes";
    (* TODO: Handle the case where n > 16 (i.e. for v128 ) *)
    f =
      (function
      | [ NumV n; NumV i ] ->
          let rec decompose n bits =
            if n = 0L then
              []
            else
              (Int64.logand bits 255L) :: decompose (Int64.sub n 8L) (Int64.shift_right bits 8)
            in
          assert (n >= 0L && Int64.rem n 8L = 0L);
          decompose n i |> List.map numV |> listV_of_list
      | _ -> failwith "Invalid bytes"
      );
  }
let inverse_of_ibytes : numerics =
  {
    name = "inverse_of_ibytes";
    f =
      (function
      | [ NumV n; ListV bs ] ->
          assert (n = Int64.of_int (Array.length !bs * 8));
          NumV (Array.fold_right (fun b acc ->
            match b with
            | NumV b when 0L <= b && b < 256L -> Int64.add b (Int64.shift_left acc 8)
            | _ -> failwith ("Invalid inverse_of_ibytes: " ^ Print.string_of_value b ^ " is not a valid byte.")
          ) !bs 0L)
      | _ -> failwith "Invalid argument for inverse_of_ibytes."
      );
  }

let ntbytes : numerics =
  {
    name = "ntbytes";
    f =
      (function
      | [ CaseV ("I32", []); n ] -> ibytes.f [ NumV 32L; n ]
      | [ CaseV ("I64", []); n ] -> ibytes.f [ NumV 64L; n ]
      | [ CaseV ("F32", []); f ] -> ibytes.f [ NumV 32L; f ] (* TODO *)
      | [ CaseV ("F64", []); f ] -> ibytes.f [ NumV 64L; f ] (* TODO *)
      | _ -> failwith "Invalid ntbytes"
      );
  }
let inverse_of_ntbytes : numerics =
  {
    name = "inverse_of_ntbytes";
    f =
      (function
      | [ CaseV ("I32", []); l ] -> inverse_of_ibytes.f [ NumV 32L; l ]
      | [ CaseV ("I64", []); l ] -> inverse_of_ibytes.f [ NumV 64L; l ]
      | [ CaseV ("F32", []); l ] -> inverse_of_ibytes.f [ NumV 32L; l ] (* TODO *)
      | [ CaseV ("F64", []); l ] -> inverse_of_ibytes.f [ NumV 64L; l ] (* TODO *)
      | _ -> failwith "Invalid inverse_of_ntbytes"
      );
  }

let inverse_of_ztbytes : numerics =
  {
    name = "inverse_of_ztbytes";
    f =
      (function
      | [ CaseV ("I8", []); l ] -> inverse_of_ibytes.f [ NumV 8L; l ]
      | [ CaseV ("I16", []); l ] -> inverse_of_ibytes.f [ NumV 16L; l ]
      | args -> inverse_of_ntbytes.f args
      );
  }

let bytes_ : numerics = { name = "bytes"; f = ntbytes.f }
let inverse_of_bytes_ : numerics = { name = "inverse_of_bytes"; f = inverse_of_ntbytes.f }

let wrap : numerics =
  {
    name = "wrap";
    f =
      (function
        | [ NumV _m; NumV n; NumV i ] ->
            let mask = Int64.sub (Int64.shift_left 1L (Int64.to_int n)) 1L in
            NumV (Int64.logand i mask)
      | _ -> failwith "Invalid wrap_"
      );
  }

let inverse_of_signed : numerics =
  {
    name = "inverse_of_signed";
    f =
      (function
      | [ n; i ] -> wrap.f [ NumV 64L; n; i ]
      | _ -> failwith "Invalid inverse_of_signed"
      );
  }

let lanes : numerics =
  {
    name = "lanes";
    f = 
      (function
      | [ CaseV ("SHAPE", [ CaseV ("I8", []); NumV 16L ]); VecV v ] ->
        v |> V128.of_bits |> V128.I8x16.to_lanes |> List.map al_of_int32 |> listV_of_list
      | [ CaseV ("SHAPE", [ CaseV ("I16", []); NumV 8L ]); VecV v ] ->
        v |> V128.of_bits |> V128.I16x8.to_lanes |> List.map al_of_int32 |> listV_of_list
      | [ CaseV ("SHAPE", [ CaseV ("I32", []); NumV 4L ]); VecV v ] ->
        v |> V128.of_bits |> V128.I32x4.to_lanes |> List.map al_of_int32 |> listV_of_list
      | [ CaseV ("SHAPE", [ CaseV ("I64", []); NumV 2L ]); VecV v ] ->
        v |> V128.of_bits |> V128.I64x2.to_lanes |> List.map al_of_int64 |> listV_of_list
      | [ CaseV ("SHAPE", [ CaseV ("F32", []); NumV 4L ]); VecV v ] ->
        v |> V128.of_bits |> V128.F32x4.to_lanes |> List.map al_of_float32 |> listV_of_list
      | [ CaseV ("SHAPE", [ CaseV ("F64", []); NumV 2L ]); VecV v ] ->
        v |> V128.of_bits |> V128.F64x2.to_lanes |> List.map al_of_float64 |> listV_of_list
      | _ -> failwith "Invaild lanes"
      );
  }

let ine: numerics =
  {
    name = "ine_128";
    f = 
      (function
      | [ VecV v1; VecV v2 ] -> (if v1 = v2 then 0L else 1L) |> numV
      | _ -> failwith "Invaild ine"
      );
  }


let vzero: numerics =
  {
    name = "vzero";
    f = 
      (fun _ -> VecV ("\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00"));
  }


let wrap_vunop = wrap1 al_to_vector al_of_vector

let vvunop: numerics =
  {
    name = "vvunop";
    f =
      (function
      | [ CaseV ("_VV", [ op ]); CaseV ("V128", []); v ] -> (
        match op with
        | CaseV ("NOT", []) -> wrap_vunop V128.V1x128.lognot v
        | _ -> failwith ("Invalid vvunop: " ^ (Print.string_of_value op)))
      | _ -> failwith "Invalid vvunop")
  }

let vunop: numerics =
  {
    name = "vunop";
    f =
      (function
      | [ CaseV ("_VI", [ op ]); CaseV ("SHAPE", [ CaseV (ls, []); NumV (ln) ]); v ] -> (
        match ls, ln with
        | "I8", 16L -> (
          match op with
          | CaseV ("ABS", []) -> wrap_vunop V128.I8x16.abs v
          | CaseV ("NEG", []) -> wrap_vunop V128.I8x16.neg v
          | _ -> failwith ("Invalid viunop: " ^ (Print.string_of_value op)))
        | "I16", 8L -> (
          match op with
          | CaseV ("ABS", []) -> wrap_vunop V128.I16x8.abs v
          | CaseV ("NEG", []) -> wrap_vunop V128.I16x8.neg v
          | _ -> failwith ("Invalid viunop: " ^ (Print.string_of_value op)))
        | "I32", 4L -> (
          match op with
          | CaseV ("ABS", []) -> wrap_vunop V128.I32x4.abs v
          | CaseV ("NEG", []) -> wrap_vunop V128.I32x4.neg v
          | _ -> failwith ("Invalid viunop: " ^ (Print.string_of_value op)))
        | "I64", 2L -> (
          match op with
          | CaseV ("ABS", []) -> wrap_vunop V128.I64x2.abs v
          | CaseV ("NEG", []) -> wrap_vunop V128.I64x2.neg v
          | _ -> failwith ("Invalid viunop: " ^ (Print.string_of_value op)))
        | _ -> failwith "Invalid type for viunop")
      | [ CaseV ("_VF", [ op ]); CaseV ("SHAPE", [ CaseV (ls, []); NumV (ln) ]); v ] -> (
        match ls, ln with
        | "F32", 4L -> (
          match op with
          | CaseV ("ABS", []) -> wrap_vunop V128.F32x4.abs v
          | CaseV ("NEG", []) -> wrap_vunop V128.F32x4.neg v
          | CaseV ("SQRT", []) -> wrap_vunop V128.F32x4.sqrt v
          | CaseV ("CEIL", []) -> wrap_vunop V128.F32x4.ceil v
          | CaseV ("FLOOR", []) -> wrap_vunop V128.F32x4.floor v
          | CaseV ("TRUNC", []) -> wrap_vunop V128.F32x4.trunc v
          | CaseV ("NEAREST", []) -> wrap_vunop V128.F32x4.nearest v
          | _ -> failwith ("Invalid vfunop: " ^ (Print.string_of_value op)))
        | "F64", 2L -> (
          match op with
          | CaseV ("ABS", []) -> wrap_vunop V128.F64x2.abs v
          | CaseV ("NEG", []) -> wrap_vunop V128.F64x2.neg v
          | CaseV ("SQRT", []) -> wrap_vunop V128.F64x2.sqrt v
          | CaseV ("CEIL", []) -> wrap_vunop V128.F64x2.ceil v
          | CaseV ("FLOOR", []) -> wrap_vunop V128.F64x2.floor v
          | CaseV ("TRUNC", []) -> wrap_vunop V128.F64x2.trunc v
          | CaseV ("NEAREST", []) -> wrap_vunop V128.F64x2.nearest v
          | _ -> failwith ("Invalid vfunop: " ^ (Print.string_of_value op)))
        | _ -> failwith "Invalid type for vfunop")
      | _ -> failwith "Invalid vunop")
  }
 
  
let wrap_vbinop = wrap2 al_to_vector al_of_vector

let vvbinop: numerics =
  {
    name = "vvbinop";
    f =
      (function
      | [ CaseV ("_VV", [ op ]); CaseV ("V128", []); v1; v2 ] -> (
        match op with
        | CaseV ("AND", []) -> wrap_vbinop V128.V1x128.and_ v1 v2
        | CaseV ("ANDNOT", []) -> wrap_vbinop V128.V1x128.andnot v1 v2
        | CaseV ("OR", []) -> wrap_vbinop V128.V1x128.or_ v1 v2
        | CaseV ("XOR", []) -> wrap_vbinop V128.V1x128.xor v1 v2
        | _ -> failwith ("Invalid vvbinop: " ^ (Print.string_of_value op)))
      | _ -> failwith "Invalid type for vvbinop")
  }

let vbinop: numerics =
  {
    name = "vbinop";
    f =
      (function
      | [ CaseV ("_VI", [ op ]); CaseV ("SHAPE", [ CaseV (ls, []); NumV (ln) ]); v1; v2 ] -> (
        match ls, ln with
        | "I8", 16L -> (
          match op with
          | CaseV ("ADD", []) -> wrap_vbinop V128.I8x16.add v1 v2
          | CaseV ("SUB", []) -> wrap_vbinop V128.I8x16.sub v1 v2
          | _ -> failwith ("Invalid vibinop: " ^ (Print.string_of_value op)))
        | _ -> failwith "Invalid type for vibinop")
      | [ CaseV ("_VF", [ op ]); CaseV ("SHAPE", [ CaseV (ls, []); NumV (ln) ]); v1; v2 ] -> (
        match ls, ln with
        | "F32", 4L -> (
          match op with
          | CaseV ("ADD", []) -> wrap_vbinop V128.F32x4.add v1 v2
          | _ -> failwith ("Invalid vfbinop: " ^ (Print.string_of_value op)))
        | "F64", 2L -> (
          match op with
          | CaseV ("ADD", []) -> wrap_vbinop V128.F64x2.add v1 v2
          | _ -> failwith ("Invalid vfbinop: " ^ (Print.string_of_value op)))
        | _ -> failwith "Invalid type for vfbinop")
      | _ -> failwith "Invalid vbinop")
  }

let wrap_vternop = wrap3 al_to_vector al_of_vector
let vvternop: numerics =
  {
    name = "vvternop";
    f =
      (function
      | [ CaseV ("_VV", [ op ]); CaseV ("V128", []); v1; v2; v3] -> (
        match op with
        | CaseV ("BITSELECT", []) -> wrap_vternop V128.V1x128.bitselect v1 v2 v3
        | _ -> failwith ("Invalid vvternop: " ^ (Print.string_of_value op)))
      | _ -> failwith "Invalid type for vvternop")
  }

let vcvtop: numerics =
  {
    name = "vcvtop";
    f =
      (function
      | [ CaseV ("_VI", [ op ]); CaseV ("SHAPE", [ CaseV (ls, []); NumV (ln) ]); v ] -> (
        match ls, ln with
        | "I16", 8L -> (
          match op with
          | CaseV ("EXTENDLOWS", []) -> wrap_vunop V128.I16x8_convert.extend_low_s v
          | CaseV ("EXTENDLOWU", []) -> wrap_vunop V128.I16x8_convert.extend_low_u v
          | CaseV ("EXTENDHIGHS", []) -> wrap_vunop V128.I16x8_convert.extend_high_s v
          | CaseV ("EXTENDHIGHU", []) -> wrap_vunop V128.I16x8_convert.extend_high_u v
          | CaseV ("EXTADDPAIRWISES", []) -> wrap_vunop V128.I16x8_convert.extadd_pairwise_s v
          | CaseV ("EXTADDPAIRWISEU", []) -> wrap_vunop V128.I16x8_convert.extadd_pairwise_u v
          | _ -> failwith ("Invalid vcvtop: " ^ (Print.string_of_value op)))
        | "I32", 4L -> (
          match op with
          | CaseV ("EXTENDLOWS", []) -> wrap_vunop V128.I32x4_convert.extend_low_s v
          | CaseV ("EXTENDLOWU", []) -> wrap_vunop V128.I32x4_convert.extend_low_u v
          | CaseV ("EXTENDHIGHS", []) -> wrap_vunop V128.I32x4_convert.extend_high_s v
          | CaseV ("EXTENDHIGHU", []) -> wrap_vunop V128.I32x4_convert.extend_high_u v
          | CaseV ("EXTADDPAIRWISES", []) -> wrap_vunop V128.I32x4_convert.extadd_pairwise_s v
          | CaseV ("EXTADDPAIRWISEU", []) -> wrap_vunop V128.I32x4_convert.extadd_pairwise_u v
          | CaseV ("TRUNCSATSF32X4", []) -> wrap_vunop V128.I32x4_convert.trunc_sat_f32x4_s v
          | CaseV ("TRUNCSATUF32X4", []) -> wrap_vunop V128.I32x4_convert.trunc_sat_f32x4_u v
          | CaseV ("TRUNCSATSZEROF64X2", []) -> wrap_vunop V128.I32x4_convert.trunc_sat_f64x2_s_zero v
          | CaseV ("TRUNCSATUZEROF64X2", []) -> wrap_vunop V128.I32x4_convert.trunc_sat_f64x2_u_zero v
          | _ -> failwith ("Invalid vcvtop: " ^ (Print.string_of_value op)))
        | "I64", 2L -> (
          match op with
          | CaseV ("EXTENDLOWS", []) -> wrap_vunop V128.I64x2_convert.extend_low_s v
          | CaseV ("EXTENDLOWU", []) -> wrap_vunop V128.I64x2_convert.extend_low_u v
          | CaseV ("EXTENDHIGHS", []) -> wrap_vunop V128.I64x2_convert.extend_high_s v
          | CaseV ("EXTENDHIGHU", []) -> wrap_vunop V128.I64x2_convert.extend_high_u v
          | _ -> failwith ("Invalid vcvtop: " ^ (Print.string_of_value op)))
        | _ -> failwith "Invalid type for vcvtop")
      | [ CaseV ("_VF", [ op ]); CaseV ("SHAPE", [ CaseV (ls, []); NumV (ln) ]); v ] -> (
        match ls, ln with
        | "F32", 4L -> (
          match op with
          | CaseV ("DEMOTEZEROF64X2", []) -> wrap_vunop V128.F32x4_convert.demote_f64x2_zero v
          | CaseV ("CONVERTSI32X4", []) -> wrap_vunop V128.F32x4_convert.convert_i32x4_s v
          | CaseV ("CONVERTUI32X4", []) -> wrap_vunop V128.F32x4_convert.convert_i32x4_u v
          | _ -> failwith ("Invalid vcvtop: " ^ (Print.string_of_value op)))
        | "F64", 2L -> (
          match op with
          | CaseV ("PROMOTELOWF32X4", []) -> wrap_vunop V128.F64x2_convert.promote_low_f32x4 v
          | _ -> failwith ("Invalid vcvtop: " ^ (Print.string_of_value op)))
        | _ -> failwith "Invalid type for vcvtop")
      | _ -> failwith "Invalid vcvtop")
  }

let numerics_list : numerics list = [
  unop;
  binop;
  testop;
  relop;
  cvtop;
  ext;
  ibytes;
  inverse_of_ibytes;
  ntbytes;
  inverse_of_ntbytes;
  inverse_of_ztbytes;
  inverse_of_signed;
  bytes_;
  inverse_of_bytes_;
  wrap;
  vvunop;
  vvbinop;
  vvternop;
  vunop;
  vbinop;
  vcvtop;
  lanes;
  ine;
  vzero ]

let call_numerics fname args =
  let numerics =
    List.find (fun numerics -> numerics.name = fname) numerics_list
  in
  numerics.f args

let mem name = List.exists (fun numerics -> numerics.name = name) numerics_list
