open Source
open Ast
open Pack
open Script
open Value
open Types
open Sexpr


(* Generic formatting *)

let nat n = I32.to_string_u (I32.of_int_u n)
let nat32 = I32.to_string_u
let nat64 = I64.to_string_u

let add_hex_char buf c = Printf.bprintf buf "\\%02x" (Char.code c)
let add_char buf = function
  | '\t' -> Buffer.add_string buf "\\t"
  | '\n' -> Buffer.add_string buf "\\n"
  | '\r' -> Buffer.add_string buf "\\r"
  | '\"' -> Buffer.add_string buf "\\\""
  | '\\' -> Buffer.add_string buf "\\\\"
  | c when '\x20' <= c && c < '\x7f' -> Buffer.add_char buf c
  | c -> add_hex_char buf c
let add_unicode_char buf = function
  | (0x09 | 0x0a | 0x0d) as uc -> add_char buf (Char.chr uc)
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
let opt_s f xo = Lib.Option.get (Lib.Option.map f xo) ""

let tab head f xs = if xs = [] then [] else [Node (head, list f xs)]
let atom f x = Atom (f x)

let break_bytes s =
  let ss = Lib.String.breakup s 16 in
  list (atom bytes) ss

let break_string s =
  let ss, s' = Lib.List.split_last (Lib.String.split s '\n') in
  list (atom string) (List.map (fun s -> s ^ "\n") ss @ [s'])


(* Types *)

let mutability node = function
  | Cons -> node
  | Var -> Node ("mut", [node])

let addrtype t = string_of_addrtype t
let numtype t = string_of_numtype t
let vectype t = string_of_vectype t
let reftype t =
  match t with
  | (Null, AnyHT) -> "anyref"
  | (Null, EqHT) -> "eqref"
  | (Null, I31HT) -> "i31ref"
  | (Null, StructHT) -> "structref"
  | (Null, ArrayHT) -> "arrayref"
  | (Null, FuncHT) -> "funcref"
  | (Null, ExnHT) -> "exnref"
  | t -> string_of_reftype t

let typeidx t = string_of_typeuse t
let typeuse t = Node ("type " ^ typeidx t, [])
let heaptype t = string_of_heaptype t
let valtype t = string_of_valtype t
let storagetype t = string_of_storagetype t

let final = function
  | NoFinal -> ""
  | Final -> " final"

let decls kind ts = tab kind (atom valtype) ts

let fieldtype (FieldT (mut, t)) =
  mutability (atom storagetype t) mut

let structtype (StructT fts) =
  Node ("struct", list (fun ft -> Node ("field", [fieldtype ft])) fts)

let arraytype (ArrayT ft) =
  Node ("array", [fieldtype ft])

let functype (FuncT (ts1, ts2)) =
  Node ("func", decls "param" ts1 @ decls "result" ts2)

let comptype = function
  | StructCT st -> structtype st
  | ArrayCT at -> arraytype at
  | FuncCT ft -> functype ft

let subtype = function
  | SubT (Final, [], ct) -> comptype ct
  | SubT (fin, uts, ct) ->
    Node (String.concat " "
      (("sub" ^ final fin) :: List.map typeidx uts), [comptype ct])

let rectype i j st =
  Node ("type $" ^ nat (i + j), [subtype st])


let limits nat {min; max} =
  String.concat " " (nat min :: opt nat max)

let tagtype (TagT ut) =
  [typeuse ut]

let globaltype (GlobalT (mut, t)) =
  [mutability (atom string_of_valtype t) mut]

let memorytype (MemoryT (at, lim)) =
  [Atom (addrtype at ^ " " ^ limits nat64 lim)]

let tabletype (TableT (at, lim, t)) =
  [Atom (addrtype at ^ " " ^ limits nat64 lim); atom reftype t]


let packsize = function
  | Pack8 -> "8"
  | Pack16 -> "16"
  | Pack32 -> "32"
  | Pack64 -> "64"

let ext = function
  | S -> "_s"
  | U -> "_u"

let packshape = function
  | Pack8x8 -> "8x8"
  | Pack16x4 -> "16x4"
  | Pack32x2 -> "32x2"

let vext sz = function
  | ExtLane (sh, sx) -> packshape sh ^ ext sx
  | ExtSplat -> packsize sz ^ "_splat"
  | ExtZero -> packsize sz ^ "_zero"


(* Operators *)

module IntOp =
struct
  open Ast.IntOp

  let testop xx = function
    | Eqz -> "eqz"

  let relop xx = function
    | Eq -> "eq"
    | Ne -> "ne"
    | Lt sx -> "lt" ^ ext sx
    | Gt sx -> "gt" ^ ext sx
    | Le sx -> "le" ^ ext sx
    | Ge sx -> "ge" ^ ext sx

  let unop xx = function
    | Clz -> "clz"
    | Ctz -> "ctz"
    | Popcnt -> "popcnt"
    | ExtendS sz -> "extend" ^ packsize sz ^ ext S

  let binop xx = function
    | Add -> "add"
    | Sub -> "sub"
    | Mul -> "mul"
    | Div sx -> "div" ^ ext sx
    | Rem sx -> "rem" ^ ext sx
    | And -> "and"
    | Or -> "or"
    | Xor -> "xor"
    | Shl -> "shl"
    | Shr sx -> "shr" ^ ext sx
    | Rotl -> "rotl"
    | Rotr -> "rotr"

  let cvtop xx = function
    | ExtendI32 sx -> "extend_i32" ^ ext sx
    | WrapI64 -> "wrap_i64"
    | TruncF32 sx -> "trunc_f32" ^ ext sx
    | TruncF64 sx -> "trunc_f64" ^ ext sx
    | TruncSatF32 sx -> "trunc_sat_f32" ^ ext sx
    | TruncSatF64 sx -> "trunc_sat_f64" ^ ext sx
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
    | ConvertI32 sx -> "convert_i32" ^ ext sx
    | ConvertI64 sx -> "convert_i64" ^ ext sx
    | PromoteF32 -> "promote_f32"
    | DemoteF64 -> "demote_f64"
    | ReinterpretInt -> "reinterpret_i" ^ xx
end

module V128Op =
struct
  open Ast.V128Op

  let half = function
    | Low -> "_low"
    | High -> "_high"

  let halve = function
    | "16x8" -> "8x16"
    | "32x4" -> "16x8"
    | "64x2" -> "32x4"
    | _ -> assert false

  let double = function
    | "8x16" -> "16x8"
    | "16x8" -> "32x4"
    | "32x4" -> "64x2"
    | _ -> assert false

  let without_high_bit = function
    | "8x16" -> "7x16"
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
    | AddSat sx -> "add_sat" ^ ext sx
    | Sub -> "sub"
    | SubSat sx -> "sub_sat" ^ ext sx
    | Mul -> "mul"
    | DotS -> "dot_i" ^ halve xxxx ^ "_s"
    | ExtMul (hf, sx) -> "extmul" ^ half hf ^ "_i" ^ halve xxxx ^ ext sx
    | Q15MulRSatS -> "q15mulr_sat" ^ ext S
    | Min sx -> "min" ^ ext sx
    | Max sx -> "max" ^ ext sx
    | AvgrU -> "avgr" ^ ext U
    | Narrow sx -> "narrow_i" ^ double xxxx ^ ext sx
    | Shuffle is -> "shuffle " ^ String.concat " " (List.map nat is)
    | Swizzle -> "swizzle"
    | RelaxedSwizzle -> "relaxed_swizzle"
    | RelaxedQ15MulRS -> "relaxed_q15mulr" ^ ext S
    | RelaxedDot ->
      "relaxed_dot_i" ^ halve xxxx ^ "_i" ^ without_high_bit (halve xxxx) ^ "_s"

  let iternop xxxx (op : iternop) = match op with
    | RelaxedLaneselect -> "relaxed_laneselect"
    | RelaxedDotAddS ->
      "relaxed_dot_i" ^ halve (halve xxxx) ^ "_i" ^
        without_high_bit (halve (halve xxxx)) ^ "_add" ^ ext S

  let fbinop xxxx (op : fbinop) = match op with
    | Add -> "add"
    | Sub -> "sub"
    | Mul -> "mul"
    | Div -> "div"
    | Min -> "min"
    | Max -> "max"
    | Pmin -> "pmin"
    | Pmax -> "pmax"
    | RelaxedMin -> "relaxed_min"
    | RelaxedMax -> "relaxed_max"

  let fternop xxxx (op : fternop) = match op with
    | RelaxedMadd -> "relaxed_madd"
    | RelaxedNmadd-> "relaxed_nmadd"

  let irelop xxxx (op : irelop) = match op with
    | Eq -> "eq"
    | Ne -> "ne"
    | Lt sx -> "lt" ^ ext sx
    | Gt sx -> "gt" ^ ext sx
    | Le sx -> "le" ^ ext sx
    | Ge sx -> "ge" ^ ext sx

  let frelop xxxx (op : frelop) = match op with
    | Eq -> "eq"
    | Ne -> "ne"
    | Lt -> "lt"
    | Le -> "le"
    | Gt -> "gt"
    | Ge -> "ge"

  let icvtop xxxx (op : icvtop) = match op with
    | Extend (hf, sx) -> "extend" ^ half hf ^ "_i" ^ halve xxxx ^ ext sx
    | ExtAddPairwise sx -> "extadd_pairwise_i" ^ halve xxxx ^ ext sx
    | TruncSatF32x4 sx -> "trunc_sat_f32x4" ^ ext sx
    | TruncSatZeroF64x2 sx -> "trunc_sat_f64x2" ^ ext sx ^ "_zero"
    | RelaxedTruncF32x4 sx -> "relaxed_trunc_f32x4" ^ ext sx
    | RelaxedTruncZeroF64x2 sx -> "relaxed_trunc_f64x2" ^ ext sx ^ "_zero"

  let fcvtop xxxx (op : fcvtop) = match op with
    | DemoteZeroF64x2  -> "demote_f64x2_zero"
    | PromoteLowF32x4  -> "promote_low_f32x4"
    | ConvertI32x4 sx ->
      "convert_" ^ (if xxxx = "32x4" then "" else "low_") ^ "i32x4" ^ ext sx

  let ishiftop xxxx (op : ishiftop) = match op with
    | Shl -> "shl"
    | Shr sx -> "shr" ^ ext sx

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

  let pextractop xxxx (op : sx nextractop) = match op with
    | Extract (i, sx) -> "extract_lane" ^ ext sx ^ " " ^ nat i

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
  string_of_numtype (type_of_num op) ^ "." ^
  (match op with
  | I32 o -> iop "32" o
  | I64 o -> iop "64" o
  | F32 o -> fop "32" o
  | F64 o -> fop "64" o
  )

let voper (vop) op =
  match op with
  | V128 o -> "v128." ^ vop o

let shoper (pop, iop, fop) op =
  match op with
  | V128 o -> V128.string_of_shape o ^ "." ^ V128Op.lane_oper (pop, iop, fop) o

let unop = oper (IntOp.unop, FloatOp.unop)
let binop = oper (IntOp.binop, FloatOp.binop)
let testop = oper (IntOp.testop, FloatOp.testop)
let relop = oper (IntOp.relop, FloatOp.relop)
let cvtop = oper (IntOp.cvtop, FloatOp.cvtop)

let vunop = shoper (V128Op.iunop, V128Op.iunop, V128Op.funop)
let vbinop = shoper (V128Op.ibinop, V128Op.ibinop, V128Op.fbinop)
let vternop = shoper (V128Op.iternop, V128Op.iternop, V128Op.fternop)
let vtestop = shoper (V128Op.itestop, V128Op.itestop, V128Op.voidop)
let vrelop = shoper (V128Op.irelop, V128Op.irelop, V128Op.frelop)
let vcvtop = shoper (V128Op.icvtop, V128Op.icvtop, V128Op.fcvtop)
let vshiftop = shoper (V128Op.ishiftop, V128Op.ishiftop, V128Op.voidop)
let vbitmaskop = shoper (V128Op.ibitmaskop, V128Op.ibitmaskop, V128Op.voidop)
let vvunop = voper (V128Op.vunop)
let vvbinop = voper (V128Op.vbinop)
let vvternop = voper (V128Op.vternop)
let vvtestop = voper (V128Op.vtestop)
let vsplatop = shoper (V128Op.splatop, V128Op.splatop, V128Op.splatop)
let vextractop = shoper (V128Op.pextractop, V128Op.extractop, V128Op.extractop)
let vreplaceop = shoper (V128Op.replaceop, V128Op.replaceop, V128Op.replaceop)

let idx x = nat32 x.it
let num v = string_of_num v.it
let vec v = string_of_vec v.it

let memop name x typ {ty; align; offset; _} sz =
  typ ty ^ "." ^ name ^ " " ^ idx x ^
  (if offset = 0L then "" else " offset=" ^ nat64 offset) ^
  (if 1 lsl align = sz then "" else " align=" ^ nat64 (Int64.shift_left 1L align))

let loadop x op =
  match op.pack with
  | None -> memop "load" x numtype op (num_size op.ty)
  | Some (sz, sx) ->
    memop ("load" ^ packsize sz ^ ext sx) x numtype op (packed_size sz)

let storeop x op =
  match op.pack with
  | None -> memop "store" x numtype op (num_size op.ty)
  | Some sz -> memop ("store" ^ packsize sz) x numtype op (packed_size sz)

let vloadop x (op : vloadop) =
  match op.pack with
  | None -> memop "load" x vectype op (vec_size op.ty)
  | Some (sz, ext) ->
    memop ("load" ^ vext sz ext) x vectype op (packed_size sz)

let vstoreop x op =
  memop "store" x vectype op (vec_size op.ty)

let vlaneop instr x op i =
  memop (instr ^ packsize op.pack ^ "_lane") x vectype op
    (packed_size op.pack) ^ " " ^ nat i

let initop = function
  | Explicit -> ""
  | Implicit -> "_default"

let constop v = string_of_numtype (type_of_num v) ^ ".const"
let vconstop v = string_of_vectype (type_of_vec v) ^ ".const i32x4"

let externop = function
  | Internalize -> "any.convert_extern"
  | Externalize -> "extern.convert_any"


(* Expressions *)

let blocktype = function
  | VarBlockType x -> [Node ("type " ^ idx x, [])]
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
    | Block (bt, es) -> "block", blocktype bt @ list instr es
    | Loop (bt, es) -> "loop", blocktype bt @ list instr es
    | If (bt, es1, es2) ->
      "if", blocktype bt @
        [Node ("then", list instr es1); Node ("else", list instr es2)]
    | Br x -> "br " ^ idx x, []
    | BrIf x -> "br_if " ^ idx x, []
    | BrTable (xs, x) ->
      "br_table " ^ String.concat " " (list idx (xs @ [x])), []
    | BrOnNull x -> "br_on_null " ^ idx x, []
    | BrOnNonNull x -> "br_on_non_null " ^ idx x, []
    | BrOnCast (x, t1, t2) ->
      "br_on_cast " ^ idx x, [Atom (reftype t1); Atom (reftype t2)]
    | BrOnCastFail (x, t1, t2) ->
      "br_on_cast_fail " ^ idx x, [Atom (reftype t1); Atom (reftype t2)]
    | Return -> "return", []
    | Call x -> "call " ^ idx x, []
    | CallRef x -> "call_ref " ^ idx x, []
    | CallIndirect (x, y) ->
      "call_indirect " ^ idx x, [Node ("type " ^ idx y, [])]
    | ReturnCall x -> "return_call " ^ idx x, []
    | ReturnCallRef x -> "return_call_ref " ^ idx x, []
    | ReturnCallIndirect (x, y) ->
      "return_call_indirect " ^ idx x, [Node ("type " ^ idx y, [])]
    | Throw x -> "throw " ^ idx x, []
    | ThrowRef -> "throw_ref", []
    | TryTable (bt, cs, es) ->
      "try_table", blocktype bt @ list catch cs @ list instr es
    | LocalGet x -> "local.get " ^ idx x, []
    | LocalSet x -> "local.set " ^ idx x, []
    | LocalTee x -> "local.tee " ^ idx x, []
    | GlobalGet x -> "global.get " ^ idx x, []
    | GlobalSet x -> "global.set " ^ idx x, []
    | TableGet x -> "table.get " ^ idx x, []
    | TableSet x -> "table.set " ^ idx x, []
    | TableSize x -> "table.size " ^ idx x, []
    | TableGrow x -> "table.grow " ^ idx x, []
    | TableFill x -> "table.fill " ^ idx x, []
    | TableCopy (x, y) -> "table.copy " ^ idx x ^ " " ^ idx y, []
    | TableInit (x, y) -> "table.init " ^ idx x ^ " " ^ idx y, []
    | ElemDrop x -> "elem.drop " ^ idx x, []
    | Load (x, op) -> loadop x op, []
    | Store (x, op) -> storeop x op, []
    | VecLoad (x, op) -> vloadop x op, []
    | VecStore (x, op) -> vstoreop x op, []
    | VecLoadLane (x, op, i) -> vlaneop "load" x op i, []
    | VecStoreLane (x, op, i) -> vlaneop "store" x op i, []
    | MemorySize x -> "memory.size " ^ idx x, []
    | MemoryGrow x -> "memory.grow " ^ idx x, []
    | MemoryFill x -> "memory.fill " ^ idx x, []
    | MemoryCopy (x, y) -> "memory.copy " ^ idx x ^ " " ^ idx y, []
    | MemoryInit (x, y) -> "memory.init " ^ idx x ^ " " ^ idx y, []
    | DataDrop x -> "data.drop " ^ idx x, []
    | RefNull t -> "ref.null", [Atom (heaptype t)]
    | RefFunc x -> "ref.func " ^ idx x, []
    | RefIsNull -> "ref.is_null", []
    | RefAsNonNull -> "ref.as_non_null", []
    | RefTest t -> "ref.test", [Atom (reftype t)]
    | RefCast t -> "ref.cast", [Atom (reftype t)]
    | RefEq -> "ref.eq", []
    | RefI31 -> "ref.i31", []
    | I31Get sx -> "i31.get" ^ ext sx, []
    | StructNew (x, op) -> "struct.new" ^ initop op ^ " " ^ idx x, []
    | StructGet (x, y, sxo) ->
      "struct.get" ^ opt_s ext sxo ^ " " ^ idx x ^ " " ^ idx y, []
    | StructSet (x, y) -> "struct.set " ^ idx x ^ " " ^ idx y, []
    | ArrayNew (x, op) -> "array.new" ^ initop op ^ " " ^ idx x, []
    | ArrayNewFixed (x, n) -> "array.new_fixed " ^ idx x ^ " " ^ nat32 n, []
    | ArrayNewElem (x, y) -> "array.new_elem " ^ idx x ^ " " ^ idx y, []
    | ArrayNewData (x, y) -> "array.new_data " ^ idx x ^ " " ^ idx y, []
    | ArrayGet (x, sxo) -> "array.get" ^ opt_s ext sxo ^ " " ^ idx x, []
    | ArraySet x -> "array.set " ^ idx x, []
    | ArrayLen -> "array.len", []
    | ArrayCopy (x, y) -> "array.copy " ^ idx x ^ " " ^ idx y, []
    | ArrayFill x -> "array.fill " ^ idx x, []
    | ArrayInitData (x, y) -> "array.init_data " ^ idx x ^ " " ^ idx y, []
    | ArrayInitElem (x, y) -> "array.init_elem " ^ idx x ^ " " ^ idx y, []
    | ExternConvert op -> externop op, []
    | Const n -> constop n.it ^ " " ^ num n, []
    | Test op -> testop op, []
    | Compare op -> relop op, []
    | Unary op -> unop op, []
    | Binary op -> binop op, []
    | Convert op -> cvtop op, []
    | VecConst v -> vconstop v.it ^ " " ^ vec v, []
    | VecTest op -> vtestop op, []
    | VecUnary op -> vunop op, []
    | VecBinary op -> vbinop op, []
    | VecTernary op -> vternop op, []
    | VecCompare op -> vrelop op, []
    | VecConvert op -> vcvtop op, []
    | VecShift op -> vshiftop op, []
    | VecBitmask op -> vbitmaskop op, []
    | VecTestBits op -> vvtestop op, []
    | VecUnaryBits op -> vvunop op, []
    | VecBinaryBits op -> vvbinop op, []
    | VecTernaryBits op -> vvternop op, []
    | VecSplat op -> vsplatop op, []
    | VecExtract op -> vextractop op, []
    | VecReplace op -> vreplaceop op, []
  in Node (head, inner)

and catch c =
  match c.it with
  | Catch (x1, x2) -> Node ("catch " ^ idx x1 ^ " " ^ idx x2, [])
  | CatchRef (x1, x2) -> Node ("catch_ref " ^ idx x1 ^ " " ^ idx x2, [])
  | CatchAll x -> Node ("catch_all " ^ idx x, [])
  | CatchAllRef x -> Node ("catch_all_ref " ^ idx x, [])

let const head c =
  match c.it with
  | [e] -> instr e
  | es -> Node (head, list instr c.it)


(* Modules *)

let type_ (ns, i) ty =
  match ty.it with
  | RecT [st] when not Free.(Set.mem (Int32.of_int i) (type_ ty).types) ->
    rectype i 0 st :: ns, i + 1
  | RecT sts ->
    Node ("rec", List.mapi (rectype i) sts) :: ns, i + List.length sts

let tag off i tag =
  let Tag tt = tag.it in
  Node ("tag $" ^ nat (off + i), tagtype tt)

let global off i g =
  let Global (gt, c) = g.it in
  Node ("global $" ^ nat (off + i), globaltype gt @ list instr c.it)

let memory off i mem =
  let Memory mt = mem.it in
  Node ("memory $" ^ nat (off + i), memorytype mt)

let table off i tab =
  let Table (tt, c) = tab.it in
  Node ("table $" ^ nat (off + i), tabletype tt @ list instr c.it)

let func_with_name name f =
  let Func (x, ls, es) = f.it in
  Node ("func" ^ name,
    [Node ("type " ^ idx x, [])] @
    decls "local" (List.map (fun {it = Local t; _} -> t) ls) @
    list instr es
  )

let func_with_index off i f =
  func_with_name (" $" ^ nat (off + i)) f

let func f =
  func_with_name "" f

let is_elemkind = function
  | (NoNull, FuncHT) -> true
  | _ -> false

let elemkind = function
  | (NoNull, FuncHT) -> "func"
  | _ -> assert false

let is_elemidx e =
  match e.it with
  | [{it = RefFunc _; _}] -> true
  | _ -> false

let elemidx e =
  match e.it with
  | [{it = RefFunc x; _}] -> atom idx x
  | _ -> assert false

let segmentmode category mode =
  match mode.it with
  | Passive -> []
  | Active (x, c) ->
    (if x.it = 0l then [] else [Node (category, [atom idx x])]) @
    [const "offset" c]
  | Declarative -> [Atom "declare"]

let data i seg =
  let Data (bs, mode) = seg.it in
  Node ("data $" ^ nat i, segmentmode "memory" mode @ break_bytes bs)

let elem i seg =
  let Elem (rt, cs, mode) = seg.it in
  Node ("elem $" ^ nat i,
    segmentmode "table" mode @
    if is_elemkind rt && List.for_all is_elemidx cs then
      atom elemkind rt :: list elemidx cs
    else
      atom reftype rt :: list (const "item") cs
  )

let start s =
  let Start x = s.it in
  Node ("start " ^ idx x, [])


let importtype fx tx mx tgx gx = function
  | ExternTagT tt -> incr tgx; Node ("tag $" ^ nat (!tgx - 1), tagtype tt)
  | ExternGlobalT gt -> incr gx; Node ("global $" ^ nat (!gx - 1), globaltype gt)
  | ExternMemoryT mt -> incr mx; Node ("memory $" ^ nat (!mx - 1), memorytype mt)
  | ExternTableT tt -> incr tx; Node ("table $" ^ nat (!tx - 1), tabletype tt)
  | ExternFuncT ut -> incr fx; Node ("func $" ^ nat (!fx - 1), [typeuse ut])

let import fx tx mx ex gx im =
  let Import (module_name, item_name, xt) = im.it in
  Node ("import",
    [atom name module_name; atom name item_name; importtype fx tx mx ex gx xt]
  )

let externidx xx =
  match xx.it with
  | TagX x -> Node ("tag", [atom idx x])
  | GlobalX x -> Node ("global", [atom idx x])
  | MemoryX x -> Node ("memory", [atom idx x])
  | TableX x -> Node ("table", [atom idx x])
  | FuncX x -> Node ("func", [atom idx x])

let export ex =
  let Export (n, xx) = ex.it in
  Node ("export", [atom name n; externidx xx])

let custom m mnode (module S : Custom.Section) =
  S.Handler.arrange m mnode S.it


let idx x =
  if String.for_all (fun c -> Lib.Char.is_alphanum_ascii c || c = '_') x.it then
    "$" ^ x.it
  else
    "$" ^ name (Utf8.decode x.it)

let var_opt = function
  | None -> ""
  | Some x -> " " ^ idx x

let module_with_var_opt isdef x_opt (m, cs) =
  let fx = ref 0 in
  let tx = ref 0 in
  let mx = ref 0 in
  let tgx = ref 0 in
  let gx = ref 0 in
  let imports = list (import fx tx mx tgx gx) m.it.imports in
  let head = if isdef then "module definition" else "module" in
  let ret = Node (head ^ var_opt x_opt,
    List.rev (fst (List.fold_left type_ ([], 0) m.it.types)) @
    imports @
    listi (table !tx) m.it.tables @
    listi (memory !mx) m.it.memories @
    listi (tag !tgx) m.it.tags @
    listi (global !gx) m.it.globals @
    list export m.it.exports @
    opt start m.it.start @
    listi elem m.it.elems @
    listi (func_with_index !fx) m.it.funcs @
    listi data m.it.datas
  ) in
  List.fold_left (custom m) ret cs


let binary_module_with_var_opt isdef x_opt bs =
  let head = if isdef then "module definition" else "module" in
  Node (head ^ var_opt x_opt ^ " binary", break_bytes bs)

let quoted_module_with_var_opt isdef x_opt s =
  let head = if isdef then "module definition" else "module" in
  Node (head ^ var_opt x_opt ^ " quote", break_string s)

let module_with_custom = module_with_var_opt false None
let module_ m = module_with_custom (m, [])


(* Scripts *)

let num mode = if mode = `Binary then hex_string_of_num else string_of_num
let vec mode = if mode = `Binary then hex_string_of_vec else string_of_vec

let ref_ = function
  | NullRef t -> Node ("ref.null " ^ heaptype t, [])
  | Script.HostRef n -> Node ("ref.host " ^ nat32 n, [])
  | Extern.ExternRef (Script.HostRef n) -> Node ("ref.extern " ^ nat32 n, [])
  | _ -> assert false

let literal mode lit =
  match lit.it with
  | Num n -> Node (constop n ^ " " ^ num mode n, [])
  | Vec v -> Node (vconstop v ^ " " ^ vec mode v, [])
  | Ref r -> ref_ r

let definition mode isdef x_opt def =
  try
    match mode with
    | `Textual ->
      let rec unquote def =
        match def.it with
        | Textual (m, cs) -> m, cs
        | Encoded (name, bs) -> Decode.decode_with_custom name bs.it
        | Quoted (_, s) ->
          unquote (snd (Parse.Module.parse_string ~offset:s.at s.it))
      in module_with_var_opt isdef x_opt (unquote def)
    | `Binary ->
      let rec unquote def =
        match def.it with
        | Textual (m, cs) -> Encode.encode_with_custom (m, cs)
        | Encoded (name, bs) ->
          Encode.encode_with_custom (Decode.decode_with_custom name bs.it)
        | Quoted (_, s) ->
          unquote (snd (Parse.Module.parse_string ~offset:s.at s.it))
      in binary_module_with_var_opt isdef x_opt (unquote def)
    | `Original ->
      match def.it with
      | Textual (m, cs) -> module_with_var_opt isdef x_opt (m, cs)
      | Encoded (_, bs) -> binary_module_with_var_opt isdef x_opt bs.it
      | Quoted (_, s) -> quoted_module_with_var_opt isdef x_opt s.it
  with Parse.Syntax _ ->
    quoted_module_with_var_opt isdef x_opt "<invalid module>"

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
  | NumPat n -> literal mode (Value.Num n.it @@ n.at)
  | NanPat nan -> Node (constop nan.it ^ " " ^ nanop nan, [])

let lane_pat mode pat shape =
  let choose fb ft = if mode = `Binary then fb else ft in
  match pat, shape with
  | NumPat {it = Value.I32 i; _}, V128.I8x16 () ->
    choose I8.to_hex_string I8.to_string_s i
  | NumPat {it = Value.I32 i; _}, V128.I16x8 () ->
    choose I16.to_hex_string I16.to_string_s i
  | NumPat n, _ -> num mode n.it
  | NanPat nan, _ -> nanop nan

let vec_pat mode = function
  | VecPat (V128 (shape, pats)) ->
    let lanes = List.map (fun p -> Atom (lane_pat mode p shape)) pats in
    Node ("v128.const " ^ V128.string_of_shape shape, lanes)

let ref_pat = function
  | RefPat r -> ref_ r.it
  | RefTypePat t -> Node ("ref." ^ heaptype t, [])
  | NullPat -> Node ("ref.null", [])

let rec result mode res =
  match res.it with
  | NumResult np -> num_pat mode np
  | VecResult vp -> vec_pat mode vp
  | RefResult rp -> ref_pat rp
  | EitherResult ress -> Node ("either", List.map (result mode) ress)

let instance (x1_opt, x2_opt) =
  Node ("module instance" ^ var_opt x1_opt ^ var_opt x2_opt, [])

let assertion mode ass =
  match ass.it with
  | AssertMalformed (def, re) ->
    (match mode, def.it with
    | `Binary, Quoted _ -> []
    | _ ->
      [Node ("assert_malformed", [definition `Original false None def; Atom (string re)])]
    )
  | AssertMalformedCustom (def, re) ->
    (match mode, def.it with
    | `Binary, Quoted _ -> []
    | _ ->
      [Node ("assert_malformed_custom", [definition `Original false None def; Atom (string re)])]
    )
  | AssertInvalid (def, re) ->
    [Node ("assert_invalid", [definition mode false None def; Atom (string re)])]
  | AssertInvalidCustom (def, re) ->
    [Node ("assert_invalid_custom", [definition mode false None def; Atom (string re)])]
  | AssertUnlinkable (x_opt, re) ->
    [Node ("assert_unlinkable", [instance (None, x_opt); Atom (string re)])]
  | AssertUninstantiable (x_opt, re) ->
    [Node ("assert_trap", [instance (None, x_opt); Atom (string re)])]
  | AssertReturn (act, results) ->
    [Node ("assert_return", action mode act :: List.map (result mode) results)]
  | AssertTrap (act, re) ->
    [Node ("assert_trap", [action mode act; Atom (string re)])]
  | AssertException act ->
    [Node ("assert_exception", [action mode act])]
  | AssertExhaustion (act, re) ->
    [Node ("assert_exhaustion", [action mode act; Atom (string re)])]

let command mode cmd =
  match cmd.it with
  | Module (x_opt, def) -> [definition mode true x_opt def]
  | Instance (x1_opt, x2_opt) -> [instance (x1_opt, x2_opt)]
  | Register (n, x_opt) -> [Node ("register " ^ name n ^ var_opt x_opt, [])]
  | Action act -> [action mode act]
  | Assertion ass -> assertion mode ass
  | Meta _ -> assert false

let script mode scr = List.concat_map (command mode) scr
