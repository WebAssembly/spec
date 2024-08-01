open Source
open Ast
open Script
open Values
open Types
open Sexpr


(* Generic formatting *)

let nat n = I32.to_string_u (I32.of_int_u n)
let nat32 = I32.to_string_u
let nat64 = I64.to_string_u

let add_hex_char buf c = Printf.bprintf buf "\\%02x" (Char.code c)
let add_char buf = function
  | '\n' -> Buffer.add_string buf "\\n"
  | '\r' -> Buffer.add_string buf "\\r"
  | '\t' -> Buffer.add_string buf "\\t"
  | '\'' -> Buffer.add_string buf "\\'"
  | '\"' -> Buffer.add_string buf "\\\""
  | '\\' -> Buffer.add_string buf "\\\\"
  | c when '\x20' <= c && c < '\x7f' -> Buffer.add_char buf c
  | c -> add_hex_char buf c
let add_unicode_char buf = function
  | (0x09 | 0x0a) as uc -> add_char buf (Char.chr uc)
  | uc when 0x20 <= uc && uc < 0x7f -> add_char buf (Char.chr uc)
  | uc -> Printf.bprintf buf "\\u{%02x}" uc

let string_with iter add_char s =
  let buf = Buffer.create 256 in
  Buffer.add_char buf '\"';
  iter (add_char buf) s;
  Buffer.add_char buf '\"';
  Buffer.contents buf

let bytes = string_with String.iter add_hex_char
let string = string_with String.iter add_char
let name = string_with List.iter add_unicode_char

let list_of_opt = function None -> [] | Some x -> [x]

let list f xs = List.map f xs
let listi f xs = List.mapi f xs
let opt f xo = list f (list_of_opt xo)

let tab head f xs = if xs = [] then [] else [Node (head, list f xs)]
let atom f x = Atom (f x)

let break_bytes s =
  let ss = Lib.String.breakup s 16 in
  list (atom bytes) ss

