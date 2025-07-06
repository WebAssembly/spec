(*
 * Throughout the implementation we use consistent naming conventions for
 * syntactic elements, associated with the types defined here and in a few
 * other places:
 *
 *   x : idx
 *   v : value
 *   e : instr
 *   f : func
 *   m : module_
 *
 *   t : valtype
 *   s : functype
 *   c : context / config
 *
 * These conventions mostly follow standard practice in language semantics.
 *)

(* Types *)

open Types
open Pack

type void = Lib.void


(* Operators *)

module IntOp =
struct
  type sx = Pack.sx = S | U

  type unop = Clz | Ctz | Popcnt | ExtendS of packsize
  type binop = Add | Sub | Mul | Div of sx | Rem of sx
             | And | Or | Xor | Shl | Shr of sx | Rotl | Rotr
  type testop = Eqz
  type relop = Eq | Ne | Lt of sx | Gt of sx | Le of sx | Ge of sx
  type cvtop = ExtendI32 of sx | WrapI64
             | TruncF32 of sx | TruncF64 of sx
             | TruncSatF32 of sx | TruncSatF64 of sx
             | ReinterpretFloat
end

module FloatOp =
struct
  type sx = Pack.sx = S | U

  type unop = Neg | Abs | Ceil | Floor | Trunc | Nearest | Sqrt
  type binop = Add | Sub | Mul | Div | Min | Max | CopySign
  type testop = |
  type relop = Eq | Ne | Lt | Gt | Le | Ge
  type cvtop = ConvertI32 of sx | ConvertI64 of sx
             | PromoteF32 | DemoteF64
             | ReinterpretInt
end

module I32Op = IntOp
module I64Op = IntOp
module F32Op = FloatOp
module F64Op = FloatOp

module V128Op =
struct
  type half = Low | High

  type iunop = Abs | Neg | Popcnt
  type funop = Abs | Neg | Sqrt | Ceil | Floor | Trunc | Nearest
  type ibinop = Add | Sub | Mul | Min of sx | Max of sx | AvgrU
              | AddSat of sx | SubSat of sx | DotS | Q15MulRSatS
              | ExtMul of half * sx
              | Swizzle | Shuffle of int list | Narrow of sx
              | RelaxedSwizzle | RelaxedQ15MulRS | RelaxedDot
  type fbinop = Add | Sub | Mul | Div | Min | Max | Pmin | Pmax
              | RelaxedMin | RelaxedMax
  type iternop = RelaxedLaneselect | RelaxedDotAddS
  type fternop = RelaxedMadd | RelaxedNmadd
  type itestop = AllTrue
  type irelop = Eq | Ne | Lt of sx | Le of sx | Gt of sx | Ge of sx
  type frelop = Eq | Ne | Lt | Le | Gt | Ge
  type icvtop = Extend of half * sx | ExtAddPairwise of sx
              | TruncSatF32x4 of sx | TruncSatZeroF64x2 of sx
              | RelaxedTruncF32x4 of sx | RelaxedTruncZeroF64x2 of sx
  type fcvtop = DemoteZeroF64x2 | PromoteLowF32x4
              | ConvertI32x4 of sx
  type ishiftop = Shl | Shr of sx
  type ibitmaskop = Bitmask

  type vtestop = AnyTrue
  type vunop = Not
  type vbinop = And | Or | Xor | AndNot
  type vternop = Bitselect

  type testop = (itestop, itestop, itestop, itestop, void, void) V128.laneop
  type unop = (iunop, iunop, iunop, iunop, funop, funop) V128.laneop
  type binop = (ibinop, ibinop, ibinop, ibinop, fbinop, fbinop) V128.laneop
  type ternop = (iternop, iternop, iternop, iternop, fternop, fternop) V128.laneop
  type relop = (irelop, irelop, irelop, irelop, frelop, frelop) V128.laneop
  type cvtop = (icvtop, icvtop, icvtop, icvtop, fcvtop, fcvtop) V128.laneop
  type shiftop = (ishiftop, ishiftop, ishiftop, ishiftop, void, void) V128.laneop
  type bitmaskop = (ibitmaskop, ibitmaskop, ibitmaskop, ibitmaskop, void, void) V128.laneop

  type nsplatop = Splat
  type 'a nextractop = Extract of int * 'a
  type nreplaceop = Replace of int

  type splatop = (nsplatop, nsplatop, nsplatop, nsplatop, nsplatop, nsplatop) V128.laneop
  type extractop = (sx nextractop, sx nextractop, unit nextractop, unit nextractop, unit nextractop, unit nextractop) V128.laneop
  type replaceop = (nreplaceop, nreplaceop, nreplaceop, nreplaceop, nreplaceop, nreplaceop) V128.laneop
