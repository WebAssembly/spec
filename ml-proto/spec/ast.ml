(* Expressions *)

type var = int Source.phrase

type expr = expr' Source.phrase
and expr' =
  (* Constants *)
  | I32_const of I32.t Source.phrase
  | I64_const of I64.t Source.phrase
  | F32_const of F32.t Source.phrase
  | F64_const of F64.t Source.phrase

  (* Control *)
  | Nop
  | Unreachable
  | Drop
  | Block of expr list
  | Loop of expr list
  | Br of int * var
  | Br_if of int * var
  | Br_table of int * var list * var
  | Return of int
  | If of expr list * expr list
  | Select
  | Call of int * var
  | Call_import of int * var
  | Call_indirect of int * var

  (* Locals *)
  | Get_local of var
  | Set_local of var
  | Tee_local of var

  (* Memory access *)
  | I32_load of Memory.offset * int
  | I64_load of Memory.offset * int
  | F32_load of Memory.offset * int
  | F64_load of Memory.offset * int
  | I32_store of Memory.offset * int
  | I64_store of Memory.offset * int
  | F32_store of Memory.offset * int
  | F64_store of Memory.offset * int
  | I32_load8_s of Memory.offset * int
  | I32_load8_u of Memory.offset * int
  | I32_load16_s of Memory.offset * int
  | I32_load16_u of Memory.offset * int
  | I64_load8_s of Memory.offset * int
  | I64_load8_u of Memory.offset * int
  | I64_load16_s of Memory.offset * int
  | I64_load16_u of Memory.offset * int
  | I64_load32_s of Memory.offset * int
  | I64_load32_u of Memory.offset * int
  | I32_store8 of Memory.offset * int
  | I32_store16 of Memory.offset * int
  | I64_store8 of Memory.offset * int
  | I64_store16 of Memory.offset * int
  | I64_store32 of Memory.offset * int

  (* Unary arithmetic *)
  | I32_clz
  | I32_ctz
  | I32_popcnt
  | I64_clz
  | I64_ctz
  | I64_popcnt
  | F32_neg
  | F32_abs
  | F32_sqrt
  | F32_ceil
  | F32_floor
  | F32_trunc
  | F32_nearest
  | F64_neg
  | F64_abs
  | F64_sqrt
  | F64_ceil
  | F64_floor
  | F64_trunc
  | F64_nearest

  (* Binary arithmetic *)
  | I32_add
  | I32_sub
  | I32_mul
  | I32_div_s
  | I32_div_u
  | I32_rem_s
  | I32_rem_u
  | I32_and
  | I32_or
  | I32_xor
  | I32_shl
  | I32_shr_s
  | I32_shr_u
  | I32_rotl
  | I32_rotr
  | I64_add
  | I64_sub
  | I64_mul
  | I64_div_s
  | I64_div_u
  | I64_rem_s
  | I64_rem_u
  | I64_and
  | I64_or
  | I64_xor
  | I64_shl
  | I64_shr_s
  | I64_shr_u
  | I64_rotl
  | I64_rotr
  | F32_add
  | F32_sub
  | F32_mul
  | F32_div
  | F32_min
  | F32_max
  | F32_copysign
  | F64_add
  | F64_sub
  | F64_mul
  | F64_div
  | F64_min
  | F64_max
  | F64_copysign

  (* Predicates *)
  | I32_eqz
  | I64_eqz

  (* Comparisons *)
  | I32_eq
  | I32_ne
  | I32_lt_s
  | I32_lt_u
  | I32_le_s
  | I32_le_u
  | I32_gt_s
  | I32_gt_u
  | I32_ge_s
  | I32_ge_u
  | I64_eq
  | I64_ne
  | I64_lt_s
  | I64_lt_u
  | I64_le_s
  | I64_le_u
  | I64_gt_s
  | I64_gt_u
  | I64_ge_s
  | I64_ge_u
  | F32_eq
  | F32_ne
  | F32_lt
  | F32_le
  | F32_gt
  | F32_ge
  | F64_eq
  | F64_ne
  | F64_lt
  | F64_le
  | F64_gt
  | F64_ge

  (* Conversions *)
  | I32_wrap_i64
  | I32_trunc_s_f32
  | I32_trunc_u_f32
  | I32_trunc_s_f64
  | I32_trunc_u_f64
  | I64_extend_s_i32
  | I64_extend_u_i32
  | I64_trunc_s_f32
  | I64_trunc_u_f32
  | I64_trunc_s_f64
  | I64_trunc_u_f64
  | F32_convert_s_i32
  | F32_convert_u_i32
  | F32_convert_s_i64
  | F32_convert_u_i64
  | F32_demote_f64
  | F64_convert_s_i32
  | F64_convert_u_i32
  | F64_convert_s_i64
  | F64_convert_u_i64
  | F64_promote_f32
  | I32_reinterpret_f32
  | I64_reinterpret_f64
  | F32_reinterpret_i32
  | F64_reinterpret_i64

  (* Host queries *)
  | Current_memory
  | Grow_memory


(* Functions *)

type func = func' Source.phrase
and func' =
{
  ftype : var;
  locals : Types.value_type list;
  body : expr list;
}


(* Modules *)

type module_ = module' Source.phrase
and module' =
{
  memory : Kernel.memory option;
  types : Types.func_type list;
  funcs : func list;
  start : var option;
  imports : Kernel.import list;
  exports : Kernel.export list;
  table : var list;
}
