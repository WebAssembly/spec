open Reference_interpreter
open Construct
open Al
open Ast
open Al_util

type numerics = { name : string; f : value list -> value }

let mask32 = Z.of_int32_unsigned (-1l)
let mask64 = Z.of_int64_unsigned (-1L)

let z_to_int32 z = Z.(to_int32_unsigned (logand mask32 z))
let z_to_int64 z = Z.(to_int64_unsigned (logand mask64 z))

let i8_to_i32 i8 =
  (* NOTE: This operation extends the sign of i8 to i32 *)
  I32.shr_s (I32.shl i8 24l) 24l
let i16_to_i32 i16 =
  (* NOTE: This operation extends the sign of i8 to i32 *)
  I32.shr_s (I32.shl i16 16l) 16l

let i32_to_i8 i32 = Int32.logand 0xffl i32
let i32_to_i16 i32 = Int32.logand 0xffffl i32

let wrap_i32_unop = map al_to_int32 (fun i32 -> listV [| al_of_int32 i32 |])
let wrap_i64_unop = map al_to_int64 (fun i64 -> listV [| al_of_int64 i64 |])
let wrap_f32_unop = map al_to_float32 (fun f32 -> listV [| al_of_float32 f32 |])
let wrap_f64_unop = map al_to_float64 (fun f64 -> listV [| al_of_float64 f64 |])
let unop: numerics =
  {
    name = "unop";
    f =
      (function
      | [ CaseV (_, [op]); CaseV (t, []); v ] -> (
        match t with
        | "I32" -> (
          match op with
          | CaseV ("CLZ", []) -> wrap_i32_unop I32.clz v
          | CaseV ("CTZ", []) -> wrap_i32_unop I32.ctz v
          | CaseV ("POPCNT", []) -> wrap_i32_unop I32.popcnt v
          | CaseV ("EXTEND8S", []) -> wrap_i32_unop (I32.extend_s 8) v
          | CaseV ("EXTEND16S", []) -> wrap_i32_unop (I32.extend_s 16) v
          | CaseV ("EXTEND32S", []) -> wrap_i32_unop (I32.extend_s 32) v
          | CaseV ("EXTEND64S", []) -> wrap_i32_unop (I32.extend_s 64) v
          | _ -> failwith ("Invalid unop: " ^ (Print.string_of_value op)))
        | "I64" -> (
          match op with
          | CaseV ("CLZ", []) -> wrap_i64_unop I64.clz v
          | CaseV ("CTZ", []) -> wrap_i64_unop I64.ctz v
          | CaseV ("POPCNT", []) -> wrap_i64_unop I64.popcnt v
          | CaseV ("EXTEND8S", []) -> wrap_i64_unop (I64.extend_s 8) v
          | CaseV ("EXTEND16S", []) -> wrap_i64_unop (I64.extend_s 16) v
          | CaseV ("EXTEND32S", []) -> wrap_i64_unop (I64.extend_s 32) v
          | CaseV ("EXTEND64S", []) -> wrap_i64_unop (I64.extend_s 64) v
          | _ -> failwith ("Invalid unop: " ^ (Print.string_of_value op)))
        | "F32"  -> (
          match op with
          | CaseV ("NEG", []) -> wrap_f32_unop (F32.neg) v
          | CaseV ("ABS", []) -> wrap_f32_unop (F32.abs) v
          | CaseV ("CEIL", []) -> wrap_f32_unop (F32.ceil) v
          | CaseV ("FLOOR", []) -> wrap_f32_unop (F32.floor) v
          | CaseV ("TRUNC", []) -> wrap_f32_unop (F32.trunc) v
          | CaseV ("NEAREST", []) -> wrap_f32_unop (F32.nearest) v
          | CaseV ("SQRT", []) -> wrap_f32_unop (F32.sqrt) v
          | _ -> failwith ("Invalid unop: " ^ (Print.string_of_value op)))
        | "F64" -> (
          match op with
          | CaseV ("NEG", []) -> wrap_f64_unop (F64.neg) v
          | CaseV ("ABS", []) -> wrap_f64_unop (F64.abs) v
          | CaseV ("CEIL", []) -> wrap_f64_unop (F64.ceil) v
          | CaseV ("FLOOR", []) -> wrap_f64_unop (F64.floor) v
          | CaseV ("TRUNC", []) -> wrap_f64_unop (F64.trunc) v
          | CaseV ("NEAREST", []) -> wrap_f64_unop (F64.nearest) v
          | CaseV ("SQRT", []) -> wrap_f64_unop (F64.sqrt) v
          | _ -> failwith ("Invalid unop: " ^ (Print.string_of_value op)))
        | _ -> failwith "Invalid type for unop")
      | _ -> failwith "Invalid unop")
  }

