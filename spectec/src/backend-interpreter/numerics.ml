open Reference_interpreter
open Al
open Al.Ast

type numerics = { name : string; f : value list -> value }

let num_to_i32 = function
  | NumV bits -> bits |> Int64.to_int32 |> I32.of_bits
  | _ -> failwith "Operand should be NumV"
let num_to_i64 = function
  | NumV bits -> bits |> I64.of_bits
  | _ -> failwith "Operand should be NumV"
let num_to_f32 = function
  | NumV bits -> bits |> Int64.to_int32 |> F32.of_bits
  | _ -> failwith "Operand should be NumV"
let num_to_f64 = function
  | NumV bits -> bits |> F64.of_bits
  | _ -> failwith "Operand should be NumV"

let num_to_i32_string n = n |> num_to_i32 |> I32.to_string_s
let num_to_i64_string n = n |> num_to_i64 |> I64.to_string_s
let num_to_f32_string n = n |> num_to_f32 |> F32.to_string
let num_to_f64_string n = n |> num_to_f64 |> F64.to_string

let int64_of_int32_u x = x |> Int64.of_int32 |> Int64.logand 0x0000_0000_ffff_ffffL
let bool_to_num b = NumV (Bool.to_int b |> I64.of_int_s)
let i32_to_num i = NumV ( i |> I32.to_bits |> int64_of_int32_u )
let i64_to_num i = NumV ( i |> I64.to_bits)
let f32_to_num f = NumV ( f |> F32.to_bits |> int64_of_int32_u )
let f64_to_num f = NumV ( f |> F64.to_bits)

let i32_to_const i = CaseV ("CONST", [ CaseV ("I32", []); i |> i32_to_num])
let i64_to_const i = CaseV ("CONST", [ CaseV ("I64", []); i |> i64_to_num])
let f32_to_const f = CaseV ("CONST", [ CaseV ("F32", []); f |> f32_to_num])
let f64_to_const f = CaseV ("CONST", [ CaseV ("F64", []); f |> f64_to_num])

let listV l = ListV (l |> Array.of_list |> ref)

let wrap_i32_unop op i =
  let result = num_to_i32 i |> op |> i32_to_num in
  listV [ result ]
let wrap_i64_unop op i =
  let result = num_to_i64 i |> op |> i64_to_num in
  listV [ result ]
let wrap_f32_unop op f =
  let result = num_to_f32 f |> op |> f32_to_num in
  listV [ result ]
let wrap_f64_unop op f =
  let result = num_to_f64 f |> op |> f64_to_num in
  listV [ result ]
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

let wrap_i32_binop op i1 i2 =
  let i1 = num_to_i32 i1 in
  let i2 = num_to_i32 i2 in
  let result = op i1 i2 |> i32_to_num in
  listV [ result ]
let wrap_i64_binop op i1 i2 =
  let i1 = num_to_i64 i1 in
  let i2 = num_to_i64 i2 in
  let result = op i1 i2 |> i64_to_num in
  listV [ result ]
let wrap_f32_binop op f1 f2 =
  let f1 = num_to_f32 f1 in
  let f2 = num_to_f32 f2 in
  let result = op f1 f2 |> f32_to_num in
  listV [ result ]
let wrap_f64_binop op f1 f2 =
  let f1 = num_to_f64 f1 in
  let f2 = num_to_f64 f2 in
  let result = op f1 f2 |> f64_to_num in
  listV [ result ]
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

let wrap_i32_testop op i = num_to_i32 i |> op |> bool_to_num
let wrap_i64_testop op i = num_to_i64 i |> op |> bool_to_num
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

let wrap_i32_relop op i1 i2 =
  let i1 = num_to_i32 i1 in
  let i2 = num_to_i32 i2 in
  op i1 i2 |> bool_to_num
let wrap_i64_relop op i1 i2 =
  let i1 = num_to_i64 i1 in
  let i2 = num_to_i64 i2 in
  op i1 i2 |> bool_to_num
let wrap_f32_relop op f1 f2 =
  let f1 = num_to_f32 f1 in
  let f2 = num_to_f32 f2 in
  op f1 f2 |> bool_to_num
let wrap_f64_relop op f1 f2 =
  let f1 = num_to_f64 f1 in
  let f2 = num_to_f64 f2 in
  op f1 f2 |> bool_to_num
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
let wrap_i64_cvtop_i32 op n = n |> num_to_i32 |> op |> i64_to_num
let wrap_f32_cvtop_i32 op n = n |> num_to_i32 |> op |> f32_to_num
let wrap_f64_cvtop_i32 op n = n |> num_to_i32 |> op |> f64_to_num
(* conversion from i64 *)
let wrap_i32_cvtop_i64 op n = n |> num_to_i64 |> op |> i32_to_num
let wrap_f32_cvtop_i64 op n = n |> num_to_i64 |> op |> f32_to_num
let wrap_f64_cvtop_i64 op n = n |> num_to_i64 |> op |> f64_to_num
(* conversion from f32 *)
let wrap_i32_cvtop_f32 op n = n |> num_to_f32 |> op |> i32_to_num
let wrap_i64_cvtop_f32 op n = n |> num_to_f32 |> op |> i64_to_num
let wrap_f64_cvtop_f32 op n = n |> num_to_f32 |> op |> f64_to_num
(* conversion from i64 *)
let wrap_i32_cvtop_f64 op n = n |> num_to_f64 |> op |> i32_to_num
let wrap_i64_cvtop_f64 op n = n |> num_to_f64 |> op |> i64_to_num
let wrap_f32_cvtop_f64 op n = n |> num_to_f64 |> op |> f32_to_num

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
        listV ([ catch_ixx_exception (fun _ -> match op, t_to, t_from, sx with
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
        | _ -> failwith ("Invalid cvtop: " ^ op ^ t_to ^ t_from ^ sx) ) ]))
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
          listV (decompose n i |> List.map (fun x -> NumV x))
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
  wrap ]

let call_numerics fname args =
  let numerics =
    List.find (fun numerics -> numerics.name = fname) numerics_list
  in
  numerics.f args

let mem name = List.exists (fun numerics -> numerics.name = name) numerics_list