let break_string s =
  let ss, s' = Lib.List.split_last (Lib.String.split s '\n') in
  list (atom string) (List.map (fun s -> s ^ "\n") ss @ [s'])


(* Types *)

let num_type t = string_of_num_type t
let vec_type t = string_of_vec_type t
let ref_type t = string_of_ref_type t
let refed_type t = string_of_refed_type t
let value_type t = string_of_value_type t

let index_type t = string_of_value_type (value_type_of_index_type t)

let decls kind ts = tab kind (atom value_type) ts

let func_type (FuncType (ins, out)) =
  Node ("func", decls "param" ins @ decls "result" out)

let struct_type = func_type

let limits nat {min; max} =
  String.concat " " (nat min :: opt nat max)

let global_type = function
  | GlobalType (t, Immutable) -> atom string_of_value_type t
  | GlobalType (t, Mutable) -> Node ("mut", [atom string_of_value_type t])

let pack_size = function
  | Pack8 -> "8"
  | Pack16 -> "16"
  | Pack32 -> "32"
  | Pack64 -> "64"

let extension = function
  | SX -> "_s"
  | ZX -> "_u"

let pack_shape = function
  | Pack8x8 -> "8x8"
  | Pack16x4 -> "16x4"
  | Pack32x2 -> "32x2"

let vec_extension sz = function
  | ExtLane (sh, ext) -> pack_shape sh ^ extension ext
  | ExtSplat -> pack_size sz ^ "_splat"
  | ExtZero -> pack_size sz ^ "_zero"


(* Operators *)

module IntOp =
struct
  open Ast.IntOp

  let testop xx = function
    | Eqz -> "eqz"

  let relop xx = function
    | Eq -> "eq"
    | Ne -> "ne"
    | LtS -> "lt_s"
    | LtU -> "lt_u"
    | GtS -> "gt_s"
    | GtU -> "gt_u"
    | LeS -> "le_s"
    | LeU -> "le_u"
    | GeS -> "ge_s"
    | GeU -> "ge_u"

  let unop xx = function
    | Clz -> "clz"
    | Ctz -> "ctz"
    | Popcnt -> "popcnt"
    | ExtendS sz -> "extend" ^ pack_size sz ^ "_s"

  let binop xx = function
    | Add -> "add"
    | Sub -> "sub"
    | Mul -> "mul"
    | DivS -> "div_s"
    | DivU -> "div_u"
    | RemS -> "rem_s"
    | RemU -> "rem_u"
    | And -> "and"
    | Or -> "or"
    | Xor -> "xor"
    | Shl -> "shl"
    | ShrS -> "shr_s"
    | ShrU -> "shr_u"
    | Rotl -> "rotl"
    | Rotr -> "rotr"

  let cvtop xx = function
    | ExtendSI32 -> "extend_i32_s"
    | ExtendUI32 -> "extend_i32_u"
    | WrapI64 -> "wrap_i64"
    | TruncSF32 -> "trunc_f32_s"
    | TruncUF32 -> "trunc_f32_u"
    | TruncSF64 -> "trunc_f64_s"
    | TruncUF64 -> "trunc_f64_u"
    | TruncSatSF32 -> "trunc_sat_f32_s"
    | TruncSatUF32 -> "trunc_sat_f32_u"
    | TruncSatSF64 -> "trunc_sat_f64_s"
    | TruncSatUF64 -> "trunc_sat_f64_u"
    | ReinterpretFloat -> "reinterpret_f" ^ xx
end

module FloatOp =
struct
  open Ast.FloatOp

  let testop xx = function (_ : testop) -> .

  let relop xx = function
    | Eq -> "eq"
    | Ne -> "ne"
    | Lt -> "lt"
    | Gt -> "gt"
    | Le -> "le"
    | Ge -> "ge"

  let unop xx = function
    | Neg -> "neg"
    | Abs -> "abs"
    | Ceil -> "ceil"
    | Floor -> "floor"
    | Trunc -> "trunc"
    | Nearest -> "nearest"
    | Sqrt -> "sqrt"

  let binop xx = function
    | Add -> "add"
    | Sub -> "sub"
    | Mul -> "mul"
    | Div -> "div"
    | Min -> "min"
    | Max -> "max"
    | CopySign -> "copysign"

  let cvtop xx = function
    | ConvertSI32 -> "convert_i32_s"
    | ConvertUI32 -> "convert_i32_u"
    | ConvertSI64 -> "convert_i64_s"
    | ConvertUI64 -> "convert_i64_u"
    | PromoteF32 -> "promote_f32"
    | DemoteF64 -> "demote_f64"
    | ReinterpretInt -> "reinterpret_i" ^ xx
end

module V128Op =
struct
  open Ast.V128Op

  let half = function
    | "16x8" -> "8x16"
    | "32x4" -> "16x8"
    | "64x2" -> "32x4"
    | _ -> assert false

  let double = function
    | "8x16" -> "16x8"
    | "16x8" -> "32x4"
    | "32x4" -> "64x2"
    | _ -> assert false

  let voidop xxxx = function (_ : void) -> .

  let itestop xxxx (op : itestop) = match op with
    | AllTrue -> "all_true"

  let iunop xxxx (op : iunop) = match op with
    | Neg -> "neg"
    | Abs -> "abs"
    | Popcnt -> "popcnt"

  let funop xxxx (op : funop) = match op with
    | Neg -> "neg"
    | Abs -> "abs"
    | Sqrt -> "sqrt"
    | Ceil -> "ceil"
    | Floor -> "floor"
    | Trunc -> "trunc"
    | Nearest -> "nearest"

  let ibinop xxxx (op : ibinop) = match op with
    | Add -> "add"
    | AddSatS -> "add_sat_s"
    | AddSatU -> "add_sat_u"
    | Sub -> "sub"
    | SubSatS -> "sub_sat_s"
    | SubSatU -> "sub_sat_u"
    | Mul -> "mul"
    | DotS -> "dot_i" ^ half xxxx ^ "_s"
    | ExtMulLowS -> "extmul_low_i" ^ half xxxx ^ "_s"
    | ExtMulHighS -> "extmul_high_i" ^ half xxxx ^ "_s"
    | ExtMulLowU -> "extmul_low_i" ^ half xxxx ^ "_u"
    | ExtMulHighU -> "extmul_high_i" ^ half xxxx ^ "_u"
    | Q15MulRSatS -> "q15mulr_sat_s"
    | MinS -> "min_s"
    | MinU -> "min_u"
    | MaxS -> "max_s"
    | MaxU -> "max_u"
    | AvgrU -> "avgr_u"
    | NarrowS -> "narrow_i" ^ double xxxx ^ "_s"
    | NarrowU -> "narrow_i" ^ double xxxx ^ "_u"
    | Shuffle is -> "shuffle " ^ String.concat " " (List.map nat is)
    | Swizzle -> "swizzle"

  let fbinop xxxx (op : fbinop) = match op with
    | Add -> "add"
    | Sub -> "sub"
    | Mul -> "mul"
    | Div -> "div"
    | Min -> "min"
    | Max -> "max"
    | Pmin -> "pmin"
    | Pmax -> "pmax"

  let irelop xxxx (op : irelop) = match op with
    | Eq -> "eq"
    | Ne -> "ne"
    | LtS -> "lt_s"
    | LtU -> "lt_u"
    | GtS -> "gt_s"
    | GtU -> "gt_u"
    | LeS -> "le_s"
    | LeU -> "le_u"
    | GeS -> "ge_s"
    | GeU -> "ge_u"

  let frelop xxxx (op : frelop) = match op with
    | Eq -> "eq"
    | Ne -> "ne"
    | Lt -> "lt"
    | Le -> "le"
    | Gt -> "gt"
    | Ge -> "ge"

  let icvtop xxxx (op : icvtop) = match op with
    | ExtendLowS -> "extend_low_i" ^ half xxxx ^ "_s"
    | ExtendLowU -> "extend_low_i" ^ half xxxx ^ "_u"
    | ExtendHighS -> "extend_high_i" ^ half xxxx ^ "_s"
    | ExtendHighU -> "extend_high_i" ^ half xxxx ^ "_u"
    | ExtAddPairwiseS -> "extadd_pairwise_i" ^ half xxxx ^ "_s"
    | ExtAddPairwiseU -> "extadd_pairwise_i" ^ half xxxx ^ "_u"
    | TruncSatSF32x4 -> "trunc_sat_f32x4_s"
    | TruncSatUF32x4 -> "trunc_sat_f32x4_u"
    | TruncSatSZeroF64x2 -> "trunc_sat_f64x2_s_zero"
    | TruncSatUZeroF64x2 -> "trunc_sat_f64x2_u_zero"

  let fcvtop xxxx (op : fcvtop) = match op with
    | DemoteZeroF64x2  -> "demote_f64x2_zero"
    | PromoteLowF32x4  -> "promote_low_f32x4"
    | ConvertSI32x4 ->
      "convert_" ^ (if xxxx = "32x4" then "" else "low_") ^ "i32x4_s"
    | ConvertUI32x4 ->
      "convert_" ^ (if xxxx = "32x4" then "" else "low_") ^ "i32x4_u"

  let ishiftop xxxx (op : ishiftop) = match op with
    | Shl -> "shl"
    | ShrS -> "shr_s"
    | ShrU -> "shr_u"

  let ibitmaskop xxxx (op : ibitmaskop) = match op with
    | Bitmask -> "bitmask"

  let vtestop (op : vtestop) = match op with
    | AnyTrue -> "any_true"

  let vunop (op : vunop) = match op with
    | Not -> "not"

  let vbinop (op : vbinop) = match op with
    | And -> "and"
    | AndNot -> "andnot"
    | Or -> "or"
    | Xor -> "xor"

  let vternop (op : vternop) = match op with
    | Bitselect -> "bitselect"

  let splatop xxxx (op : nsplatop) = match op with
    | Splat -> "splat"

  let pextractop xxxx (op : extension nextractop) = match op with
    | Extract (i, ext) -> "extract_lane" ^ extension ext ^ " " ^ nat i

  let extractop xxxx (op : unit nextractop) = match op with
    | Extract (i, ()) -> "extract_lane " ^ nat i

  let replaceop xxxx (op : nreplaceop) = match op with
    | Replace i -> "replace_lane " ^ nat i

  let lane_oper (pop, iop, fop) op =
    match op with
    | V128.I8x16 o -> pop "8x16" o
    | V128.I16x8 o -> pop "16x8" o
    | V128.I32x4 o -> iop "32x4" o
    | V128.I64x2 o -> iop "64x2" o
    | V128.F32x4 o -> fop "32x4" o
    | V128.F64x2 o -> fop "64x2" o
end

let oper (iop, fop) op =
  num_type (type_of_num op) ^ "." ^
  (match op with
  | I32 o -> iop "32" o
  | I64 o -> iop "64" o
  | F32 o -> fop "32" o
  | F64 o -> fop "64" o
  )

let vec_oper (vop) op =
  match op with
  | V128 o -> "v128." ^ vop o

let vec_shape_oper (pop, iop, fop) op =
  match op with
  | V128 o -> V128.string_of_shape o ^ "." ^ V128Op.lane_oper (pop, iop, fop) o

let unop = oper (IntOp.unop, FloatOp.unop)
let binop = oper (IntOp.binop, FloatOp.binop)
let testop = oper (IntOp.testop, FloatOp.testop)
let relop = oper (IntOp.relop, FloatOp.relop)
let cvtop = oper (IntOp.cvtop, FloatOp.cvtop)

let vec_unop = vec_shape_oper (V128Op.iunop, V128Op.iunop, V128Op.funop)
let vec_binop = vec_shape_oper (V128Op.ibinop, V128Op.ibinop, V128Op.fbinop)
let vec_testop = vec_shape_oper (V128Op.itestop, V128Op.itestop, V128Op.voidop)
let vec_relop = vec_shape_oper (V128Op.irelop, V128Op.irelop, V128Op.frelop)
let vec_cvtop = vec_shape_oper (V128Op.icvtop, V128Op.icvtop, V128Op.fcvtop)
let vec_shiftop = vec_shape_oper (V128Op.ishiftop, V128Op.ishiftop, V128Op.voidop)
let vec_bitmaskop = vec_shape_oper (V128Op.ibitmaskop, V128Op.ibitmaskop, V128Op.voidop)
let vec_vunop = vec_oper (V128Op.vunop)
let vec_vbinop = vec_oper (V128Op.vbinop)
let vec_vternop = vec_oper (V128Op.vternop)
let vec_vtestop = vec_oper (V128Op.vtestop)
let vec_splatop = vec_shape_oper (V128Op.splatop, V128Op.splatop, V128Op.splatop)
let vec_extractop = vec_shape_oper (V128Op.pextractop, V128Op.extractop, V128Op.extractop)
let vec_replaceop = vec_shape_oper (V128Op.replaceop, V128Op.replaceop, V128Op.replaceop)

let memop name typ {ty; align; offset; _} sz =
  typ ty ^ "." ^ name ^
  (if offset = 0L then "" else " offset=" ^ nat64 offset) ^
  (if 1 lsl align = sz then "" else " align=" ^ nat (1 lsl align))

let loadop op =
  match op.pack with
  | None -> memop "load" num_type op (num_size op.ty)
  | Some (sz, ext) ->
    memop ("load" ^ pack_size sz ^ extension ext) num_type op (packed_size sz)

let storeop op =
  match op.pack with
  | None -> memop "store" num_type op (num_size op.ty)
  | Some sz -> memop ("store" ^ pack_size sz) num_type op (packed_size sz)

let vec_loadop (op : vec_loadop) =
  match op.pack with
  | None -> memop "load" vec_type op (vec_size op.ty)
  | Some (sz, ext) ->
    memop ("load" ^ vec_extension sz ext) vec_type op (packed_size sz)

let vec_storeop op =
  memop "store" vec_type op (vec_size op.ty)

let vec_laneop instr (op, i) =
  memop (instr ^ pack_size op.pack ^ "_lane") vec_type op
    (packed_size op.pack) ^ " " ^ nat i


(* Expressions *)

let var x = nat32 x.it
let num v = string_of_num v.it
let vec v = string_of_vec v.it
let constop v = num_type (type_of_num v) ^ ".const"
let vec_constop v = vec_type (type_of_vec v) ^ ".const i32x4"

let block_type = function
  | VarBlockType x -> [Node ("type " ^ var x, [])]
  | ValBlockType ts -> decls "result" (list_of_opt ts)

let rec instr e =
  let head, inner =
    match e.it with
    | Unreachable -> "unreachable", []
    | Nop -> "nop", []
    | Drop -> "drop", []
    | Select None -> "select", []
    | Select (Some []) -> "select", [Node ("result", [])]
    | Select (Some ts) -> "select", decls "result" ts
    | Block (bt, es) -> "block", block_type bt @ list instr es
    | Loop (bt, es) -> "loop", block_type bt @ list instr es
    | If (bt, es1, es2) ->
      "if", block_type bt @
        [Node ("then", list instr es1); Node ("else", list instr es2)]
    | Br x -> "br " ^ var x, []
    | BrIf x -> "br_if " ^ var x, []
    | BrTable (xs, x) ->
      "br_table " ^ String.concat " " (list var (xs @ [x])), []
    | Return -> "return", []
    | Call x -> "call " ^ var x, []
    | CallIndirect (x, y) ->
      "call_indirect " ^ var x, [Node ("type " ^ var y, [])]
    | LocalGet x -> "local.get " ^ var x, []
    | LocalSet x -> "local.set " ^ var x, []
    | LocalTee x -> "local.tee " ^ var x, []
    | GlobalGet x -> "global.get " ^ var x, []
    | GlobalSet x -> "global.set " ^ var x, []
    | TableGet x -> "table.get " ^ var x, []
    | TableSet x -> "table.set " ^ var x, []
    | TableSize x -> "table.size " ^ var x, []
    | TableGrow x -> "table.grow " ^ var x, []
    | TableFill x -> "table.fill " ^ var x, []
    | TableCopy (x, y) -> "table.copy " ^ var x ^ " " ^ var y, []
    | TableInit (x, y) -> "table.init " ^ var x ^ " " ^ var y, []
    | ElemDrop x -> "elem.drop " ^ var x, []
    | Load op -> loadop op, []
    | Store op -> storeop op, []
    | VecLoad op -> vec_loadop op, []
    | VecStore op -> vec_storeop op, []
    | VecLoadLane op -> vec_laneop "load" op, []
    | VecStoreLane op -> vec_laneop "store" op, []
    | MemorySize -> "memory.size", []
    | MemoryGrow -> "memory.grow", []
    | MemoryFill -> "memory.fill", []
    | MemoryCopy -> "memory.copy", []
    | MemoryInit x -> "memory.init " ^ var x, []
    | DataDrop x -> "data.drop " ^ var x, []
    | RefNull t -> "ref.null", [Atom (refed_type t)]
    | RefIsNull -> "ref.is_null", []
    | RefFunc x -> "ref.func " ^ var x, []
    | Const n -> constop n.it ^ " " ^ num n, []
    | Test op -> testop op, []
    | Compare op -> relop op, []
    | Unary op -> unop op, []
    | Binary op -> binop op, []
    | Convert op -> cvtop op, []
    | VecConst v -> vec_constop v.it ^ " " ^ vec v, []
    | VecTest op -> vec_testop op, []
    | VecUnary op -> vec_unop op, []
    | VecBinary op -> vec_binop op, []
    | VecCompare op -> vec_relop op, []
    | VecConvert op -> vec_cvtop op, []
    | VecShift op -> vec_shiftop op, []
    | VecBitmask op -> vec_bitmaskop op, []
    | VecTestBits op -> vec_vtestop op, []
    | VecUnaryBits op -> vec_vunop op, []
    | VecBinaryBits op -> vec_vbinop op, []
    | VecTernaryBits op -> vec_vternop op, []
    | VecSplat op -> vec_splatop op, []
    | VecExtract op -> vec_extractop op, []
    | VecReplace op -> vec_replaceop op, []
  in Node (head, inner)

let const head c =
  match c.it with
  | [e] -> instr e
  | es -> Node (head, list instr c.it)


(* Functions *)

let func_with_name name f =
  let {ftype; locals; body} = f.it in
  Node ("func" ^ name,
    [Node ("type " ^ var ftype, [])] @
    decls "local" locals @
    list instr body
  )

let func_with_index off i f =
  func_with_name (" $" ^ nat (off + i)) f

let func f =
  func_with_name "" f


(* Tables & memories *)

let table off i tab =
  let {ttype = TableType (lim, it, t)} = tab.it in
  Node ("table $" ^ nat (off + i) ^ " " ^ index_type it ^ " " ^
        limits nat64 lim, [atom ref_type t]
  )

let memory off i mem =
  let {mtype = MemoryType (lim, it)} = mem.it in
  Node ("memory $" ^ nat (off + i) ^  " " ^ index_type it ^ " " ^
        limits nat64 lim, [])

let is_elem_kind = function
  | FuncRefType -> true
  | _ -> false

let elem_kind = function
  | FuncRefType -> "func"
  | _ -> assert false

let is_elem_index e =
  match e.it with
  | [{it = RefFunc _; _}] -> true
  | _ -> false

let elem_index e =
  match e.it with
  | [{it = RefFunc x; _}] -> atom var x
  | _ -> assert false

let segment_mode category mode =
  match mode.it with
  | Passive -> []
  | Active {index; offset} ->
    (if index.it = 0l then [] else [Node (category, [atom var index])]) @
    [const "offset" offset]
  | Declarative -> [Atom "declare"]

let elem i seg =
  let {etype; einit; emode} = seg.it in
  Node ("elem $" ^ nat i,
    segment_mode "table" emode @
    if is_elem_kind etype && List.for_all is_elem_index einit then
      atom elem_kind etype :: list elem_index einit
    else
      atom ref_type etype :: list (const "item") einit
  )

let data i seg =
  let {dinit; dmode} = seg.it in
  Node ("data $" ^ nat i, segment_mode "memory" dmode @ break_bytes dinit)


(* Modules *)

let typedef i ty =
  Node ("type $" ^ nat i, [struct_type ty.it])

let import_desc fx tx mx gx d =
  match d.it with
  | FuncImport x ->
    incr fx; Node ("func $" ^ nat (!fx - 1), [Node ("type", [atom var x])])
  | TableImport t ->
    incr tx; table 0 (!tx - 1) ({ttype = t} @@ d.at)
  | MemoryImport t ->
    incr mx; memory 0 (!mx - 1) ({mtype = t} @@ d.at)
  | GlobalImport t ->
    incr gx; Node ("global $" ^ nat (!gx - 1), [global_type t])

let import fx tx mx gx im =
  let {module_name; item_name; idesc} = im.it in
  Node ("import",
    [atom name module_name; atom name item_name; import_desc fx tx mx gx idesc]
  )

let export_desc d =
  match d.it with
  | FuncExport x -> Node ("func", [atom var x])
  | TableExport x -> Node ("table", [atom var x])
  | MemoryExport x -> Node ("memory", [atom var x])
  | GlobalExport x -> Node ("global", [atom var x])

let export ex =
  let {name = n; edesc} = ex.it in
  Node ("export", [atom name n; export_desc edesc])

let global off i g =
  let {gtype; ginit} = g.it in
  Node ("global $" ^ nat (off + i), global_type gtype :: list instr ginit.it)

let start s =
  Node ("start " ^ var s.it.sfunc, [])


(* Modules *)

let var_opt = function
  | None -> ""
  | Some x -> " " ^ x.it

let module_with_var_opt x_opt m =
  let fx = ref 0 in
  let tx = ref 0 in
  let mx = ref 0 in
  let gx = ref 0 in
  let imports = list (import fx tx mx gx) m.it.imports in
  Node ("module" ^ var_opt x_opt,
    listi typedef m.it.types @
    imports @
    listi (table !tx) m.it.tables @
    listi (memory !mx) m.it.memories @
    listi (global !gx) m.it.globals @
    listi (func_with_index !fx) m.it.funcs @
    list export m.it.exports @
    opt start m.it.start @
    listi elem m.it.elems @
    listi data m.it.datas
  )

let binary_module_with_var_opt x_opt bs =
  Node ("module" ^ var_opt x_opt ^ " binary", break_bytes bs)

let quoted_module_with_var_opt x_opt s =
  Node ("module" ^ var_opt x_opt ^ " quote", break_string s)

let module_ = module_with_var_opt None


(* Scripts *)

let num mode = if mode = `Binary then hex_string_of_num else string_of_num
let vec mode = if mode = `Binary then hex_string_of_vec else string_of_vec

let ref_ = function
  | NullRef t -> Node ("ref.null " ^ refed_type t, [])
  | ExternRef n -> Node ("ref.extern " ^ nat32 n, [])
  | _ -> assert false

let literal mode lit =
  match lit.it with
  | Num n -> Node (constop n ^ " " ^ num mode n, [])
  | Vec v -> Node (vec_constop v ^ " " ^ vec mode v, [])
  | Ref r -> ref_ r

let definition mode x_opt def =
  try
    match mode with
    | `Textual ->
      let rec unquote def =
        match def.it with
        | Textual m -> m
        | Encoded (_, bs) -> Decode.decode "" bs
        | Quoted (_, s) -> unquote (snd (Parse.Module.parse_string s))
      in module_with_var_opt x_opt (unquote def)
    | `Binary ->
      let rec unquote def =
        match def.it with
        | Textual m -> Encode.encode m
        | Encoded (_, bs) -> Encode.encode (Decode.decode "" bs)
        | Quoted (_, s) -> unquote (snd (Parse.Module.parse_string s))
      in binary_module_with_var_opt x_opt (unquote def)
    | `Original ->
      match def.it with
      | Textual m -> module_with_var_opt x_opt m
      | Encoded (_, bs) -> binary_module_with_var_opt x_opt bs
      | Quoted (_, s) -> quoted_module_with_var_opt x_opt s
  with Parse.Syntax _ ->
    quoted_module_with_var_opt x_opt "<invalid module>"

let access x_opt n =
  String.concat " " [var_opt x_opt; name n]

let action mode act =
  match act.it with
  | Invoke (x_opt, name, lits) ->
    Node ("invoke" ^ access x_opt name, List.map (literal mode) lits)
  | Get (x_opt, name) ->
    Node ("get" ^ access x_opt name, [])

let nan = function
  | CanonicalNan -> "nan:canonical"
  | ArithmeticNan -> "nan:arithmetic"

let nanop (n : nanop) =
  match n.it with
  | F32 n' | F64 n' -> nan n'
  | _ -> .

let num_pat mode = function
  | NumPat n -> literal mode (Values.Num n.it @@ n.at)
  | NanPat nan -> Node (constop nan.it ^ " " ^ nanop nan, [])

let lane_pat mode pat shape =
  let choose fb ft = if mode = `Binary then fb else ft in
  match pat, shape with
  | NumPat {it = Values.I32 i; _}, V128.I8x16 () ->
    choose I8.to_hex_string I8.to_string_s i
  | NumPat {it = Values.I32 i; _}, V128.I16x8 () ->
    choose I16.to_hex_string I16.to_string_s i
  | NumPat n, _ -> num mode n.it
  | NanPat nan, _ -> nanop nan

let vec_pat mode = function
  | VecPat (V128 (shape, pats)) ->
    let lanes = List.map (fun p -> Atom (lane_pat mode p shape)) pats in
    Node ("v128.const " ^ V128.string_of_shape shape, lanes)

let ref_pat = function
  | RefPat r -> ref_ r.it
  | RefTypePat t -> Node ("ref." ^ refed_type t, [])

let result mode res =
  match res.it with
  | NumResult np -> num_pat mode np
  | VecResult vp -> vec_pat mode vp
  | RefResult rp -> ref_pat rp

let assertion mode ass =
  match ass.it with
  | AssertMalformed (def, re) ->
    (match mode, def.it with
    | `Binary, Quoted _ -> []
    | _ ->
      [Node ("assert_malformed", [definition `Original None def; Atom (string re)])]
    )
  | AssertInvalid (def, re) ->
    [Node ("assert_invalid", [definition mode None def; Atom (string re)])]
  | AssertUnlinkable (def, re) ->
    [Node ("assert_unlinkable", [definition mode None def; Atom (string re)])]
  | AssertUninstantiable (def, re) ->
    [Node ("assert_trap", [definition mode None def; Atom (string re)])]
  | AssertReturn (act, results) ->
    [Node ("assert_return", action mode act :: List.map (result mode) results)]
  | AssertTrap (act, re) ->
    [Node ("assert_trap", [action mode act; Atom (string re)])]
  | AssertExhaustion (act, re) ->
    [Node ("assert_exhaustion", [action mode act; Atom (string re)])]

let command mode cmd =
  match cmd.it with
  | Module (x_opt, def) -> [definition mode x_opt def]
  | Register (n, x_opt) -> [Node ("register " ^ name n ^ var_opt x_opt, [])]
  | Action act -> [action mode act]
  | Assertion ass -> assertion mode ass
  | Meta _ -> assert false

let script mode scr = Lib.List.concat_map (command mode) scr
