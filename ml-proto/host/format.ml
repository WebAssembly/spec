open Source
open Kernel
open Values
open Types
open Sexpr


(* Generic formatting *)

let int = string_of_int
let int32 = Int32.to_string
let int64 = Int64.to_string
let string s = "\"" ^ String.escaped s ^ "\""

let list_of_opt = function None -> [] | Some x -> [x]

let list f xs = List.map f xs
let opt f xo = list f (list_of_opt xo)

let tab head f xs = if xs = [] then [] else [Node (head, list f xs)]
let atom f x = Atom (f x)


(* Types *)

let value_type t = string_of_value_type t

let decls kind ts = tab kind (atom value_type) ts

let func_type {ins; out} =
  Node ("func", decls "param" ins @ decls "result" (list_of_opt out))

let struct_type = func_type


(* Operators *)

module IntOp =
struct
  open Kernel.IntOp

  let unop xx = function
    | Clz -> "clz"
    | Ctz -> "ctz"
    | Popcnt -> "popcnt"

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

  let testop xx = function
    | Eqz -> "eqz"

  let relop xx = function
    | Eq -> "eq"
    | Ne -> "ne"
    | LtS -> "lt_s"
    | LtU -> "lt_u"
    | LeS -> "le_s"
    | LeU -> "le_u"
    | GtS -> "gt_s"
    | GtU -> "gt_u"
    | GeS -> "ge_s"
    | GeU -> "ge_u"

  let cvtop xx = function
    | ExtendSInt32 -> "extend_s/i32"
    | ExtendUInt32 -> "extend_u/i32"
    | WrapInt64 -> "wrap/i64"
    | TruncSFloat32 -> "trunc_s/f32"
    | TruncUFloat32 -> "trunc_u/f32"
    | TruncSFloat64 -> "trunc_s/f64"
    | TruncUFloat64 -> "trunc_u/f64"
    | ReinterpretFloat -> "reinterpret/f" ^ xx
end

module FloatOp =
struct
  open Kernel.FloatOp

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

  let testop xx = fun _ -> assert false

  let relop xx = function
    | Eq -> "eq"
    | Ne -> "ne"
    | Lt -> "lt"
    | Le -> "le"
    | Gt -> "gt"
    | Ge -> "ge"

  let cvtop xx = function
    | ConvertSInt32 -> "convert_s/i32"
    | ConvertUInt32 -> "convert_u/i32"
    | ConvertSInt64 -> "convert_s/i64"
    | ConvertUInt64 -> "convert_u/i64"
    | PromoteFloat32 -> "promote/f32"
    | DemoteFloat64 -> "demote/f64"
    | ReinterpretInt -> "reinterpret/i" ^ xx
end

let oper (intop, floatop) op =
  value_type (type_of op) ^ "." ^
  (match op with
  | Int32 o -> intop "32" o
  | Int64 o -> intop "64" o
  | Float32 o -> floatop "32" o
  | Float64 o -> floatop "64" o
  )

let unop = oper (IntOp.unop, FloatOp.unop)
let binop = oper (IntOp.binop, FloatOp.binop)
let testop = oper (IntOp.testop, FloatOp.testop)
let relop = oper (IntOp.relop, FloatOp.relop)
let cvtop = oper (IntOp.cvtop, FloatOp.cvtop)

(*
let memop op = "..."
let extop op = "..."
let wrapop op = "..."

type mem_size = Mem8 | Mem16 | Mem32
type extension = SX | ZX
type memop = {ty : value_type; offset : Memory.offset; align : int}
type extop = {memop : memop; sz : Memory.mem_size; ext : Memory.extension}
type wrapop = {memop : memop; sz : Memory.mem_size}
*)

let memop name {ty; offset; align} =
  value_type ty ^ "." ^ name ^
  (if offset = 0L then "" else " offset=" ^ int64 offset) ^
  (if align = 1 then "" else " align=" ^ int align)

let mem_size = function
  | Memory.Mem8 -> "8"
  | Memory.Mem16 -> "16"
  | Memory.Mem32 -> "32"

let extension = function
  | Memory.SX -> "_s"
  | Memory.ZX -> "_u"

let extop {memop = op; sz; ext} =
  memop ("load" ^ mem_size sz ^ extension ext) op

let wrapop {memop = op; sz} =
  memop ("store" ^ mem_size sz) op

