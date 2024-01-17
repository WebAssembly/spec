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

let i8_to_i32 i8 =
  (* NOTE: This operation extends the sign of i8 to i32 *)
  I32.shr_s (I32.shl i8 24l) 24l
let i16_to_i32 i16 =
  (* NOTE: This operation extends the sign of i8 to i32 *)
  I32.shr_s (I32.shl i16 16l) 16l

let i32_to_i8 i32 = Int32.logand 0xffl i32
let i32_to_i16 i32 = Int32.logand 0xffffl i32

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

let ext128 : numerics =
  {
    name = "ext128";
    f =
      (function
      | [ _; NumV v ] -> VecV (V128.I64x2.of_lanes [ v; 0L ] |> V128.to_bits)
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

let vtbytes : numerics =
  {
    name = "vtbytes";
    f =
      (function
      | [ CaseV ("V128", []); VecV v ] ->
        let v1 = (ibytes.f [ NumV 64L; NumV (Bytes.get_int64_le (Bytes.of_string v) 0) ]) in
        let v2 = (ibytes.f [ NumV 64L; NumV (Bytes.get_int64_le (Bytes.of_string v) 8) ]) in
        (match v1, v2 with
        | ListV l1, ListV l2 -> Array.concat [ !l1; !l2] |> listV
        | _ -> failwith "Invalid vtbytes")
      | _ -> failwith "Invalid vtbytes"
      );
  }
let inverse_of_vtbytes : numerics =
  {
    name = "inverse_of_vtbytes";
    f =
      (function
      | [ CaseV ("V128", []); ListV l ] ->
        let v1 = inverse_of_ibytes.f [ NumV 64L; Array.sub !l 0 8 |> listV ] in
        let v2 = inverse_of_ibytes.f [ NumV 64L; Array.sub !l 8 8 |> listV ] in

        (match v1, v2 with
        | NumV n1, NumV n2 -> al_of_vector (V128.I64x2.of_lanes [ n1; n2 ])
        | _ -> failwith "Invalid inverse_of_vtbytes")

      | _ -> failwith "Invalid inverse_of_vtbytes"
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


let ine: numerics =
  {
    name = "ine_128";
    f = 
      (function
      | [ VecV v1; VecV v2 ] -> (if v1 = v2 then 0L else 1L) |> numV
      | _ -> failwith "Invaild ine"
      );
  }

let inverse_of_ibits : numerics =
  {
    name = "inverse_of_ibits";
    f = 
      (function
      | [ NumV _; ListV l ] -> 
        let na = Array.map (function | NumV e -> e | _ -> failwith "Invaild inverse_of_ibits") !l in
        NumV (Array.fold_right (fun e acc -> Int64.logor e (Int64.shift_left acc 1)) na 0L)
      | _ -> failwith "Invaild inverse_of_ibits"
      );
  }


let ilt_s: numerics =
  {
    name = "ilt_s";
    f =
      (function
      | [ NumV t; NumV n1; NumV n2 ] ->
        (match t with
        | 8L -> I8.lt_s (n1 |> Int64.to_int32 |> i8_to_i32) (n2 |> Int64.to_int32 |> i8_to_i32) |> al_of_bool
        | 16L -> I16.lt_s (n1 |> Int64.to_int32 |> i16_to_i32) (n2 |> Int64.to_int32 |> i16_to_i32) |> al_of_bool
        | 32L -> I32.lt_s (n1 |> Int64.to_int32) (n2 |> Int64.to_int32) |> al_of_bool
        | 64L -> I64.lt_s n1 n2 |> al_of_bool
        | _ -> failwith "Invaild ilt_s"
        )
      | _ -> failwith "Invaild ilt_s"
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
          | CaseV ("POPCNT", []) -> wrap_vunop V128.I8x16.popcnt v
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
 
  
let wrap_vvbinop = wrap2 al_to_vector al_of_vector

let wrap_vbinop op v1 v2 =
  let v1 = al_to_vector v1 in
  let v2 = al_to_vector v2 in
  [ op v1 v2 |> al_of_vector ] |> listV_of_list

let vvbinop: numerics =
  {
    name = "vvbinop";
    f =
      (function
      | [ CaseV ("_VV", [ op ]); CaseV ("V128", []); v1; v2 ] -> (
        match op with
        | CaseV ("AND", []) -> wrap_vvbinop V128.V1x128.and_ v1 v2
        | CaseV ("ANDNOT", []) -> wrap_vvbinop V128.V1x128.andnot v1 v2
        | CaseV ("OR", []) -> wrap_vvbinop V128.V1x128.or_ v1 v2
        | CaseV ("XOR", []) -> wrap_vvbinop V128.V1x128.xor v1 v2
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
          | CaseV ("ADDSATS", []) -> wrap_vbinop V128.I8x16.add_sat_s v1 v2
          | CaseV ("ADDSATU", []) -> wrap_vbinop V128.I8x16.add_sat_u v1 v2
          | CaseV ("SUBSATS", []) -> wrap_vbinop V128.I8x16.sub_sat_s v1 v2
          | CaseV ("SUBSATU", []) -> wrap_vbinop V128.I8x16.sub_sat_u v1 v2
          | CaseV ("MINS", []) -> wrap_vbinop V128.I8x16.min_s v1 v2
          | CaseV ("MINU", []) -> wrap_vbinop V128.I8x16.min_u v1 v2
          | CaseV ("MAXS", []) -> wrap_vbinop V128.I8x16.max_s v1 v2
          | CaseV ("MAXU", []) -> wrap_vbinop V128.I8x16.max_u v1 v2
          | CaseV ("AVGRU", []) -> wrap_vbinop V128.I8x16.avgr_u v1 v2
          | _ -> failwith ("Invalid vibinop: " ^ (Print.string_of_value op)))
        | "I16", 8L -> (
          match op with
          | CaseV ("ADD", []) -> wrap_vbinop V128.I16x8.add v1 v2
          | CaseV ("SUB", []) -> wrap_vbinop V128.I16x8.sub v1 v2
          | CaseV ("ADDSATS", []) -> wrap_vbinop V128.I16x8.add_sat_s v1 v2
          | CaseV ("ADDSATU", []) -> wrap_vbinop V128.I16x8.add_sat_u v1 v2
          | CaseV ("SUBSATS", []) -> wrap_vbinop V128.I16x8.sub_sat_s v1 v2
          | CaseV ("SUBSATU", []) -> wrap_vbinop V128.I16x8.sub_sat_u v1 v2
          | CaseV ("MINS", []) -> wrap_vbinop V128.I16x8.min_s v1 v2
          | CaseV ("MINU", []) -> wrap_vbinop V128.I16x8.min_u v1 v2
          | CaseV ("MAXS", []) -> wrap_vbinop V128.I16x8.max_s v1 v2
          | CaseV ("MAXU", []) -> wrap_vbinop V128.I16x8.max_u v1 v2
          | CaseV ("MUL", []) -> wrap_vbinop V128.I16x8.mul v1 v2
          | CaseV ("AVGRU", []) -> wrap_vbinop V128.I16x8.avgr_u v1 v2
          | CaseV ("Q15MULRSATS", []) -> wrap_vbinop V128.I16x8.q15mulr_sat_s v1 v2
          | _ -> failwith ("Invalid vibinop: " ^ (Print.string_of_value op)))
        | "I32", 4L -> (
          match op with
          | CaseV ("ADD", []) -> wrap_vbinop V128.I32x4.add v1 v2
          | CaseV ("SUB", []) -> wrap_vbinop V128.I32x4.sub v1 v2
          | CaseV ("ADDSATS", []) -> wrap_vbinop V128.I32x4.add_sat_s v1 v2
          | CaseV ("ADDSATU", []) -> wrap_vbinop V128.I32x4.add_sat_u v1 v2
          | CaseV ("SUBSATS", []) -> wrap_vbinop V128.I32x4.sub_sat_s v1 v2
          | CaseV ("SUBSATU", []) -> wrap_vbinop V128.I32x4.sub_sat_u v1 v2
          | CaseV ("MINS", []) -> wrap_vbinop V128.I32x4.min_s v1 v2
          | CaseV ("MINU", []) -> wrap_vbinop V128.I32x4.min_u v1 v2
          | CaseV ("MAXS", []) -> wrap_vbinop V128.I32x4.max_s v1 v2
          | CaseV ("MAXU", []) -> wrap_vbinop V128.I32x4.max_u v1 v2
          | CaseV ("MUL", []) -> wrap_vbinop V128.I32x4.mul v1 v2
          | _ -> failwith ("Invalid vibinop: " ^ (Print.string_of_value op)))
        | "I64", 2L -> (
          match op with
          | CaseV ("ADD", []) -> wrap_vbinop V128.I64x2.add v1 v2
          | CaseV ("SUB", []) -> wrap_vbinop V128.I64x2.sub v1 v2
          | CaseV ("ADDSATS", []) -> wrap_vbinop V128.I64x2.add_sat_s v1 v2
          | CaseV ("ADDSATU", []) -> wrap_vbinop V128.I64x2.add_sat_u v1 v2
          | CaseV ("SUBSATS", []) -> wrap_vbinop V128.I64x2.sub_sat_s v1 v2
          | CaseV ("SUBSATU", []) -> wrap_vbinop V128.I64x2.sub_sat_u v1 v2
          | CaseV ("MINS", []) -> wrap_vbinop V128.I64x2.min_s v1 v2
          | CaseV ("MINU", []) -> wrap_vbinop V128.I64x2.min_u v1 v2
          | CaseV ("MAXS", []) -> wrap_vbinop V128.I64x2.max_s v1 v2
          | CaseV ("MAXU", []) -> wrap_vbinop V128.I64x2.max_u v1 v2
          | CaseV ("MUL", []) -> wrap_vbinop V128.I64x2.mul v1 v2
          | _ -> failwith ("Invalid vibinop: " ^ (Print.string_of_value op)))
        | _ -> failwith "Invalid type for vibinop")
      | [ CaseV ("_VF", [ op ]); CaseV ("SHAPE", [ CaseV (ls, []); NumV (ln) ]); v1; v2 ] -> (
        match ls, ln with
        | "F32", 4L -> (
          match op with
          | CaseV ("ADD", []) -> wrap_vbinop V128.F32x4.add v1 v2
          | CaseV ("SUB", []) -> wrap_vbinop V128.F32x4.sub v1 v2
          | CaseV ("MUL", []) -> wrap_vbinop V128.F32x4.mul v1 v2
          | CaseV ("DIV", []) -> wrap_vbinop V128.F32x4.div v1 v2
          | CaseV ("MIN", []) -> wrap_vbinop V128.F32x4.min v1 v2
          | CaseV ("MAX", []) -> wrap_vbinop V128.F32x4.max v1 v2
          | CaseV ("PMIN", []) -> wrap_vbinop V128.F32x4.pmin v1 v2
          | CaseV ("PMAX", []) -> wrap_vbinop V128.F32x4.pmax v1 v2
          | _ -> failwith ("Invalid vfbinop: " ^ (Print.string_of_value op)))
        | "F64", 2L -> (
          match op with
          | CaseV ("ADD", []) -> wrap_vbinop V128.F64x2.add v1 v2
          | CaseV ("SUB", []) -> wrap_vbinop V128.F64x2.sub v1 v2
          | CaseV ("MUL", []) -> wrap_vbinop V128.F64x2.mul v1 v2
          | CaseV ("DIV", []) -> wrap_vbinop V128.F64x2.div v1 v2
          | CaseV ("MIN", []) -> wrap_vbinop V128.F64x2.min v1 v2
          | CaseV ("MAX", []) -> wrap_vbinop V128.F64x2.max v1 v2
          | CaseV ("PMIN", []) -> wrap_vbinop V128.F64x2.pmin v1 v2
          | CaseV ("PMAX", []) -> wrap_vbinop V128.F64x2.pmax v1 v2
          | _ -> failwith ("Invalid vfbinop: " ^ (Print.string_of_value op)))
        | _ -> failwith "Invalid type for vfbinop")
      | _ -> failwith "Invalid vbinop")
  }

let wrap_vrelop op v1 v2 =
  op v1 v2 |> al_of_bool

let vrelop: numerics =
  {
    name = "vrelop";
    f =
      (function
      | [ CaseV ("_VI", [ op ]); CaseV ("SHAPE", [ CaseV (ls, []); NumV (ln) ]); NumV v1; NumV v2 ] -> (
        match ls, ln with
        | "I8", 16L -> (
          match op with
          | CaseV ("EQ", []) -> wrap_vrelop I8.eq (v1 |> Int64.to_int32 |> i8_to_i32) (v2 |> Int64.to_int32 |> i8_to_i32)
          | CaseV ("NE", []) -> wrap_vrelop I8.ne (v1 |> Int64.to_int32 |> i8_to_i32) (v2 |> Int64.to_int32 |> i8_to_i32)
          | CaseV ("LTS", []) -> wrap_vrelop I8.lt_s (v1 |> Int64.to_int32 |> i8_to_i32) (v2 |> Int64.to_int32 |> i8_to_i32)
          | CaseV ("LTU", []) -> wrap_vrelop I8.lt_u (v1 |> Int64.to_int32 |> i8_to_i32) (v2 |> Int64.to_int32 |> i8_to_i32)
          | CaseV ("GTS", []) -> wrap_vrelop I8.gt_s (v1 |> Int64.to_int32 |> i8_to_i32) (v2 |> Int64.to_int32 |> i8_to_i32)
          | CaseV ("GTU", []) -> wrap_vrelop I8.gt_u (v1 |> Int64.to_int32 |> i8_to_i32) (v2 |> Int64.to_int32 |> i8_to_i32)
          | CaseV ("LES", []) -> wrap_vrelop I8.le_s (v1 |> Int64.to_int32 |> i8_to_i32) (v2 |> Int64.to_int32 |> i8_to_i32)
          | CaseV ("LEU", []) -> wrap_vrelop I8.le_u (v1 |> Int64.to_int32 |> i8_to_i32) (v2 |> Int64.to_int32 |> i8_to_i32)
          | CaseV ("GES", []) -> wrap_vrelop I8.ge_s (v1 |> Int64.to_int32 |> i8_to_i32) (v2 |> Int64.to_int32 |> i8_to_i32)
          | CaseV ("GEU", []) -> wrap_vrelop I8.ge_u (v1 |> Int64.to_int32 |> i8_to_i32) (v2 |> Int64.to_int32 |> i8_to_i32)
          | _ -> failwith ("Invalid virelop: " ^ (Print.string_of_value op)))
        | "I16", 8L -> (
          match op with
          | CaseV ("EQ", []) -> wrap_vrelop I16.eq (v1 |> Int64.to_int32 |> i16_to_i32) (v2 |> Int64.to_int32 |> i16_to_i32)
          | CaseV ("NE", []) -> wrap_vrelop I16.ne (v1 |> Int64.to_int32 |> i16_to_i32) (v2 |> Int64.to_int32 |> i16_to_i32)
          | CaseV ("LTS", []) -> wrap_vrelop I16.lt_s  (v1 |> Int64.to_int32 |> i16_to_i32) (v2 |> Int64.to_int32 |> i16_to_i32)
          | CaseV ("LTU", []) -> wrap_vrelop I16.lt_u  (v1 |> Int64.to_int32 |> i16_to_i32) (v2 |> Int64.to_int32 |> i16_to_i32)
          | CaseV ("GTS", []) -> wrap_vrelop I16.gt_s  (v1 |> Int64.to_int32 |> i16_to_i32) (v2 |> Int64.to_int32 |> i16_to_i32)
          | CaseV ("GTU", []) -> wrap_vrelop I16.gt_u  (v1 |> Int64.to_int32 |> i16_to_i32) (v2 |> Int64.to_int32 |> i16_to_i32)
          | CaseV ("LES", []) -> wrap_vrelop I16.le_s  (v1 |> Int64.to_int32 |> i16_to_i32) (v2 |> Int64.to_int32 |> i16_to_i32)
          | CaseV ("LEU", []) -> wrap_vrelop I16.le_u  (v1 |> Int64.to_int32 |> i16_to_i32) (v2 |> Int64.to_int32 |> i16_to_i32)
          | CaseV ("GES", []) -> wrap_vrelop I16.ge_s  (v1 |> Int64.to_int32 |> i16_to_i32) (v2 |> Int64.to_int32 |> i16_to_i32)
          | CaseV ("GEU", []) -> wrap_vrelop I16.ge_u  (v1 |> Int64.to_int32 |> i16_to_i32) (v2 |> Int64.to_int32 |> i16_to_i32)
          | _ -> failwith ("Invalid virelop: " ^ (Print.string_of_value op)))
        | "I32", 4L -> (
          match op with
          | CaseV ("EQ", []) -> wrap_vrelop I32.eq (v1 |> Int64.to_int32) (v2 |> Int64.to_int32)
          | CaseV ("NE", []) -> wrap_vrelop I32.ne (v1 |> Int64.to_int32) (v2 |> Int64.to_int32)
          | CaseV ("LTS", []) -> wrap_vrelop I32.lt_s (v1 |> Int64.to_int32) (v2 |> Int64.to_int32)
          | CaseV ("LTU", []) -> wrap_vrelop I32.lt_u (v1 |> Int64.to_int32) (v2 |> Int64.to_int32)
          | CaseV ("GTS", []) -> wrap_vrelop I32.gt_s (v1 |> Int64.to_int32) (v2 |> Int64.to_int32)
          | CaseV ("GTU", []) -> wrap_vrelop I32.gt_u (v1 |> Int64.to_int32) (v2 |> Int64.to_int32)
          | CaseV ("LES", []) -> wrap_vrelop I32.le_s (v1 |> Int64.to_int32) (v2 |> Int64.to_int32)
          | CaseV ("LEU", []) -> wrap_vrelop I32.le_u (v1 |> Int64.to_int32) (v2 |> Int64.to_int32)
          | CaseV ("GES", []) -> wrap_vrelop I32.ge_s (v1 |> Int64.to_int32) (v2 |> Int64.to_int32)
          | CaseV ("GEU", []) -> wrap_vrelop I32.ge_u (v1 |> Int64.to_int32) (v2 |> Int64.to_int32)
          | _ -> failwith ("Invalid virelop: " ^ (Print.string_of_value op)))
        | "I64", 2L -> (
          match op with
          | CaseV ("EQ", []) -> wrap_vrelop I64.eq v1 v2
          | CaseV ("NE", []) -> wrap_vrelop I64.ne v1 v2
          | CaseV ("LTS", []) -> wrap_vrelop I64.lt_s v1 v2
          | CaseV ("LTU", []) -> wrap_vrelop I64.lt_u v1 v2
          | CaseV ("GTS", []) -> wrap_vrelop I64.gt_s v1 v2
          | CaseV ("GTU", []) -> wrap_vrelop I64.gt_u v1 v2
          | CaseV ("LES", []) -> wrap_vrelop I64.le_s v1 v2
          | CaseV ("LEU", []) -> wrap_vrelop I64.le_u v1 v2
          | CaseV ("GES", []) -> wrap_vrelop I64.ge_s v1 v2
          | CaseV ("GEU", []) -> wrap_vrelop I64.ge_u v1 v2
          | _ -> failwith ("Invalid virelop: " ^ (Print.string_of_value op)))
        | _ -> failwith "Invalid type for virelop")
      | [ CaseV ("_VF", [ op ]); CaseV ("SHAPE", [ CaseV (ls, []); NumV (ln) ]); v1; v2 ] -> (
        match ls, ln with
        | "F32", 4L -> (
          match op with
          | CaseV ("EQ", []) -> wrap_vrelop F32.eq (al_to_float32 v1) (al_to_float32 v2)
          | CaseV ("NE", []) -> wrap_vrelop F32.ne (al_to_float32 v1) (al_to_float32 v2)
          | CaseV ("LT", []) -> wrap_vrelop F32.lt (al_to_float32 v1) (al_to_float32 v2)
          | CaseV ("GT", []) -> wrap_vrelop F32.gt (al_to_float32 v1) (al_to_float32 v2)
          | CaseV ("LE", []) -> wrap_vrelop F32.le (al_to_float32 v1) (al_to_float32 v2)
          | CaseV ("GE", []) -> wrap_vrelop F32.ge (al_to_float32 v1) (al_to_float32 v2)
          | _ -> failwith ("Invalid vfrelop: " ^ (Print.string_of_value op)))
        | "F64", 2L -> (
          match op with
          | CaseV ("EQ", []) -> wrap_vrelop F64.eq (al_to_float64 v1) (al_to_float64 v2)
          | CaseV ("NE", []) -> wrap_vrelop F64.ne (al_to_float64 v1) (al_to_float64 v2)
          | CaseV ("LT", []) -> wrap_vrelop F64.lt (al_to_float64 v1) (al_to_float64 v2)
          | CaseV ("GT", []) -> wrap_vrelop F64.gt (al_to_float64 v1) (al_to_float64 v2)
          | CaseV ("LE", []) -> wrap_vrelop F64.le (al_to_float64 v1) (al_to_float64 v2)
          | CaseV ("GE", []) -> wrap_vrelop F64.ge (al_to_float64 v1) (al_to_float64 v2)
          | _ -> failwith ("Invalid vfrelop: " ^ (Print.string_of_value op)))
        | _ -> failwith "Invalid type for vfrelop")
      | _ -> failwith "Invalid vrelop")
  }

let wrap_vternop op v1 v2 v3 =
  let v1 = al_to_vector v1 in
  let v2 = al_to_vector v2 in
  let v3 = al_to_vector v3 in
  op v1 v2 v3 |> al_of_vector
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


let narrow : numerics =
  {
    name = "narrow";
    f =
      (function
      | [ NumV _; NumV n; CaseV ("S", []); NumV i ] -> (
        match n with
        | 8L -> NumV (i |> Int64.to_int32 |> i16_to_i32 |> I8.saturate_s |> i32_to_i8 |> Int64.of_int32)
        | 16L -> NumV (i |> Int64.to_int32 |> I16.saturate_s |> i32_to_i16 |> Int64.of_int32)
        | _ -> failwith "Invalid narrow"
        )
      | [ NumV _; NumV n; CaseV ("U", []); NumV i ] -> (
        match n with
        | 8L -> NumV (i |> Int64.to_int32 |> i16_to_i32 |> I8.saturate_u |> Int64.of_int32)
        | 16L -> NumV (i |> Int64.to_int32 |> I16.saturate_u |> i32_to_i16 |> Int64.of_int32)
        | _ -> failwith "Invalid narrow"
        )
      | _ -> failwith "Invalid narrow");
  }

let lanes : numerics =
  {
    name = "lanes";
    f = 
      (function
      | [ CaseV ("SHAPE", [ CaseV ("I8", []); NumV 16L ]); VecV v ] ->
        v |> V128.of_bits |> V128.I8x16.to_lanes |> List.map al_of_int8 |> listV_of_list
      | [ CaseV ("SHAPE", [ CaseV ("I16", []); NumV 8L ]); VecV v ] ->
        v |> V128.of_bits |> V128.I16x8.to_lanes |> List.map al_of_int16 |> listV_of_list
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
let inverse_of_lanes : numerics =
  {
    name = "inverse_of_lanes";
    f = 
      (function
      | [ CaseV("SHAPE", [ CaseV ("I8", []); NumV 16L ]); ListV lanes; ] -> VecV (List.map al_to_int32 (!lanes |> Array.to_list) |> List.map i8_to_i32 |> V128.I8x16.of_lanes |> V128.to_bits)
      | [ CaseV("SHAPE", [ CaseV ("I16", []); NumV 8L ]); ListV lanes; ] -> VecV (List.map al_to_int32 (!lanes |> Array.to_list) |> List.map i16_to_i32 |> V128.I16x8.of_lanes |> V128.to_bits)
      | [ CaseV("SHAPE", [ CaseV ("I32", []); NumV 4L ]); ListV lanes; ] -> VecV (List.map al_to_int32 (!lanes |> Array.to_list) |> V128.I32x4.of_lanes |> V128.to_bits)
      | [ CaseV("SHAPE", [ CaseV ("I64", []); NumV 2L ]); ListV lanes; ] -> VecV (List.map al_to_int64 (!lanes |> Array.to_list) |> V128.I64x2.of_lanes |> V128.to_bits)
      | [ CaseV("SHAPE", [ CaseV ("F32", []); NumV 4L ]); ListV lanes; ] -> VecV (List.map al_to_float32 (!lanes |> Array.to_list) |> V128.F32x4.of_lanes |> V128.to_bits)
      | [ CaseV("SHAPE", [ CaseV ("F64", []); NumV 2L ]); ListV lanes; ] -> VecV (List.map al_to_float64 (!lanes |> Array.to_list) |> V128.F64x2.of_lanes |> V128.to_bits)
      | _ -> failwith "Invaild inverse_of_lanes"
      );
  }

let rec inverse_of_concat_bytes_helper = function
  | a :: b :: l -> 
    [listV_of_list [a; b]] @ inverse_of_concat_bytes_helper l
  | [] -> []
  | _ -> failwith "Invaild inverse_of_concat_bytes_helper"

let inverse_of_concat_bytes : numerics =
  {
    name = "inverse_of_concat_bytes";
    f = 
      (function
      | [ ListV l ] -> listV_of_list (inverse_of_concat_bytes_helper (Array.to_list !l))
      | _ -> failwith "Invalid inverse_of_concat_bytes"
      );
  }

let iadd : numerics =
  {
    name = "iadd";
    f = 
      (function
      | [ NumV 8L; NumV m; NumV n ] -> al_of_int32 (I8.add (Int64.to_int32 m) (Int64.to_int32 n))
      | [ NumV 16L; NumV m; NumV n ] -> al_of_int32 (I16.add (Int64.to_int32 m) (Int64.to_int32 n))
      | [ NumV 32L; NumV m; NumV n ] -> al_of_int32 (I32.add (Int64.to_int32 m) (Int64.to_int32 n))
      | [ NumV 64L; NumV m; NumV n ] -> al_of_int64 (I64.add m n)
      | v -> fail_list "Invalid iadd" v
      );
  }

let imul : numerics =
  {
    name = "imul";
    f = 
      (function
      | [ NumV 8L; NumV m; NumV n ] -> al_of_int32 (I8.mul (Int64.to_int32 m) (Int64.to_int32 n))
      | [ NumV 16L; NumV m; NumV n ] -> al_of_int32 (I16.mul (Int64.to_int32 m) (Int64.to_int32 n))
      | [ NumV 32L; NumV m; NumV n ] -> al_of_int32 (I32.mul (Int64.to_int32 m) (Int64.to_int32 n))
      | [ NumV 64L; NumV m; NumV n ] -> al_of_int64 (I64.mul m n)
      | v -> fail_list "Invalid iadd" v
      );
  }

let wrap_i32_cvtop_i32 = wrap1 al_to_int32 al_of_int32
let wrap_i64_cvtop_i64 = wrap1 al_to_int64 al_of_int64

let vcvtop: numerics =
  {
    name = "vcvtop";
    f = 
      (function
      | [ CaseV (op, []); NumV m; NumV n; OptV sx_opt; v] -> (
        let sx = match sx_opt with
          | None -> ""
          | Some (CaseV (sx, [])) -> sx
          | _ -> failwith "invalid cvtop" in
        match m, n, op, sx with
        (* Conversion to I16 *)
        | 8L, 16L, "EXTEND", "S" -> wrap_i32_cvtop_i32 (fun e -> Int32.logand 0xffffffffl (e |> i8_to_i32)) v
        | 8L, 16L, "EXTEND", "U" -> wrap_i32_cvtop_i32 (Int32.logand 0xffl) v
        (* Conversion to I32 *)
        | 16L, 32L, "EXTEND", "S" -> wrap_i32_cvtop_i32 (fun e -> Int32.logand 0xffffffffl (e |> i16_to_i32)) v
        | 16L, 32L, "EXTEND", "U" -> wrap_i32_cvtop_i32 (Int32.logand 0xffffl) v
        | 32L, 32L, "TRUNC_SAT", "S" -> wrap_i32_cvtop_f32 I32_convert.trunc_sat_f32_s v
        | 32L, 32L, "TRUNC_SAT", "U" -> wrap_i32_cvtop_f32 I32_convert.trunc_sat_f32_u v
        | 64L, 32L, "TRUNC_SAT", "S" -> wrap_i32_cvtop_f64 I32_convert.trunc_sat_f64_s v
        | 64L, 32L, "TRUNC_SAT", "U" -> wrap_i32_cvtop_f64 I32_convert.trunc_sat_f64_u v
        (* Conversion to I64 *)
        | 32L, 64L, "EXTEND", "S" -> wrap_i64_cvtop_i64 (fun e -> I64.shr_s (I64.shl e 32L) 32L) v
        | 32L, 64L, "EXTEND", "U" -> wrap_i64_cvtop_i64 (Int64.logand 0xffffffffL) v
        (* Conversion to F32 *)
        | 32L, 32L, "CONVERT", "S" -> wrap_f32_cvtop_i32 F32_convert.convert_i32_s v
        | 32L, 32L, "CONVERT", "U" -> wrap_f32_cvtop_i32 F32_convert.convert_i32_u v
        | 64L, 32L, "DEMOTE", _ -> wrap_f32_cvtop_f64 F32_convert.demote_f64 v
        (* Conversion to F64 *)
        | 32L, 64L, "CONVERT", "S" -> wrap_f64_cvtop_i32 F64_convert.convert_i32_s v
        | 32L, 64L, "CONVERT", "U" -> wrap_f64_cvtop_i32 F64_convert.convert_i32_u v
        | 32L, 64L, "PROMOTE", _ -> wrap_f64_cvtop_f32 F64_convert.promote_f32 v
        | _ -> failwith ("Invalid vcvtop")
      )
      | _ -> failwith "Invalid vcvtop"
    )
  }

let vishiftop: numerics =
  {
    name = "vishiftop";
    f =
      (function
      | [ CaseV ("_VI", [ op ]); CaseV (ls, []); NumV v1; NumV v2] -> (
        match ls with
        | "I8" -> (
          let v1p = v1 |> Int64.to_int32 |> i8_to_i32 in
          let v2p = Int64.rem v2 8L |> Int64.to_int32 in

          match op with
          | CaseV ("SHL", []) -> I8.shl v1p v2p |> al_of_int32
          | CaseV ("SHRS", []) -> I8.shr_s v1p v2p |> al_of_int32
          | CaseV ("SHRU", []) -> I8.shr_u v1p v2p |> al_of_int32
          | _ -> failwith ("Invalid vishiftop: " ^ (Print.string_of_value op))
        )
        | "I16" -> (
          let v1p = v1 |> Int64.to_int32 |> i16_to_i32 in
          let v2p = Int64.rem v2 16L |> Int64.to_int32 in

          match op with
          | CaseV ("SHL", []) -> I16.shl v1p v2p |> al_of_int32
          | CaseV ("SHRS", []) -> I16.shr_s v1p v2p |> al_of_int32
          | CaseV ("SHRU", []) -> I16.shr_u v1p v2p |> al_of_int32
          | _ -> failwith ("Invalid vishiftop: " ^ (Print.string_of_value op))
        )
        | "I32" -> (
          let v1p = v1 |> Int64.to_int32 in
          let v2p = Int64.rem v2 32L |> Int64.to_int32 in

          match op with
          | CaseV ("SHL", []) -> I32.shl v1p v2p |> al_of_int32
          | CaseV ("SHRS", []) -> I32.shr_s v1p v2p |> al_of_int32
          | CaseV ("SHRU", []) -> I32.shr_u v1p v2p |> al_of_int32
          | _ -> failwith ("Invalid vishiftop: " ^ (Print.string_of_value op))
        )
        | "I64" -> (
          let v1p = v1 in
          let v2p = Int64.rem v2 64L in

          match op with
          | CaseV ("SHL", []) -> I64.shl v1p v2p |> al_of_int64
          | CaseV ("SHRS", []) -> I64.shr_s v1p v2p |> al_of_int64
          | CaseV ("SHRU", []) -> I64.shr_u v1p v2p |> al_of_int64
          | _ -> failwith ("Invalid vishiftop: " ^ (Print.string_of_value op))
        )
        | _ -> failwith "Invalid type for vishiftop"
        )
      | _ -> failwith "Invalid vishiftop")
  }

let numerics_list : numerics list = [
  unop;
  binop;
  testop;
  relop;
  cvtop;
  ext;
  ext128;
  ibytes;
  inverse_of_ibytes;
  ntbytes;
  vtbytes;
  inverse_of_ntbytes;
  inverse_of_vtbytes;
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
  inverse_of_concat_bytes;
  iadd;
  imul;
  vcvtop;
  vrelop;
  vishiftop;
  narrow;
  lanes;
  inverse_of_lanes;
  ine;
  ilt_s;
  inverse_of_ibits;
  vzero ]

let call_numerics fname args =
  let numerics =
    List.find (fun numerics -> numerics.name = fname) numerics_list
  in
  numerics.f args

let mem name = List.exists (fun numerics -> numerics.name = name) numerics_list
