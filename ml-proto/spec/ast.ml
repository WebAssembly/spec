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
  | Drop of expr
  | Block of expr list
  | Loop of expr list
  | Br of var * expr option
  | Br_if of var * expr option * expr
  | Br_table of var list * var * expr option * expr
  | Return of expr option
  | If of expr * expr list * expr list
  | Select of expr * expr * expr
  | Call of var * expr list
  | Call_import of var * expr list
  | Call_indirect of var * expr * expr list

  (* Variables *)
  | Get_local of var
  | Set_local of var * expr
  | Tee_local of var * expr
  | Get_global of var
  | Set_global of var * expr

  (* Memory access *)
  | I32_load of Memory.offset * int * expr
  | I64_load of Memory.offset * int * expr
  | F32_load of Memory.offset * int * expr
  | F64_load of Memory.offset * int * expr
  | I32_store of Memory.offset * int * expr * expr
  | I64_store of Memory.offset * int * expr * expr
  | F32_store of Memory.offset * int * expr * expr
  | F64_store of Memory.offset * int * expr * expr
  | I32_load8_s of Memory.offset * int * expr
  | I32_load8_u of Memory.offset * int * expr
  | I32_load16_s of Memory.offset * int * expr
  | I32_load16_u of Memory.offset * int * expr
  | I64_load8_s of Memory.offset * int * expr
  | I64_load8_u of Memory.offset * int * expr
  | I64_load16_s of Memory.offset * int * expr
  | I64_load16_u of Memory.offset * int * expr
  | I64_load32_s of Memory.offset * int * expr
  | I64_load32_u of Memory.offset * int * expr
  | I32_store8 of Memory.offset * int * expr * expr
  | I32_store16 of Memory.offset * int * expr * expr
  | I64_store8 of Memory.offset * int * expr * expr
  | I64_store16 of Memory.offset * int * expr * expr
  | I64_store32 of Memory.offset * int * expr * expr

  (* Unary arithmetic *)
  | I32_clz of expr
  | I32_ctz of expr
  | I32_popcnt of expr
  | I64_clz of expr
  | I64_ctz of expr
  | I64_popcnt of expr
  | F32_neg of expr
  | F32_abs of expr
  | F32_sqrt of expr
  | F32_ceil of expr
  | F32_floor of expr
  | F32_trunc of expr
  | F32_nearest of expr
  | F64_neg of expr
  | F64_abs of expr
  | F64_sqrt of expr
  | F64_ceil of expr
  | F64_floor of expr
  | F64_trunc of expr
  | F64_nearest of expr

  (* Binary arithmetic *)
  | I32_add of expr * expr
  | I32_sub of expr * expr
  | I32_mul of expr * expr
  | I32_div_s of expr * expr
  | I32_div_u of expr * expr
  | I32_rem_s of expr * expr
  | I32_rem_u of expr * expr
  | I32_and of expr * expr
  | I32_or of expr * expr
  | I32_xor of expr * expr
  | I32_shl of expr * expr
  | I32_shr_s of expr * expr
  | I32_shr_u of expr * expr
  | I32_rotl of expr * expr
  | I32_rotr of expr * expr
  | I64_add of expr * expr
  | I64_sub of expr * expr
  | I64_mul of expr * expr
  | I64_div_s of expr * expr
  | I64_div_u of expr * expr
  | I64_rem_s of expr * expr
  | I64_rem_u of expr * expr
  | I64_and of expr * expr
  | I64_or of expr * expr
  | I64_xor of expr * expr
  | I64_shl of expr * expr
  | I64_shr_s of expr * expr
  | I64_shr_u of expr * expr
  | I64_rotl of expr * expr
  | I64_rotr of expr * expr
  | F32_add of expr * expr
  | F32_sub of expr * expr
  | F32_mul of expr * expr
  | F32_div of expr * expr
  | F32_min of expr * expr
  | F32_max of expr * expr
  | F32_copysign of expr * expr
  | F64_add of expr * expr
  | F64_sub of expr * expr
  | F64_mul of expr * expr
  | F64_div of expr * expr
  | F64_min of expr * expr
  | F64_max of expr * expr
  | F64_copysign of expr * expr

  (* Predicates *)
  | I32_eqz of expr
  | I64_eqz of expr

  (* Comparisons *)
  | I32_eq of expr * expr
  | I32_ne of expr * expr
  | I32_lt_s of expr * expr
  | I32_lt_u of expr * expr
  | I32_le_s of expr * expr
  | I32_le_u of expr * expr
  | I32_gt_s of expr * expr
  | I32_gt_u of expr * expr
  | I32_ge_s of expr * expr
  | I32_ge_u of expr * expr
  | I64_eq of expr * expr
  | I64_ne of expr * expr
  | I64_lt_s of expr * expr
  | I64_lt_u of expr * expr
  | I64_le_s of expr * expr
  | I64_le_u of expr * expr
  | I64_gt_s of expr * expr
  | I64_gt_u of expr * expr
  | I64_ge_s of expr * expr
  | I64_ge_u of expr * expr
  | F32_eq of expr * expr
  | F32_ne of expr * expr
  | F32_lt of expr * expr
  | F32_le of expr * expr
  | F32_gt of expr * expr
  | F32_ge of expr * expr
  | F64_eq of expr * expr
  | F64_ne of expr * expr
  | F64_lt of expr * expr
  | F64_le of expr * expr
  | F64_gt of expr * expr
  | F64_ge of expr * expr

  (* Conversions *)
  | I32_wrap_i64 of expr
  | I32_trunc_s_f32 of expr
  | I32_trunc_u_f32 of expr
  | I32_trunc_s_f64 of expr
  | I32_trunc_u_f64 of expr
  | I64_extend_s_i32 of expr
  | I64_extend_u_i32 of expr
  | I64_trunc_s_f32 of expr
  | I64_trunc_u_f32 of expr
  | I64_trunc_s_f64 of expr
  | I64_trunc_u_f64 of expr
  | F32_convert_s_i32 of expr
  | F32_convert_u_i32 of expr
  | F32_convert_s_i64 of expr
  | F32_convert_u_i64 of expr
  | F32_demote_f64 of expr
  | F64_convert_s_i32 of expr
  | F64_convert_u_i32 of expr
  | F64_convert_s_i64 of expr
  | F64_convert_u_i64 of expr
  | F64_promote_f32 of expr
  | I32_reinterpret_f32 of expr
  | I64_reinterpret_f64 of expr
  | F32_reinterpret_i32 of expr
  | F64_reinterpret_i64 of expr

  (* Host queries *)
  | Current_memory
  | Grow_memory of expr


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
  globals : Types.value_type list;
  funcs : func list;
  start : var option;
  imports : Kernel.import list;
  exports : Kernel.export list;
  table : var list;
}