let wrap_i32_binop = map2 al_to_int32 (fun i32 -> listV [| al_of_int32 i32 |])
let wrap_i64_binop = map2 al_to_int64 (fun i64 -> listV [| al_of_int64 i64 |])
let wrap_f32_binop = map2 al_to_float32 (fun f32 -> listV [| al_of_float32 f32 |])
let wrap_f64_binop = map2 al_to_float64 (fun f64 -> listV [| al_of_float64 f64 |])
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
      | [ CaseV (_, [op]); CaseV (t, []); v1; v2 ] -> (
        match t with
        | "I32"  -> (
          match op with
          | CaseV ("ADD", [])  -> wrap_i32_binop I32.add v1 v2
          | CaseV ("SUB", [])  -> wrap_i32_binop I32.sub v1 v2
          | CaseV ("MUL", [])  -> wrap_i32_binop I32.mul v1 v2
          | CaseV ("DIV", [CaseV ("S", [])]) -> wrap_i32_binop_with_trap I32.div_s v1 v2
          | CaseV ("DIV", [CaseV ("U", [])]) -> wrap_i32_binop_with_trap I32.div_u v1 v2
          | CaseV ("REM", [CaseV ("S", [])]) -> wrap_i32_binop_with_trap I32.rem_s v1 v2
          | CaseV ("REM", [CaseV ("U", [])]) -> wrap_i32_binop_with_trap I32.rem_u v1 v2
          | CaseV ("AND", [])  -> wrap_i32_binop I32.and_ v1 v2
          | CaseV ("OR", [])   -> wrap_i32_binop I32.or_ v1 v2
          | CaseV ("XOR", [])  -> wrap_i32_binop I32.xor v1 v2
          | CaseV ("SHL", [])  -> wrap_i32_binop I32.shl v1 v2
          | CaseV ("SHR", [CaseV ("S", [])]) -> wrap_i32_binop I32.shr_s v1 v2
          | CaseV ("SHR", [CaseV ("U", [])]) -> wrap_i32_binop I32.shr_u v1 v2
          | CaseV ("ROTL", []) -> wrap_i32_binop I32.rotl v1 v2
          | CaseV ("ROTR", []) -> wrap_i32_binop I32.rotr v1 v2
          | _ -> failwith ("Invalid binop: " ^ (Print.string_of_value op)))
        | "I64" -> (
          match op with
          | CaseV ("ADD", [])  -> wrap_i64_binop I64.add v1 v2
          | CaseV ("SUB", [])  -> wrap_i64_binop I64.sub v1 v2
          | CaseV ("MUL", [])  -> wrap_i64_binop I64.mul v1 v2
          | CaseV ("DIV", [CaseV ("S", [])]) -> wrap_i64_binop_with_trap I64.div_s v1 v2
          | CaseV ("DIV", [CaseV ("U", [])]) -> wrap_i64_binop_with_trap I64.div_u v1 v2
          | CaseV ("REM", [CaseV ("S", [])]) -> wrap_i64_binop_with_trap I64.rem_s v1 v2
          | CaseV ("REM", [CaseV ("U", [])]) -> wrap_i64_binop_with_trap I64.rem_u v1 v2
          | CaseV ("AND", [])  -> wrap_i64_binop I64.and_ v1 v2
          | CaseV ("OR", [])   -> wrap_i64_binop I64.or_ v1 v2
          | CaseV ("XOR", [])  -> wrap_i64_binop I64.xor v1 v2
          | CaseV ("SHL", [])  -> wrap_i64_binop I64.shl v1 v2
          | CaseV ("SHR", [CaseV ("S", [])]) -> wrap_i64_binop I64.shr_s v1 v2
          | CaseV ("SHR", [CaseV ("U", [])]) -> wrap_i64_binop I64.shr_u v1 v2
          | CaseV ("ROTL", []) -> wrap_i64_binop I64.rotl v1 v2
          | CaseV ("ROTR", []) -> wrap_i64_binop I64.rotr v1 v2
          | _ -> failwith ("Invalid binop: " ^ (Print.string_of_value op)))
        | "F32" -> (
          match op with
          | CaseV ("ADD", []) -> wrap_f32_binop F32.add v1 v2
          | CaseV ("SUB", []) -> wrap_f32_binop F32.sub v1 v2
          | CaseV ("MUL", []) -> wrap_f32_binop F32.mul v1 v2
          | CaseV ("DIV", []) -> wrap_f32_binop F32.div v1 v2
          | CaseV ("MIN", []) -> wrap_f32_binop F32.min v1 v2
          | CaseV ("MAX", []) -> wrap_f32_binop F32.max v1 v2
          | CaseV ("COPYSIGN", []) -> wrap_f32_binop F32.copysign v1 v2
          | _ -> failwith ("Invalid binop: " ^ (Print.string_of_value op)))
        | "F64" -> (
          match op with
          | CaseV ("ADD", []) -> wrap_f64_binop F64.add v1 v2
          | CaseV ("SUB", []) -> wrap_f64_binop F64.sub v1 v2
          | CaseV ("MUL", []) -> wrap_f64_binop F64.mul v1 v2
          | CaseV ("DIV", []) -> wrap_f64_binop F64.div v1 v2
          | CaseV ("MIN", []) -> wrap_f64_binop F64.min v1 v2
          | CaseV ("MAX", []) -> wrap_f64_binop F64.max v1 v2
          | CaseV ("COPYSIGN", []) -> wrap_f64_binop F64.copysign v1 v2
          | _ -> failwith ("Invalid binop: " ^ (Print.string_of_value op)))
        | _ -> failwith "Invalid type for binop")
      | _ -> failwith "Invalid binop");
  }

let wrap_i32_testop = map al_to_int32 al_of_bool
let wrap_i64_testop = map al_to_int64 al_of_bool
let testop : numerics =
  {
    name = "testop";
    f =
      (function
      | [ CaseV ("_I", [CaseV ("EQZ", [])]); CaseV (t, []); i ] -> (
          match t with
          | "I32" -> wrap_i32_testop I32.eqz i
          | "I64" -> wrap_i64_testop I64.eqz i
          | _ -> failwith "Invalid type for testop")
      | _ -> failwith "Invalid testop");
  }

let wrap_i32_relop = map2 al_to_int32 al_of_bool
let wrap_i64_relop = map2 al_to_int64 al_of_bool
let wrap_f32_relop = map2 al_to_float32 al_of_bool
let wrap_f64_relop = map2 al_to_float64 al_of_bool
let relop : numerics =
  {
    name = "relop";
    f =
      (function
      | [ CaseV (_, [op]); CaseV (t, []); v1; v2 ] -> (
        match t with
        | "I32"  -> (
          match op with
          | CaseV ("EQ", []) -> wrap_i32_relop I32.eq v1 v2
          | CaseV ("NE", []) -> wrap_i32_relop I32.ne v1 v2
          | CaseV ("LT", [CaseV ("S", [])]) -> wrap_i32_relop I32.lt_s v1 v2
          | CaseV ("LT", [CaseV ("U", [])]) -> wrap_i32_relop I32.lt_u v1 v2
          | CaseV ("LE", [CaseV ("S", [])]) -> wrap_i32_relop I32.le_s v1 v2
          | CaseV ("LE", [CaseV ("U", [])]) -> wrap_i32_relop I32.le_u v1 v2
          | CaseV ("GT", [CaseV ("S", [])]) -> wrap_i32_relop I32.gt_s v1 v2
          | CaseV ("GT", [CaseV ("U", [])]) -> wrap_i32_relop I32.gt_u v1 v2
          | CaseV ("GE", [CaseV ("S", [])]) -> wrap_i32_relop I32.ge_s v1 v2
          | CaseV ("GE", [CaseV ("U", [])]) -> wrap_i32_relop I32.ge_u v1 v2
          | _ -> failwith ("Invalid relop: " ^ (Print.string_of_value op)))
        | "I64" -> (
          match op with
          | CaseV ("EQ", []) -> wrap_i64_relop I64.eq v1 v2
          | CaseV ("NE", []) -> wrap_i64_relop I64.ne v1 v2
          | CaseV ("LT", [CaseV ("S", [])]) -> wrap_i64_relop I64.lt_s v1 v2
          | CaseV ("LT", [CaseV ("U", [])]) -> wrap_i64_relop I64.lt_u v1 v2
          | CaseV ("LE", [CaseV ("S", [])]) -> wrap_i64_relop I64.le_s v1 v2
          | CaseV ("LE", [CaseV ("U", [])]) -> wrap_i64_relop I64.le_u v1 v2
          | CaseV ("GT", [CaseV ("S", [])]) -> wrap_i64_relop I64.gt_s v1 v2
          | CaseV ("GT", [CaseV ("U", [])]) -> wrap_i64_relop I64.gt_u v1 v2
          | CaseV ("GE", [CaseV ("S", [])]) -> wrap_i64_relop I64.ge_s v1 v2
          | CaseV ("GE", [CaseV ("U", [])]) -> wrap_i64_relop I64.ge_u v1 v2
          | _ -> failwith ("Invalid relop: " ^ (Print.string_of_value op)))
        | "F32" -> (
          match op with
          | CaseV ("EQ", []) -> wrap_f32_relop F32.eq v1 v2
          | CaseV ("NE", []) -> wrap_f32_relop F32.ne v1 v2
          | CaseV ("LT", []) -> wrap_f32_relop F32.lt v1 v2
          | CaseV ("GT", []) -> wrap_f32_relop F32.gt v1 v2
          | CaseV ("LE", []) -> wrap_f32_relop F32.le v1 v2
          | CaseV ("GE", []) -> wrap_f32_relop F32.ge v1 v2
          | _ -> failwith ("Invalid relop: " ^ (Print.string_of_value op)))
        | "F64" -> (
          match op with
          | CaseV ("EQ", []) -> wrap_f64_relop F64.eq v1 v2
          | CaseV ("NE", []) -> wrap_f64_relop F64.ne v1 v2
          | CaseV ("LT", []) -> wrap_f64_relop F64.lt v1 v2
          | CaseV ("GT", []) -> wrap_f64_relop F64.gt v1 v2
          | CaseV ("LE", []) -> wrap_f64_relop F64.le v1 v2
          | CaseV ("GE", []) -> wrap_f64_relop F64.ge v1 v2
          | _ -> failwith ("Invalid relop: " ^ (Print.string_of_value op)))
        | _ -> failwith "Invalid type for relop" )
      | _ -> failwith "Invalid relop");
  }