end

type testop = (I32Op.testop, I64Op.testop, F32Op.testop, F64Op.testop) Value.op
type unop = (I32Op.unop, I64Op.unop, F32Op.unop, F64Op.unop) Value.op
type binop = (I32Op.binop, I64Op.binop, F32Op.binop, F64Op.binop) Value.op
type relop = (I32Op.relop, I64Op.relop, F32Op.relop, F64Op.relop) Value.op
type cvtop = (I32Op.cvtop, I64Op.cvtop, F32Op.cvtop, F64Op.cvtop) Value.op

type vtestop = (V128Op.testop) Value.vecop
type vrelop = (V128Op.relop) Value.vecop
type vunop = (V128Op.unop) Value.vecop
type vbinop = (V128Op.binop) Value.vecop
type vternop = (V128Op.ternop) Value.vecop
type vcvtop = (V128Op.cvtop) Value.vecop
type vshiftop = (V128Op.shiftop) Value.vecop
type vbitmaskop = (V128Op.bitmaskop) Value.vecop
type vvtestop = (V128Op.vtestop) Value.vecop
type vvunop = (V128Op.vunop) Value.vecop
type vvbinop = (V128Op.vbinop) Value.vecop
type vvternop = (V128Op.vternop) Value.vecop
type vsplatop = (V128Op.splatop) Value.vecop
type vextractop = (V128Op.extractop) Value.vecop
type vreplaceop = (V128Op.replaceop) Value.vecop

type ('t, 'p) memop = {ty : 't; align : int; offset : int64; pack : 'p}
type loadop = (numtype, (packsize * sx) option) memop
type storeop = (numtype, packsize option) memop

type vloadop = (vectype, (packsize * vext) option) memop
type vstoreop = (vectype, unit) memop
type vlaneop = (vectype, packsize) memop

type initop = Explicit | Implicit
type externop = Internalize | Externalize


(* Expressions *)

type idx = int32 Source.phrase
type num = Value.num Source.phrase
type vec = Value.vec Source.phrase
type name = Utf8.unicode

type blocktype = VarBlockType of idx | ValBlockType of valtype option

