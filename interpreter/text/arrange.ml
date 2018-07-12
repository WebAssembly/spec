open Source
open Ast
open Script
open Values
open Types
open Sexpr


(* Generic formatting *)

let nat n = I32.to_string_u (I32.of_int_u n)
let nat32 = I32.to_string_u

let add_hex_char buf c = Printf.bprintf buf "\\%02x" (Char.code c)
let add_char buf = function
  | '\n' -> Buffer.add_string buf "\\n"
  | '\t' -> Buffer.add_string buf "\\t"
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

let value_type t = string_of_value_type t

let elem_type t = string_of_elem_type t

let decls kind ts = tab kind (atom value_type) ts

let stack_type ts = decls "result" ts

let func_type (FuncType (ins, out)) =
  Node ("func", decls "param" ins @ decls "result" out)

let struct_type = func_type

let limits nat {min; max} =
  String.concat " " (nat min :: opt nat max)

let global_type = function
  | GlobalType (t, Immutable) -> atom string_of_value_type t
  | GlobalType (t, Mutable) -> Node ("mut", [atom string_of_value_type t])


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
    | ExtendSI32 -> "extend_s/i32"
    | ExtendUI32 -> "extend_u/i32"
    | WrapI64 -> "wrap/i64"
    | TruncSF32 -> "trunc_s/f32"
    | TruncUF32 -> "trunc_u/f32"
    | TruncSF64 -> "trunc_s/f64"
    | TruncUF64 -> "trunc_u/f64"
    | ReinterpretFloat -> "reinterpret/f" ^ xx
end

module FloatOp =
struct
  open Ast.FloatOp

  let testop xx = fun _ -> assert false

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
    | ConvertSI32 -> "convert_s/i32"
    | ConvertUI32 -> "convert_u/i32"
    | ConvertSI64 -> "convert_s/i64"
    | ConvertUI64 -> "convert_u/i64"
    | PromoteF32 -> "promote/f32"
    | DemoteF64 -> "demote/f64"
    | ReinterpretInt -> "reinterpret/i" ^ xx
end

let oper (intop, floatop) op =
  value_type (type_of op) ^ "." ^
  (match op with
  | I32 o -> intop "32" o
  | I64 o -> intop "64" o
  | F32 o -> floatop "32" o
  | F64 o -> floatop "64" o
  )

let unop = oper (IntOp.unop, FloatOp.unop)
let binop = oper (IntOp.binop, FloatOp.binop)
let testop = oper (IntOp.testop, FloatOp.testop)
let relop = oper (IntOp.relop, FloatOp.relop)
let cvtop = oper (IntOp.cvtop, FloatOp.cvtop)

let mem_size = function
  | Memory.Mem8 -> "8"
  | Memory.Mem16 -> "16"
  | Memory.Mem32 -> "32"

let extension = function
  | Memory.SX -> "_s"
  | Memory.ZX -> "_u"

let memop name {ty; align; offset; _} =
  value_type ty ^ "." ^ name ^
  (if offset = 0l then "" else " offset=" ^ nat32 offset) ^
  (if 1 lsl align = size ty then "" else " align=" ^ nat (1 lsl align))

let loadop op =
  match op.sz with
  | None -> memop "load" op
  | Some (sz, ext) -> memop ("load" ^ mem_size sz ^ extension ext) op

let storeop op =
  match op.sz with
  | None -> memop "store" op
  | Some sz -> memop ("store" ^ mem_size sz) op


(* Expressions *)

let var x = nat32 x.it
let value v = string_of_value v.it
let constop v = value_type (type_of v.it) ^ ".const"

let rec instr e =
  let head, inner =
    match e.it with
    | Unreachable -> "unreachable", []
    | Nop -> "nop", []
    | Block (ts, es) -> "block", stack_type ts @ list instr es
    | Loop (ts, es) -> "loop", stack_type ts @ list instr es
    | If (ts, es1, es2) ->
      "if", stack_type ts @
        [Node ("then", list instr es1); Node ("else", list instr es2)]
    | Br x -> "br " ^ var x, []
    | BrIf x -> "br_if " ^ var x, []
    | BrTable (xs, x) ->
      "br_table " ^ String.concat " " (list var (xs @ [x])), []
    | Return -> "return", []
    | Call x -> "call " ^ var x, []
    | CallIndirect x -> "call_indirect " ^ var x, []
    | Drop -> "drop", []
    | Select -> "select", []
    | GetLocal x -> "get_local " ^ var x, []
    | SetLocal x -> "set_local " ^ var x, []
    | TeeLocal x -> "tee_local " ^ var x, []
    | GetGlobal x -> "get_global " ^ var x, []
    | SetGlobal x -> "set_global " ^ var x, []
    | Load op -> loadop op, []
    | Store op -> storeop op, []
    | CurrentMemory -> "current_memory", []
    | GrowMemory -> "grow_memory", []
    | Const lit -> constop lit ^ " " ^ value lit, []
    | Test op -> testop op, []
    | Compare op -> relop op, []
    | Unary op -> unop op, []
    | Binary op -> binop op, []
    | Convert op -> cvtop op, []
  in Node (head, inner)

let const c =
  list instr c.it


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

let start x = Node ("start " ^ var x, [])


(* Tables & memories *)

let table off i tab =
  let {ttype = TableType (lim, t)} = tab.it in
  Node ("table $" ^ nat (off + i) ^ " " ^ limits nat32 lim,
    [atom elem_type t]
  )

let memory off i mem =
  let {mtype = MemoryType lim} = mem.it in
  Node ("memory $" ^ nat (off + i) ^ " " ^ limits nat32 lim, [])