(* conversion from i32 *)
let wrap_i64_cvtop_i32 = map al_to_int32 al_of_int64
let wrap_f32_cvtop_i32 = map al_to_int32 al_of_float32
let wrap_f64_cvtop_i32 = map al_to_int32 al_of_float64
(* conversion from i64 *)
let wrap_i32_cvtop_i64 = map al_to_int64 al_of_int32
let wrap_f32_cvtop_i64 = map al_to_int64 al_of_float32
let wrap_f64_cvtop_i64 = map al_to_int64 al_of_float64
(* conversion from f32 *)
let wrap_i32_cvtop_f32 = map al_to_float32 al_of_int32
let wrap_i64_cvtop_f32 = map al_to_float32 al_of_int64
let wrap_f64_cvtop_f32 = map al_to_float32 al_of_float64
(* conversion from i64 *)
let wrap_i32_cvtop_f64 = map al_to_float64 al_of_int32
let wrap_i64_cvtop_f64 = map al_to_float64 al_of_int64
let wrap_f32_cvtop_f64 = map al_to_float64 al_of_float32

let cvtop : numerics =
  {
    name = "cvtop";
    f =
      (function
      | [ CaseV (op, []); CaseV (t_from, []); CaseV (t_to, []); OptV sx_opt; v ] -> (
        let sx = match sx_opt with
          | None -> ""
          | Some (CaseV (sx, [])) -> sx
          | _ -> failwith "invalid cvtop" in
        listV ([| catch_ixx_exception (fun _ -> match op, t_to, t_from, sx with
        (* Conversion to I32 *)
        | "WRAP", "I32", "I64", "" -> wrap_i32_cvtop_i64 I32_convert.wrap_i64 v
        | "TRUNC", "I32", "F32", "S" -> wrap_i32_cvtop_f32 I32_convert.trunc_f32_s v
        | "TRUNC", "I32", "F32", "U" -> wrap_i32_cvtop_f32 I32_convert.trunc_f32_u v
        | "TRUNC", "I32", "F64", "S" -> wrap_i32_cvtop_f64 I32_convert.trunc_f64_s v
        | "TRUNC", "I32", "F64", "U" -> wrap_i32_cvtop_f64 I32_convert.trunc_f64_u v
        | "TRUNCSAT", "I32", "F32", "S" -> wrap_i32_cvtop_f32 I32_convert.trunc_sat_f32_s v
        | "TRUNCSAT", "I32", "F32", "U" -> wrap_i32_cvtop_f32 I32_convert.trunc_sat_f32_u v
        | "TRUNCSAT", "I32", "F64", "S" -> wrap_i32_cvtop_f64 I32_convert.trunc_sat_f64_s v
        | "TRUNCSAT", "I32", "F64", "U" -> wrap_i32_cvtop_f64 I32_convert.trunc_sat_f64_u v
        | "REINTERPRET", "I32", "F32", "" -> wrap_i32_cvtop_f32 I32_convert.reinterpret_f32 v
        (* CONVERSION TO I64 *)
        | "EXTEND", "I64", "I32", "S" -> wrap_i64_cvtop_i32 I64_convert.extend_i32_s v
        | "EXTEND", "I64", "I32", "U" -> wrap_i64_cvtop_i32 I64_convert.extend_i32_u v
        | "TRUNC", "I64", "F32", "S" -> wrap_i64_cvtop_f32 I64_convert.trunc_f32_s v
        | "TRUNC", "I64", "F32", "U" -> wrap_i64_cvtop_f32 I64_convert.trunc_f32_u v
        | "TRUNC", "I64", "F64", "S" -> wrap_i64_cvtop_f64 I64_convert.trunc_f64_s v
        | "TRUNC", "I64", "F64", "U" -> wrap_i64_cvtop_f64 I64_convert.trunc_f64_u v
        | "TRUNCSAT", "I64", "F32", "S" -> wrap_i64_cvtop_f32 I64_convert.trunc_sat_f32_s v
        | "TRUNCSAT", "I64", "F32", "U" -> wrap_i64_cvtop_f32 I64_convert.trunc_sat_f32_u v
        | "TRUNCSAT", "I64", "F64", "S" -> wrap_i64_cvtop_f64 I64_convert.trunc_sat_f64_s v
        | "TRUNCSAT", "I64", "F64", "U" -> wrap_i64_cvtop_f64 I64_convert.trunc_sat_f64_u v
        | "REINTERPRET", "I64", "F64", "" -> wrap_i64_cvtop_f64 I64_convert.reinterpret_f64 v
        (* CONVERSION TO F32 *)
        | "DEMOTE", "F32", "F64", "" -> wrap_f32_cvtop_f64 F32_convert.demote_f64 v
        | "CONVERT", "F32", "I32", "S" -> wrap_f32_cvtop_i32 F32_convert.convert_i32_s v
        | "CONVERT", "F32", "I32", "U" -> wrap_f32_cvtop_i32 F32_convert.convert_i32_u v
        | "CONVERT", "F32", "I64", "S" -> wrap_f32_cvtop_i64 F32_convert.convert_i64_s v
        | "CONVERT", "F32", "I64", "U" -> wrap_f32_cvtop_i64 F32_convert.convert_i64_u v
        | "REINTERPRET", "F32", "I32", "" -> wrap_f32_cvtop_i32 F32_convert.reinterpret_i32 v
        (* CONVERSION TO F64 *)
        | "PROMOTE", "F64", "F32", "" -> wrap_f64_cvtop_f32 F64_convert.promote_f32 v
        | "CONVERT", "F64", "I32", "S" -> wrap_f64_cvtop_i32 F64_convert.convert_i32_s v
        | "CONVERT", "F64", "I32", "U" -> wrap_f64_cvtop_i32 F64_convert.convert_i32_u v
        | "CONVERT", "F64", "I64", "S" -> wrap_f64_cvtop_i64 F64_convert.convert_i64_s v
        | "CONVERT", "F64", "I64", "U" -> wrap_f64_cvtop_i64 F64_convert.convert_i64_u v
        | "REINTERPRET", "F64", "I64", "" -> wrap_f64_cvtop_i64 F64_convert.reinterpret_i64 v
        | _ -> failwith ("Invalid cvtop: " ^ op ^ t_to ^ t_from ^ sx) ) |]))
      | _ -> failwith "Invalid cvtop");
  }