(*
  | (nxx as t)".load"
    { LOAD (fun (o, a, e) ->
        numop t (I32_load (o, (Lib.Option.get a 4), e))
                (I64_load (o, (Lib.Option.get a 8), e))
                (F32_load (o, (Lib.Option.get a 4), e))
                (F64_load (o, (Lib.Option.get a 8), e))) }
  | (nxx as t)".store"
    { STORE (fun (o, a, e1, e2) ->
        numop t (I32_store (o, (Lib.Option.get a 4), e1, e2))
                (I64_store (o, (Lib.Option.get a 8), e1, e2))
                (F32_store (o, (Lib.Option.get a 4), e1, e2))
                (F64_store (o, (Lib.Option.get a 8), e1, e2))) }
  | (ixx as t)".load"(mem_size as sz)"_"(sign as s)
    { if t = "i32" && sz = "32" then error lexbuf "unknown opcode";
      LOAD (fun (o, a, e) ->
        intop t
          (memsz sz
            (ext s (I32_load8_s (o, (Lib.Option.get a 1), e))
                   (I32_load8_u (o, (Lib.Option.get a 1), e)))
            (ext s (I32_load16_s (o, (Lib.Option.get a 2), e))
                   (I32_load16_u (o, (Lib.Option.get a 2), e)))
            Unreachable)
          (memsz sz
            (ext s (I64_load8_s (o, (Lib.Option.get a 1), e))
                   (I64_load8_u (o, (Lib.Option.get a 1), e)))
            (ext s (I64_load16_s (o, (Lib.Option.get a 2), e))
                   (I64_load16_u (o, (Lib.Option.get a 2), e)))
            (ext s (I64_load32_s (o, (Lib.Option.get a 4), e))
                   (I64_load32_u (o, (Lib.Option.get a 4), e))))) }
  | (ixx as t)".store"(mem_size as sz)
    { if t = "i32" && sz = "32" then error lexbuf "unknown opcode";
      STORE (fun (o, a, e1, e2) ->
        intop t
          (memsz sz
            (I32_store8 (o, (Lib.Option.get a 1), e1, e2))
            (I32_store16 (o, (Lib.Option.get a 2), e1, e2))
            Unreachable)
          (memsz sz
            (I64_store8 (o, (Lib.Option.get a 1), e1, e2))
            (I64_store16 (o, (Lib.Option.get a 2), e1, e2))
            (I64_store32 (o, (Lib.Option.get a 4), e1, e2)))
        ) }

  | "offset="(digits as s) { OFFSET (Int64.of_string s) }
  | "align="(digits as s) { ALIGN (int_of_string s) }


offset :
  | /* empty */ { 0L }
  | OFFSET { $1 }
;
align :
  | /* empty */ { None }
  | ALIGN { Some $1 }

  | LOAD offset align expr { fun c -> $1 ($2, $3, $4 c) }
  | STORE offset align expr expr { fun c -> $1 ($2, $3, $4 c, $5 c) }



  | Ast.I32_load (offset, align, e) ->
    Load ({ty = Int32Type; offset; align}, expr e)
  | Ast.I64_load (offset, align, e) ->
    Load ({ty = Int64Type; offset; align}, expr e)
  | Ast.F32_load (offset, align, e) ->
    Load ({ty = Float32Type; offset; align}, expr e)
  | Ast.F64_load (offset, align, e) ->
    Load ({ty = Float64Type; offset; align}, expr e)
  | Ast.I32_store (offset, align, e1, e2) ->
    Store ({ty = Int32Type; offset; align}, expr e1, expr e2)
  | Ast.I64_store (offset, align, e1, e2) ->
    Store ({ty = Int64Type; offset; align}, expr e1, expr e2)
  | Ast.F32_store (offset, align, e1, e2) ->
    Store ({ty = Float32Type; offset; align}, expr e1, expr e2)
  | Ast.F64_store (offset, align, e1, e2) ->
    Store ({ty = Float64Type; offset; align}, expr e1, expr e2)
  | Ast.I32_load8_s (offset, align, e) ->
    LoadExtend
      ({memop = {ty = Int32Type; offset; align}; sz = Mem8; ext = SX}, expr e)
  | Ast.I32_load8_u (offset, align, e) ->
    LoadExtend
      ({memop = {ty = Int32Type; offset; align}; sz = Mem8; ext = ZX}, expr e)
  | Ast.I32_load16_s (offset, align, e) ->
    LoadExtend
      ({memop = {ty = Int32Type; offset; align}; sz = Mem16; ext = SX}, expr e)
  | Ast.I32_load16_u (offset, align, e) ->
    LoadExtend
      ({memop = {ty = Int32Type; offset; align}; sz = Mem16; ext = ZX}, expr e)
  | Ast.I64_load8_s (offset, align, e) ->
    LoadExtend
      ({memop = {ty = Int64Type; offset; align}; sz = Mem8; ext = SX}, expr e)
  | Ast.I64_load8_u (offset, align, e) ->
    LoadExtend
      ({memop = {ty = Int64Type; offset; align}; sz = Mem8; ext = ZX}, expr e)
  | Ast.I64_load16_s (offset, align, e) ->
    LoadExtend
      ({memop = {ty = Int64Type; offset; align}; sz = Mem16; ext = SX}, expr e)
  | Ast.I64_load16_u (offset, align, e) ->
    LoadExtend
      ({memop = {ty = Int64Type; offset; align}; sz = Mem16; ext = ZX}, expr e)
  | Ast.I64_load32_s (offset, align, e) ->
    LoadExtend
      ({memop = {ty = Int64Type; offset; align}; sz = Mem32; ext = SX}, expr e)
  | Ast.I64_load32_u (offset, align, e) ->
    LoadExtend
      ({memop = {ty = Int64Type; offset; align}; sz = Mem32; ext = ZX}, expr e)
  | Ast.I32_store8 (offset, align, e1, e2) ->
    StoreWrap
      ({memop = {ty = Int32Type; offset; align}; sz = Mem8}, expr e1, expr e2)
  | Ast.I32_store16 (offset, align, e1, e2) ->
    StoreWrap
      ({memop = {ty = Int32Type; offset; align}; sz = Mem16}, expr e1, expr e2)
  | Ast.I64_store8 (offset, align, e1, e2) ->
    StoreWrap
      ({memop = {ty = Int64Type; offset; align}; sz = Mem8}, expr e1, expr e2)
  | Ast.I64_store16 (offset, align, e1, e2) ->
    StoreWrap
      ({memop = {ty = Int64Type; offset; align}; sz = Mem16}, expr e1, expr e2)
  | Ast.I64_store32 (offset, align, e1, e2) ->
    StoreWrap
      ({memop = {ty = Int64Type; offset; align}; sz = Mem32}, expr e1, expr e2)
*)