let segment head dat seg =
  let {index; offset; init} = seg.it in
  Node (head, atom var index :: Node ("offset", const offset) :: dat init)

let elems seg =
  segment "elem" (list (atom var)) seg

let data seg =
  segment "data" break_bytes seg


(* Modules *)

let typedef i ty =
  Node ("type $" ^ nat i, [struct_type ty.it])

let import_desc i d =
  match d.it with
  | FuncImport x ->
    Node ("func $" ^ nat i, [Node ("type", [atom var x])])
  | TableImport t -> table 0 i ({ttype = t} @@ d.at)
  | MemoryImport t -> memory 0 i ({mtype = t} @@ d.at)
  | GlobalImport t -> Node ("global $" ^ nat i, [global_type t])

let import i im =
  let {module_name; item_name; idesc} = im.it in
  Node ("import",
    [atom name module_name; atom name item_name; import_desc i idesc]
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
  let {gtype; value} = g.it in
  Node ("global $" ^ nat (off + i), global_type gtype :: const value)


(* Modules *)

let var_opt = function
  | None -> ""
  | Some x -> " " ^ x.it

let is_func_import im =
  match im.it.idesc.it with FuncImport _ -> true | _ -> false
let is_table_import im =
  match im.it.idesc.it with TableImport _ -> true | _ -> false
let is_memory_import im =
  match im.it.idesc.it with MemoryImport _ -> true | _ -> false
let is_global_import im =
  match im.it.idesc.it with GlobalImport _ -> true | _ -> false

let module_with_var_opt x_opt m =
  let func_imports = List.filter is_func_import m.it.imports in
  let table_imports = List.filter is_table_import m.it.imports in
  let memory_imports = List.filter is_memory_import m.it.imports in
  let global_imports = List.filter is_global_import m.it.imports in
  Node ("module" ^ var_opt x_opt,
    listi typedef m.it.types @
    listi import table_imports @
    listi import memory_imports @
    listi import global_imports @
    listi import func_imports @
    listi (table (List.length table_imports)) m.it.tables @
    listi (memory (List.length memory_imports)) m.it.memories @
    listi (global (List.length global_imports)) m.it.globals @
    listi (func_with_index (List.length func_imports)) m.it.funcs @
    list export m.it.exports @
    opt start m.it.start @
    list elems m.it.elems @
    list data m.it.data
  )

let binary_module_with_var_opt x_opt bs =
  Node ("module" ^ var_opt x_opt ^ " binary", break_bytes bs)

let quoted_module_with_var_opt x_opt s =
  Node ("module" ^ var_opt x_opt ^ " quote", break_string s)

let module_ = module_with_var_opt None


(* Scripts *)

let literal lit =
  match lit.it with
  | Values.I32 i -> Node ("i32.const " ^ I32.to_string_s i, [])
  | Values.I64 i -> Node ("i64.const " ^ I64.to_string_s i, [])
  | Values.F32 z -> Node ("f32.const " ^ F32.to_string z, [])
  | Values.F64 z -> Node ("f64.const " ^ F64.to_string z, [])

let definition mode x_opt def =
  try
    match mode, def.it with
    | `Textual, _ | `Original, Textual _ ->
      let rec unquote def =
        match def.it with
        | Textual m -> m
        | Encoded (_, bs) -> Decode.decode "" bs
        | Quoted (_, s) -> unquote (Parse.string_to_module s)
      in module_with_var_opt x_opt (unquote def)
    | `Binary, _ | `Original, Encoded _ ->
      let rec unquote def =
        match def.it with
        | Textual m -> Encode.encode m
        | Encoded (_, bs) -> bs
        | Quoted (_, s) -> unquote (Parse.string_to_module s)
      in binary_module_with_var_opt x_opt (unquote def)
    | `Original, Quoted (_, s) ->
      quoted_module_with_var_opt x_opt s
  with Parse.Syntax _ ->
    quoted_module_with_var_opt x_opt "<invalid module>"

let access x_opt n =
  String.concat " " [var_opt x_opt; name n]

let action act =
  match act.it with
  | Invoke (x_opt, name, lits) ->
    Node ("invoke" ^ access x_opt name, List.map literal lits)
  | Get (x_opt, name) ->
    Node ("get" ^ access x_opt name, [])

let assertion mode ass =
  match ass.it with
  | AssertMalformed (def, re) ->
    Node ("assert_malformed", [definition `Original None def; Atom (string re)])
  | AssertInvalid (def, re) ->
    Node ("assert_invalid", [definition mode None def; Atom (string re)])
  | AssertUnlinkable (def, re) ->
    Node ("assert_unlinkable", [definition mode None def; Atom (string re)])
  | AssertUninstantiable (def, re) ->
    Node ("assert_trap", [definition mode None def; Atom (string re)])
  | AssertReturn (act, lits) ->
    Node ("assert_return", action act :: List.map literal lits)
  | AssertReturnCanonicalNaN act ->
    Node ("assert_return_canonical_nan", [action act])
  | AssertReturnArithmeticNaN act ->
    Node ("assert_return_arithmetic_nan", [action act])
  | AssertTrap (act, re) ->
    Node ("assert_trap", [action act; Atom (string re)])
  | AssertExhaustion (act, re) ->
    Node ("assert_exhaustion", [action act; Atom (string re)])

let command mode cmd =
  match cmd.it with
  | Module (x_opt, def) -> definition mode x_opt def
  | Merkle def -> definition mode None def
  | Register (n, x_opt) ->
    Node ("register " ^ name n ^ var_opt x_opt, [])
  | Action act -> action act
  | Assertion ass -> assertion mode ass
  | Meta _ -> assert false

let script mode scr = List.map (command mode) scr