let ext : numerics =
  {
    name = "ext";
    f =
      (function
      | [ NumV z; _; CaseV ("U", []); NumV v ] when z = Z.of_int 128 -> VecV (V128.I64x2.of_lanes [ z_to_int64 v; 0L ] |> V128.to_bits) (* HARDCODE *)
      | [ _; _; CaseV ("U", []); v ] -> v
      | [ NumV n1; NumV n2; CaseV ("S", []); NumV n3 ] ->
        let i1 = Z.to_int n1 in
        let i2 = Z.to_int n2 in
        if Z.shift_right n3 (i1 - 1) = Z.zero then NumV n3 else
          let mask = Z.sub (if i2 = 64 then Z.zero else Z.shift_left Z.zero i2) (Z.shift_left Z.one i1) in
          NumV (Z.logor n3 mask)
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
            if n = Z.zero then
              []
            else
              Z.(bits land of_int 0xff) :: decompose Z.(n - of_int 8) Z.(shift_right bits 8)
            in
          assert Z.(n >= Z.zero && rem n (of_int 8) = zero);
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
          assert (n = Z.of_int (Array.length !bs * 8));
          NumV (Array.fold_right (fun b acc ->
            match b with
            | NumV b when Z.zero <= b && b < Z.of_int 256 -> Z.add b (Z.shift_left acc 8)
            | _ -> failwith ("Invalid inverse_of_ibytes: " ^ Print.string_of_value b ^ " is not a valid byte.")
          ) !bs Z.zero)
      | _ -> failwith "Invalid argument for inverse_of_ibytes."
      );
  }

let ntbytes : numerics =
  {
    name = "ntbytes";
    f =
      (function
      | [ CaseV ("I32", []); n ] -> ibytes.f [ NumV (Z.of_int 32); n ]
      | [ CaseV ("I64", []); n ] -> ibytes.f [ NumV (Z.of_int 64); n ]
      | [ CaseV ("F32", []); f ] -> ibytes.f [ NumV (Z.of_int 32); f ] (* TODO *)
      | [ CaseV ("F64", []); f ] -> ibytes.f [ NumV (Z.of_int 64); f ] (* TODO *)
      | _ -> failwith "Invalid ntbytes"
      );
  }
let inverse_of_ntbytes : numerics =
  {
    name = "inverse_of_ntbytes";
    f =
      (function
      | [ CaseV ("I32", []); l ] -> inverse_of_ibytes.f [ NumV (Z.of_int 32); l ]
      | [ CaseV ("I64", []); l ] -> inverse_of_ibytes.f [ NumV (Z.of_int 64); l ]
      | [ CaseV ("F32", []); l ] -> inverse_of_ibytes.f [ NumV (Z.of_int 32); l ] (* TODO *)
      | [ CaseV ("F64", []); l ] -> inverse_of_ibytes.f [ NumV (Z.of_int 64); l ] (* TODO *)
      | _ -> failwith "Invalid inverse_of_ntbytes"
      );
  }

let vtbytes : numerics =
  {
    name = "vtbytes";
    f =
      (function
      | [ CaseV ("V128", []); VecV v ] ->
        let v1 = (ibytes.f [ NumV (Z.of_int 64); NumV (Z.of_int64 (Bytes.get_int64_le (Bytes.of_string v) 0)) ]) in
        let v2 = (ibytes.f [ NumV (Z.of_int 64); NumV (Z.of_int64 (Bytes.get_int64_le (Bytes.of_string v) 8)) ]) in
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
        let v1 = inverse_of_ibytes.f [ NumV (Z.of_int 64); Array.sub !l 0 8 |> listV ] in
        let v2 = inverse_of_ibytes.f [ NumV (Z.of_int 64); Array.sub !l 8 8 |> listV ] in

        (match v1, v2 with
        | NumV n1, NumV n2 -> al_of_vector (V128.I64x2.of_lanes [ z_to_int64 n1; z_to_int64 n2 ])
        | _ -> failwith "Invalid inverse_of_vtbytes")

      | _ -> failwith "Invalid inverse_of_vtbytes"
      );
  }

let inverse_of_ztbytes : numerics =
  {
    name = "inverse_of_ztbytes";
    f =
      (function
      | [ CaseV ("I8", []); l ] -> inverse_of_ibytes.f [ NumV (Z.of_int 8); l ]
      | [ CaseV ("I16", []); l ] -> inverse_of_ibytes.f [ NumV (Z.of_int 16); l ]
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
            let mask = Z.pred (Z.shift_left Z.one (Z.to_int n)) in
            NumV (Z.logand i mask)
      | _ -> failwith "Invalid wrap_"
      );
  }

let inverse_of_signed : numerics =
  {
    name = "inverse_of_signed";
    f =
      (function
      | [ n; i ] -> wrap.f [ NumV (Z.of_int 64); n; i ]
      | _ -> failwith "Invalid inverse_of_signed"
      );
  }


let ine: numerics =
  {
    name = "ine";
    f =
      (function
      | [ _; VecV v1; VecV v2 ] -> (if v1 = v2 then Z.zero else Z.one) |> numV
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
        NumV (Array.fold_right (fun e acc -> Z.logor e (Z.shift_left acc 1)) na Z.zero)
      | _ -> failwith "Invaild inverse_of_ibits"
      );
  }


let ilt: numerics =
  {
    name = "ilt";
    f =
      (function
      | [ CaseV ("S", []); NumV t; NumV n1; NumV n2 ] ->
        (match z_to_int64 t with
        | 8L -> I8.lt_s (n1 |> z_to_int32 |> i8_to_i32) (n2 |> z_to_int32 |> i8_to_i32) |> al_of_bool
        | 16L -> I16.lt_s (n1 |> z_to_int32 |> i16_to_i32) (n2 |> z_to_int32 |> i16_to_i32) |> al_of_bool
        | 32L -> I32.lt_s (n1 |> z_to_int32) (n2 |> z_to_int32) |> al_of_bool
        | 64L -> I64.lt_s (n1 |> z_to_int64) (n2 |> z_to_int64) |> al_of_bool
        | _ -> failwith "Invaild ilt"
        )
      | _ -> failwith "Invaild ilt"
      );
  }