let hostop = function
  | CurrentMemory -> "current_memory"
  | GrowMemory -> "grow_memory"


(* Expressions *)

let var x = string_of_int x.it
let value v = string_of_value v.it
let constop v = value_type (type_of v.it) ^ ".const"

let rec expr e =
  let head, inner =
    match e.it with
    | Nop -> "nop", []
    | Unreachable -> "unreachable", []
    | Block (es, e) -> "block", list expr (es @ [e])
    | Loop e -> "loop", [expr e]
    | Break (x, eo) -> "br " ^ var x, opt expr eo
    | BreakIf (x, eo, e) -> "br_if " ^ var x, opt expr eo @ [expr e]
    | BreakTable (xs, x, eo, e) ->
      "br_table", list (atom var) (xs @ [x]) @ opt expr eo @ [expr e]
    | If (e1, e2, e3) ->
      (match block e2, block e3 with
      | [sx2], [] -> "if", [expr e1; sx2]
      | [sx2], [sx3] -> "if", [expr e1; sx2; sx3]
      | sxs2, [] -> "if", [expr e1; Node ("then", sxs2)]
      | sxs2, sxs3 -> "if", [expr e1; Node ("then", sxs2); Node ("else", sxs3)]
      )
    | Select (e1, e2, e3) -> "select", [expr e1; expr e2; expr e3]
    | Call (x, es) -> "call " ^ var x, list expr es
    | CallImport (x, es) -> "call_import " ^ var x, list expr es
    | CallIndirect (x, e, es) -> "call_indirect " ^ var x, list expr (e::es)
    | GetLocal x -> "get_local " ^ var x, []
    | SetLocal (x, e) -> "set_local " ^ var x, [expr e]
    | Load (op, e) -> memop "load" op, [expr e]
    | Store (op, e1, e2) -> memop "store" op, [expr e1; expr e2]
    | LoadExtend (op, e) -> extop op, [expr e]
    | StoreWrap (op, e1, e2) -> wrapop op, [expr e1; expr e2]
    | Const lit -> constop lit, [atom value lit]
    | Unary (op, e) -> unop op, [expr e]
    | Binary (op, e1, e2) -> binop op, [expr e1; expr e2]
    | Test (op, e) -> testop op, [expr e]
    | Compare (op, e1, e2) -> relop op, [expr e1; expr e2]
    | Convert (op, e) -> cvtop op, [expr e]
    | Host (op, es) -> hostop op, list expr es
  in Node (head, inner)

and block e =
  match e.it with
  | Block (es, e) -> list expr (es @ [e])
  | Nop -> []
  | _ -> assert false  (* TODO *)


(* Functions *)

let func m f =
  let {ftype; locals; body} = f.it in
  let {ins; out} = List.nth m.it.types ftype.it in
  Node ("func",
    decls "param" ins @
    decls "result" (list_of_opt out) @
    decls "local" locals @
    block body
  )

let start x = Node ("start " ^ var x, [])

let table xs = tab "table" (atom var) xs


(* Memory *)

let segment seg =
  let {Memory.addr; data} = seg.it in
  Node ("segment " ^ int64 addr, [atom string data])

let memory mem =
  let {min; max; segments} = mem.it in
  Node ("memory " ^ int64 min ^ " " ^ int64 max, list segment segments)


(* Modules *)

let typedef t =
  Node ("type", [struct_type t])

let import im =
  let {itype; module_name; func_name} = im.it in
  let ty = Node ("type " ^ var itype, []) in
  Node ("import", [atom string module_name; atom string func_name; ty])

let export ex =
  let {name; kind} = ex.it in
  let desc = match kind with `Func x -> var x | `Memory -> "memory" in
  Node ("export", [atom string name; Atom desc])


(* Modules *)

let module_ m =
  Node ("module",
    list typedef m.it.types @
    list import m.it.imports @
    list export m.it.exports @
    list (func m) m.it.funcs @
    opt start m.it.start @
    table m.it.table @
    opt memory m.it.memory
  )