type instr = instr' Source.phrase
and instr' =
  | Unreachable                       (* trap unconditionally *)
  | Nop                               (* do nothing *)
  | Drop                              (* forget a value *)
  | Select of valtype list option     (* branchless conditional *)
  | Block of blocktype * instr list   (* execute in sequence *)
  | Loop of blocktype * instr list    (* loop header *)
  | If of blocktype * instr list * instr list   (* conditional *)
  | Br of idx                         (* break to n-th surrounding label *)
  | BrIf of idx                       (* conditional break *)
  | BrTable of idx list * idx         (* indexed break *)
  | BrOnNull of idx                   (* break on type *)
  | BrOnNonNull of idx                (* break on type inverted *)
  | BrOnCast of idx * reftype * reftype     (* break on type *)
  | BrOnCastFail of idx * reftype * reftype (* break on type inverted *)
  | Return                            (* break from function body *)
  | Call of idx                       (* call function *)
  | CallRef of idx                    (* call function through reference *)
  | CallIndirect of idx * idx         (* call function through table *)
  | ReturnCall of idx                 (* tail-call function *)
  | ReturnCallRef of idx              (* tail call through reference *)
  | ReturnCallIndirect of idx * idx   (* tail-call function through table *)
  | Throw of idx                      (* throw exception *)
  | ThrowRef                          (* rethrow exception *)
  | TryTable of blocktype * catch list * instr list  (* handle exceptions *)
  | LocalGet of idx                   (* read local idxiable *)
  | LocalSet of idx                   (* write local idxiable *)
  | LocalTee of idx                   (* write local idxiable and keep value *)
  | GlobalGet of idx                  (* read global idxiable *)
  | GlobalSet of idx                  (* write global idxiable *)
  | TableGet of idx                   (* read table element *)
  | TableSet of idx                   (* write table element *)
  | TableSize of idx                  (* size of table *)
  | TableGrow of idx                  (* grow table *)
  | TableFill of idx                  (* fill table with unique value *)
  | TableCopy of idx * idx            (* copy table range *)
  | TableInit of idx * idx            (* initialize table range from segment *)
  | ElemDrop of idx                   (* drop passive element segment *)
  | Load of idx * loadop              (* read memory at address *)
  | Store of idx * storeop            (* write memory at address *)
  | VecLoad of idx * vloadop          (* read memory at address *)
  | VecStore of idx * vstoreop        (* write memory at address *)
  | VecLoadLane of idx * vlaneop * int  (* read single lane at address *)
  | VecStoreLane of idx * vlaneop * int (* write single lane to address *)
  | MemorySize of idx                 (* size of memory *)
  | MemoryGrow of idx                 (* grow memory *)
  | MemoryFill of idx                 (* fill memory range with value *)
  | MemoryCopy of idx * idx           (* copy memory ranges *)
  | MemoryInit of idx * idx           (* initialize memory range from segment *)
  | DataDrop of idx                   (* drop passive data segment *)
  | Const of num                      (* constant *)
  | Test of testop                    (* numeric test *)
  | Compare of relop                  (* numeric comparison *)
  | Unary of unop                     (* unary numeric operator *)
  | Binary of binop                   (* binary numeric operator *)
  | Convert of cvtop                  (* conversion *)
  | RefNull of heaptype               (* null reference *)
  | RefFunc of idx                    (* function reference *)
  | RefIsNull                         (* type test *)
  | RefAsNonNull                      (* type cast *)
  | RefTest of reftype                (* type test *)
  | RefCast of reftype                (* type cast *)
  | RefEq                             (* reference equality *)
  | RefI31                            (* scalar reference *)
  | I31Get of sx                      (* read scalar *)
  | StructNew of idx * initop         (* allocate structure *)
  | StructGet of idx * idx * sx option  (* read structure field *)
  | StructSet of idx * idx            (* write structure field *)
  | ArrayNew of idx * initop          (* allocate array *)
  | ArrayNewFixed of idx * int32      (* allocate fixed array *)
  | ArrayNewElem of idx * idx         (* allocate array from element segment *)
  | ArrayNewData of idx * idx         (* allocate array from data segment *)
  | ArrayGet of idx * sx option       (* read array slot *)
  | ArraySet of idx                   (* write array slot *)
  | ArrayLen                          (* read array length *)
  | ArrayCopy of idx * idx            (* copy between two arrays *)
  | ArrayFill of idx                  (* fill array with value *)
  | ArrayInitData of idx * idx        (* fill array from data segment *)
  | ArrayInitElem of idx * idx        (* fill array from elem segment *)
  | ExternConvert of externop         (* extern conversion *)
  | VecConst of vec                   (* constant *)
  | VecTest of vtestop                (* vector test *)
  | VecCompare of vrelop              (* vector comparison *)
  | VecUnary of vunop                 (* unary vector operator *)
  | VecBinary of vbinop               (* binary vector operator *)
  | VecTernary of vternop             (* ternary vector operator *)
  | VecConvert of vcvtop              (* vector conversion *)
  | VecShift of vshiftop              (* vector shifts *)
  | VecBitmask of vbitmaskop          (* vector masking *)
  | VecTestBits of vvtestop           (* vector bit test *)
  | VecUnaryBits of vvunop            (* unary bit vector operator *)
  | VecBinaryBits of vvbinop          (* binary bit vector operator *)
  | VecTernaryBits of vvternop        (* ternary bit vector operator *)
  | VecSplat of vsplatop              (* number to vector conversion *)
  | VecExtract of vextractop          (* extract lane from vector *)
  | VecReplace of vreplaceop          (* replace lane in vector *)