let al_to_vector v = v |> al_to_vector |> V128.of_bits

let vzero: numerics =
  {
    name = "vzero";
    f =
      (fun _ -> VecV ("\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00"));
  }


let wrap_vunop = map al_to_vector al_of_vector

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
      | [ CaseV ("_VI", [ op ]); TupV [ CaseV (ls, []); NumV (ln) ]; v ] -> (
        match ls, ln with
        | "I8", z when z = Z.of_int 16 -> (
          match op with
          | CaseV ("ABS", []) -> wrap_vunop V128.I8x16.abs v
          | CaseV ("NEG", []) -> wrap_vunop V128.I8x16.neg v
          | CaseV ("POPCNT", []) -> wrap_vunop V128.I8x16.popcnt v
          | _ -> failwith ("Invalid viunop: " ^ (Print.string_of_value op)))
        | "I16", z when z = Z.of_int 8 -> (
          match op with
          | CaseV ("ABS", []) -> wrap_vunop V128.I16x8.abs v
          | CaseV ("NEG", []) -> wrap_vunop V128.I16x8.neg v
          | _ -> failwith ("Invalid viunop: " ^ (Print.string_of_value op)))
        | "I32", z when z = Z.of_int 4 -> (
          match op with
          | CaseV ("ABS", []) -> wrap_vunop V128.I32x4.abs v
          | CaseV ("NEG", []) -> wrap_vunop V128.I32x4.neg v
          | _ -> failwith ("Invalid viunop: " ^ (Print.string_of_value op)))
        | "I64", z when z = Z.of_int 2 -> (
          match op with
          | CaseV ("ABS", []) -> wrap_vunop V128.I64x2.abs v
          | CaseV ("NEG", []) -> wrap_vunop V128.I64x2.neg v
          | _ -> failwith ("Invalid viunop: " ^ (Print.string_of_value op)))
        | _ -> failwith "Invalid type for viunop")
      | [ CaseV ("_VF", [ op ]); TupV [ CaseV (ls, []); NumV (ln) ]; v ] -> (
        match ls, ln with
        | "F32", z when z = Z.of_int 4 -> (
          match op with
          | CaseV ("ABS", []) -> wrap_vunop V128.F32x4.abs v
          | CaseV ("NEG", []) -> wrap_vunop V128.F32x4.neg v
          | CaseV ("SQRT", []) -> wrap_vunop V128.F32x4.sqrt v
          | CaseV ("CEIL", []) -> wrap_vunop V128.F32x4.ceil v
          | CaseV ("FLOOR", []) -> wrap_vunop V128.F32x4.floor v
          | CaseV ("TRUNC", []) -> wrap_vunop V128.F32x4.trunc v
          | CaseV ("NEAREST", []) -> wrap_vunop V128.F32x4.nearest v
          | _ -> failwith ("Invalid vfunop: " ^ (Print.string_of_value op)))
        | "F64", z when z = Z.of_int 2 -> (
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


let wrap_vvbinop = map2 al_to_vector al_of_vector

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
      | [ CaseV ("_VI", [ op ]); TupV [ CaseV (ls, []); NumV (ln) ]; v1; v2 ] -> (
        match ls, ln with
        | "I8", z when z = Z.of_int 16 -> (
          match op with
          | CaseV ("ADD", []) -> wrap_vbinop V128.I8x16.add v1 v2
          | CaseV ("SUB", []) -> wrap_vbinop V128.I8x16.sub v1 v2
          | CaseV ("ADD_SAT", [CaseV ("S", [])]) -> wrap_vbinop V128.I8x16.add_sat_s v1 v2
          | CaseV ("ADD_SAT", [CaseV ("U", [])]) -> wrap_vbinop V128.I8x16.add_sat_u v1 v2
          | CaseV ("SUB_SAT", [CaseV ("S", [])]) -> wrap_vbinop V128.I8x16.sub_sat_s v1 v2
          | CaseV ("SUB_SAT", [CaseV ("U", [])]) -> wrap_vbinop V128.I8x16.sub_sat_u v1 v2
          | CaseV ("MIN", [CaseV ("S", [])]) -> wrap_vbinop V128.I8x16.min_s v1 v2
          | CaseV ("MIN", [CaseV ("U", [])]) -> wrap_vbinop V128.I8x16.min_u v1 v2
          | CaseV ("MAX", [CaseV ("S", [])]) -> wrap_vbinop V128.I8x16.max_s v1 v2
          | CaseV ("MAX", [CaseV ("U", [])]) -> wrap_vbinop V128.I8x16.max_u v1 v2
          | CaseV ("AVGR_U", []) -> wrap_vbinop V128.I8x16.avgr_u v1 v2
          | _ -> failwith ("Invalid vibinop: " ^ (Print.string_of_value op)))
        | "I16", z when z = Z.of_int 8 -> (
          match op with
          | CaseV ("ADD", []) -> wrap_vbinop V128.I16x8.add v1 v2
          | CaseV ("SUB", []) -> wrap_vbinop V128.I16x8.sub v1 v2
          | CaseV ("ADD_SAT", [CaseV ("S", [])]) -> wrap_vbinop V128.I16x8.add_sat_s v1 v2
          | CaseV ("ADD_SAT", [CaseV ("U", [])]) -> wrap_vbinop V128.I16x8.add_sat_u v1 v2
          | CaseV ("SUB_SAT", [CaseV ("S", [])]) -> wrap_vbinop V128.I16x8.sub_sat_s v1 v2
          | CaseV ("SUB_SAT", [CaseV ("U", [])]) -> wrap_vbinop V128.I16x8.sub_sat_u v1 v2
          | CaseV ("MIN", [CaseV ("S", [])]) -> wrap_vbinop V128.I16x8.min_s v1 v2
          | CaseV ("MIN", [CaseV ("U", [])]) -> wrap_vbinop V128.I16x8.min_u v1 v2
          | CaseV ("MAX", [CaseV ("S", [])]) -> wrap_vbinop V128.I16x8.max_s v1 v2
          | CaseV ("MAX", [CaseV ("U", [])]) -> wrap_vbinop V128.I16x8.max_u v1 v2
          | CaseV ("MUL", []) -> wrap_vbinop V128.I16x8.mul v1 v2
          | CaseV ("AVGR_U", []) -> wrap_vbinop V128.I16x8.avgr_u v1 v2
          | CaseV ("Q15MULR_SAT_S", []) -> wrap_vbinop V128.I16x8.q15mulr_sat_s v1 v2
          | _ -> failwith ("Invalid vibinop: " ^ (Print.string_of_value op)))
        | "I32", z when z = Z.of_int 4 -> (
          match op with
          | CaseV ("ADD", []) -> wrap_vbinop V128.I32x4.add v1 v2
          | CaseV ("SUB", []) -> wrap_vbinop V128.I32x4.sub v1 v2
          | CaseV ("ADD_SAT", [CaseV ("S", [])]) -> wrap_vbinop V128.I32x4.add_sat_s v1 v2
          | CaseV ("ADD_SAT", [CaseV ("U", [])]) -> wrap_vbinop V128.I32x4.add_sat_u v1 v2
          | CaseV ("SUB_SAT", [CaseV ("S", [])]) -> wrap_vbinop V128.I32x4.sub_sat_s v1 v2
          | CaseV ("SUB_SAT", [CaseV ("U", [])]) -> wrap_vbinop V128.I32x4.sub_sat_u v1 v2
          | CaseV ("MIN", [CaseV ("S", [])]) -> wrap_vbinop V128.I32x4.min_s v1 v2
          | CaseV ("MIN", [CaseV ("U", [])]) -> wrap_vbinop V128.I32x4.min_u v1 v2
          | CaseV ("MAX", [CaseV ("S", [])]) -> wrap_vbinop V128.I32x4.max_s v1 v2
          | CaseV ("MAX", [CaseV ("U", [])]) -> wrap_vbinop V128.I32x4.max_u v1 v2
          | CaseV ("MUL", []) -> wrap_vbinop V128.I32x4.mul v1 v2
          | _ -> failwith ("Invalid vibinop: " ^ (Print.string_of_value op)))
        | "I64", z when z = Z.of_int 2 -> (
          match op with
          | CaseV ("ADD", []) -> wrap_vbinop V128.I64x2.add v1 v2
          | CaseV ("SUB", []) -> wrap_vbinop V128.I64x2.sub v1 v2
          | CaseV ("ADD_SAT", [CaseV ("S", [])]) -> wrap_vbinop V128.I64x2.add_sat_s v1 v2
          | CaseV ("ADD_SAT", [CaseV ("U", [])]) -> wrap_vbinop V128.I64x2.add_sat_u v1 v2
          | CaseV ("SUB_SAT", [CaseV ("S", [])]) -> wrap_vbinop V128.I64x2.sub_sat_s v1 v2
          | CaseV ("SUB_SAT", [CaseV ("U", [])]) -> wrap_vbinop V128.I64x2.sub_sat_u v1 v2
          | CaseV ("MIN", [CaseV ("S", [])]) -> wrap_vbinop V128.I64x2.min_s v1 v2
          | CaseV ("MIN", [CaseV ("U", [])]) -> wrap_vbinop V128.I64x2.min_u v1 v2
          | CaseV ("MAX", [CaseV ("S", [])]) -> wrap_vbinop V128.I64x2.max_s v1 v2
          | CaseV ("MAX", [CaseV ("U", [])]) -> wrap_vbinop V128.I64x2.max_u v1 v2
          | CaseV ("MUL", []) -> wrap_vbinop V128.I64x2.mul v1 v2
          | _ -> failwith ("Invalid vibinop: " ^ (Print.string_of_value op)))
        | _ -> failwith "Invalid type for vibinop")
      | [ CaseV ("_VF", [ op ]); TupV [ CaseV (ls, []); NumV (ln) ]; v1; v2 ] -> (
        match ls, ln with
        | "F32", z when z = Z.of_int 4 -> (
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
        | "F64", z when z = Z.of_int 2 -> (
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
      | [ CaseV ("_VI", [ op ]); TupV [ CaseV (ls, []); NumV (ln) ]; NumV v1; NumV v2 ] -> (
        match ls, ln with
        | "I8", z when z = Z.of_int 16 -> (
          match op with
          | CaseV ("EQ", []) -> wrap_vrelop I8.eq (v1 |> z_to_int32 |> i8_to_i32) (v2 |> z_to_int32 |> i8_to_i32)
          | CaseV ("NE", []) -> wrap_vrelop I8.ne (v1 |> z_to_int32 |> i8_to_i32) (v2 |> z_to_int32 |> i8_to_i32)
          | CaseV ("LTS", []) -> wrap_vrelop I8.lt_s (v1 |> z_to_int32 |> i8_to_i32) (v2 |> z_to_int32 |> i8_to_i32)
          | CaseV ("LTU", []) -> wrap_vrelop I8.lt_u (v1 |> z_to_int32 |> i8_to_i32) (v2 |> z_to_int32 |> i8_to_i32)
          | CaseV ("GTS", []) -> wrap_vrelop I8.gt_s (v1 |> z_to_int32 |> i8_to_i32) (v2 |> z_to_int32 |> i8_to_i32)
          | CaseV ("GTU", []) -> wrap_vrelop I8.gt_u (v1 |> z_to_int32 |> i8_to_i32) (v2 |> z_to_int32 |> i8_to_i32)
          | CaseV ("LES", []) -> wrap_vrelop I8.le_s (v1 |> z_to_int32 |> i8_to_i32) (v2 |> z_to_int32 |> i8_to_i32)
          | CaseV ("LEU", []) -> wrap_vrelop I8.le_u (v1 |> z_to_int32 |> i8_to_i32) (v2 |> z_to_int32 |> i8_to_i32)
          | CaseV ("GES", []) -> wrap_vrelop I8.ge_s (v1 |> z_to_int32 |> i8_to_i32) (v2 |> z_to_int32 |> i8_to_i32)
          | CaseV ("GEU", []) -> wrap_vrelop I8.ge_u (v1 |> z_to_int32 |> i8_to_i32) (v2 |> z_to_int32 |> i8_to_i32)
          | _ -> failwith ("Invalid virelop: " ^ (Print.string_of_value op)))
        | "I16", z when z = Z.of_int 8 -> (
          match op with
          | CaseV ("EQ", []) -> wrap_vrelop I16.eq (v1 |> z_to_int32 |> i16_to_i32) (v2 |> z_to_int32 |> i16_to_i32)
          | CaseV ("NE", []) -> wrap_vrelop I16.ne (v1 |> z_to_int32 |> i16_to_i32) (v2 |> z_to_int32 |> i16_to_i32)
          | CaseV ("LTS", []) -> wrap_vrelop I16.lt_s  (v1 |> z_to_int32 |> i16_to_i32) (v2 |> z_to_int32 |> i16_to_i32)
          | CaseV ("LTU", []) -> wrap_vrelop I16.lt_u  (v1 |> z_to_int32 |> i16_to_i32) (v2 |> z_to_int32 |> i16_to_i32)
          | CaseV ("GTS", []) -> wrap_vrelop I16.gt_s  (v1 |> z_to_int32 |> i16_to_i32) (v2 |> z_to_int32 |> i16_to_i32)
          | CaseV ("GTU", []) -> wrap_vrelop I16.gt_u  (v1 |> z_to_int32 |> i16_to_i32) (v2 |> z_to_int32 |> i16_to_i32)
          | CaseV ("LES", []) -> wrap_vrelop I16.le_s  (v1 |> z_to_int32 |> i16_to_i32) (v2 |> z_to_int32 |> i16_to_i32)
          | CaseV ("LEU", []) -> wrap_vrelop I16.le_u  (v1 |> z_to_int32 |> i16_to_i32) (v2 |> z_to_int32 |> i16_to_i32)
          | CaseV ("GES", []) -> wrap_vrelop I16.ge_s  (v1 |> z_to_int32 |> i16_to_i32) (v2 |> z_to_int32 |> i16_to_i32)
          | CaseV ("GEU", []) -> wrap_vrelop I16.ge_u  (v1 |> z_to_int32 |> i16_to_i32) (v2 |> z_to_int32 |> i16_to_i32)
          | _ -> failwith ("Invalid virelop: " ^ (Print.string_of_value op)))
        | "I32", z when z = Z.of_int 4 -> (
          match op with
          | CaseV ("EQ", []) -> wrap_vrelop I32.eq (v1 |> z_to_int32) (v2 |> z_to_int32)
          | CaseV ("NE", []) -> wrap_vrelop I32.ne (v1 |> z_to_int32) (v2 |> z_to_int32)
          | CaseV ("LTS", []) -> wrap_vrelop I32.lt_s (v1 |> z_to_int32) (v2 |> z_to_int32)
          | CaseV ("LTU", []) -> wrap_vrelop I32.lt_u (v1 |> z_to_int32) (v2 |> z_to_int32)
          | CaseV ("GTS", []) -> wrap_vrelop I32.gt_s (v1 |> z_to_int32) (v2 |> z_to_int32)
          | CaseV ("GTU", []) -> wrap_vrelop I32.gt_u (v1 |> z_to_int32) (v2 |> z_to_int32)
          | CaseV ("LES", []) -> wrap_vrelop I32.le_s (v1 |> z_to_int32) (v2 |> z_to_int32)
          | CaseV ("LEU", []) -> wrap_vrelop I32.le_u (v1 |> z_to_int32) (v2 |> z_to_int32)
          | CaseV ("GES", []) -> wrap_vrelop I32.ge_s (v1 |> z_to_int32) (v2 |> z_to_int32)
          | CaseV ("GEU", []) -> wrap_vrelop I32.ge_u (v1 |> z_to_int32) (v2 |> z_to_int32)
          | _ -> failwith ("Invalid virelop: " ^ (Print.string_of_value op)))
        | "I64", z when z = Z.of_int 2 -> (
          match op with
          | CaseV ("EQ", []) -> wrap_vrelop I64.eq (v1 |> z_to_int64) (v2 |> z_to_int64)
          | CaseV ("NE", []) -> wrap_vrelop I64.ne (v1 |> z_to_int64) (v2 |> z_to_int64)
          | CaseV ("LTS", []) -> wrap_vrelop I64.lt_s (v1 |> z_to_int64) (v2 |> z_to_int64)
          | CaseV ("LTU", []) -> wrap_vrelop I64.lt_u (v1 |> z_to_int64) (v2 |> z_to_int64)
          | CaseV ("GTS", []) -> wrap_vrelop I64.gt_s (v1 |> z_to_int64) (v2 |> z_to_int64)
          | CaseV ("GTU", []) -> wrap_vrelop I64.gt_u (v1 |> z_to_int64) (v2 |> z_to_int64)
          | CaseV ("LES", []) -> wrap_vrelop I64.le_s (v1 |> z_to_int64) (v2 |> z_to_int64)
          | CaseV ("LEU", []) -> wrap_vrelop I64.le_u (v1 |> z_to_int64) (v2 |> z_to_int64)
          | CaseV ("GES", []) -> wrap_vrelop I64.ge_s (v1 |> z_to_int64) (v2 |> z_to_int64)
          | CaseV ("GEU", []) -> wrap_vrelop I64.ge_u (v1 |> z_to_int64) (v2 |> z_to_int64)
          | _ -> failwith ("Invalid virelop: " ^ (Print.string_of_value op)))
        | _ -> failwith "Invalid type for virelop")
      | [ CaseV ("_VF", [ op ]); TupV [ CaseV (ls, []); NumV (ln) ]; v1; v2 ] -> (
        match ls, ln with
        | "F32", z when z = Z.of_int 4 -> (
          match op with
          | CaseV ("EQ", []) -> wrap_vrelop F32.eq (al_to_float32 v1) (al_to_float32 v2)
          | CaseV ("NE", []) -> wrap_vrelop F32.ne (al_to_float32 v1) (al_to_float32 v2)
          | CaseV ("LT", []) -> wrap_vrelop F32.lt (al_to_float32 v1) (al_to_float32 v2)
          | CaseV ("GT", []) -> wrap_vrelop F32.gt (al_to_float32 v1) (al_to_float32 v2)
          | CaseV ("LE", []) -> wrap_vrelop F32.le (al_to_float32 v1) (al_to_float32 v2)
          | CaseV ("GE", []) -> wrap_vrelop F32.ge (al_to_float32 v1) (al_to_float32 v2)
          | _ -> failwith ("Invalid vfrelop: " ^ (Print.string_of_value op)))
        | "F64", z when z = Z.of_int 2 -> (
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
        match z_to_int64 n with
        | 8L -> NumV (i |> z_to_int32 |> i16_to_i32 |> I8.saturate_s |> i32_to_i8 |> Z.of_int32)
        | 16L -> NumV (i |> z_to_int32 |> I16.saturate_s |> i32_to_i16 |> Z.of_int32)
        | _ -> failwith "Invalid narrow"
        )
      | [ NumV _; NumV n; CaseV ("U", []); NumV i ] -> (
        match z_to_int64 n with
        | 8L -> NumV (i |> z_to_int32 |> i16_to_i32 |> I8.saturate_u |> Z.of_int32)
        | 16L -> NumV (i |> z_to_int32 |> I16.saturate_u |> i32_to_i16 |> Z.of_int32)
        | _ -> failwith "Invalid narrow"
        )
      | _ -> failwith "Invalid narrow");
  }

let lanes : numerics =
  {
    name = "lanes";
    f =
      (function
      | [ TupV [ CaseV ("I8", []); NumV z ]; VecV v ] when z = Z.of_int 16 ->
        v |> V128.of_bits |> V128.I8x16.to_lanes |> List.map al_of_int8 |> listV_of_list
      | [ TupV [ CaseV ("I16", []); NumV z ]; VecV v ] when z = Z.of_int 8 ->
        v |> V128.of_bits |> V128.I16x8.to_lanes |> List.map al_of_int16 |> listV_of_list
      | [ TupV [ CaseV ("I32", []); NumV z ]; VecV v ] when z = Z.of_int 4 ->
        v |> V128.of_bits |> V128.I32x4.to_lanes |> List.map al_of_int32 |> listV_of_list
      | [ TupV [ CaseV ("I64", []); NumV z ]; VecV v ] when z = Z.of_int 2 ->
        v |> V128.of_bits |> V128.I64x2.to_lanes |> List.map al_of_int64 |> listV_of_list
      | [ TupV [ CaseV ("F32", []); NumV z ]; VecV v ] when z = Z.of_int 4 ->
        v |> V128.of_bits |> V128.F32x4.to_lanes |> List.map al_of_float32 |> listV_of_list
      | [ TupV [ CaseV ("F64", []); NumV z ]; VecV v ] when z = Z.of_int 2 ->
        v |> V128.of_bits |> V128.F64x2.to_lanes |> List.map al_of_float64 |> listV_of_list
      | _ -> failwith "Invaild lanes"
      );
  }
let inverse_of_lanes : numerics =
  {
    name = "inverse_of_lanes";
    f =
      (function
      | [ TupV [ CaseV ("I8", []); NumV z ]; ListV lanes; ] when z = Z.of_int 16 -> VecV (List.map al_to_int32 (!lanes |> Array.to_list) |> List.map i8_to_i32 |> V128.I8x16.of_lanes |> V128.to_bits)
      | [ TupV [ CaseV ("I16", []); NumV z ]; ListV lanes; ] when z = Z.of_int 8 -> VecV (List.map al_to_int32 (!lanes |> Array.to_list) |> List.map i16_to_i32 |> V128.I16x8.of_lanes |> V128.to_bits)
      | [ TupV [ CaseV ("I32", []); NumV z ]; ListV lanes; ] when z = Z.of_int 4 -> VecV (List.map al_to_int32 (!lanes |> Array.to_list) |> V128.I32x4.of_lanes |> V128.to_bits)
      | [ TupV [ CaseV ("I64", []); NumV z ]; ListV lanes; ] when z = Z.of_int 2 -> VecV (List.map al_to_int64 (!lanes |> Array.to_list) |> V128.I64x2.of_lanes |> V128.to_bits)
      | [ TupV [ CaseV ("F32", []); NumV z ]; ListV lanes; ] when z = Z.of_int 4 -> VecV (List.map al_to_float32 (!lanes |> Array.to_list) |> V128.F32x4.of_lanes |> V128.to_bits)
      | [ TupV [ CaseV ("F64", []); NumV z ]; ListV lanes; ] when z = Z.of_int 2 -> VecV (List.map al_to_float64 (!lanes |> Array.to_list) |> V128.F64x2.of_lanes |> V128.to_bits)
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
      | [ NumV z; NumV m; NumV n ] when z = Z.of_int 8 -> al_of_int32 (I8.add (z_to_int32 m) (z_to_int32 n))
      | [ NumV z; NumV m; NumV n ] when z = Z.of_int 16 -> al_of_int32 (I16.add (z_to_int32 m) (z_to_int32 n))
      | [ NumV z; NumV m; NumV n ] when z = Z.of_int 32 -> al_of_int32 (I32.add (z_to_int32 m) (z_to_int32 n))
      | [ NumV z; NumV m; NumV n ] when z = Z.of_int 64 -> al_of_int64 (I64.add (z_to_int64 m) (z_to_int64 n))
      | v -> fail_list "Invalid iadd" v
      );
  }

let imul : numerics =
  {
    name = "imul";
    f =
      (function
      | [ NumV z; NumV m; NumV n ] when z = Z.of_int 8 -> al_of_int32 (I8.mul (z_to_int32 m) (z_to_int32 n))
      | [ NumV z; NumV m; NumV n ] when z = Z.of_int 16 -> al_of_int32 (I16.mul (z_to_int32 m) (z_to_int32 n))
      | [ NumV z; NumV m; NumV n ] when z = Z.of_int 32 -> al_of_int32 (I32.mul (z_to_int32 m) (z_to_int32 n))
      | [ NumV z; NumV m; NumV n ] when z = Z.of_int 64 -> al_of_int64 (I64.mul (z_to_int64 m) (z_to_int64 n))
      | v -> fail_list "Invalid imul" v
      );
  }

let wrap_i32_cvtop_i32 = map al_to_int32 al_of_int32
let wrap_i64_cvtop_i64 = map al_to_int64 al_of_int64

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
        match z_to_int64 m, z_to_int64 n, op, sx with
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
          let v1p = v1 |> z_to_int32 |> i8_to_i32 in
          let v2p = Z.rem v2 (Z.of_int 8) |> z_to_int32 in

          match op with
          | CaseV ("SHL", []) -> I8.shl v1p v2p |> al_of_int32
          | CaseV ("SHR", [CaseV ("S", [])]) -> I8.shr_s v1p v2p |> al_of_int32
          | CaseV ("SHR", [CaseV ("U", [])]) -> I8.shr_u v1p v2p |> al_of_int32
          | _ -> failwith ("Invalid vishiftop: " ^ (Print.string_of_value op))
        )
        | "I16" -> (
          let v1p = v1 |> z_to_int32 |> i16_to_i32 in
          let v2p = Z.rem v2 (Z.of_int 16) |> z_to_int32 in

          match op with
          | CaseV ("SHL", []) -> I16.shl v1p v2p |> al_of_int32
          | CaseV ("SHR", [CaseV ("S", [])]) -> I16.shr_s v1p v2p |> al_of_int32
          | CaseV ("SHR", [CaseV ("U", [])]) -> I16.shr_u v1p v2p |> al_of_int32
          | _ -> failwith ("Invalid vishiftop: " ^ (Print.string_of_value op))
        )
        | "I32" -> (
          let v1p = v1 |> z_to_int32 in
          let v2p = Z.rem v2 (Z.of_int 32) |> z_to_int32 in

          match op with
          | CaseV ("SHL", []) -> I32.shl v1p v2p |> al_of_int32
          | CaseV ("SHR", [CaseV ("S", [])]) -> I32.shr_s v1p v2p |> al_of_int32
          | CaseV ("SHR", [CaseV ("U", [])]) -> I32.shr_u v1p v2p |> al_of_int32
          | _ -> failwith ("Invalid vishiftop: " ^ (Print.string_of_value op))
        )
        | "I64" -> (
          let v1p = v1 |> z_to_int64 in
          let v2p = Z.rem v2 (Z.of_int 64) |> z_to_int64 in

          match op with
          | CaseV ("SHL", []) -> I64.shl v1p v2p |> al_of_int64
          | CaseV ("SHR", [CaseV ("S", [])]) -> I64.shr_s v1p v2p |> al_of_int64
          | CaseV ("SHR", [CaseV ("U", [])]) -> I64.shr_u v1p v2p |> al_of_int64
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
  ilt;
  inverse_of_ibits;
  vzero ]

let call_numerics fname args =
  let numerics =
    List.find (fun numerics -> numerics.name = fname) numerics_list
  in
  numerics.f args

let mem name = List.exists (fun numerics -> numerics.name = name) numerics_list
