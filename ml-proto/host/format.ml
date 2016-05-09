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
    | Drop e -> "drop", [expr e]
    | Block ([], {it = Loop e}) -> "loop", [expr e]
    | Block (es, e) -> "block", list expr (es @ [e])
    | Loop e -> assert false
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

