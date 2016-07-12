open Source
open Ast
open Values
open Types
open Sexpr


(* Generic formatting *)

let int = string_of_int
let int32 = Int32.to_string
let int64 = Int64.to_string

let string s =
  let buf = Buffer.create (String.length s + 2) in
  Buffer.add_char buf '\"';
  for i = 0 to String.length s - 1 do
    let c = s.[i] in
    if c = '\"' then
      Buffer.add_string buf "\\\""
    else if '\x20' <= c && c < '\x7f' then
      Buffer.add_char buf c
    else
      Buffer.add_string buf (Printf.sprintf "\\%02x" (Char.code c));
  done;
  Buffer.add_char buf '\"';
  Buffer.contents buf

let list_of_opt = function None -> [] | Some x -> [x]

let list f xs = List.map f xs
let listi f xs = List.mapi f xs
let opt f xo = list f (list_of_opt xo)

let tab head f xs = if xs = [] then [] else [Node (head, list f xs)]
let atom f x = Atom (f x)


(* Types *)

let value_type t = string_of_value_type t

let decls kind ts = tab kind (atom value_type) ts

let func_type (FuncType (ins, out)) =
  Node ("func", decls "param" ins @ decls "result" out)

let struct_type = func_type


(* Operators *)

module IntOp =
struct
  open Ast.IntOp

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
  open Ast.FloatOp

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

let memop name {ty; align; offset} =
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


(* Expressions *)

let var x = string_of_int x.it
let value v = string_of_value v.it
let constop v = value_type (type_of v.it) ^ ".const"

let rec expr e =
    match e.it with
    | Nop -> Atom "nop"
    | Unreachable -> Atom "unreachable"
    | Drop -> Atom "drop"
    | Block es -> Node ("block", list expr es)
    | Loop es -> Node ("loop", list expr es)
    | Br (n, x) -> Atom ("br " ^ int n ^ " " ^ var x)
    | BrIf (n, x) -> Atom ("br_if " ^ int n ^ " " ^ var x)
    | BrTable (n, xs, x) ->
      Atom ("br_table " ^ int n ^ " " ^ String.concat " " (list var (xs @ [x])))
    | Return n -> Atom ("return " ^ int n)
    | If (es1, es2) ->
      (match list expr es1, list expr es2 with
      | [sx2], [] -> Node ("if", [sx2])
      | [sx2], [sx3] -> Node ("if", [sx2; sx3])
      | sxs2, [] -> Node ("if", [Node ("then", sxs2)])
      | sxs2, sxs3 -> Node ("if", [Node ("then", sxs2); Node ("else", sxs3)])
      )
    | Select -> Atom "select"
    | Call (n, x) -> Atom ("call " ^ int n ^ " " ^ var x)
    | CallImport (n, x) -> Atom ("call_import " ^ int n ^ " " ^ var x)
    | CallIndirect (n, x) -> Atom ("call_indirect " ^ int n ^ " " ^ var x)
    | GetLocal x -> Atom ("get_local " ^ var x)
    | SetLocal x -> Atom ("set_local " ^ var x)
    | TeeLocal x -> Atom ("tee_local " ^ var x)
    | Load op -> Atom (memop "load" op)
    | Store op -> Atom (memop "store" op)
    | LoadPacked op -> Atom (extop op)
    | StorePacked op -> Atom (wrapop op)
    | Const lit -> Atom (constop lit ^ " " ^ value lit)
    | Unary op -> Atom (unop op)
    | Binary op -> Atom (binop op)
    | Test op -> Atom (testop op)
    | Compare op -> Atom (relop op)
    | Convert op -> Atom (cvtop op)
    | CurrentMemory -> Atom "current_memory"
    | GrowMemory -> Atom "grow_memory"
    | Label (e, vs, es) ->
      let ves = List.map (fun v -> Const (v @@ e.at) @@ e.at) (List.rev vs) in
      Node ("label", list expr (ves @ es))


(* Functions *)

let func i f =
  let {ftype; locals; body} = f.it in
  Node ("func $" ^ string_of_int i,
    [Node ("type " ^ var ftype, [])] @
    decls "local" locals @
    list expr body
  )

let start x = Node ("start " ^ var x, [])

let table xs = tab "table" (atom var) xs


(* Memory *)

let segment seg =
  let {Memory.addr; data} = seg.it in
  let ss = Lib.String.breakup data (!Flags.width / 2) in
  Node ("segment " ^ int64 addr, list (atom string) ss)

let memory mem =
  let {min; max; segments} = mem.it in
  Node ("memory " ^ int64 min ^ " " ^ int64 max, list segment segments)


(* Modules *)

let typedef i t =
  Node ("type $" ^ string_of_int i, [struct_type t])

let import i im =
  let {itype; module_name; func_name} = im.it in
  let ty = Node ("type " ^ var itype, []) in
  Node ("import $" ^ string_of_int i,
    [atom string module_name; atom string func_name; ty]
  )

let export ex =
  let {name; kind} = ex.it in
  let desc = match kind with `Func x -> var x | `Memory -> "memory" in
  Node ("export", [atom string name; Atom desc])


(* Modules *)

let module_ m =
  Node ("module",
    listi typedef m.it.types @
    listi import m.it.imports @
    listi func m.it.funcs @
    table m.it.table @
    opt memory m.it.memory @
    list export m.it.exports @
    opt start m.it.start
  )

