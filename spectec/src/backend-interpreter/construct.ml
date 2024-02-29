open Reference_interpreter
open Ast
open Types
open Value
open Al.Ast
open Al.Al_util
open Source
open Util

(* Constant *)

let default_table_max = 4294967295L
let default_memory_max = 65536L
let version = ref 3


(* Failure *)

let fail ty v =
  Al.Print.structured_string_of_value v
  |> Printf.sprintf "Invalid %s: %s" ty
  |> failwith

let fail_list ty l = listV_of_list l |> fail ty


(* Destruct *)

(* Destruct data structure *)

let al_to_opt (f: value -> 'a) (v: value): 'a option = unwrap_optv v |> Option.map f
let al_to_list (f: value -> 'a) (v: value): 'a list =
  unwrap_listv v |> (!) |> Array.to_list |> List.map f
let al_to_seq f s = al_to_list f s |> List.to_seq
let al_to_phrase (f: value -> 'a) (v: value): 'a phrase = f v @@ no_region


(* Destruct minor *)

type layout = { width : int; exponent : int; mantissa : int }
let layout32 = { width = 32; exponent = 8; mantissa = 23 }
let layout64 = { width = 64; exponent = 11; mantissa = 52 }

let mask_sign layout = Z.shift_left Z.one (layout.width - 1)
let mask_mag layout = Z.pred (mask_sign layout)
let mask_mant layout = Z.(pred (shift_left one layout.mantissa))
let mask_exp layout = Z.(mask_mag layout - mask_mant layout)
let bias layout = let em1 = layout.exponent - 1 in Z.((one + one)**em1 - one)

let al_to_z: value -> Z.t = unwrap_numv
let z_to_intN signed unsigned z = if z < Z.zero then signed z else unsigned z

let al_to_fmagN layout = function
  | CaseV ("NORM", [ m; n ]) ->
    Z.(shift_left (al_to_z n + bias layout) layout.mantissa + al_to_z m)
  | CaseV ("SUBNORM", [ m ]) -> al_to_z m
  | CaseV ("INF", []) -> mask_exp layout
  | CaseV ("NAN", [ m ]) -> Z.(mask_exp layout + al_to_z m)
  | v -> fail "al_to_fmagN" v

let al_to_floatN layout = function
  | CaseV ("POS", [ mag ]) -> al_to_fmagN layout mag
  | CaseV ("NEG", [ mag ]) -> Z.(mask_sign layout + al_to_fmagN layout mag)
  | v -> fail "al_to_floatN" v

let e64 = Z.(shift_left one 64)
let z_to_vec128 i =
  let hi, lo = Z.div_rem i e64 in
  V128.I64x2.of_lanes [Z.to_int64_unsigned lo; Z.to_int64_unsigned hi]

let al_to_int (v: value): int = al_to_z v |> Z.to_int
let al_to_int32 (v: value): I32.t = al_to_z v |> z_to_intN Z.to_int32 Z.to_int32_unsigned
let al_to_int64 (v: value): I64.t = al_to_z v |> z_to_intN Z.to_int64 Z.to_int64_unsigned
let al_to_float32 (v: value): F32.t = al_to_floatN layout32 v |> Z.to_int32_unsigned |> F32.of_bits
let al_to_float64 (v: value): F64.t = al_to_floatN layout64 v |> Z.to_int64_unsigned |> F64.of_bits
let al_to_vec128 (v: value): V128.t = al_to_z v |> z_to_vec128
let al_to_idx: value -> idx = al_to_phrase al_to_int32
let al_to_byte (v: value): Char.t = al_to_int v |> Char.chr
let al_to_bytes (v: value): string = al_to_seq al_to_byte v |> String.of_seq
let al_to_string = function
  | TextV str -> str
  | v -> fail "text" v
let al_to_name name = name |> al_to_string |> Utf8.decode
let al_to_bool = unwrap_boolv


(* Destruct type *)

let al_to_null: value -> null = function
  | CaseV ("NULL", [ OptV None ]) -> NoNull
  | CaseV ("NULL", [ OptV _ ]) -> Null
  | v -> fail "null" v

let al_to_final: value -> final = function
  | CaseV ("FINAL", [ OptV None ]) -> NoFinal
  | CaseV ("FINAL", [ OptV _ ]) -> Final
  | v -> fail "final" v

let al_to_mut: value -> mut = function
  | CaseV ("MUT", [ OptV None ]) -> Cons
  | CaseV ("MUT", [ OptV _ ]) -> Var
  | v -> fail "mut" v

let rec al_to_storage_type: value -> storage_type = function
  | CaseV ("I8", []) -> PackStorageT Pack8
  | CaseV ("I16", []) -> PackStorageT Pack16
  | v -> ValStorageT (al_to_val_type v)

and al_to_field_type: value -> field_type = function
  | TupV [ mut; st ] -> FieldT (al_to_mut mut, al_to_storage_type st)
  | v -> fail "field type" v

and al_to_result_type: value -> result_type = function
  v -> al_to_list al_to_val_type v

and al_to_str_type: value -> str_type = function
  | CaseV ("STRUCT", [ ftl ]) -> DefStructT (StructT (al_to_list al_to_field_type ftl))
  | CaseV ("ARRAY", [ ft ]) -> DefArrayT (ArrayT (al_to_field_type ft))
  | CaseV ("FUNC", [ TupV [ rt1; rt2 ] ]) ->
    DefFuncT (FuncT (al_to_result_type rt1, (al_to_result_type rt2)))
  | v -> fail "str type" v

and al_to_sub_type: value -> sub_type = function
  | CaseV ("SUBD", [ fin; htl; st ]) ->
    SubT (al_to_final fin, al_to_list al_to_heap_type htl, al_to_str_type st)
  | v -> fail "sub type" v

and al_to_rec_type: value -> rec_type = function
  | CaseV ("REC", [ stl ]) -> RecT (al_to_list al_to_sub_type stl)
  | v -> fail "rec type" v

and al_to_def_type: value -> def_type = function
  | CaseV ("DEF", [ rt; i32 ]) -> DefT (al_to_rec_type rt, al_to_int32 i32)
  | v -> fail "def type" v

and al_to_heap_type: value -> heap_type = function
  | CaseV ("_IDX", [ i32 ]) -> VarHT (StatX (al_to_int32 i32))
  | CaseV ("REC", [ i32 ]) -> VarHT (RecX (al_to_int32 i32))
  | CaseV ("DEF", _) as v -> DefHT (al_to_def_type v)
  | CaseV (tag, []) as v ->
    (match tag with
    | "BOT" -> BotHT
    | "ANY" -> AnyHT
    | "NONE" -> NoneHT
    | "EQ" -> EqHT
    | "I31" -> I31HT
    | "STRUCT" -> StructHT
    | "ARRAY" -> ArrayHT
    | "FUNC" | "FUNCREF" -> FuncHT
    | "NOFUNC" -> NoFuncHT
    | "EXTERN" | "EXTERNREF" -> ExternHT
    | "NOEXTERN" -> NoExternHT
    | _ -> fail "abstract heap type" v)
  | v -> fail "heap type" v

and al_to_ref_type: value -> ref_type = function
  | CaseV ("REF", [ n; ht ]) -> al_to_null n, al_to_heap_type ht
  | v -> fail "ref type" v

and al_to_num_type: value -> num_type = function
  | CaseV ("I32", []) -> I32T
  | CaseV ("I64", []) -> I64T
  | CaseV ("F32", []) -> F32T
  | CaseV ("F64", []) -> F64T
  | v -> fail "num type" v

and al_to_val_type: value -> val_type = function
  | CaseV ("I32", _) | CaseV ("I64", _)
  | CaseV ("F32", _) | CaseV ("F64", _) as v -> NumT (al_to_num_type v)
  | CaseV ("V128", []) -> VecT V128T
  | CaseV ("REF", _) as v -> RefT (al_to_ref_type v)
  | CaseV ("BOT", []) -> BotT
  | v -> fail "val type" v

let al_to_block_type: value -> block_type = function
  | CaseV ("_IDX", [ idx ]) -> VarBlockType (al_to_idx idx)
  | CaseV ("_RESULT", [ vt_opt ]) -> ValBlockType (al_to_opt al_to_val_type vt_opt)
  | v -> fail "block type" v

let al_to_limits (default: int64): value -> int32 limits = function
  | TupV [ min; max ] ->
    let max' =
      match al_to_int64 max with
      | i64 when default = i64 -> None
      | _ -> Some (al_to_int32 max)
    in
    { min = al_to_int32 min; max = max' }
  | v -> fail "limits" v


let al_to_global_type: value -> global_type = function
  | TupV [ mut; vt ] -> GlobalT (al_to_mut mut, al_to_val_type vt)
  | v -> fail "global type" v

let al_to_table_type: value -> table_type = function
  | TupV [ limits; rt ] -> TableT (al_to_limits default_table_max limits, al_to_ref_type rt)
  | v -> fail "table type" v

let al_to_memory_type: value -> memory_type = function
  | CaseV ("I8", [ limits ]) -> MemoryT (al_to_limits default_memory_max limits)
  | v -> fail "memory type" v


(* Destruct value *)

let rec al_to_field: value -> Aggr.field = function
  | CaseV ("PACK", [pack_size; c]) ->
    (* TODO: fix bug in packsize *)
    let pack_size' =
      match pack_size with
      | CaseV ("I8", []) -> Pack.Pack8
      | CaseV ("I16", []) -> Pack.Pack16
      | CaseV ("I32", []) -> Pack.Pack32
      | CaseV ("I64", []) -> Pack.Pack64
      | v -> fail "packsize" v
    in
    Aggr.PackField (pack_size', ref (al_to_int c))
  | v -> Aggr.ValField (ref (al_to_value v))

and al_to_array: value -> Aggr.array = function
  | StrV r when Record.mem "TYPE" r && Record.mem "FIELD" r ->
    Aggr.Array (
      al_to_def_type (Record.find "TYPE" r),
      al_to_list al_to_field (Record.find "FIELD" r)
    )
  | v -> fail "array" v

and al_to_struct: value -> Aggr.struct_ = function
  | StrV r when Record.mem "TYPE" r && Record.mem "FIELD" r ->
    Aggr.Struct (
      al_to_def_type (Record.find "TYPE" r),
      al_to_list al_to_field (Record.find "FIELD" r)
    )
  | v -> fail "struct" v

and al_to_num: value -> num = function
  | CaseV ("CONST", [ CaseV ("I32", []); i32 ]) -> I32 (al_to_int32 i32)
  | CaseV ("CONST", [ CaseV ("I64", []); i64 ]) -> I64 (al_to_int64 i64)
  | CaseV ("CONST", [ CaseV ("F32", []); f32 ]) -> F32 (al_to_float32 f32)
  | CaseV ("CONST", [ CaseV ("F64", []); f64 ]) -> F64 (al_to_float64 f64)
  | v -> fail "num" v

and al_to_vec: value -> vec = function
  | CaseV ("VCONST", [ CaseV ("V128", []); v128 ]) -> V128 (al_to_vec128 v128)
  | v -> fail "vec" v

and al_to_ref: value -> ref_ = function
  | CaseV ("REF.NULL", [ ht ]) -> NullRef (al_to_heap_type ht)
  | CaseV ("REF.HOST_ADDR", [ i32 ]) -> Script.HostRef (al_to_int32 i32)
  | CaseV ("REF.I31_NUM", [ i ]) -> I31.I31Ref (al_to_int i)
  | CaseV ("REF.STRUCT_ADDR", [ addr ]) ->
    let struct_insts = Ds.Store.access "STRUCT" in
    let struct_ = addr |> al_to_int |> listv_nth struct_insts |> al_to_struct in
    Aggr.StructRef struct_
  | CaseV ("REF.ARRAY_ADDR", [ addr ]) ->
    let arr_insts = Ds.Store.access "ARRAY" in
    let arr = addr |> al_to_int |> listv_nth arr_insts |> al_to_array in
    Aggr.ArrayRef arr
  | CaseV ("REF.EXTERN", [ r ]) -> Extern.ExternRef (al_to_ref r)
  | v -> fail "ref" v

and al_to_value: value -> Value.value = function
  | CaseV ("CONST", _) as v -> Num (al_to_num v)
  | CaseV (ref_, _) as v when String.sub ref_ 0 4 = "REF." -> Ref (al_to_ref v)
  | CaseV ("VCONST", _) as v -> Vec (al_to_vec v)
  | v -> fail "value" v


(* Destruct operator *)

let al_to_op f1 f2 = function
  | [ CaseV ("I32", []); op ] -> I32 (f1 op)
  | [ CaseV ("I64", []); op ] -> I64 (f1 op)
  | [ CaseV ("F32", []); op ] -> F32 (f2 op)
  | [ CaseV ("F64", []); op ] -> F64 (f2 op)
  | l -> fail_list "op" l

let al_to_int_unop: value -> IntOp.unop = function
  | CaseV ("CLZ", []) -> IntOp.Clz
  | CaseV ("CTZ", []) -> IntOp.Ctz
  | CaseV ("POPCNT", []) -> IntOp.Popcnt
  | CaseV ("EXTEND", [NumV z]) when z = Z.of_int 8 -> IntOp.ExtendS Pack.Pack8
  | CaseV ("EXTEND", [NumV z]) when z = Z.of_int 16 -> IntOp.ExtendS Pack.Pack16
  | CaseV ("EXTEND", [NumV z]) when z = Z.of_int 32 -> IntOp.ExtendS Pack.Pack32
  | CaseV ("EXTEND", [NumV z]) when z = Z.of_int 64 -> IntOp.ExtendS Pack.Pack64
  | v -> fail "integer unop" v
let al_to_float_unop: value -> FloatOp.unop = function
  | CaseV ("NEG", []) -> FloatOp.Neg
  | CaseV ("ABS", []) -> FloatOp.Abs
  | CaseV ("CEIL", []) -> FloatOp.Ceil
  | CaseV ("FLOOR", []) -> FloatOp.Floor
  | CaseV ("TRUNC", []) -> FloatOp.Trunc
  | CaseV ("NEAREST", []) -> FloatOp.Nearest
  | CaseV ("SQRT", []) -> FloatOp.Sqrt
  | v -> fail "float unop" v
let al_to_unop: value list -> Ast.unop = al_to_op al_to_int_unop al_to_float_unop

let al_to_int_binop: value -> IntOp.binop = function
  | CaseV ("ADD", []) -> IntOp.Add
  | CaseV ("SUB", []) -> IntOp.Sub
  | CaseV ("MUL", []) -> IntOp.Mul
  | CaseV ("DIV", [CaseV ("S", [])]) -> IntOp.DivS
  | CaseV ("DIV", [CaseV ("U", [])]) -> IntOp.DivU
  | CaseV ("REM", [CaseV ("S", [])]) -> IntOp.RemS
  | CaseV ("REM", [CaseV ("U", [])]) -> IntOp.RemU
  | CaseV ("AND", []) -> IntOp.And
  | CaseV ("OR", []) -> IntOp.Or
  | CaseV ("XOR", []) -> IntOp.Xor
  | CaseV ("SHL", []) -> IntOp.Shl
  | CaseV ("SHR", [CaseV ("S", [])]) -> IntOp.ShrS
  | CaseV ("SHR", [CaseV ("U", [])]) -> IntOp.ShrU
  | CaseV ("ROTL", []) -> IntOp.Rotl
  | CaseV ("ROTR", []) -> IntOp.Rotr
  | v -> fail "integer binop" v
let al_to_float_binop: value -> FloatOp.binop = function
  | CaseV ("ADD", []) -> FloatOp.Add
  | CaseV ("SUB", []) -> FloatOp.Sub
  | CaseV ("MUL", []) -> FloatOp.Mul
  | CaseV ("DIV", []) -> FloatOp.Div
  | CaseV ("MIN", []) -> FloatOp.Min
  | CaseV ("MAX", []) -> FloatOp.Max
  | CaseV ("COPYSIGN", []) -> FloatOp.CopySign
  | v -> fail "float binop" v
let al_to_binop: value list -> Ast.binop = al_to_op al_to_int_binop al_to_float_binop

let al_to_int_testop: value -> IntOp.testop = function
  | CaseV ("EQZ", []) -> IntOp.Eqz
  | v -> fail "integer testop" v
let al_to_testop: value list -> Ast.testop = function
  | [ CaseV ("I32", []); op ] -> Value.I32 (al_to_int_testop op)
  | [ CaseV ("I64", []); op ] -> Value.I64 (al_to_int_testop op)
  | l -> fail_list "testop" l

let al_to_int_relop: value -> IntOp.relop = function
  | CaseV ("EQ", []) -> IntOp.Eq
  | CaseV ("NE", []) -> IntOp.Ne
  | CaseV ("LT", [CaseV ("S", [])]) -> IntOp.LtS
  | CaseV ("LT", [CaseV ("U", [])]) -> IntOp.LtU
  | CaseV ("GT", [CaseV ("S", [])]) -> IntOp.GtS
  | CaseV ("GT", [CaseV ("U", [])]) -> IntOp.GtU
  | CaseV ("LE", [CaseV ("S", [])]) -> IntOp.LeS
  | CaseV ("LE", [CaseV ("U", [])]) -> IntOp.LeU
  | CaseV ("GE", [CaseV ("S", [])]) -> IntOp.GeS
  | CaseV ("GE", [CaseV ("U", [])]) -> IntOp.GeU
  | v -> fail "integer relop" v
let al_to_float_relop: value -> FloatOp.relop = function
  | CaseV ("EQ", []) -> FloatOp.Eq
  | CaseV ("NE", []) -> FloatOp.Ne
  | CaseV ("LT", []) -> FloatOp.Lt
  | CaseV ("GT", []) -> FloatOp.Gt
  | CaseV ("LE", []) -> FloatOp.Le
  | CaseV ("GE", []) -> FloatOp.Ge
  | v -> fail "float relop" v
let al_to_relop: value list -> relop = al_to_op al_to_int_relop al_to_float_relop

let al_to_int_cvtop: value list -> IntOp.cvtop = function
  | [ CaseV ("I64", []); CaseV ("CONVERT", []); CaseV ("I32", []); opt ] as l ->
    (match opt with
    | OptV (Some (CaseV ("S", []))) -> IntOp.ExtendSI32
    | OptV (Some (CaseV ("U", []))) -> IntOp.ExtendUI32
    | _ -> fail_list "extend" l)
  | CaseV ("I32", []) :: [ CaseV ("CONVERT", []); CaseV ("I64", []); OptV None ] -> IntOp.WrapI64
  | CaseV (_, []) :: CaseV ("CONVERT", []) :: args ->
    (match args with
    | [ CaseV ("F32", []); OptV (Some (CaseV ("S", []))) ] -> IntOp.TruncSF32
    | [ CaseV ("F32", []); OptV (Some (CaseV ("U", []))) ] -> IntOp.TruncUF32
    | [ CaseV ("F64", []); OptV (Some (CaseV ("S", []))) ] -> IntOp.TruncSF64
    | [ CaseV ("F64", []); OptV (Some (CaseV ("U", []))) ] -> IntOp.TruncUF64
    | l -> fail_list "trunc" l)
  | CaseV (_, []) :: CaseV ("CONVERT_SAT", []) :: args ->
    (match args with
    | [ CaseV ("F32", []); OptV (Some (CaseV ("S", []))) ] -> IntOp.TruncSatSF32
    | [ CaseV ("F32", []); OptV (Some (CaseV ("U", []))) ] -> IntOp.TruncSatUF32
    | [ CaseV ("F64", []); OptV (Some (CaseV ("S", []))) ] -> IntOp.TruncSatSF64
    | [ CaseV ("F64", []); OptV (Some (CaseV ("U", []))) ] -> IntOp.TruncSatUF64
    | l -> fail_list "truncsat" l)
  | [ _; CaseV ("REINTERPRET", []); _; OptV None ] -> IntOp.ReinterpretFloat
  | l -> fail_list "integer cvtop" l
let al_to_float_cvtop : value list -> FloatOp.cvtop = function
  | [ CaseV (_, []); CaseV ("CONVERT", []); CaseV (nt, []); OptV (Some (CaseV (opt, []))) ] as l ->
    (match nt, opt with
    | "I32", "S" -> FloatOp.ConvertSI32
    | "I32", "U" -> FloatOp.ConvertUI32
    | "I64", "S" -> FloatOp.ConvertSI64
    | "I64", "U" -> FloatOp.ConvertUI64
    | _ -> fail_list "convert" l)
  | [ CaseV ("F64", []); CaseV ("CONVERT", []); CaseV ("F32", []); OptV None ] -> FloatOp.PromoteF32
  | [ CaseV ("F32", []); CaseV ("CONVERT", []); CaseV ("F64", []); OptV None ] -> FloatOp.DemoteF64
  | [ _; CaseV ("REINTERPRET", []); _; OptV None ] -> FloatOp.ReinterpretInt
  | l -> fail_list "float cvtop" l
let al_to_cvtop: value list -> cvtop = function
  | CaseV ("I32", []) :: _ as op -> I32 (al_to_int_cvtop op)
  | CaseV ("I64", []) :: _ as op -> I64 (al_to_int_cvtop op)
  | CaseV ("F32", []) :: _ as op -> F32 (al_to_float_cvtop op)
  | CaseV ("F64", []) :: _ as op -> F64 (al_to_float_cvtop op)
  | l -> fail_list "cvtop" l

(* Vector operator *)

let two = Z.of_int 2
let four = Z.of_int 4
let eight = Z.of_int 8
let sixteen = Z.of_int 16
let thirtytwo = Z.of_int 32
let sixtyfour = Z.of_int 64

let al_to_extension : value -> Pack.extension = function
  | CaseV ("S", []) -> Pack.SX
  | CaseV ("U", []) -> Pack.ZX
  | v -> fail "extension" v

let al_to_vop f1 f2 = function
  | [ TupV [ CaseV ("I8", []); NumV z ]; vop ] when z = sixteen -> V128 (V128.I8x16 (f1 vop))
  | [ TupV [ CaseV ("I16", []); NumV z ]; vop ] when z = eight -> V128 (V128.I16x8 (f1 vop))
  | [ TupV [ CaseV ("I32", []); NumV z ]; vop ] when z = four -> V128 (V128.I32x4 (f1 vop))
  | [ TupV [ CaseV ("I64", []); NumV z ]; vop ] when z = two -> V128 (V128.I64x2 (f1 vop))
  | [ TupV [ CaseV ("F32", []); NumV z ]; vop ] when z = four -> V128 (V128.F32x4 (f2 vop))
  | [ TupV [ CaseV ("F64", []); NumV z ]; vop ] when z = two -> V128 (V128.F64x2 (f2 vop))
  | l -> fail_list "vop" l

let al_to_vvop f = function
  | [ CaseV ("V128", []); vop ] -> V128 (f vop)
  | l -> fail_list "vvop" l

let al_to_int_vtestop : value -> V128Op.itestop = function
  | CaseV ("ALL_TRUE", []) -> V128Op.AllTrue
  | v -> fail "integer vtestop" v

let al_to_float_vtestop : value -> Ast.void = function
  | v -> fail "float vtestop" v

let al_to_vtestop : value list -> vec_testop =
  al_to_vop al_to_int_vtestop al_to_float_vtestop

let al_to_vbitmaskop : value list -> vec_bitmaskop = function
  | [ TupV [ CaseV ("I8", []); NumV z ] ] when z = sixteen -> V128 (V128.I8x16 (V128Op.Bitmask))
  | [ TupV [ CaseV ("I16", []); NumV z ] ] when z = eight -> V128 (V128.I16x8 (V128Op.Bitmask))
  | [ TupV [ CaseV ("I32", []); NumV z ] ] when z = four -> V128 (V128.I32x4 (V128Op.Bitmask))
  | [ TupV [ CaseV ("I64", []); NumV z ] ] when z = two -> V128 (V128.I64x2 (V128Op.Bitmask))
  | l -> fail_list "vbitmaskop" l

let al_to_int_vrelop : value -> V128Op.irelop = function
  | CaseV ("EQ", []) -> V128Op.Eq
  | CaseV ("NE", []) -> V128Op.Ne
  | CaseV ("LT", [CaseV ("S", [])]) -> V128Op.LtS
  | CaseV ("LT", [CaseV ("U", [])]) -> V128Op.LtU
  | CaseV ("LE", [CaseV ("S", [])]) -> V128Op.LeS
  | CaseV ("LE", [CaseV ("U", [])]) -> V128Op.LeU
  | CaseV ("GT", [CaseV ("S", [])]) -> V128Op.GtS
  | CaseV ("GT", [CaseV ("U", [])]) -> V128Op.GtU
  | CaseV ("GE", [CaseV ("S", [])]) -> V128Op.GeS
  | CaseV ("GE", [CaseV ("U", [])]) -> V128Op.GeU
  | v -> fail "integer vrelop" v

let al_to_float_vrelop : value -> V128Op.frelop = function
  | CaseV ("EQ", []) -> V128Op.Eq
  | CaseV ("NE", []) -> V128Op.Ne
  | CaseV ("LT", []) -> V128Op.Lt
  | CaseV ("LE", []) -> V128Op.Le
  | CaseV ("GT", []) -> V128Op.Gt
  | CaseV ("GE", []) -> V128Op.Ge
  | v -> fail "float vrelop" v

let al_to_vrelop : value list -> vec_relop =
  al_to_vop al_to_int_vrelop al_to_float_vrelop

let al_to_int_vunop : value -> V128Op.iunop = function
  | CaseV ("ABS", []) -> V128Op.Abs
  | CaseV ("NEG", []) -> V128Op.Neg
  | CaseV ("POPCNT", []) -> V128Op.Popcnt
  | v -> fail "integer vunop" v

let al_to_float_vunop : value -> V128Op.funop = function
  | CaseV ("ABS", []) -> V128Op.Abs
  | CaseV ("NEG", []) -> V128Op.Neg
  | CaseV ("SQRT", []) -> V128Op.Sqrt
  | CaseV ("CEIL", []) -> V128Op.Ceil
  | CaseV ("FLOOR", []) -> V128Op.Floor
  | CaseV ("TRUNC", []) -> V128Op.Trunc
  | CaseV ("NEAREST", []) -> V128Op.Nearest
  | v -> fail "float vunop" v

let al_to_vunop : value list -> vec_unop =
  al_to_vop al_to_int_vunop al_to_float_vunop

let al_to_int_vbinop : value -> V128Op.ibinop = function
  | CaseV ("ADD", []) -> V128Op.Add
  | CaseV ("SUB", []) -> V128Op.Sub
  | CaseV ("MUL", []) -> V128Op.Mul
  | CaseV ("MIN", [CaseV ("S", [])]) -> V128Op.MinS
  | CaseV ("MIN", [CaseV ("U", [])]) -> V128Op.MinU
  | CaseV ("MAX", [CaseV ("S", [])]) -> V128Op.MaxS
  | CaseV ("MAX", [CaseV ("U", [])]) -> V128Op.MaxU
  | CaseV ("AVGR_U", []) -> V128Op.AvgrU
  | CaseV ("ADD_SAT", [CaseV ("S", [])]) -> V128Op.AddSatS
  | CaseV ("ADD_SAT", [CaseV ("U", [])]) -> V128Op.AddSatU
  | CaseV ("SUB_SAT", [CaseV ("S", [])]) -> V128Op.SubSatS
  | CaseV ("SUB_SAT", [CaseV ("U", [])]) -> V128Op.SubSatU
  | CaseV ("DOTS", []) -> V128Op.DotS
  | CaseV ("Q15MULR_SAT_S", []) -> V128Op.Q15MulRSatS
  | CaseV ("SWIZZLE", []) -> V128Op.Swizzle
  (*TODO *)
  | CaseV ("Shuffle", [ l ]) -> V128Op.Shuffle (al_to_list al_to_int l)
  | v -> fail "integer vbinop" v

let al_to_float_vbinop : value -> V128Op.fbinop = function
  | CaseV ("ADD", []) -> V128Op.Add
  | CaseV ("SUB", []) -> V128Op.Sub
  | CaseV ("MUL", []) -> V128Op.Mul
  | CaseV ("DIV", []) -> V128Op.Div
  | CaseV ("MIN", []) -> V128Op.Min
  | CaseV ("MAX", []) -> V128Op.Max
  | CaseV ("PMIN", []) -> V128Op.Pmin
  | CaseV ("PMAX", []) -> V128Op.Pmax
  | v -> fail "float vbinop" v

let al_to_vbinop : value list -> vec_binop = al_to_vop al_to_int_vbinop al_to_float_vbinop

let al_to_special_vbinop = function
  | CaseV ("VSWIZZLE", [ TupV [ CaseV ("I8", []); NumV z ]; ]) when z = sixteen -> V128 (V128.I8x16 (V128Op.Swizzle))
  | CaseV ("VSHUFFLE", [ TupV [ CaseV ("I8", []); NumV z ]; l ]) when z = sixteen -> V128 (V128.I8x16 (V128Op.Shuffle (al_to_list al_to_int l)))
  | CaseV ("VNARROW", [ TupV [ CaseV ("I8", []); NumV z1 ]; TupV [ CaseV ("I16", []); NumV z2 ]; CaseV ("S", []) ]) when z1 = sixteen && z2 = eight -> V128 (V128.I8x16 (V128Op.NarrowS))
  | CaseV ("VNARROW", [ TupV [ CaseV ("I16", []); NumV z1 ]; TupV [ CaseV ("I32", []); NumV z2 ]; CaseV ("S", []) ]) when z1 = eight && z2 = four -> V128 (V128.I16x8 (V128Op.NarrowS))
  | CaseV ("VNARROW", [ TupV [ CaseV ("I8", []); NumV z1 ]; TupV [ CaseV ("I16", []); NumV z2 ]; CaseV ("U", []) ]) when z1 = sixteen && z2 = eight -> V128 (V128.I8x16 (V128Op.NarrowU))
  | CaseV ("VNARROW", [ TupV [ CaseV ("I16", []); NumV z1 ]; TupV [ CaseV ("I32", []); NumV z2 ]; CaseV ("U", []) ]) when z1 = eight && z2 = four -> V128 (V128.I16x8 (V128Op.NarrowU))
  | CaseV ("VEXTMUL", [ TupV [ CaseV ("I16", []); NumV z1 ]; CaseV ("HIGH", []); TupV [ CaseV ("I8", []); NumV z2 ]; CaseV ("S", []) ]) when z1 = eight && z2 = sixteen -> V128 (V128.I16x8 (V128Op.ExtMulHighS))
  | CaseV ("VEXTMUL", [ TupV [ CaseV ("I16", []); NumV z1 ]; CaseV ("HIGH", []); TupV [ CaseV ("I8", []); NumV z2 ]; CaseV ("U", []) ]) when z1 = eight && z2 = sixteen -> V128 (V128.I16x8 (V128Op.ExtMulHighU))
  | CaseV ("VEXTMUL", [ TupV [ CaseV ("I16", []); NumV z1 ]; CaseV ("LOW", []); TupV [ CaseV ("I8", []); NumV z2 ]; CaseV ("S", []) ]) when z1 = eight && z2 = sixteen -> V128 (V128.I16x8 (V128Op.ExtMulLowS))
  | CaseV ("VEXTMUL", [ TupV [ CaseV ("I16", []); NumV z1 ]; CaseV ("LOW", []); TupV [ CaseV ("I8", []); NumV z2 ]; CaseV ("U", []) ] ) when z1 = eight && z2 = sixteen -> V128 (V128.I16x8 (V128Op.ExtMulLowU))
  | CaseV ("VEXTMUL", [ TupV [ CaseV ("I32", []); NumV z1 ]; CaseV ("HIGH", []); TupV [ CaseV ("I16", []); NumV z2 ]; CaseV ("S", []) ]) when z1 = four && z2 = eight -> V128 (V128.I32x4 (V128Op.ExtMulHighS))
  | CaseV ("VEXTMUL", [ TupV [ CaseV ("I32", []); NumV z1 ]; CaseV ("HIGH", []); TupV [ CaseV ("I16", []); NumV z2 ]; CaseV ("U", []) ]) when z1 = four && z2 = eight -> V128 (V128.I32x4 (V128Op.ExtMulHighU))
  | CaseV ("VEXTMUL", [ TupV [ CaseV ("I32", []); NumV z1 ]; CaseV ("LOW", []); TupV [ CaseV ("I16", []); NumV z2 ]; CaseV ("S", []) ]) when z1 = four && z2 = eight -> V128 (V128.I32x4 (V128Op.ExtMulLowS))
  | CaseV ("VEXTMUL", [ TupV [ CaseV ("I32", []); NumV z1 ]; CaseV ("LOW", []); TupV [ CaseV ("I16", []); NumV z2 ]; CaseV ("U", []) ] ) when z1 = four && z2 = eight -> V128 (V128.I32x4 (V128Op.ExtMulLowU))
  | CaseV ("VEXTMUL", [ TupV [ CaseV ("I64", []); NumV z1 ]; CaseV ("HIGH", []); TupV [ CaseV ("I32", []); NumV z2 ]; CaseV ("S", []) ]) when z1 = two && z2 = four -> V128 (V128.I64x2 (V128Op.ExtMulHighS))
  | CaseV ("VEXTMUL", [ TupV [ CaseV ("I64", []); NumV z1 ]; CaseV ("HIGH", []); TupV [ CaseV ("I32", []); NumV z2 ]; CaseV ("U", []) ]) when z1 = two && z2 = four -> V128 (V128.I64x2 (V128Op.ExtMulHighU))
  | CaseV ("VEXTMUL", [ TupV [ CaseV ("I64", []); NumV z1 ]; CaseV ("LOW", []); TupV [ CaseV ("I32", []); NumV z2 ]; CaseV ("S", []) ]) when z1 = two && z2 = four -> V128 (V128.I64x2 (V128Op.ExtMulLowS))
  | CaseV ("VEXTMUL", [ TupV [ CaseV ("I64", []); NumV z1 ]; CaseV ("LOW", []); TupV [ CaseV ("I32", []); NumV z2 ]; CaseV ("U", []) ] ) when z1 = two && z2 = four -> V128 (V128.I64x2 (V128Op.ExtMulLowU))
  | CaseV ("VDOT", [ TupV [ CaseV ("I32", []); NumV z1 ]; TupV [ CaseV ("I16", []); NumV z2 ]; CaseV ("S", []) ]) when z1 = four && z2 = eight -> V128 (V128.I32x4 (V128Op.DotS))
  | v -> fail "special vbinop" v

let al_to_int_vcvtop : value list -> V128Op.icvtop = function
  | [ CaseV (op, []); OptV half; sh; OptV ext; CaseV ("ZERO", [OptV _]) ] as l -> (
    match op with
    | "EXTEND" -> (
      match half, ext with
      | Some (CaseV ("LOW", [])), Some (CaseV ("S", [])) -> V128Op.ExtendLowS
      | Some (CaseV ("LOW", [])), Some (CaseV ("U", [])) -> V128Op.ExtendLowU
      | Some (CaseV ("HIGH", [])), Some (CaseV ("S", [])) -> V128Op.ExtendHighS
      | Some (CaseV ("HIGH", [])), Some (CaseV ("U", [])) -> V128Op.ExtendHighU
      | _ -> fail_list "integer vcvtop" l
    )
    | "TRUNC_SAT" -> (
      match sh, ext with
      | TupV [ CaseV ("F32", []); NumV z ], Some (CaseV ("S", [])) when z = four -> V128Op.TruncSatSF32x4
      | TupV [ CaseV ("F32", []); NumV z ], Some (CaseV ("U", [])) when z = four -> V128Op.TruncSatUF32x4
      | TupV [ CaseV ("F64", []); NumV z ], Some (CaseV ("S", [])) when z = two -> V128Op.TruncSatSZeroF64x2
      | TupV [ CaseV ("F64", []); NumV z ], Some (CaseV ("U", [])) when z = two -> V128Op.TruncSatUZeroF64x2
      | _ -> fail_list "integer vcvtop" l
    )
    | _ -> fail_list "integer vcvtop" l
  )
  | l -> fail_list "integer vcvtop" l

let al_to_float_vcvtop : value list -> V128Op.fcvtop = function
  | [ CaseV (op, []); OptV _; _; OptV ext; CaseV ("ZERO", [OptV _]) ] as l -> (
    match op with
    | "DEMOTE" -> V128Op.DemoteZeroF64x2
    | "CONVERT" -> (
      match ext with
      | Some (CaseV ("S", [])) -> V128Op.ConvertSI32x4
      | Some (CaseV ("U", [])) -> V128Op.ConvertUI32x4
      | _ -> fail_list "float vcvtop" l
    )
    | "PROMOTE" -> V128Op.PromoteLowF32x4
    | _ -> fail_list "float vcvtop" l
  )
  | l -> fail_list "float vcvtop" l

let al_to_vcvtop : value list -> vec_cvtop = function
  | TupV [ CaseV ("I8", []); NumV z ] :: op when z = sixteen -> V128 (V128.I8x16 (al_to_int_vcvtop op))
  | TupV [ CaseV ("I16", []); NumV z ] :: op when z = eight -> V128 (V128.I16x8 (al_to_int_vcvtop op))
  | TupV [ CaseV ("I32", []); NumV z ] :: op when z = four -> V128 (V128.I32x4 (al_to_int_vcvtop op))
  | TupV [ CaseV ("I64", []); NumV z ] :: op when z = two -> V128 (V128.I64x2 (al_to_int_vcvtop op))
  | TupV [ CaseV ("F32", []); NumV z ] :: op when z = four -> V128 (V128.F32x4 (al_to_float_vcvtop op))
  | TupV [ CaseV ("F64", []); NumV z ] :: op when z = two -> V128 (V128.F64x2 (al_to_float_vcvtop op))
  | l -> fail_list "vcvtop" l

let al_to_special_vcvtop = function
  | CaseV ("VEXTADD_PAIRWISE", [ TupV [ CaseV ("I16", []); NumV z1]; TupV [ CaseV ("I8", []); NumV z2 ]; CaseV ("S", []) ]) when z1 = eight && z2 = sixteen -> V128 (V128.I16x8 (V128Op.ExtAddPairwiseS))
  | CaseV ("VEXTADD_PAIRWISE", [ TupV [ CaseV ("I16", []); NumV z1]; TupV [ CaseV ("I8", []); NumV z2 ]; CaseV ("U", []) ]) when z1 = eight && z2 = sixteen -> V128 (V128.I16x8 (V128Op.ExtAddPairwiseU))
  | CaseV ("VEXTADD_PAIRWISE", [ TupV [ CaseV ("I32", []); NumV z1]; TupV [ CaseV ("I16", []); NumV z2 ]; CaseV ("S", []) ]) when z1 = four && z2 = eight -> V128 (V128.I32x4 (V128Op.ExtAddPairwiseS))
  | CaseV ("VEXTADD_PAIRWISE", [ TupV [ CaseV ("I32", []); NumV z1]; TupV [ CaseV ("I16", []); NumV z2 ]; CaseV ("U", []) ]) when z1 = four && z2 = eight -> V128 (V128.I32x4 (V128Op.ExtAddPairwiseU))
  | v -> fail "special vcvtop" v

let al_to_int_vshiftop : value -> V128Op.ishiftop = function
  | CaseV ("SHL", []) -> V128Op.Shl
  | CaseV ("SHR", [CaseV ("S", [])]) -> V128Op.ShrS
  | CaseV ("SHR", [CaseV ("U", [])]) -> V128Op.ShrU
  | v -> fail "integer vshiftop" v
let al_to_float_vshiftop : value -> void = fail "float vshiftop"
let al_to_vshiftop : value list -> vec_shiftop = al_to_vop al_to_int_vshiftop al_to_float_vshiftop

let al_to_vvtestop' : value -> V128Op.vtestop = function
  | CaseV ("ANY_TRUE", []) -> V128Op.AnyTrue
  | v -> fail "vvtestop" v
let al_to_vvtestop : value list -> vec_vtestop = al_to_vvop al_to_vvtestop'

let al_to_vvunop' : value -> V128Op.vunop = function
  | CaseV ("NOT", []) -> V128Op.Not
  | v -> fail "vvunop" v
let al_to_vvunop : value list -> vec_vunop = al_to_vvop al_to_vvunop'

let al_to_vvbinop' = function
  | CaseV ("AND", []) -> V128Op.And
  | CaseV ("OR", []) -> V128Op.Or
  | CaseV ("XOR", []) -> V128Op.Xor
  | CaseV ("ANDNOT", []) -> V128Op.AndNot
  | v -> fail "vvbinop" v
let al_to_vvbinop : value list -> vec_vbinop = al_to_vvop al_to_vvbinop'

let al_to_vvternop' : value -> V128Op.vternop = function
  | CaseV ("BITSELECT", []) -> V128Op.Bitselect
  | v -> fail "vvternop" v
let al_to_vvternop : value list -> vec_vternop = al_to_vvop al_to_vvternop'

let al_to_vsplatop : value list -> vec_splatop = function
  | [ TupV [ CaseV ("I8", []); NumV z ] ] when z = sixteen -> V128 (V128.I8x16 Splat)
  | [ TupV [ CaseV ("I16", []); NumV z ] ] when z = eight -> V128 (V128.I16x8 Splat)
  | [ TupV [ CaseV ("I32", []); NumV z ] ] when z = four -> V128 (V128.I32x4 Splat)
  | [ TupV [ CaseV ("I64", []); NumV z ] ] when z = two -> V128 (V128.I64x2 Splat)
  | [ TupV [ CaseV ("F32", []); NumV z ] ] when z = four -> V128 (V128.F32x4 Splat)
  | [ TupV [ CaseV ("F64", []); NumV z ] ] when z = two -> V128 (V128.F64x2 Splat)
  | vl -> fail_list "vsplatop" vl

let al_to_vextractop : value list -> vec_extractop = function
  | [ TupV [ CaseV ("I8", []); NumV z ]; OptV (Some ext); n ] when z = sixteen ->
    V128 (V128.I8x16 (Extract (al_to_int n, al_to_extension ext)))
  | [ TupV [ CaseV ("I16", []); NumV z ]; OptV (Some ext); n ] when z = eight ->
    V128 (V128.I16x8 (Extract (al_to_int n, al_to_extension ext)))
  | [ TupV [ CaseV ("I32", []); NumV z ]; OptV None; n ] when z = four ->
    V128 (V128.I32x4 (Extract (al_to_int n, ())))
  | [ TupV [ CaseV ("I64", []); NumV z ]; OptV None; n ] when z = two ->
    V128 (V128.I64x2 (Extract (al_to_int n, ())))
  | [ TupV [ CaseV ("F32", []); NumV z ]; OptV None; n ] when z = four ->
    V128 (V128.F32x4 (Extract (al_to_int n, ())))
  | [ TupV [ CaseV ("F64", []); NumV z ]; OptV None; n ] when z = two ->
    V128 (V128.F64x2 (Extract (al_to_int n, ())))
  | vl -> fail_list "vextractop" vl

let al_to_vreplaceop : value list -> vec_replaceop = function
  | [ TupV [ CaseV ("I8", []); NumV z ]; n ] when z = sixteen -> V128 (V128.I8x16 (Replace (al_to_int n)))
  | [ TupV [ CaseV ("I16", []); NumV z ]; n ] when z = eight -> V128 (V128.I16x8 (Replace (al_to_int n)))
  | [ TupV [ CaseV ("I32", []); NumV z ]; n ] when z = four -> V128 (V128.I32x4 (Replace (al_to_int n)))
  | [ TupV [ CaseV ("I64", []); NumV z ]; n ] when z = two -> V128 (V128.I64x2 (Replace (al_to_int n)))
  | [ TupV [ CaseV ("F32", []); NumV z ]; n ] when z = four -> V128 (V128.F32x4 (Replace (al_to_int n)))
  | [ TupV [ CaseV ("F64", []); NumV z ]; n ] when z = two -> V128 (V128.F64x2 (Replace (al_to_int n)))
  | vl -> fail_list "vreplaceop" vl

let al_to_pack_size : value -> Pack.pack_size = function
  | NumV z when z = eight -> Pack.Pack8
  | NumV z when z = sixteen -> Pack.Pack16
  | NumV z when z = thirtytwo -> Pack.Pack32
  | NumV z when z = sixtyfour -> Pack.Pack64
  | v -> fail "pack_size" v

let al_to_extension: value -> Pack.extension = function
  | CaseV ("S", []) -> Pack.SX
  | CaseV ("U", []) -> Pack.ZX
  | v -> fail "extension" v

let al_to_memop (f: value -> 'p) : value list -> (num_type, 'p) memop = function
  | [ nt; p; NumV z; StrV str ] when z = Z.zero ->
    {
      ty = al_to_num_type nt;
      align = Record.find "ALIGN" str |> al_to_int;
      offset = Record.find "OFFSET" str |> al_to_int32;
      pack = f p;
    }
  | v -> fail_list "memop" v

let al_to_pack_size_extension: value -> Pack.pack_size * Pack.extension = function
  | TupV [ p; ext ] -> al_to_pack_size p, al_to_extension ext
  | v -> fail "pack size, extension" v

let al_to_loadop: value list -> loadop = al_to_opt al_to_pack_size_extension |> al_to_memop

let al_to_storeop: value list -> storeop = al_to_opt al_to_pack_size |> al_to_memop

let al_to_vmemop (f: value -> 'p): value list -> (vec_type, 'p) memop = function
  | [ StrV str ] ->
    {
      ty = V128T;
      align = Record.find "ALIGN" str |> al_to_int;
      offset = Record.find "OFFSET" str |> al_to_int32;
      pack = f (numV Z.zero);
    }
  | [ p; StrV str ] ->
    {
      ty = V128T;
      align = Record.find "ALIGN" str |> al_to_int;
      offset = Record.find "OFFSET" str |> al_to_int32;
      pack = f p;
    }
  | v -> fail_list "vmemop" v

let al_to_pack_shape = function
  | [NumV z1; NumV z2] when z1 = eight && z2 = eight -> Pack.Pack8x8
  | [NumV z1; NumV z2] when z1 = sixteen && z2 = four -> Pack.Pack16x4
  | [NumV z1; NumV z2] when z1 = thirtytwo && z2 = two -> Pack.Pack32x2
  | vs -> fail "pack shape" (TupV vs)

let pack_shape_to_pack_size = function
  | Pack.Pack8x8 -> Pack.Pack8
  | Pack.Pack16x4 -> Pack.Pack16
  | Pack.Pack32x2 -> Pack.Pack32

let al_to_vloadop': value -> Pack.pack_size * Pack.vec_extension = function
  | CaseV ("SHAPE", [ v1; v2; ext ] ) ->
    let pack_shape = al_to_pack_shape [v1; v2] in
    (
      pack_shape_to_pack_size pack_shape,
      Pack.ExtLane (pack_shape, al_to_extension ext)
    )
  | CaseV ("SPLAT", [ pack_size ]) -> al_to_pack_size pack_size, Pack.ExtSplat
  | CaseV ("ZERO", [ pack_size ]) -> al_to_pack_size pack_size, Pack.ExtZero
  | v -> fail "vloadop" v

let al_to_vloadop: value list -> vec_loadop = al_to_vmemop (al_to_opt al_to_vloadop')

let al_to_vstoreop = al_to_vmemop (fun _ -> ())

let al_to_vlaneop (vl: value list): vec_laneop =
  let h, t = Util.Lib.List.split_last vl in
  al_to_vmemop al_to_pack_size h, al_to_int t


let rec al_to_instr (v: value): Ast.instr = al_to_phrase al_to_instr' v
and al_to_instr': value -> Ast.instr' = function
  (* wasm values *)
  | CaseV ("CONST", _) as v -> Const (al_to_phrase al_to_num v)
  | CaseV ("VCONST", _) as v -> VecConst (al_to_phrase al_to_vec v)
  | CaseV ("REF.NULL", [ ht ]) -> RefNull (al_to_heap_type ht)
  (* wasm instructions *)
  | CaseV ("UNREACHABLE", []) -> Unreachable
  | CaseV ("NOP", []) -> Nop
  | CaseV ("DROP", []) -> Drop
  | CaseV ("UNOP", op) -> Unary (al_to_unop op)
  | CaseV ("BINOP", op) -> Binary (al_to_binop op)
  | CaseV ("TESTOP", op) -> Test (al_to_testop op)
  | CaseV ("RELOP", op) -> Compare (al_to_relop op)
  | CaseV ("CVTOP", op) -> Convert (al_to_cvtop op)
  | CaseV ("VTESTOP", vop) -> VecTest (al_to_vtestop vop)
  | CaseV ("VRELOP", vop) -> VecCompare (al_to_vrelop vop)
  | CaseV ("VUNOP", vop) -> VecUnary (al_to_vunop vop)
  | CaseV ("VBINOP", vop) -> VecBinary (al_to_vbinop vop)
  | CaseV (("VSWIZZLE" | "VSHUFFLE" | "VNARROW" | "VEXTMUL" | "VDOT"), _) as v ->
    VecBinary (al_to_special_vbinop v)
  | CaseV ("VCVTOP", vop) -> VecConvert (al_to_vcvtop vop)
  | CaseV ("VEXTADD_PAIRWISE", _) as v -> VecConvert (al_to_special_vcvtop v)
  | CaseV ("VSHIFTOP", vop) -> VecShift (al_to_vshiftop vop)
  | CaseV ("VBITMASK", vop) -> VecBitmask (al_to_vbitmaskop vop)
  | CaseV ("VVTESTOP", vop) -> VecTestBits (al_to_vvtestop vop)
  | CaseV ("VVUNOP", vop) -> VecUnaryBits (al_to_vvunop vop)
  | CaseV ("VVBINOP", vop) -> VecBinaryBits (al_to_vvbinop vop)
  | CaseV ("VVTERNOP", vop) -> VecTernaryBits (al_to_vvternop vop)
  | CaseV ("VSPLAT", vop) -> VecSplat (al_to_vsplatop vop)
  | CaseV ("VEXTRACT_LANE", vop) -> VecExtract (al_to_vextractop vop)
  | CaseV ("VREPLACE_LANE", vop) -> VecReplace (al_to_vreplaceop vop)
  | CaseV ("REF.IS_NULL", []) -> RefIsNull
  | CaseV ("REF.FUNC", [ idx ]) -> RefFunc (al_to_idx idx)
  | CaseV ("SELECT", [ vtl_opt ]) -> Select (al_to_opt (al_to_list al_to_val_type) vtl_opt)
  | CaseV ("LOCAL.GET", [ idx ]) -> LocalGet (al_to_idx idx)
  | CaseV ("LOCAL.SET", [ idx ]) -> LocalSet (al_to_idx idx)
  | CaseV ("LOCAL.TEE", [ idx ]) -> LocalTee (al_to_idx idx)
  | CaseV ("GLOBAL.GET", [ idx ]) -> GlobalGet (al_to_idx idx)
  | CaseV ("GLOBAL.SET", [ idx ]) -> GlobalSet (al_to_idx idx)
  | CaseV ("TABLE.GET", [ idx ]) -> TableGet (al_to_idx idx)
  | CaseV ("TABLE.SET", [ idx ]) -> TableSet (al_to_idx idx)
  | CaseV ("TABLE.SIZE", [ idx ]) -> TableSize (al_to_idx idx)
  | CaseV ("TABLE.GROW", [ idx ]) -> TableGrow (al_to_idx idx)
  | CaseV ("TABLE.FILL", [ idx ]) -> TableFill (al_to_idx idx)
  | CaseV ("TABLE.COPY", [ idx1; idx2 ]) -> TableCopy (al_to_idx idx1, al_to_idx idx2)
  | CaseV ("TABLE.INIT", [ idx1; idx2 ]) -> TableInit (al_to_idx idx1, al_to_idx idx2)
  | CaseV ("ELEM.DROP", [ idx ]) -> ElemDrop (al_to_idx idx)
  | CaseV ("BLOCK", [ bt; instrs ]) ->
    Block (al_to_block_type bt, al_to_list al_to_instr instrs)
  | CaseV ("LOOP", [ bt; instrs ]) ->
    Loop (al_to_block_type bt, al_to_list al_to_instr instrs)
  | CaseV ("IF", [ bt; instrs1; instrs2 ]) ->
    If (al_to_block_type bt, al_to_list al_to_instr instrs1, al_to_list al_to_instr instrs2)
  | CaseV ("BR", [ idx ]) -> Br (al_to_idx idx)
  | CaseV ("BR_IF", [ idx ]) -> BrIf (al_to_idx idx)
  | CaseV ("BR_TABLE", [ idxs; idx ]) -> BrTable (al_to_list al_to_idx idxs, al_to_idx idx)
  | CaseV ("BR_ON_NULL", [ idx ]) -> BrOnNull (al_to_idx idx)
  | CaseV ("BR_ON_NON_NULL", [ idx ]) -> BrOnNonNull (al_to_idx idx)
  | CaseV ("BR_ON_CAST", [ idx; rt1; rt2 ]) ->
    BrOnCast (al_to_idx idx, al_to_ref_type rt1, al_to_ref_type rt2)
  | CaseV ("BR_ON_CAST_FAIL", [ idx; rt1; rt2 ]) ->
    BrOnCastFail (al_to_idx idx, al_to_ref_type rt1, al_to_ref_type rt2)
  | CaseV ("RETURN", []) -> Return
  | CaseV ("CALL", [ idx ]) -> Call (al_to_idx idx)
  | CaseV ("CALL_REF", [ OptV (Some idx) ]) -> CallRef (al_to_idx idx)
  | CaseV ("CALL_INDIRECT", [ idx1; idx2 ]) ->
    CallIndirect (al_to_idx idx1, al_to_idx idx2)
  | CaseV ("RETURN_CALL", [ idx ]) -> ReturnCall (al_to_idx idx)
  | CaseV ("RETURN_CALL_REF", [ OptV (Some idx) ]) -> ReturnCallRef (al_to_idx idx)
  | CaseV ("RETURN_CALL_INDIRECT", [ idx1; idx2 ]) ->
    ReturnCallIndirect (al_to_idx idx1, al_to_idx idx2)
  | CaseV ("LOAD", loadop) -> Load (al_to_loadop loadop)
  | CaseV ("STORE", storeop) -> Store (al_to_storeop storeop)
  | CaseV ("VLOAD", vloadop) -> VecLoad (al_to_vloadop vloadop)
  | CaseV ("VLOAD_LANE", vlaneop) -> VecLoadLane (al_to_vlaneop vlaneop)
  | CaseV ("VSTORE", vstoreop) -> VecStore (al_to_vstoreop vstoreop)
  | CaseV ("VSTORE_LANE", vlaneop) -> VecStoreLane (al_to_vlaneop vlaneop)
  | CaseV ("MEMORY.SIZE", [ NumV z ]) when z = Z.zero -> MemorySize
  | CaseV ("MEMORY.GROW", [ NumV z ]) when z = Z.zero -> MemoryGrow
  | CaseV ("MEMORY.FILL", [ NumV z ]) when z = Z.zero -> MemoryFill
  | CaseV ("MEMORY.COPY", [ NumV z1; NumV z2 ]) when z1 = Z.zero && z2 = Z.zero -> MemoryCopy
  | CaseV ("MEMORY.INIT", [ NumV z; idx ]) when z = Z.zero -> MemoryInit (al_to_idx idx)
  | CaseV ("DATA.DROP", [ idx ]) -> DataDrop (al_to_idx idx)
  | CaseV ("REF.AS_NON_NULL", []) -> RefAsNonNull
  | CaseV ("REF.TEST", [ rt ]) -> RefTest (al_to_ref_type rt)
  | CaseV ("REF.CAST", [ rt ]) -> RefCast (al_to_ref_type rt)
  | CaseV ("REF.EQ", []) -> RefEq
  | CaseV ("REF.I31", []) -> RefI31
  | CaseV ("I31.GET", [ ext ]) -> I31Get (al_to_extension ext)
  | CaseV ("STRUCT.NEW", [ idx ]) -> StructNew (al_to_idx idx, Explicit)
  | CaseV ("STRUCT.NEW_DEFAULT", [ idx ]) -> StructNew (al_to_idx idx, Implicit)
  | CaseV ("STRUCT.GET", [ ext_opt; idx1; idx2 ]) ->
    StructGet (al_to_idx idx1, al_to_idx idx2, al_to_opt al_to_extension ext_opt)
  | CaseV ("STRUCT.SET", [ idx1; idx2 ]) -> StructSet (al_to_idx idx1, al_to_idx idx2)
  | CaseV ("ARRAY.NEW", [ idx ]) -> ArrayNew (al_to_idx idx, Explicit)
  | CaseV ("ARRAY.NEW_DEFAULT", [ idx ]) -> ArrayNew (al_to_idx idx, Implicit)
  | CaseV ("ARRAY.NEW_FIXED", [ idx; i32 ]) ->
    ArrayNewFixed (al_to_idx idx, al_to_int32 i32)
  | CaseV ("ARRAY.NEW_ELEM", [ idx1; idx2 ]) ->
    ArrayNewElem (al_to_idx idx1, al_to_idx idx2)
  | CaseV ("ARRAY.NEW_DATA", [ idx1; idx2 ]) ->
    ArrayNewData (al_to_idx idx1, al_to_idx idx2)
  | CaseV ("ARRAY.GET", [ ext_opt; idx ]) ->
    ArrayGet (al_to_idx idx, al_to_opt al_to_extension ext_opt)
  | CaseV ("ARRAY.SET", [ idx ]) -> ArraySet (al_to_idx idx)
  | CaseV ("ARRAY.LEN", []) -> ArrayLen
  | CaseV ("ARRAY.COPY", [ idx1; idx2 ]) -> ArrayCopy (al_to_idx idx1, al_to_idx idx2)
  | CaseV ("ARRAY.FILL", [ idx ]) -> ArrayFill (al_to_idx idx)
  | CaseV ("ARRAY.INIT_DATA", [ idx1; idx2 ]) ->
    ArrayInitData (al_to_idx idx1, al_to_idx idx2)
  | CaseV ("ARRAY.INIT_ELEM", [ idx1; idx2 ]) ->
    ArrayInitElem (al_to_idx idx1, al_to_idx idx2)
  | CaseV ("ANY.CONVERT_EXTERN", []) -> ExternConvert Internalize
  | CaseV ("EXTERN.CONVERT_ANY", []) -> ExternConvert Externalize
  | v -> fail "instrunction" v

let al_to_const: value -> const = al_to_list al_to_instr |> al_to_phrase


(* Deconstruct module *)

let al_to_type: value -> type_ = function
  | CaseV ("TYPE", [ rt ]) -> al_to_phrase al_to_rec_type rt
  | v -> fail "type" v

let al_to_local': value -> local' = function
  | CaseV ("LOCAL", [ vt ]) -> { ltype = al_to_val_type vt }
  | v -> fail "local" v
let al_to_local: value -> local = al_to_phrase al_to_local'

let al_to_func': value -> func' = function
  | CaseV ("FUNC", [ idx; locals; instrs ]) ->
    {
      ftype = al_to_idx idx;
      locals = al_to_list al_to_local locals;
      body = al_to_list al_to_instr instrs;
    }
  | v -> fail "func" v
let al_to_func: value -> func = al_to_phrase al_to_func'

let al_to_global': value -> global' = function
  | CaseV ("GLOBAL", [ gt; const ]) ->
    { gtype = al_to_global_type gt; ginit = al_to_const const }
  | v -> fail "global" v
let al_to_global: value -> global = al_to_phrase al_to_global'

let al_to_table': value -> table' = function
  | CaseV ("TABLE", [ tt; const ]) ->
    { ttype = al_to_table_type tt; tinit = al_to_const const }
  | v -> fail "table" v
let al_to_table: value -> table = al_to_phrase al_to_table'

let al_to_memory': value -> memory' = function
  | CaseV ("MEMORY", [ mt ]) -> { mtype = al_to_memory_type mt }
  | v -> fail "memory" v
let al_to_memory: value -> memory = al_to_phrase al_to_memory'

let al_to_segment': value -> segment_mode' = function
  | CaseV ("PASSIVE", []) -> Passive
  | CaseV ("ACTIVE", [ idx; const ]) ->
    Active { index = al_to_idx idx; offset = al_to_const const }
  | CaseV ("DECLARE", []) -> Declarative
  | v -> fail "segment mode" v
let al_to_segment: value -> segment_mode = al_to_phrase al_to_segment'

let al_to_elem': value -> elem_segment' = function
  | CaseV ("ELEM", [ rt; consts; seg ]) ->
    {
      etype = al_to_ref_type rt;
      einit = al_to_list al_to_const consts;
      emode = al_to_segment seg
    }
  | v -> fail "elem segment" v
let al_to_elem: value -> elem_segment = al_to_phrase al_to_elem'

let al_to_data': value -> data_segment' = function
  | CaseV ("DATA", [ bytes_; seg ]) ->
    { dinit = al_to_bytes bytes_; dmode = al_to_segment seg }
  | v -> fail "data segment" v
let al_to_data: value -> data_segment = al_to_phrase al_to_data'

  (*

let al_to_import_desc module_ idesc =
  match idesc.it with
  | FuncImport x ->
      let dts = def_types_of module_ in
      let dt = Lib.List32.nth dts x.it |> al_to_def_type in
      CaseV ("FUNC", [ dt ])
  | TableImport tt -> CaseV ("TABLE", [ al_to_table_type tt ])
  | MemoryImport mt -> CaseV ("MEM", [ al_to_memory_type mt ])
  | GlobalImport gt -> CaseV ("GLOBAL", [ al_to_global_type gt ])

let al_to_import module_ import =
  CaseV ("IMPORT", [
    al_to_name import.it.module_name;
    al_to_name import.it.item_name;
    al_to_import_desc module_ import.it.idesc;
  ])
  *)

let al_to_export_desc': value -> export_desc' = function
  | CaseV ("FUNC", [ idx ]) -> FuncExport (al_to_idx idx)
  | CaseV ("TABLE", [ idx ]) -> TableExport (al_to_idx idx)
  | CaseV ("MEM", [ idx ]) -> MemoryExport (al_to_idx idx)
  | CaseV ("GLOBAL", [ idx ]) -> GlobalExport (al_to_idx idx)
  | v -> fail "export desc" v
let al_to_export_desc: value -> export_desc = al_to_phrase al_to_export_desc'

let al_to_start': value -> start' = function
  | CaseV ("START", [ idx ]) -> { sfunc = al_to_idx idx }
  | v -> fail "start" v
let al_to_start: value -> start = al_to_phrase al_to_start'

let al_to_export': value -> export' = function
  | CaseV ("EXPORT", [ name; ed ]) ->
    { name = al_to_name name; edesc = al_to_export_desc ed }
  | v -> fail "export" v
let al_to_export: value -> export = al_to_phrase al_to_export'

let al_to_module': value -> module_' = function
  | CaseV ("MODULE", [
    types; _imports; funcs; globals; tables; memories; elems; datas; start; exports
  ]) ->
    {
      types = al_to_list al_to_type types;
      (* TODO: imports = al_to_list (al_to_import module_) imports;*)
      imports = [];
      funcs = al_to_list al_to_func funcs;
      globals = al_to_list al_to_global globals;
      tables = al_to_list al_to_table tables;
      memories = al_to_list al_to_memory memories;
      elems = al_to_list al_to_elem elems;
      datas = al_to_list al_to_data datas;
      start = al_to_opt al_to_start start;
      exports = al_to_list al_to_export exports;
    }
  | v -> fail "module" v
let al_to_module: value -> module_ = al_to_phrase al_to_module'


(* Construct *)

(* Construct data structure *)

let al_of_list f l = List.map f l |> listV_of_list
let al_of_seq f s = List.of_seq s |> al_of_list f
let al_of_opt f opt = Option.map f opt |> optV


(* Construct minor *)

let al_of_z z = numV z

let al_of_fmagN layout i =
  let n = Z.logand i (mask_exp layout) in
  let m = Z.logand i (mask_mant layout) in
  if n = Z.zero then
    CaseV ("SUBNORM", [ al_of_z m ])
  else if n <> mask_exp layout then
    CaseV ("NORM", [ al_of_z m; al_of_z Z.(shift_right n layout.mantissa - bias layout) ])
  else if m = Z.zero then
    CaseV ("INF", [])
  else
    CaseV ("NAN", [ al_of_z m ])

let al_of_floatN layout i =
  let i' = Z.logand i (mask_mag layout) in
  let mag = al_of_fmagN layout i in
  CaseV ((if i' = i then "POS" else "NEG"), [ mag ])

let vec128_to_z vec =
  match V128.I64x2.to_lanes vec with
  | [ v1; v2 ] -> Z.(of_int64_unsigned v1 + e64 * of_int64_unsigned v2)
  | _ -> assert false

let al_of_int i = Z.of_int i |> al_of_z
let al_of_int8 i8 =
  (* NOTE: int8 is considered to be unsigned *)
  Z.of_int32_unsigned Int32.(logand i8 0x0000_00ffl) |> al_of_z
let al_of_int16 i16 =
  (* NOTE: int32 is considered to be unsigned *)
  Z.of_int32_unsigned Int32.(logand i16 0x0000_ffffl) |> al_of_z
let al_of_int32 i32 =
  (* NOTE: int32 is considered to be unsigned *)
  Z.of_int32_unsigned i32 |> al_of_z
let al_of_int64 i64 =
  (* NOTE: int32 is considered to be unsigned *)
  Z.of_int64_unsigned i64 |> al_of_z
let al_of_float32 f32 = F32.to_bits f32 |> Z.of_int32_unsigned |> al_of_floatN layout32
let al_of_float64 f64 = F64.to_bits f64 |> Z.of_int64_unsigned |> al_of_floatN layout64
let al_of_vec128 vec = vec128_to_z vec |> al_of_z
let al_of_bool b = Bool.to_int b |> al_of_int
let al_of_idx idx = al_of_int32 idx.it
let al_of_byte byte = Char.code byte |> al_of_int
let al_of_bytes bytes_ = String.to_seq bytes_ |> al_of_seq al_of_byte
let al_of_name name = TextV (Utf8.encode name)
let al_with_version vs f a = if (List.mem !version vs) then [ f a ] else []
let al_of_memidx () = al_with_version [ 3 ] (fun v -> v) zero

(* Helper *)

let arg_of_case case i = function
| CaseV (case', args) when case = case' -> List.nth args i
| _ -> failwith "invalid arg_of_case"
let arg_of_tup i = function
| TupV args -> List.nth args i
| _ -> failwith "invalid arg_of_tup"

(* Construct type *)

let al_of_null = function
  | NoNull -> none "NULL"
  | Null -> some "NULL"

let al_of_final = function
  | NoFinal -> some "FINAL"
  | Final -> none "FINAL"

let al_of_mut = function
  | Cons -> some "MUT"
  | Var -> none "MUT"

let rec al_of_storage_type = function
  | ValStorageT vt -> al_of_val_type vt
  | PackStorageT _ as st -> nullary (string_of_storage_type st)

and al_of_field_type = function
  | FieldT (mut, st) -> tupV [ al_of_mut mut; al_of_storage_type st ]

and al_of_result_type rt = al_of_list al_of_val_type rt

and al_of_str_type = function
  | DefStructT (StructT ftl) -> CaseV ("STRUCT", [ al_of_list al_of_field_type ftl ])
  | DefArrayT (ArrayT ft) -> CaseV ("ARRAY", [ al_of_field_type ft ])
  | DefFuncT (FuncT (rt1, rt2)) ->
    CaseV ("FUNC", [ TupV [ al_of_result_type rt1; al_of_result_type rt2] ])

and al_of_sub_type = function
  | SubT (fin, htl, st) ->
    CaseV ("SUBD", [ al_of_final fin; al_of_list al_of_heap_type htl; al_of_str_type st ])

and al_of_rec_type = function
  | RecT stl -> CaseV ("REC", [ al_of_list al_of_sub_type stl ])

and al_of_def_type = function
  | DefT (rt, i) -> CaseV ("DEF", [al_of_rec_type rt; al_of_int32 i])

and al_of_heap_type = function
  | VarHT (StatX i) -> CaseV ("_IDX", [ al_of_int32 i ])
  | VarHT (RecX i) -> CaseV ("REC", [ al_of_int32 i ])
  | DefHT dt -> al_of_def_type dt
  | BotHT -> nullary "BOT"
  | FuncHT | ExternHT as ht when !version = 2 ->
    string_of_heap_type ht ^ "REF" |> nullary
  | ht -> string_of_heap_type ht |> nullary

and al_of_ref_type (null, ht) =
  if !version = 3 then
    CaseV ("REF", [ al_of_null null; al_of_heap_type ht ])
  else
    al_of_heap_type ht

and al_of_num_type nt = string_of_num_type nt |> nullary

and al_of_vec_type vt = string_of_vec_type vt |> nullary

and al_of_val_type = function
  | RefT rt -> al_of_ref_type rt
  | NumT nt -> al_of_num_type nt
  | VecT vt -> al_of_vec_type vt
  | BotT -> nullary "BOT"

let al_of_blocktype = function
  | VarBlockType idx -> CaseV ("_IDX", [ al_of_idx idx ])
  | ValBlockType vt_opt ->
    if !version = 1 then
      al_of_opt al_of_val_type vt_opt
    else
      CaseV ("_RESULT", [ al_of_opt al_of_val_type vt_opt ])

let al_of_limits default limits =
  let max =
    match limits.max with
    | Some v -> al_of_int32 v
    | None -> al_of_int64 default
  in

  tupV [ al_of_int32 limits.min; max ]

let al_of_global_type = function
  | GlobalT (mut, vt) -> tupV [ al_of_mut mut; al_of_val_type vt ]

let al_of_table_type = function
  | TableT (limits, rt) -> tupV [ al_of_limits default_table_max limits; al_of_ref_type rt ]

let al_of_memory_type = function
  | MemoryT limits -> CaseV ("I8", [ al_of_limits default_memory_max limits ])

(* Construct value *)

let al_of_num = function
  | I32 i32 -> CaseV ("CONST", [ nullary "I32"; al_of_int32 i32 ])
  | I64 i64 -> CaseV ("CONST", [ nullary "I64"; al_of_int64 i64 ])
  | F32 f32 -> CaseV ("CONST", [ nullary "F32"; al_of_float32 f32 ])
  | F64 f64 -> CaseV ("CONST", [ nullary "F64"; al_of_float64 f64 ])

let al_of_vec = function
  | V128 v128 -> CaseV ("VCONST", [ nullary "V128"; al_of_vec128 v128 ])

let al_of_vec_shape shape (lanes: int64 list) =
  al_of_vec (V128  (
    match shape with
    | V128.I8x16() -> V128.I8x16.of_lanes (List.map Int64.to_int32 lanes)
    | V128.I16x8() -> V128.I16x8.of_lanes (List.map Int64.to_int32 lanes)
    | V128.I32x4() -> V128.I32x4.of_lanes (List.map Int64.to_int32 lanes)
    | V128.I64x2() -> V128.I64x2.of_lanes lanes
    | V128.F32x4() -> V128.F32x4.of_lanes (List.map (fun i -> i |> Int64.to_int32 |> F32.of_bits) lanes)
    | V128.F64x2() -> V128.F64x2.of_lanes (List.map F64.of_bits lanes)
  ))

let rec al_of_ref = function
  | NullRef ht -> CaseV ("REF.NULL", [ al_of_heap_type ht ])
  (*
  | I31.I31Ref i ->
    CaseV ("REF.I31_NUM", [ NumV (Int64.of_int i) ])
  | Aggr.StructRef a ->
    CaseV ("REF.STRUCT_ADDR", [ NumV (int64_of_int32_u a) ])
  | Aggr.ArrayRef a ->
    CaseV ("REF.ARRAY_ADDR", [ NumV (int64_of_int32_u a) ])
  | Instance.FuncRef a ->
    CaseV ("REF.FUNC_ADDR", [ NumV (int64_of_int32_u a) ])
  *)
  | Script.HostRef i32 -> CaseV ("REF.HOST_ADDR", [ al_of_int32 i32 ])
  | Extern.ExternRef r -> CaseV ("REF.EXTERN", [ al_of_ref r ])
  | r -> string_of_ref r |> failwith

let al_of_value = function
  | Num n -> al_of_num n
  | Vec v -> al_of_vec v
  | Ref r -> al_of_ref r


(* Construct operation *)

let al_of_op f1 f2 = function
  | I32 op -> [ nullary "I32"; f1 op ]
  | I64 op -> [ nullary "I64"; f1 op ]
  | F32 op -> [ nullary "F32"; f2 op ]
  | F64 op -> [ nullary "F64"; f2 op ]

let al_of_int_unop = function
  | IntOp.Clz -> CaseV ("CLZ", [])
  | IntOp.Ctz -> CaseV ("CTZ", [])
  | IntOp.Popcnt -> CaseV ("POPCNT", [])
  | IntOp.ExtendS Pack.Pack8 -> CaseV ("EXTEND", [al_of_int 8])
  | IntOp.ExtendS Pack.Pack16 -> CaseV ("EXTEND", [al_of_int 16])
  | IntOp.ExtendS Pack.Pack32 -> CaseV ("EXTEND", [al_of_int 32])
  | IntOp.ExtendS Pack.Pack64 -> CaseV ("EXTEND", [al_of_int 64])
let al_of_float_unop = function
  | FloatOp.Neg -> CaseV ("NEG", [])
  | FloatOp.Abs -> CaseV ("ABS", [])
  | FloatOp.Ceil -> CaseV ("CEIL", [])
  | FloatOp.Floor -> CaseV ("FLOOR", [])
  | FloatOp.Trunc -> CaseV ("TRUNC", [])
  | FloatOp.Nearest -> CaseV ("NEAREST", [])
  | FloatOp.Sqrt -> CaseV ("SQRT", [])
let al_of_unop = al_of_op al_of_int_unop al_of_float_unop

let al_of_int_binop = function
  | IntOp.Add -> CaseV ("ADD", [])
  | IntOp.Sub -> CaseV ("SUB", [])
  | IntOp.Mul -> CaseV ("MUL", [])
  | IntOp.DivS -> CaseV ("DIV", [CaseV ("S", [])])
  | IntOp.DivU -> CaseV ("DIV", [CaseV ("U", [])])
  | IntOp.RemS -> CaseV ("REM", [CaseV ("S", [])])
  | IntOp.RemU -> CaseV ("REM", [CaseV ("U", [])])
  | IntOp.And -> CaseV ("AND", [])
  | IntOp.Or -> CaseV ("OR", [])
  | IntOp.Xor -> CaseV ("XOR", [])
  | IntOp.Shl -> CaseV ("SHL", [])
  | IntOp.ShrS -> CaseV ("SHR", [CaseV ("S", [])])
  | IntOp.ShrU -> CaseV ("SHR", [CaseV ("U", [])])
  | IntOp.Rotl -> CaseV ("ROTL", [])
  | IntOp.Rotr -> CaseV ("ROTR", [])
let al_of_float_binop = function
  | FloatOp.Add -> CaseV ("ADD", [])
  | FloatOp.Sub -> CaseV ("SUB", [])
  | FloatOp.Mul -> CaseV ("MUL", [])
  | FloatOp.Div -> CaseV ("DIV", [])
  | FloatOp.Min -> CaseV ("MIN", [])
  | FloatOp.Max -> CaseV ("MAX", [])
  | FloatOp.CopySign -> CaseV ("COPYSIGN", [])
let al_of_binop = al_of_op al_of_int_binop al_of_float_binop

let al_of_int_testop: IntOp.testop -> value = function
  | IntOp.Eqz -> CaseV ("EQZ", [])
let al_of_float_testop: FloatOp.testop -> value = function
  | _ -> .
let al_of_testop: testop -> value list = al_of_op al_of_int_testop al_of_float_testop

let al_of_int_relop = function
  | IntOp.Eq -> CaseV ("EQ", [])
  | IntOp.Ne -> CaseV ("NE", [])
  | IntOp.LtS -> CaseV ("LT", [CaseV ("S", [])])
  | IntOp.LtU -> CaseV ("LT", [CaseV ("U", [])])
  | IntOp.GtS -> CaseV ("GT", [CaseV ("S", [])])
  | IntOp.GtU -> CaseV ("GT", [CaseV ("U", [])])
  | IntOp.LeS -> CaseV ("LE", [CaseV ("S", [])])
  | IntOp.LeU -> CaseV ("LE", [CaseV ("U", [])])
  | IntOp.GeS -> CaseV ("GE", [CaseV ("S", [])])
  | IntOp.GeU -> CaseV ("GE", [CaseV ("U", [])])
let al_of_float_relop = function
  | FloatOp.Eq -> CaseV ("EQ", [])
  | FloatOp.Ne -> CaseV ("NE", [])
  | FloatOp.Lt -> CaseV ("LT", [])
  | FloatOp.Gt -> CaseV ("GT", [])
  | FloatOp.Le -> CaseV ("LE", [])
  | FloatOp.Ge -> CaseV ("GE", [])
let al_of_relop = al_of_op al_of_int_relop al_of_float_relop

let al_of_int_cvtop num_bits = function
  | IntOp.ExtendSI32 -> "Convert", "I64", Some (nullary "S")
  | IntOp.ExtendUI32 -> "Convert", "I64", Some (nullary "U")
  | IntOp.WrapI64 -> "Convert", "I64", None
  | IntOp.TruncSF32 -> "Convert", "F32", Some (nullary "S")
  | IntOp.TruncUF32 -> "Convert", "F32", Some (nullary "U")
  | IntOp.TruncSF64 -> "Convert", "F64", Some (nullary "S")
  | IntOp.TruncUF64 -> "Convert", "F64", Some (nullary "U")
  | IntOp.TruncSatSF32 -> "Convert_sat", "F32", Some (nullary "S")
  | IntOp.TruncSatUF32 -> "Convert_sat", "F32", Some (nullary "U")
  | IntOp.TruncSatSF64 -> "Convert_sat", "F64", Some (nullary "S")
  | IntOp.TruncSatUF64 -> "Convert_sat", "F64", Some (nullary "U")
  | IntOp.ReinterpretFloat -> "Reinterpret", "F" ^ num_bits, None
let al_of_float_cvtop num_bits = function
  | FloatOp.ConvertSI32 -> "Convert", "I32", Some (nullary ("S"))
  | FloatOp.ConvertUI32 -> "Convert", "I32", Some (nullary ("U"))
  | FloatOp.ConvertSI64 -> "Convert", "I64", Some (nullary ("S"))
  | FloatOp.ConvertUI64 -> "Convert", "I64", Some (nullary ("U"))
  | FloatOp.PromoteF32 -> "Convert", "F32", None
  | FloatOp.DemoteF64 -> "Convert", "F64", None
  | FloatOp.ReinterpretInt -> "Reinterpret", "I" ^ num_bits, None
let al_of_cvtop = function
  | I32 op ->
    let op', to_, ext = al_of_int_cvtop "32" op in
    [ nullary "I32"; nullary op'; nullary to_; optV ext ]
  | I64 op ->
    let op', to_, ext = al_of_int_cvtop "64" op in
    [ nullary "I64"; nullary op'; nullary to_; optV ext ]
  | F32 op ->
    let op', to_, ext = al_of_float_cvtop "32" op in
    [ nullary "F32"; nullary op'; nullary to_; optV ext ]
  | F64 op ->
    let op', to_, ext = al_of_float_cvtop "64" op in
    [ nullary "F64"; nullary op'; nullary to_; optV ext ]

(* Vector operator *)

let al_of_extension = function
  | Pack.SX -> nullary "S"
  | Pack.ZX -> nullary "U"

let al_of_vop f1 f2 = function
  | V128 vop -> (
    match vop with
    | V128.I8x16 op -> [ TupV [ nullary "I8"; numV sixteen ]; f1 op ]
    | V128.I16x8 op -> [ TupV [ nullary "I16"; numV eight ]; f1 op ]
    | V128.I32x4 op -> [ TupV [ nullary "I32"; numV four ]; f1 op ]
    | V128.I64x2 op -> [ TupV [ nullary "I64"; numV two ]; f1 op ]
    | V128.F32x4 op -> [ TupV [ nullary "F32"; numV four ]; f2 op ]
    | V128.F64x2 op -> [ TupV [ nullary "F64"; numV two ]; f2 op ]
  )

let al_of_viop f1:
    ('a, 'a, 'a, 'a, void, void) V128.laneop vecop -> value list =
  function
  | V128 vop -> (
    match vop with
    | V128.I8x16 op -> [ TupV [ nullary "I8"; numV sixteen ]; f1 op ]
    | V128.I16x8 op -> [ TupV [ nullary "I16"; numV eight ]; f1 op ]
    | V128.I32x4 op -> [ TupV [ nullary "I32"; numV four ]; f1 op ]
    | V128.I64x2 op -> [ TupV [ nullary "I64"; numV two ]; f1 op ]
    | _ -> .
  )

let al_of_vbitmaskop = function
  | V128 vop -> (
    match vop with
    | V128.I8x16 _ -> [ TupV [ nullary "I8"; numV sixteen ] ]
    | V128.I16x8 _ -> [ TupV [ nullary "I16"; numV eight ] ]
    | V128.I32x4 _ -> [ TupV [ nullary "I32"; numV four ] ]
    | V128.I64x2 _ -> [ TupV [ nullary "I64"; numV two ] ]
    | _ -> failwith "Invalid shape"
  )

let al_of_int_vtestop : V128Op.itestop -> value = function
  | V128Op.AllTrue -> nullary "ALL_TRUE"

let al_of_float_vtestop : Ast.void -> value = function
  | _ -> .

let al_of_vtestop = al_of_vop al_of_int_vtestop al_of_float_vtestop

let al_of_int_vrelop : V128Op.irelop -> value = function
  | V128Op.Eq -> nullary "EQ"
  | V128Op.Ne -> nullary "NE"
  | V128Op.LtS -> caseV ("LT", [nullary "S"])
  | V128Op.LtU -> caseV ("LT", [nullary "U"])
  | V128Op.LeS -> caseV ("LE", [nullary "S"])
  | V128Op.LeU -> caseV ("LE", [nullary "U"])
  | V128Op.GtS -> caseV ("GT", [nullary "S"])
  | V128Op.GtU -> caseV ("GT", [nullary "U"])
  | V128Op.GeS -> caseV ("GE", [nullary "S"])
  | V128Op.GeU -> caseV ("GE", [nullary "U"])

let al_of_float_vrelop : V128Op.frelop -> value = function
  | V128Op.Eq -> nullary "EQ"
  | V128Op.Ne -> nullary "NE"
  | V128Op.Lt -> nullary "LT"
  | V128Op.Le -> nullary "LE"
  | V128Op.Gt -> nullary "GT"
  | V128Op.Ge -> nullary "GE"

let al_of_vrelop = al_of_vop al_of_int_vrelop al_of_float_vrelop

let al_of_int_vunop : V128Op.iunop -> value = function
  | V128Op.Abs -> nullary "ABS"
  | V128Op.Neg -> nullary "NEG"
  | V128Op.Popcnt -> nullary "POPCNT"

let al_of_float_vunop : V128Op.funop -> value = function
  | V128Op.Abs -> nullary "ABS"
  | V128Op.Neg -> nullary "NEG"
  | V128Op.Sqrt -> nullary "SQRT"
  | V128Op.Ceil -> nullary "CEIL"
  | V128Op.Floor -> nullary "FLOOR"
  | V128Op.Trunc -> nullary "TRUNC"
  | V128Op.Nearest -> nullary "NEAREST"

let al_of_vunop = al_of_vop al_of_int_vunop al_of_float_vunop

let al_of_int_vbinop : V128Op.ibinop -> value option = function
  | V128Op.Add -> Some (nullary "ADD")
  | V128Op.Sub -> Some (nullary "SUB")
  | V128Op.Mul -> Some (nullary "MUL")
  | V128Op.MinS -> Some (caseV ("MIN", [nullary "S"]))
  | V128Op.MinU -> Some (caseV ("MIN", [nullary "U"]))
  | V128Op.MaxS -> Some (caseV ("MAX", [nullary "S"]))
  | V128Op.MaxU -> Some (caseV ("MAX", [nullary "U"]))
  | V128Op.AvgrU -> Some (nullary "AVGR_U")
  | V128Op.AddSatS -> Some (CaseV ("ADD_SAT", [nullary "S"]))
  | V128Op.AddSatU -> Some (CaseV ("ADD_SAT", [nullary "U"]))
  | V128Op.SubSatS -> Some (CaseV ("SUB_SAT", [nullary "S"]))
  | V128Op.SubSatU -> Some (CaseV ("SUB_SAT", [nullary "U"]))
  | V128Op.Q15MulRSatS -> Some (nullary "Q15MULR_SAT_S")
  | _ -> None

let al_of_float_vbinop : V128Op.fbinop -> value = function
  | V128Op.Add -> nullary "ADD"
  | V128Op.Sub -> nullary "SUB"
  | V128Op.Mul -> nullary "MUL"
  | V128Op.Div -> nullary "DIV"
  | V128Op.Min -> nullary "MIN"
  | V128Op.Max -> nullary "MAX"
  | V128Op.Pmin -> nullary "PMIN"
  | V128Op.Pmax -> nullary "PMAX"

let al_of_vbinop = function
  | V128 vop -> (
    match vop with
    | V128.I8x16 op -> Option.map (fun v -> [ TupV [ nullary "I8"; numV sixteen ]; v ]) (al_of_int_vbinop op)
    | V128.I16x8 op -> Option.map (fun v -> [ TupV [ nullary "I16"; numV eight ]; v ]) (al_of_int_vbinop op)
    | V128.I32x4 op -> Option.map (fun v -> [ TupV [ nullary "I32"; numV four ]; v ]) (al_of_int_vbinop op)
    | V128.I64x2 op -> Option.map (fun v -> [ TupV [ nullary "I64"; numV two ]; v ]) (al_of_int_vbinop op)
    | V128.F32x4 op -> Some ([ TupV [ nullary "F32"; numV four ]; al_of_float_vbinop op ])
    | V128.F64x2 op -> Some ([ TupV [ nullary "F64"; numV two ]; al_of_float_vbinop op ])
  )

let al_of_special_vbinop = function
  | V128 (V128.I8x16 (V128Op.Swizzle)) -> CaseV ("VSWIZZLE", [ TupV [ nullary "I8"; numV sixteen ]; ])
  | V128 (V128.I8x16 (V128Op.Shuffle l)) -> CaseV ("VSHUFFLE", [ TupV [ nullary "I8"; numV sixteen ]; al_of_list al_of_int l ])
  | V128 (V128.I8x16 (V128Op.NarrowS)) -> CaseV ("VNARROW", [ TupV [ nullary "I8"; numV sixteen ]; TupV [ nullary "I16"; numV eight ]; al_of_extension Pack.SX ])
  | V128 (V128.I16x8 (V128Op.NarrowS)) -> CaseV ("VNARROW", [ TupV [ nullary "I16"; numV eight ]; TupV [ nullary "I32"; numV four ]; al_of_extension Pack.SX ])
  | V128 (V128.I8x16 (V128Op.NarrowU)) -> CaseV ("VNARROW", [ TupV [ nullary "I8"; numV sixteen ]; TupV [ nullary "I16"; numV eight ]; al_of_extension Pack.ZX ])
  | V128 (V128.I16x8 (V128Op.NarrowU)) -> CaseV ("VNARROW", [ TupV [ nullary "I16"; numV eight]; TupV [ nullary "I32"; numV four ]; al_of_extension Pack.ZX ])
  | V128 (V128.I16x8 (V128Op.ExtMulHighS)) -> CaseV ("VEXTBINOP", [ TupV [ nullary "I16"; numV eight ]; TupV [ nullary "I8"; numV sixteen ]; caseV ("EXTMUL", [nullary "HIGH"]); al_of_extension Pack.SX ])
  | V128 (V128.I16x8 (V128Op.ExtMulHighU)) -> CaseV ("VEXTBINOP", [ TupV [ nullary "I16"; numV eight ]; TupV [ nullary "I8"; numV sixteen ]; caseV ("EXTMUL", [nullary "HIGH"]); al_of_extension Pack.ZX ])
  | V128 (V128.I16x8 (V128Op.ExtMulLowS)) -> CaseV ("VEXTBINOP", [ TupV [ nullary "I16"; numV eight ]; TupV [ nullary "I8"; numV sixteen ]; caseV ("EXTMUL", [nullary "LOW"]); al_of_extension Pack.SX ])
  | V128 (V128.I16x8 (V128Op.ExtMulLowU)) -> CaseV ("VEXTBINOP", [ TupV [ nullary "I16"; numV eight ]; TupV [ nullary "I8"; numV sixteen ]; caseV ("EXTMUL", [nullary "LOW"]); al_of_extension Pack.ZX ] )
  | V128 (V128.I32x4 (V128Op.ExtMulHighS)) -> CaseV ("VEXTBINOP", [ TupV [ nullary "I32"; numV four ]; TupV [ nullary "I16"; numV eight ]; caseV ("EXTMUL", [nullary "HIGH"]); al_of_extension Pack.SX ])
  | V128 (V128.I32x4 (V128Op.ExtMulHighU)) -> CaseV ("VEXTBINOP", [ TupV [ nullary "I32"; numV four ]; TupV [ nullary "I16"; numV eight ]; caseV ("EXTMUL", [nullary "HIGH"]); al_of_extension Pack.ZX ])
  | V128 (V128.I32x4 (V128Op.ExtMulLowS)) -> CaseV ("VEXTBINOP", [ TupV [ nullary "I32"; numV four ]; TupV [ nullary "I16"; numV eight ]; caseV ("EXTMUL", [nullary "LOW"]); al_of_extension Pack.SX ])
  | V128 (V128.I32x4 (V128Op.ExtMulLowU)) -> CaseV ("VEXTBINOP", [ TupV [ nullary "I32"; numV four ]; TupV [ nullary "I16"; numV eight ]; caseV ("EXTMUL", [nullary "LOW"]); al_of_extension Pack.ZX ] )
  | V128 (V128.I64x2 (V128Op.ExtMulHighS)) -> CaseV ("VEXTBINOP", [ TupV [ nullary "I64"; numV two ]; TupV [ nullary "I32"; numV four ]; caseV ("EXTMUL", [nullary "HIGH"]); al_of_extension Pack.SX ])
  | V128 (V128.I64x2 (V128Op.ExtMulHighU)) -> CaseV ("VEXTBINOP", [ TupV [ nullary "I64"; numV two ]; TupV [ nullary "I32"; numV four ]; caseV ("EXTMUL", [nullary "HIGH"]); al_of_extension Pack.ZX ])
  | V128 (V128.I64x2 (V128Op.ExtMulLowS)) -> CaseV ("VEXTBINOP", [ TupV [ nullary "I64"; numV two ]; TupV [ nullary "I32"; numV four ]; caseV ("EXTMUL", [nullary "LOW"]); al_of_extension Pack.SX ])
  | V128 (V128.I64x2 (V128Op.ExtMulLowU)) -> CaseV ("VEXTBINOP", [ TupV [ nullary "I64"; numV two ]; TupV [ nullary "I32"; numV four ]; caseV ("EXTMUL", [nullary "LOW"]); al_of_extension Pack.ZX ] )
  | V128 (V128.I32x4 (V128Op.DotS)) -> CaseV ("VEXTBINOP", [ TupV [ nullary "I32"; numV four ]; TupV [ nullary "I16"; numV eight ]; nullary "DOT"; al_of_extension Pack.SX ])
  | _ -> failwith "invalid special vbinop"

let al_of_int_vcvtop = function
  | V128Op.ExtendLowS -> Some (nullary "EXTEND", Some (nullary "LOW"), None, Some (nullary "S"), None)
  | V128Op.ExtendLowU -> Some (nullary "EXTEND", Some (nullary "LOW"), None, Some (nullary "U"), None)
  | V128Op.ExtendHighS -> Some (nullary "EXTEND", Some (nullary "HIGH"), None, Some (nullary "S"), None)
  | V128Op.ExtendHighU -> Some (nullary "EXTEND", Some (nullary "HIGH"), None, Some (nullary "U"), None)
  | V128Op.TruncSatSF32x4 -> Some (nullary "TRUNC_SAT", None, Some (TupV [ nullary "F32"; numV four ]), Some (nullary "S"), None)
  | V128Op.TruncSatUF32x4 -> Some (nullary "TRUNC_SAT", None, Some (TupV [ nullary "F32"; numV four ]), Some (nullary "U"), None)
  | V128Op.TruncSatSZeroF64x2 -> Some (nullary "TRUNC_SAT", None, Some (TupV [ nullary "F64"; numV two ]), Some (nullary "S"), Some (tupV []))
  | V128Op.TruncSatUZeroF64x2 -> Some (nullary "TRUNC_SAT", None, Some (TupV [ nullary "F64"; numV two ]), Some (nullary "U"), Some (tupV []))
  | _ -> None

let al_of_float32_vcvtop = function
  | V128Op.DemoteZeroF64x2 -> Some (nullary "DEMOTE", None, Some (TupV [ nullary "F64"; numV two ]), None, Some (tupV []))
  | V128Op.ConvertSI32x4 -> Some (nullary "CONVERT", None, Some (TupV [ nullary "I32"; numV four ]), Some (nullary "S"), None)
  | V128Op.ConvertUI32x4 -> Some (nullary "CONVERT", None, Some (TupV [ nullary "I32"; numV four ]), Some (nullary "U"), None)
  | _ -> None

let al_of_float64_vcvtop = function
  | V128Op.PromoteLowF32x4 -> Some (nullary "PROMOTE", Some (nullary "LOW"), Some (TupV [ nullary "F32"; numV four ]), None, None)
  | V128Op.ConvertSI32x4 -> Some (nullary "CONVERT", Some (nullary "LOW"), Some (TupV [ nullary "I32"; numV four ]), Some (nullary "S"), None)
  | V128Op.ConvertUI32x4 -> Some (nullary "CONVERT", Some (nullary "LOW"), Some (TupV [ nullary "I32"; numV four ]), Some (nullary "U"), None)
  | _ -> None

let al_of_vcvtop = function
  | V128 vop -> (
    match vop with
    | V128.I8x16 op -> (
      Option.map (fun (op', half, to_, ext, zero) ->
        let sh = match to_ with Some sh -> sh | None -> (
          match half with
          | Some _ -> failwith "invalid vcvtop"
          | None -> TupV [ nullary "I8"; numV sixteen ]
        ) in
        [ TupV [ nullary "I8"; numV sixteen ]; op'; optV half; sh; optV ext; CaseV ("ZERO", [OptV zero]) ]
      ) (al_of_int_vcvtop op)
    )
    | V128.I16x8 op -> (
      Option.map (fun (op', half, to_, ext, zero) ->
        let sh = match to_ with Some sh -> sh | None -> (
          match half with
          | Some _ -> TupV [ nullary "I8"; numV sixteen ]
          | None -> TupV [ nullary "I16"; numV eight ]
        ) in
        [ TupV [ nullary "I16"; numV eight ]; op'; optV half; sh; optV ext; CaseV ("ZERO", [OptV zero]) ]
      ) (al_of_int_vcvtop op)
    )
    | V128.I32x4 op -> (
      Option.map (fun (op', half, to_, ext, zero) ->
        let sh = match to_ with Some sh -> sh | None -> (
          match half with
          | Some _ -> TupV [ nullary "I16"; numV eight ]
          | None -> TupV [ nullary "I32"; numV four ]
        ) in
        [ TupV [ nullary "I32"; numV four ]; op'; optV half; sh; optV ext; CaseV ("ZERO", [OptV zero]) ]
      ) (al_of_int_vcvtop op)
    )
    | V128.I64x2 op -> (
      Option.map (fun (op', half, to_, ext, zero) ->
        let sh = match to_ with Some sh -> sh | None -> (
          match half with
          | Some _ -> TupV [ nullary "I32"; numV four ]
          | None -> TupV [ nullary "I64"; numV two ]
        ) in
        [ TupV [ nullary "I64"; numV two ]; op'; optV half; sh; optV ext; CaseV ("ZERO", [OptV zero]) ]
      ) (al_of_int_vcvtop op)
    )
    | V128.F32x4 op -> (
      Option.map (fun (op', half, to_, ext, zero) ->
        let sh = match to_ with Some sh -> sh | None -> (
          match half with
          | Some _ -> failwith "invalid vcvtop"
          | None -> TupV [ nullary "F32"; numV four ]
        ) in
        [ TupV [ nullary "F32"; numV four ]; op'; optV half; sh; optV ext; CaseV ("ZERO", [OptV zero]) ]
      ) (al_of_float32_vcvtop op)
    )
    | V128.F64x2 op -> (
      Option.map (fun (op', half, to_, ext, zero) ->
        let sh = match to_ with Some sh -> sh | None -> (
          match half with
          | Some _ -> TupV [ nullary "F32"; numV four ]
          | None -> TupV [ nullary "F64"; numV two ]
        ) in
        [ TupV [ nullary "F64"; numV two ]; op'; optV half; sh; optV ext; CaseV ("ZERO", [OptV zero]) ]
      ) (al_of_float64_vcvtop op)
    )
  )


let al_of_special_vcvtop = function
  | V128 (V128.I16x8 (V128Op.ExtAddPairwiseS)) -> CaseV ("VEXTUNOP", [ TupV [ nullary "I16"; numV eight]; TupV [ nullary "I8"; numV sixteen ]; nullary "EXTADD_PAIRWISE"; al_of_extension Pack.SX ])
  | V128 (V128.I16x8 (V128Op.ExtAddPairwiseU)) -> CaseV ("VEXTUNOP", [ TupV [ nullary "I16"; numV eight]; TupV [ nullary "I8"; numV sixteen ]; nullary "EXTADD_PAIRWISE"; al_of_extension Pack.ZX ])
  | V128 (V128.I32x4 (V128Op.ExtAddPairwiseS)) -> CaseV ("VEXTUNOP", [ TupV [ nullary "I32"; numV four]; TupV [ nullary "I16"; numV eight ]; nullary "EXTADD_PAIRWISE"; al_of_extension Pack.SX ])
  | V128 (V128.I32x4 (V128Op.ExtAddPairwiseU)) -> CaseV ("VEXTUNOP", [ TupV [ nullary "I32"; numV four]; TupV [ nullary "I16"; numV eight ]; nullary "EXTADD_PAIRWISE"; al_of_extension Pack.ZX ])
  | _ -> failwith "invalid vcvtop"

let al_of_int_vshiftop : V128Op.ishiftop -> value = function
  | V128Op.Shl -> nullary "SHL"
  | V128Op.ShrS -> caseV ("SHR", [nullary "S"])
  | V128Op.ShrU -> caseV ("SHR", [nullary "U"])

let al_of_vshiftop = al_of_viop al_of_int_vshiftop

let al_of_vvtestop : vec_vtestop -> value list = function
  | V128 vop -> (
    match vop with
    | V128Op.AnyTrue ->
      [ nullary "V128"; nullary "ANY_TRUE" ]
  )

let al_of_vvunop : vec_vunop -> value list = function
  | V128 vop -> (
    match vop with
    | V128Op.Not -> [ nullary "V128"; nullary "NOT" ]
  )

let al_of_vvbinop : vec_vbinop -> value list = function
  | V128 vop -> (
    match vop with
    | V128Op.And -> [ nullary "V128"; nullary "AND" ]
    | V128Op.Or -> [ nullary "V128"; nullary "OR" ]
    | V128Op.Xor -> [ nullary "V128"; nullary "XOR" ]
    | V128Op.AndNot -> [ nullary "V128"; nullary "ANDNOT" ]
  )

let al_of_vvternop : vec_vternop -> value list = function
  | V128 vop -> (
    match vop with
    | V128Op.Bitselect ->
      [ nullary "V128"; nullary "BITSELECT" ]
  )

let al_of_vsplatop : vec_splatop -> value list = function
  | V128 vop -> (
    match vop with
    | V128.I8x16 _ -> [ TupV [ nullary "I8"; numV sixteen ] ]
    | V128.I16x8 _ -> [ TupV [ nullary "I16"; numV eight ] ]
    | V128.I32x4 _ -> [ TupV [ nullary "I32"; numV four ] ]
    | V128.I64x2 _ -> [ TupV [ nullary "I64"; numV two ] ]
    | V128.F32x4 _ -> [ TupV [ nullary "F32"; numV four ] ]
    | V128.F64x2 _ -> [ TupV [ nullary "F64"; numV two ] ]
  )

let al_of_vextractop : vec_extractop -> value list = function
  | V128 vop -> (
    match vop with
    | V128.I8x16 vop' -> (
      match vop' with
      | Extract (n, ext) ->
        [ TupV [ nullary "I8"; numV sixteen ]; optV (Some (al_of_extension ext)); al_of_int n; ]
    )
    | V128.I16x8 vop' -> (
      match vop' with
      | Extract (n, ext) ->
        [ TupV [ nullary "I16"; numV eight ]; optV (Some (al_of_extension ext)); al_of_int n; ]
    )
    | V128.I32x4 vop' -> (
      match vop' with
      | Extract (n, _) -> [ TupV [ nullary "I32"; numV four ]; optV None; al_of_int n ]
    )
    | V128.I64x2 vop' -> (
      match vop' with
      | Extract (n, _) -> [ TupV [ nullary "I64"; numV two ]; optV None; al_of_int n ]
    )
    | V128.F32x4 vop' -> (
      match vop' with
      | Extract (n, _) -> [ TupV [ nullary "F32"; numV four ]; optV None; al_of_int n ]
    )
    | V128.F64x2 vop' -> (
      match vop' with
      | Extract (n, _) -> [ TupV [ nullary "F64"; numV two ]; optV None; al_of_int n ]
    )
  )

let al_of_vreplaceop : vec_replaceop -> value list = function
  | V128 vop -> (
    match vop with
    | V128.I8x16 (Replace n) -> [ TupV [ nullary "I8"; numV sixteen ]; al_of_int n ]
    | V128.I16x8 (Replace n) -> [ TupV [ nullary "I16"; numV eight ]; al_of_int n ]
    | V128.I32x4 (Replace n) -> [ TupV [ nullary "I32"; numV four ]; al_of_int n ]
    | V128.I64x2 (Replace n) -> [ TupV [ nullary "I64"; numV two ]; al_of_int n ]
    | V128.F32x4 (Replace n) -> [ TupV [ nullary "F32"; numV four ]; al_of_int n ]
    | V128.F64x2 (Replace n) -> [ TupV [ nullary "F64"; numV two ]; al_of_int n ]
  )

let al_of_pack_size = function
  | Pack.Pack8 -> al_of_int 8
  | Pack.Pack16 -> al_of_int 16
  | Pack.Pack32 -> al_of_int 32
  | Pack.Pack64 -> al_of_int 64

let al_of_pack_shape = function
  | Pack.Pack8x8 -> [NumV eight; NumV eight]
  | Pack.Pack16x4 -> [NumV sixteen; NumV four]
  | Pack.Pack32x2 -> [NumV thirtytwo; NumV two]

let al_of_extension = function
  | Pack.SX -> nullary "S"
  | Pack.ZX -> nullary "U"

let al_of_memop f memop =
  let str =
    Record.empty
    |> Record.add "ALIGN" (al_of_int memop.align)
    |> Record.add "OFFSET" (al_of_int32 memop.offset)
  in
  [ al_of_num_type memop.ty; f memop.pack ] @ al_of_memidx () @ [ StrV str ]

let al_of_pack_size_extension (p, s) = tupV [ al_of_pack_size p; al_of_extension s ]

let al_of_loadop = al_of_opt al_of_pack_size_extension |> al_of_memop

let al_of_storeop = al_of_opt al_of_pack_size |> al_of_memop

let al_of_vloadop vloadop =

  let str =
    Record.empty
    |> Record.add "ALIGN" (al_of_int vloadop.align)
    |> Record.add "OFFSET" (al_of_int32 vloadop.offset)
  in

  let vmemop = match vloadop.pack with
  | Option.Some (pack_size, vextension) -> (
    match vextension with
    | Pack.ExtLane (pack_shape, extension) -> CaseV ("SHAPE", al_of_pack_shape pack_shape @ [al_of_extension extension])
    | Pack.ExtSplat -> CaseV ("SPLAT", [ al_of_pack_size pack_size ])
    | Pack.ExtZero -> CaseV ("ZERO", [ al_of_pack_size pack_size ])
  ) |> Option.some |> optV
  | None -> OptV None in

  [ vmemop ] @ al_of_memidx () @ [ StrV str ]

let al_of_vstoreop vstoreop =
  let str =
    Record.empty
    |> Record.add "ALIGN" (al_of_int vstoreop.align)
    |> Record.add "OFFSET" (al_of_int32 vstoreop.offset)
  in

  al_of_memidx () @ [ StrV str; ]

let al_of_vlaneop vlaneop =
  let (vmemop, laneidx) = vlaneop in
  let pack_size = vmemop.pack in

  let str =
    Record.empty
    |> Record.add "ALIGN" (al_of_int vmemop.align)
    |> Record.add "OFFSET" (al_of_int32 vmemop.offset)
  in

  [ al_of_pack_size pack_size; ] @ al_of_memidx () @ [ StrV str; al_of_int laneidx ]

(* Construct instruction *)

let rec al_of_instr instr =
  match instr.it with
  (* wasm values *)
  | Const num -> al_of_num num.it
  | VecConst vec -> al_of_vec vec.it
  | RefNull ht -> CaseV ("REF.NULL", [ al_of_heap_type ht ])
  (* wasm instructions *)
  | Unreachable -> nullary "UNREACHABLE"
  | Nop -> nullary "NOP"
  | Drop -> nullary "DROP"
  | Unary op -> CaseV ("UNOP", al_of_unop op)
  | Binary op -> CaseV ("BINOP", al_of_binop op)
  | Test op -> CaseV ("TESTOP", al_of_testop op)
  | Compare op -> CaseV ("RELOP", al_of_relop op)
  | Convert op -> CaseV ("CVTOP", al_of_cvtop op)
  | VecTest vop -> CaseV ("VTESTOP", al_of_vtestop vop)
  | VecCompare vop -> CaseV ("VRELOP", al_of_vrelop vop)
  | VecUnary vop -> CaseV ("VUNOP", al_of_vunop vop)
  | VecBinary vop -> (match al_of_vbinop vop with Some l -> CaseV ("VBINOP", l) | None -> al_of_special_vbinop vop)
  | VecConvert vop -> (match al_of_vcvtop vop with Some l -> CaseV ("VCVTOP", l) | None -> al_of_special_vcvtop vop)
  | VecShift vop -> CaseV ("VSHIFTOP", al_of_vshiftop vop)
  | VecBitmask vop -> CaseV ("VBITMASK", al_of_vbitmaskop vop)
  | VecTestBits vop -> CaseV ("VVTESTOP", al_of_vvtestop vop)
  | VecUnaryBits vop -> CaseV ("VVUNOP", al_of_vvunop vop)
  | VecBinaryBits vop -> CaseV ("VVBINOP", al_of_vvbinop vop)
  | VecTernaryBits vop -> CaseV ("VVTERNOP", al_of_vvternop vop)
  | VecSplat vop -> CaseV ("VSPLAT", al_of_vsplatop vop)
  | VecExtract vop -> CaseV ("VEXTRACT_LANE", al_of_vextractop vop)
  | VecReplace vop -> CaseV ("VREPLACE_LANE", al_of_vreplaceop vop)
  | RefIsNull -> nullary "REF.IS_NULL"
  | RefFunc idx -> CaseV ("REF.FUNC", [ al_of_idx idx ])
  | Select vtl_opt -> CaseV ("SELECT", [ al_of_opt (al_of_list al_of_val_type) vtl_opt ])
  | LocalGet idx -> CaseV ("LOCAL.GET", [ al_of_idx idx ])
  | LocalSet idx -> CaseV ("LOCAL.SET", [ al_of_idx idx ])
  | LocalTee idx -> CaseV ("LOCAL.TEE", [ al_of_idx idx ])
  | GlobalGet idx -> CaseV ("GLOBAL.GET", [ al_of_idx idx ])
  | GlobalSet idx -> CaseV ("GLOBAL.SET", [ al_of_idx idx ])
  | TableGet idx -> CaseV ("TABLE.GET", [ al_of_idx idx ])
  | TableSet idx -> CaseV ("TABLE.SET", [ al_of_idx idx ])
  | TableSize idx -> CaseV ("TABLE.SIZE", [ al_of_idx idx ])
  | TableGrow idx -> CaseV ("TABLE.GROW", [ al_of_idx idx ])
  | TableFill idx -> CaseV ("TABLE.FILL", [ al_of_idx idx ])
  | TableCopy (idx1, idx2) -> CaseV ("TABLE.COPY", [ al_of_idx idx1; al_of_idx idx2 ])
  | TableInit (idx1, idx2) -> CaseV ("TABLE.INIT", [ al_of_idx idx1; al_of_idx idx2 ])
  | ElemDrop idx -> CaseV ("ELEM.DROP", [ al_of_idx idx ])
  | Block (bt, instrs) ->
    CaseV ("BLOCK", [ al_of_blocktype bt; al_of_list al_of_instr instrs ])
  | Loop (bt, instrs) ->
    CaseV ("LOOP", [ al_of_blocktype bt; al_of_list al_of_instr instrs ])
  | If (bt, instrs1, instrs2) ->
    CaseV ("IF", [
      al_of_blocktype bt;
      al_of_list al_of_instr instrs1;
      al_of_list al_of_instr instrs2;
    ])
  | Br idx -> CaseV ("BR", [ al_of_idx idx ])
  | BrIf idx -> CaseV ("BR_IF", [ al_of_idx idx ])
  | BrTable (idxs, idx) ->
    CaseV ("BR_TABLE", [ al_of_list al_of_idx idxs; al_of_idx idx ])
  | BrOnNull idx -> CaseV ("BR_ON_NULL", [ al_of_idx idx ])
  | BrOnNonNull idx -> CaseV ("BR_ON_NON_NULL", [ al_of_idx idx ])
  | BrOnCast (idx, rt1, rt2) ->
    CaseV ("BR_ON_CAST", [ al_of_idx idx; al_of_ref_type rt1; al_of_ref_type rt2 ])
  | BrOnCastFail (idx, rt1, rt2) ->
    CaseV ("BR_ON_CAST_FAIL", [ al_of_idx idx; al_of_ref_type rt1; al_of_ref_type rt2 ])
  | Return -> nullary "RETURN"
  | Call idx -> CaseV ("CALL", [ al_of_idx idx ])
  | CallRef idx -> CaseV ("CALL_REF", [ optV (Some (al_of_idx idx)) ])
  | CallIndirect (idx1, idx2) ->
    let args = al_with_version [ 2; 3 ] al_of_idx idx1 @ [ al_of_idx idx2 ] in
    CaseV ("CALL_INDIRECT", args)
  | ReturnCall idx -> CaseV ("RETURN_CALL", [ al_of_idx idx ])
  | ReturnCallRef idx -> CaseV ("RETURN_CALL_REF", [ optV (Some (al_of_idx idx)) ])
  | ReturnCallIndirect (idx1, idx2) ->
    CaseV ("RETURN_CALL_INDIRECT", [ al_of_idx idx1; al_of_idx idx2 ])
  | Load loadop -> CaseV ("LOAD", al_of_loadop loadop)
  | Store storeop -> CaseV ("STORE", al_of_storeop storeop)
  | VecLoad vloadop -> CaseV ("VLOAD", al_of_vloadop vloadop)
  | VecLoadLane vlaneop -> CaseV ("VLOAD_LANE", al_of_vlaneop vlaneop)
  | VecStore vstoreop -> CaseV ("VSTORE", al_of_vstoreop vstoreop)
  | VecStoreLane vlaneop -> CaseV ("VSTORE_LANE", al_of_vlaneop vlaneop)
  | MemorySize -> CaseV ("MEMORY.SIZE", al_of_memidx ())
  | MemoryGrow -> CaseV ("MEMORY.GROW", al_of_memidx ())
  | MemoryFill -> CaseV ("MEMORY.FILL", al_of_memidx ())
  | MemoryCopy -> CaseV ("MEMORY.COPY", al_of_memidx () @ al_of_memidx ())
  | MemoryInit i32 -> CaseV ("MEMORY.INIT", (al_of_memidx ()) @ [ al_of_idx i32 ])
  | DataDrop idx -> CaseV ("DATA.DROP", [ al_of_idx idx ])
  | RefAsNonNull -> nullary "REF.AS_NON_NULL"
  | RefTest rt -> CaseV ("REF.TEST", [ al_of_ref_type rt ])
  | RefCast rt -> CaseV ("REF.CAST", [ al_of_ref_type rt ])
  | RefEq -> nullary "REF.EQ"
  | RefI31 -> nullary "REF.I31"
  | I31Get ext -> CaseV ("I31.GET", [ al_of_extension ext ])
  | StructNew (idx, Explicit) -> CaseV ("STRUCT.NEW", [ al_of_idx idx ])
  | StructNew (idx, Implicit) -> CaseV ("STRUCT.NEW_DEFAULT", [ al_of_idx idx ])
  | StructGet (idx1, idx2, ext_opt) ->
    CaseV ("STRUCT.GET", [
      al_of_opt al_of_extension ext_opt;
      al_of_idx idx1;
      al_of_idx idx2;
    ])
  | StructSet (idx1, idx2) -> CaseV ("STRUCT.SET", [ al_of_idx idx1; al_of_idx idx2 ])
  | ArrayNew (idx, Explicit) -> CaseV ("ARRAY.NEW", [ al_of_idx idx ])
  | ArrayNew (idx, Implicit) -> CaseV ("ARRAY.NEW_DEFAULT", [ al_of_idx idx ])
  | ArrayNewFixed (idx, i32) ->
    CaseV ("ARRAY.NEW_FIXED", [ al_of_idx idx; al_of_int32 i32 ])
  | ArrayNewElem (idx1, idx2) ->
    CaseV ("ARRAY.NEW_ELEM", [ al_of_idx idx1; al_of_idx idx2 ])
  | ArrayNewData (idx1, idx2) ->
    CaseV ("ARRAY.NEW_DATA", [ al_of_idx idx1; al_of_idx idx2 ])
  | ArrayGet (idx, ext_opt) ->
    CaseV ("ARRAY.GET", [ al_of_opt al_of_extension ext_opt; al_of_idx idx ])
  | ArraySet idx -> CaseV ("ARRAY.SET", [ al_of_idx idx ])
  | ArrayLen -> nullary "ARRAY.LEN"
  | ArrayCopy (idx1, idx2) -> CaseV ("ARRAY.COPY", [ al_of_idx idx1; al_of_idx idx2 ])
  | ArrayFill idx -> CaseV ("ARRAY.FILL", [ al_of_idx idx ])
  | ArrayInitData (idx1, idx2) ->
    CaseV ("ARRAY.INIT_DATA", [ al_of_idx idx1; al_of_idx idx2 ])
  | ArrayInitElem (idx1, idx2) ->
    CaseV ("ARRAY.INIT_ELEM", [ al_of_idx idx1; al_of_idx idx2 ])
  | ExternConvert Internalize -> nullary "ANY.CONVERT_EXTERN"
  | ExternConvert Externalize -> nullary "EXTERN.CONVERT_ANY"
  (* | _ -> CaseV ("TODO: Unconstructed Wasm instruction (al_of_instr)", []) *)

let al_of_const const = al_of_list al_of_instr const.it


(* Construct module *)

let al_of_type ty =
  match !version with
  | 3 ->
    CaseV ("TYPE", [ al_of_rec_type ty.it ])
  | _ ->
    let sub_types =
      al_of_rec_type ty.it
      |> arg_of_case "REC" 0
      |> unwrap_listv_to_list
    in

    match sub_types with
    | [ subtype ] ->
      let rt = subtype |> arg_of_case "SUBD" 2 |> arg_of_case "FUNC" 0 in
      CaseV ("TYPE", [ rt ])
    | _ -> failwith ("Rectype is not supported in Wasm " ^ (string_of_int !version))

let al_of_local l = CaseV ("LOCAL", [ al_of_val_type l.it.ltype ])

let al_of_func func =
  CaseV ("FUNC", [
    al_of_idx func.it.ftype;
    al_of_list al_of_local func.it.locals;
    al_of_list al_of_instr func.it.body;
  ])

let al_of_global global =
  CaseV ("GLOBAL", [
    al_of_global_type global.it.gtype;
    al_of_const global.it.ginit;
  ])

let al_of_table table =
  match !version with
  | 1 -> CaseV ("TABLE", [ al_of_table_type table.it.ttype |> arg_of_tup 0 ])
  | 2 -> CaseV ("TABLE", [ al_of_table_type table.it.ttype ])
  | 3 -> CaseV ("TABLE", [ al_of_table_type table.it.ttype; al_of_const table.it.tinit ])
  | _ -> failwith "Unsupported version"

let al_of_memory memory =
  let arg = al_of_memory_type memory.it.mtype in
  let arg' =
    if !version = 1 then
      arg_of_case "I8" 0 arg
    else arg
  in
  CaseV ("MEMORY", [ arg' ])

let al_of_segment segment =
  match segment.it with
  | Passive -> nullary "PASSIVE"
  | Active { index; offset } ->
    CaseV ("ACTIVE", [ al_of_idx index; al_of_const offset ])
  | Declarative -> nullary "DECLARE"

let al_of_elem elem =
  if !version = 1 then
    CaseV ("ELEM", [
      al_of_segment elem.it.emode |> arg_of_case "ACTIVE" 1;
      al_of_list al_of_const elem.it.einit
      |> unwrap_listv_to_list
      |> List.map (fun expr -> expr |> unwrap_listv_to_list |> List.hd |> (arg_of_case "REF.FUNC" 0))
      |> listV_of_list;
    ])
  else
    CaseV ("ELEM", [
      al_of_ref_type elem.it.etype;
      al_of_list al_of_const elem.it.einit;
      al_of_segment elem.it.emode;
    ])

let al_of_data data =
  let seg = al_of_segment data.it.dmode in
  let bytes_ = al_of_bytes data.it.dinit in
  if !version = 1 then
    CaseV ("DATA", [ arg_of_case "ACTIVE" 1 seg; bytes_ ])
  else
    CaseV ("DATA", [ bytes_; seg ])

let al_of_import_desc module_ idesc =
  match idesc.it with
  | FuncImport x ->
    let dts = def_types_of module_ in
    let dt = x.it |> Int32.to_int |> List.nth dts |> al_of_def_type in
    CaseV ("FUNC", [ dt ])
  | TableImport tt -> CaseV ("TABLE", [ al_of_table_type tt ])
  | MemoryImport mt -> CaseV ("MEM", [ al_of_memory_type mt ])
  | GlobalImport gt -> CaseV ("GLOBAL", [ al_of_global_type gt ])

let al_of_import module_ import =
  CaseV ("IMPORT", [
    al_of_name import.it.module_name;
    al_of_name import.it.item_name;
    al_of_import_desc module_ import.it.idesc;
  ])

let al_of_export_desc export_desc = match export_desc.it with
  | FuncExport idx -> CaseV ("FUNC", [ al_of_idx idx ])
  | TableExport idx -> CaseV ("TABLE", [ al_of_idx idx ])
  | MemoryExport idx -> CaseV ("MEM", [ al_of_idx idx ])
  | GlobalExport idx -> CaseV ("GLOBAL", [ al_of_idx idx ])

let al_of_start start = CaseV ("START", [ al_of_idx start.it.sfunc ])

let al_of_export export =
  CaseV ("EXPORT", [ al_of_name export.it.name; al_of_export_desc export.it.edesc ])

let al_of_module module_ =
  CaseV ("MODULE", [
    al_of_list al_of_type module_.it.types;
    al_of_list (al_of_import module_) module_.it.imports;
    al_of_list al_of_func module_.it.funcs;
    al_of_list al_of_global module_.it.globals;
    al_of_list al_of_table module_.it.tables;
    al_of_list al_of_memory module_.it.memories;
    al_of_list al_of_elem module_.it.elems;
    al_of_list al_of_data module_.it.datas;
    al_of_opt al_of_start module_.it.start;
    al_of_list al_of_export module_.it.exports;
  ])