and catch = catch' Source.phrase
and catch' =
  | Catch of idx * idx
  | CatchRef of idx * idx
  | CatchAll of idx
  | CatchAllRef of idx


(* Modules *)

type const = instr list Source.phrase

type type_ = rectype Source.phrase

type tag = tag' Source.phrase
and tag' =
  | Tag of tagtype

type global = global' Source.phrase
and global' =
  | Global of globaltype * const

type memory = memory' Source.phrase
and memory' =
  | Memory of memorytype

type table = table' Source.phrase
and table' =
  | Table of tabletype * const

type local = local' Source.phrase
and local' =
  | Local of valtype

type func = func' Source.phrase
and func' =
  | Func of idx * local list * instr list

type segmentmode = segmentmode' Source.phrase
and segmentmode' =
  | Passive
  | Active of idx * const
  | Declarative

type data = data' Source.phrase
and data' =
  | Data of string * segmentmode

type elem = elem' Source.phrase
and elem' =
  | Elem of reftype * const list * segmentmode

type start = start' Source.phrase
and start' =
  | Start of idx

type externidx = externidx' Source.phrase
and externidx' =
  | TagX of idx
  | GlobalX of idx
  | MemoryX of idx
  | TableX of idx
  | FuncX of idx

type export = export' Source.phrase
and export' =
  | Export of name * externidx

type import = import' Source.phrase
and import' =
  | Import of name * name * externtype

type module_ = module_' Source.phrase
and module_' =
{
  types : type_ list;
  tags : tag list;
  globals : global list;
  memories : memory list;
  tables : table list;
  funcs : func list;
  datas : data list;
  elems : elem list;
  start : start option;
  imports : import list;
  exports : export list;
}


let empty_module =
{
  types = [];
  tags = [];
  globals = [];
  memories = [];
  tables = [];
  funcs = [];
  datas = [];
  elems = [];
  start = None;
  imports = [];
  exports = [];
}


(* Extract module type (unchecked) *)

open Source

let deftypes_of (m : module_) : deftype list =
  let rts = List.map Source.it m.it.types in
  List.fold_left (fun dts rt ->
    let x = Lib.List32.length dts in
    dts @ List.map (subst_deftype (subst_of dts)) (roll_deftypes x rt)
  ) [] rts

let importtype_of (m : module_) (im : import) : importtype =
  let Import (module_name, item_name, xt) = im.it in
  let dts = deftypes_of m in
  ImportT (module_name, item_name, subst_externtype (subst_of dts) xt)

let exporttype_of (m : module_) (ex : export) : exporttype =
  let Export (name, xx) = ex.it in
  let dts = deftypes_of m in
  let its = List.map (importtype_of m) m.it.imports in
  let xts = List.map externtype_of_importtype its in
  let xt =
    match xx.it with
    | TagX x ->
      let tts = tags xts @ List.map (fun t ->
        let Tag tt = t.it in tt) m.it.tags in
      ExternTagT (Lib.List32.nth tts x.it)
    | GlobalX x ->
      let gts = globals xts @ List.map (fun g ->
        let Global (gt, _) = g.it in gt) m.it.globals in
      ExternGlobalT (Lib.List32.nth gts x.it)
    | MemoryX x ->
      let mts = memories xts @ List.map (fun m ->
        let Memory mt = m.it in mt) m.it.memories in
      ExternMemoryT (Lib.List32.nth mts x.it)
    | TableX x ->
      let tts = tables xts @ List.map (fun t ->
        let Table (tt, _) = t.it in tt) m.it.tables in
      ExternTableT (Lib.List32.nth tts x.it)
    | FuncX x ->
      let dts = funcs xts @ List.map (fun f ->
        let Func (y, _, _) = f.it in Def (Lib.List32.nth dts y.it)) m.it.funcs in
      ExternFuncT (Lib.List32.nth dts x.it)
  in ExportT (name, subst_externtype (subst_of dts) xt)

let moduletype_of (m : module_) : moduletype =
  let its = List.map (importtype_of m) m.it.imports in
  let ets = List.map (exporttype_of m) m.it.exports in
  ModuleT (its, ets)
