%{
open Source
open Types
open Ast
open Operators
open Script


(* Error handling *)

let error at msg = raise (Script.Syntax (at, msg))

let parse_error msg =
  error Source.no_region
    (if msg = "syntax error" then "unexpected token" else msg)


(* Position handling *)

let position_to_pos position =
  { file = position.Lexing.pos_fname;
    line = position.Lexing.pos_lnum;
    column = position.Lexing.pos_cnum - position.Lexing.pos_bol
  }

let positions_to_region position1 position2 =
  { left = position_to_pos position1;
    right = position_to_pos position2
  }

let at () =
  positions_to_region (Parsing.symbol_start_pos ()) (Parsing.symbol_end_pos ())
let ati i =
  positions_to_region (Parsing.rhs_start_pos i) (Parsing.rhs_end_pos i)


(* Literals *)

let literal f s =
  try f s with Failure _ -> error s.at "constant out of range"

let nat s at =
  try
    let n = int_of_string s in
    if n >= 0 then n else raise (Failure "")
  with Failure _ -> error at "integer constant out of range"

let nat32 s at =
  try I32.of_string_u s with Failure _ -> error at "i32 constant out of range"

let name s at =
  try Utf8.decode s with Utf8.Utf8 -> error at "invalid UTF-8 encoding"


(* Symbolic variables *)

module VarMap = Map.Make(String)

type space = {mutable map : int32 VarMap.t; mutable count : int32}
let empty () = {map = VarMap.empty; count = 0l}

type types = {space : space; mutable list : type_ list}
let empty_types () = {space = empty (); list = []}

type context =
  { types : types; tables : space; memories : space;
    funcs : space; locals : space; globals : space; labels : int32 VarMap.t }

let empty_context () =
  { types = empty_types (); tables = empty (); memories = empty ();
    funcs = empty (); locals = empty (); globals = empty ();
    labels = VarMap.empty }

let enter_func (c : context) =
  {c with labels = VarMap.empty; locals = empty ()}

let lookup category space x =
  try VarMap.find x.it space.map
  with Not_found -> error x.at ("unknown " ^ category ^ " " ^ x.it)

let type_ (c : context) x = lookup "type" c.types.space x
let func (c : context) x = lookup "function" c.funcs x
let local (c : context) x = lookup "local" c.locals x
let global (c : context) x = lookup "global" c.globals x
let table (c : context) x = lookup "table" c.tables x
let memory (c : context) x = lookup "memory" c.memories x
let label (c : context) x =
  try VarMap.find x.it c.labels
  with Not_found -> error x.at ("unknown label " ^ x.it)

let func_type (c : context) x =
  try (Lib.List32.nth c.types.list x.it).it
  with Failure _ -> error x.at ("unknown type " ^ Int32.to_string x.it)


let bind category space x =
  if VarMap.mem x.it space.map then
    error x.at ("duplicate " ^ category ^ " " ^ x.it);
  let i = space.count in
  space.map <- VarMap.add x.it space.count space.map;
  space.count <- Int32.add space.count 1l;
  if space.count = 0l then 
    error x.at ("too many " ^ category ^ " bindings");
  i

let bind_type (c : context) x ty =
  c.types.list <- c.types.list @ [ty];
  bind "type" c.types.space x
let bind_func (c : context) x = bind "function" c.funcs x
let bind_local (c : context) x = bind "local" c.locals x
let bind_global (c : context) x = bind "global" c.globals x
let bind_table (c : context) x = bind "table" c.tables x
let bind_memory (c : context) x = bind "memory" c.memories x
let bind_label (c : context) x =
  {c with labels = VarMap.add x.it 0l (VarMap.map (Int32.add 1l) c.labels)}

let anon category space n =
  let i = space.count in
  space.count <- Int32.add space.count n;
  if I32.lt_u space.count n then
    error no_region ("too many " ^ category ^ " bindings");
  i

let anon_type (c : context) ty =
  c.types.list <- c.types.list @ [ty];
  anon "type" c.types.space 1l
let anon_func (c : context) = anon "function" c.funcs 1l
let anon_locals (c : context) ts =
  ignore (anon "local" c.locals (Lib.List32.length ts))
let anon_global (c : context) = anon "global" c.globals 1l
let anon_table (c : context) = anon "table" c.tables 1l
let anon_memory (c : context) = anon "memory" c.memories 1l
let anon_label (c : context) =
  {c with labels = VarMap.map (Int32.add 1l) c.labels}

let inline_type (c : context) ft at =
  match Lib.List.index_where (fun ty -> ty.it = ft) c.types.list with
  | Some i -> Int32.of_int i @@ at
  | None -> anon_type c (ft @@ at) @@ at

let inline_type_explicit (c : context) x ft at =
  if ft <> FuncType ([], []) && ft <> func_type c x then
    error at "inline function type does not match explicit type";
  x

%}

%token NAT INT FLOAT STRING VAR VALUE_TYPE ANYFUNC MUT LPAR RPAR
%token NOP DROP BLOCK END IF THEN ELSE SELECT LOOP BR BR_IF BR_TABLE
%token CALL CALL_INDIRECT RETURN
%token GET_LOCAL SET_LOCAL TEE_LOCAL GET_GLOBAL SET_GLOBAL
%token LOAD STORE OFFSET_EQ_NAT ALIGN_EQ_NAT
%token CONST UNARY BINARY TEST COMPARE CONVERT
%token UNREACHABLE CURRENT_MEMORY GROW_MEMORY
%token FUNC START TYPE PARAM RESULT LOCAL GLOBAL
%token TABLE ELEM MEMORY DATA OFFSET IMPORT EXPORT TABLE
%token MODULE BIN QUOTE MERKLE
%token SCRIPT REGISTER INVOKE GET
%token ASSERT_MALFORMED ASSERT_INVALID ASSERT_SOFT_INVALID ASSERT_UNLINKABLE
%token ASSERT_RETURN ASSERT_RETURN_CANONICAL_NAN ASSERT_RETURN_ARITHMETIC_NAN ASSERT_TRAP ASSERT_EXHAUSTION
%token INPUT OUTPUT
%token EOF

%token<string> NAT
%token<string> INT
%token<string> FLOAT
%token<string> STRING
%token<string> VAR
%token<Types.value_type> VALUE_TYPE
%token<string Source.phrase -> Ast.instr' * Values.value> CONST
%token<Ast.instr'> UNARY
%token<Ast.instr'> BINARY
%token<Ast.instr'> TEST
%token<Ast.instr'> COMPARE
%token<Ast.instr'> CONVERT
%token<int option -> Memory.offset -> Ast.instr'> LOAD
%token<int option -> Memory.offset -> Ast.instr'> STORE
%token<string> OFFSET_EQ_NAT
%token<string> ALIGN_EQ_NAT

%nonassoc LOW
%nonassoc VAR

%start script script1 module1
%type<Script.script> script
%type<Script.script> script1
%type<Script.var option * Script.definition> module1

%%

/* Auxiliaries */

name :
  | STRING { name $1 (at ()) }

string_list :
  | /* empty */ { "" }
  | string_list STRING { $1 ^ $2 }


/* Types */

value_type_list :
  | /* empty */ { [] }
  | VALUE_TYPE value_type_list { $1 :: $2 }

elem_type :
  | ANYFUNC { AnyFuncType }

global_type :
  | VALUE_TYPE { GlobalType ($1, Immutable) }
  | LPAR MUT VALUE_TYPE RPAR { GlobalType ($3, Mutable) }

func_type :
  | LPAR FUNC func_sig RPAR { $3 }

func_sig :
  | /* empty */
    { FuncType ([], []) }
  | LPAR RESULT value_type_list RPAR func_sig
    { let FuncType (ins, out) = $5 in
      if ins <> [] then error (at ()) "result before parameter";
      FuncType (ins, $3 @ out) }
  | LPAR PARAM value_type_list RPAR func_sig
    { let FuncType (ins, out) = $5 in FuncType ($3 @ ins, out) }
  | LPAR PARAM bind_var VALUE_TYPE RPAR func_sig  /* Sugar */
    { let FuncType (ins, out) = $6 in FuncType ($4 :: ins, out) }

table_sig :
  | limits elem_type { TableType ($1, $2) }

memory_sig :
  | limits { MemoryType $1 }

limits :
  | NAT { {min = nat32 $1 (ati 1); max = None} }
  | NAT NAT { {min = nat32 $1 (ati 1); max = Some (nat32 $2 (ati 2))} }

type_use :
  | LPAR TYPE var RPAR { $3 }


/* Immediates */

literal :
  | NAT { $1 @@ at () }
  | INT { $1 @@ at () }
  | FLOAT { $1 @@ at () }

var :
  | NAT { let at = at () in fun c lookup -> nat32 $1 at @@ at }
  | VAR { let at = at () in fun c lookup -> lookup c ($1 @@ at) @@ at }

var_list :
  | /* empty */ { fun c lookup -> [] }
  | var var_list { fun c lookup -> $1 c lookup :: $2 c lookup }

bind_var_opt :
  | /* empty */ { fun c anon bind -> anon c }
  | bind_var { fun c anon bind -> bind c $1 }  /* Sugar */

bind_var :
  | VAR { $1 @@ at () }

labeling_opt :
  | /* empty */ %prec LOW
    { fun c xs ->
      List.iter (fun x -> error x.at "mismatching label") xs;
      anon_label c }
  | bind_var
    { fun c xs ->
      List.iter
        (fun x -> if x.it <> $1.it then error x.at "mismatching label") xs;
      bind_label c $1 }

labeling_end_opt :
  | /* empty */ %prec LOW { [] }
  | bind_var { [$1] }

offset_opt :
  | /* empty */ { 0l }
  | OFFSET_EQ_NAT { nat32 $1 (at ()) }

align_opt :
  | /* empty */ { None }
  | ALIGN_EQ_NAT
    { let n = nat $1 (at ()) in
      if not (Lib.Int.is_power_of_two n) then
        error (at ()) "alignment must be a power of two";
      Some (Lib.Int.log2 n) }


/* Instructions & Expressions */

instr :
  | plain_instr { let at = at () in fun c -> [$1 c @@ at] }
  | block_instr { let at = at () in fun c -> [$1 c @@ at] }
  | expr { $1 } /* Sugar */

plain_instr :
  | UNREACHABLE { fun c -> unreachable }
  | NOP { fun c -> nop }
  | BR var { fun c -> br ($2 c label) }
  | BR_IF var { fun c -> br_if ($2 c label) }
  | BR_TABLE var var_list
    { fun c -> let xs, x = Lib.List.split_last ($2 c label :: $3 c label) in
      br_table xs x }
  | RETURN { fun c -> return }
  | CALL var { fun c -> call ($2 c func) }
  | CALL_INDIRECT var { fun c -> call_indirect ($2 c type_) }
  | DROP { fun c -> drop }
  | SELECT { fun c -> select }
  | GET_LOCAL var { fun c -> get_local ($2 c local) }
  | SET_LOCAL var { fun c -> set_local ($2 c local) }
  | TEE_LOCAL var { fun c -> tee_local ($2 c local) }
  | GET_GLOBAL var { fun c -> get_global ($2 c global) }
  | SET_GLOBAL var { fun c -> set_global ($2 c global) }
  | LOAD offset_opt align_opt { fun c -> $1 $3 $2 }
  | STORE offset_opt align_opt { fun c -> $1 $3 $2 }
  | CURRENT_MEMORY { fun c -> current_memory }
  | GROW_MEMORY { fun c -> grow_memory }
  | CONST literal { fun c -> fst (literal $1 $2) }
  | TEST { fun c -> $1 }
  | COMPARE { fun c -> $1 }
  | UNARY { fun c -> $1 }
  | BINARY { fun c -> $1 }
  | CONVERT { fun c -> $1 }

block_instr :
  | BLOCK labeling_opt block END labeling_end_opt
    { fun c -> let c' = $2 c $5 in let ts, es = $3 c' in block ts es }
  | LOOP labeling_opt block END labeling_end_opt
    { fun c -> let c' = $2 c $5 in let ts, es = $3 c' in loop ts es }
  | IF labeling_opt block END labeling_end_opt
    { fun c -> let c' = $2 c $5 in let ts, es = $3 c' in if_ ts es [] }
  | IF labeling_opt block ELSE labeling_end_opt instr_list END labeling_end_opt
    { fun c -> let c' = $2 c ($5 @ $8) in
      let ts, es1 = $3 c' in if_ ts es1 ($6 c') }

block_sig :
  | LPAR RESULT VALUE_TYPE RPAR { [$3] }

block :
  | block_sig instr_list
    { fun c -> $1, $2 c }
  | instr_list { fun c -> [], $1 c }

expr :  /* Sugar */
  | LPAR expr1 RPAR
    { let at = at () in fun c -> let es, e' = $2 c in es @ [e' @@ at] }

expr1 :  /* Sugar */
  | plain_instr expr_list { fun c -> $2 c, $1 c }
  | BLOCK labeling_opt block
    { fun c -> let c' = $2 c [] in let ts, es = $3 c' in [], block ts es }
  | LOOP labeling_opt block
    { fun c -> let c' = $2 c [] in let ts, es = $3 c' in [], loop ts es }
  | IF labeling_opt if_block
    { fun c -> let c' = $2 c [] in
      let ts, (es, es1, es2) = $3 c c' in es, if_ ts es1 es2 }

if_block :
  | block_sig if_block { fun c c' -> let ts, ess = $2 c c' in $1 @ ts, ess }
  | if_ { fun c c' -> [], $1 c c' }

if_ :
  | expr if_
    { fun c c' -> let es = $1 c in let es0, es1, es2 = $2 c c' in
      es @ es0, es1, es2 }
  | LPAR THEN instr_list RPAR LPAR ELSE instr_list RPAR  /* Sugar */
    { fun c c' -> [], $3 c', $7 c' }
  | LPAR THEN instr_list RPAR  /* Sugar */
    { fun c c' -> [], $3 c', [] }

instr_list :
  | /* empty */ { fun c -> [] }
  | instr instr_list { fun c -> $1 c @ $2 c }

expr_list :
  | /* empty */ { fun c -> [] }
  | expr expr_list { fun c -> $1 c @ $2 c }

const_expr :
  | instr_list { let at = at () in fun c -> $1 c @@ at }


/* Functions */

func :
  | LPAR FUNC bind_var_opt func_fields RPAR
    { let at = at () in
      fun c -> let x = $3 c anon_func bind_func @@ at in fun () -> $4 c x at }

func_fields :
  | type_use func_fields_body
    { fun c x at ->
      let t = inline_type_explicit c ($1 c type_) (fst $2) at in
      [{(snd $2 (enter_func c)) with ftype = t} @@ at], [], [] }
  | func_fields_body  /* Sugar */
    { fun c x at ->
      let t = inline_type c (fst $1) at in
      [{(snd $1 (enter_func c)) with ftype = t} @@ at], [], [] }
  | inline_import type_use func_fields_import  /* Sugar */
    { fun c x at ->
      let t = inline_type_explicit c ($2 c type_) $3 at in
      [],
      [{ module_name = fst $1; item_name = snd $1;
         idesc = FuncImport t @@ at } @@ at ], [] }
  | inline_import func_fields_import  /* Sugar */
    { fun c x at ->
      let t = inline_type c $2 at in
      [],
      [{ module_name = fst $1; item_name = snd $1;
         idesc = FuncImport t @@ at } @@ at ], [] }
  | inline_export func_fields  /* Sugar */
    { fun c x at ->
      let fns, ims, exs = $2 c x at in fns, ims, $1 (FuncExport x) c :: exs }

func_fields_import :  /* Sugar */
  | func_fields_import_result { $1 }
  | LPAR PARAM value_type_list RPAR func_fields_import
    { let FuncType (ins, out) = $5 in FuncType ($3 @ ins, out) }
  | LPAR PARAM bind_var VALUE_TYPE RPAR func_fields_import  /* Sugar */
    { let FuncType (ins, out) = $6 in FuncType ($4 :: ins, out) }

func_fields_import_result :  /* Sugar */
  | /* empty */ { FuncType ([], []) }
  | LPAR RESULT value_type_list RPAR func_fields_import_result
    { let FuncType (ins, out) = $5 in FuncType (ins, $3 @ out) }

func_fields_body :
  | func_result_body { $1 }
  | LPAR PARAM value_type_list RPAR func_fields_body
    { let FuncType (ins, out) = fst $5 in
      FuncType ($3 @ ins, out),
      fun c -> ignore (anon_locals c $3); snd $5 c }
  | LPAR PARAM bind_var VALUE_TYPE RPAR func_fields_body  /* Sugar */
    { let FuncType (ins, out) = fst $6 in
      FuncType ($4 :: ins, out),
      fun c -> ignore (bind_local c $3); snd $6 c }

func_result_body :
  | func_body { FuncType ([], []), $1 }
  | LPAR RESULT value_type_list RPAR func_result_body
    { let FuncType (ins, out) = fst $5 in
      FuncType (ins, $3 @ out), snd $5 }

func_body :
  | instr_list
    { fun c -> let c' = anon_label c in
      {ftype = -1l @@ at(); locals = []; body = $1 c'} }
  | LPAR LOCAL value_type_list RPAR func_body
    { fun c -> ignore (anon_locals c $3); let f = $5 c in
      {f with locals = $3 @ f.locals} }
  | LPAR LOCAL bind_var VALUE_TYPE RPAR func_body  /* Sugar */
    { fun c -> ignore (bind_local c $3); let f = $6 c in
      {f with locals = $4 :: f.locals} }


/* Tables, Memories & Globals */

offset :
  | LPAR OFFSET const_expr RPAR { $3 }
  | expr { let at = at () in fun c -> $1 c @@ at }  /* Sugar */

elem :
  | LPAR ELEM var offset var_list RPAR
    { let at = at () in
      fun c -> {index = $3 c table; offset = $4 c; init = $5 c func} @@ at }
  | LPAR ELEM offset var_list RPAR  /* Sugar */
    { let at = at () in
      fun c -> {index = 0l @@ at; offset = $3 c; init = $4 c func} @@ at }

table :
  | LPAR TABLE bind_var_opt table_fields RPAR
    { let at = at () in
      fun c -> let x = $3 c anon_table bind_table @@ at in
      fun () -> $4 c x at }

table_fields :
  | table_sig
    { fun c x at -> [{ttype = $1} @@ at], [], [], [] }
  | inline_import table_sig
    { fun c x at ->
      [], [],
      [{ module_name = fst $1; item_name = snd $1;
        idesc = TableImport $2 @@ at } @@ at], [] }
  | inline_export table_fields  /* Sugar */
    { fun c x at -> let tabs, elems, ims, exs = $2 c x at in
      tabs, elems, ims, $1 (TableExport x) c :: exs }
  | elem_type LPAR ELEM var_list RPAR  /* Sugar */
    { fun c x at ->
      let init = $4 c func in let size = Int32.of_int (List.length init) in
      [{ttype = TableType ({min = size; max = Some size}, $1)} @@ at],
      [{index = x; offset = [i32_const (0l @@ at) @@ at] @@ at; init} @@ at],
      [], [] }

data :
  | LPAR DATA var offset string_list RPAR
    { let at = at () in
      fun c -> {index = $3 c memory; offset = $4 c; init = $5} @@ at }
  | LPAR DATA offset string_list RPAR  /* Sugar */
    { let at = at () in
      fun c -> {index = 0l @@ at; offset = $3 c; init = $4} @@ at }

memory :
  | LPAR MEMORY bind_var_opt memory_fields RPAR
    { let at = at () in
      fun c -> let x = $3 c anon_memory bind_memory @@ at in
      fun () -> $4 c x at }

memory_fields :
  | memory_sig
    { fun c x at -> [{mtype = $1} @@ at], [], [], [] }
  | inline_import memory_sig
    { fun c x at ->
      [], [],
      [{ module_name = fst $1; item_name = snd $1;
         idesc = MemoryImport $2 @@ at } @@ at], [] }
  | inline_export memory_fields  /* Sugar */
    { fun c x at -> let mems, data, ims, exs = $2 c x at in
      mems, data, ims, $1 (MemoryExport x) c :: exs }
  | LPAR DATA string_list RPAR  /* Sugar */
    { fun c x at ->
      let size = Int32.(div (add (of_int (String.length $3)) 65535l) 65536l) in
      [{mtype = MemoryType {min = size; max = Some size}} @@ at],
      [{index = x;
        offset = [i32_const (0l @@ at) @@ at] @@ at; init = $3} @@ at],
      [], [] }

global :
  | LPAR GLOBAL bind_var_opt global_fields RPAR
    { let at = at () in
      fun c -> let x = $3 c anon_global bind_global @@ at in
      fun () -> $4 c x at }

global_fields :
  | global_type const_expr
    { fun c x at -> [{gtype = $1; value = $2 c} @@ at], [], [] }
  | inline_import global_type
    { fun c x at ->
      [],
      [{ module_name = fst $1; item_name = snd $1;
         idesc = GlobalImport $2 @@ at } @@ at], [] }
  | inline_export global_fields  /* Sugar */
    { fun c x at -> let globs, ims, exs = $2 c x at in
      globs, ims, $1 (GlobalExport x) c :: exs }


/* Imports & Exports */

import_desc :
  | LPAR FUNC bind_var_opt type_use RPAR
    { fun c -> ignore ($3 c anon_func bind_func);
      fun () -> FuncImport ($4 c type_) }
  | LPAR FUNC bind_var_opt func_sig RPAR  /* Sugar */
    { let at4 = ati 4 in
      fun c -> ignore ($3 c anon_func bind_func);
      fun () -> FuncImport (inline_type c $4 at4) }
  | LPAR TABLE bind_var_opt table_sig RPAR
    { fun c -> ignore ($3 c anon_table bind_table);
      fun () -> TableImport $4 }
  | LPAR MEMORY bind_var_opt memory_sig RPAR
    { fun c -> ignore ($3 c anon_memory bind_memory);
      fun () -> MemoryImport $4 }
  | LPAR GLOBAL bind_var_opt global_type RPAR
    { fun c -> ignore ($3 c anon_global bind_global);
      fun () -> GlobalImport $4 }

import :
  | LPAR IMPORT name name import_desc RPAR
    { let at = at () and at5 = ati 5 in
      fun c -> let df = $5 c in
      fun () -> {module_name = $3; item_name = $4; idesc = df () @@ at5} @@ at }

inline_import :
  | LPAR IMPORT name name RPAR { $3, $4 }

export_desc :
  | LPAR FUNC var RPAR { fun c -> FuncExport ($3 c func) }
  | LPAR TABLE var RPAR { fun c -> TableExport ($3 c table) }
  | LPAR MEMORY var RPAR { fun c -> MemoryExport ($3 c memory) }
  | LPAR GLOBAL var RPAR { fun c -> GlobalExport ($3 c global) }

export :
  | LPAR EXPORT name export_desc RPAR
    { let at = at () and at4 = ati 4 in
      fun c -> {name = $3; edesc = $4 c @@ at4} @@ at }

inline_export :
  | LPAR EXPORT name RPAR
    { let at = at () in fun d c -> {name = $3; edesc = d @@ at} @@ at }


/* Modules */

type_ :
  | func_type { $1 @@ at () }

type_def :
  | LPAR TYPE type_ RPAR
    { fun c -> anon_type c $3 }
  | LPAR TYPE bind_var type_ RPAR  /* Sugar */
    { fun c -> bind_type c $3 $4 }

start :
  | LPAR START var RPAR
    { fun c -> $3 c func }

module_fields :
  | /* empty */
    { fun (c : context) () -> {empty_module with types = c.types.list} }
  | module_fields1 { $1 }

module_fields1 :
  | type_def module_fields
    { fun c -> ignore ($1 c); $2 c }
  | global module_fields
    { fun c -> let gf = $1 c in let mf = $2 c in
      fun () -> let globs, ims, exs = gf () in let m = mf () in
      if globs <> [] && m.imports <> [] then
        error (List.hd m.imports).at "import after global definition";
      { m with globals = globs @ m.globals;
        imports = ims @ m.imports; exports = exs @ m.exports } }
  | table module_fields
    { fun c -> let tf = $1 c in let mf = $2 c in
      fun () -> let tabs, elems, ims, exs = tf () in let m = mf () in
      if tabs <> [] && m.imports <> [] then
        error (List.hd m.imports).at "import after table definition";
      { m with tables = tabs @ m.tables; elems = elems @ m.elems;
        imports = ims @ m.imports; exports = exs @ m.exports } }
  | memory module_fields
    { fun c -> let mmf = $1 c in let mf = $2 c in
      fun () -> let mems, data, ims, exs = mmf () in let m = mf () in
      if mems <> [] && m.imports <> [] then
        error (List.hd m.imports).at "import after memory definition";
      { m with memories = mems @ m.memories; data = data @ m.data;
        imports = ims @ m.imports; exports = exs @ m.exports } }
  | func module_fields
    { fun c -> let ff = $1 c in let mf = $2 c in
      fun () -> let funcs, ims, exs = ff () in let m = mf () in
      if funcs <> [] && m.imports <> [] then
        error (List.hd m.imports).at "import after function definition";
      { m with funcs = funcs @ m.funcs;
        imports = ims @ m.imports; exports = exs @ m.exports } }
  | elem module_fields
    { fun c -> let mf = $2 c in
      fun () -> let m = mf () in
      {m with elems = $1 c :: m.elems} }
  | data module_fields
    { fun c -> let mf = $2 c in
      fun () -> let m = mf () in
      {m with data = $1 c :: m.data} }
  | start module_fields
    { fun c -> let mf = $2 c in
      fun () -> let m = mf () in let x = $1 c in
      match m.start with
      | Some _ -> error x.at "multiple start sections"
      | None -> {m with start = Some x} }
  | import module_fields
    { fun c -> let imf = $1 c in let mf = $2 c in
      fun () -> let im = imf () in let m = mf () in
      {m with imports = im :: m.imports} }
  | export module_fields
    { fun c -> let mf = $2 c in
      fun () -> let m = mf () in
      {m with exports = $1 c :: m.exports} }

module_var_opt :
  | /* empty */ { None }
  | VAR { Some ($1 @@ at ()) }  /* Sugar */

module_ :
  | LPAR MODULE module_var_opt module_fields RPAR
    { $3, Textual ($4 (empty_context ()) () @@ at ()) @@ at () }

merkle :
  | LPAR MERKLE module_fields RPAR
    { Textual ($3 (empty_context ()) () @@ at ()) @@ at () }

inline_module :  /* Sugar */
  | module_fields { Textual ($1 (empty_context ()) () @@ at ()) @@ at () }

inline_module1 :  /* Sugar */
  | module_fields1 { Textual ($1 (empty_context ()) () @@ at ()) @@ at () }


/* Scripts */

script_var_opt :
  | /* empty */ { None }
  | VAR { Some ($1 @@ at ()) }  /* Sugar */

script_module :
  | module_ { $1 }
  | LPAR MODULE module_var_opt BIN string_list RPAR
    { $3, Encoded ("binary", $5) @@ at() }
  | LPAR MODULE module_var_opt QUOTE string_list RPAR
    { $3, Quoted ("quote", $5) @@ at() }

action :
  | LPAR INVOKE module_var_opt name const_list RPAR
    { Invoke ($3, $4, $5) @@ at () }
  | LPAR GET module_var_opt name RPAR
    { Get ($3, $4) @@ at() }

assertion :
  | LPAR ASSERT_MALFORMED script_module STRING RPAR
    { AssertMalformed (snd $3, $4) @@ at () }
  | LPAR ASSERT_INVALID script_module STRING RPAR
    { AssertInvalid (snd $3, $4) @@ at () }
  | LPAR ASSERT_UNLINKABLE script_module STRING RPAR
    { AssertUnlinkable (snd $3, $4) @@ at () }
  | LPAR ASSERT_TRAP script_module STRING RPAR
    { AssertUninstantiable (snd $3, $4) @@ at () }
  | LPAR ASSERT_RETURN action const_list RPAR { AssertReturn ($3, $4) @@ at () }
  | LPAR ASSERT_RETURN_CANONICAL_NAN action RPAR { AssertReturnCanonicalNaN $3 @@ at () }
  | LPAR ASSERT_RETURN_ARITHMETIC_NAN action RPAR { AssertReturnArithmeticNaN $3 @@ at () }
  | LPAR ASSERT_TRAP action STRING RPAR { AssertTrap ($3, $4) @@ at () }
  | LPAR ASSERT_EXHAUSTION action STRING RPAR { AssertExhaustion ($3, $4) @@ at () }

cmd :
  | action { Action $1 @@ at () }
  | assertion { Assertion $1 @@ at () }
  | merkle { Merkle $1 @@ at () }
  | script_module { Module (fst $1, snd $1) @@ at () }
  | LPAR REGISTER name module_var_opt RPAR { Register ($3, $4) @@ at () }
  | meta { Meta $1 @@ at () }

cmd_list :
  | /* empty */ { [] }
  | cmd cmd_list { $1 :: $2 }

meta :
  | LPAR SCRIPT script_var_opt cmd_list RPAR { Script ($3, $4) @@ at () }
  | LPAR INPUT script_var_opt STRING RPAR { Input ($3, $4) @@ at () }
  | LPAR OUTPUT script_var_opt STRING RPAR { Output ($3, Some $4) @@ at () }
  | LPAR OUTPUT script_var_opt RPAR { Output ($3, None) @@ at () }

const :
  | LPAR CONST literal RPAR { snd (literal $2 $3) @@ ati 3 }

const_list :
  | /* empty */ { [] }
  | const const_list { $1 :: $2 }

script :
  | cmd_list EOF { $1 }
  | inline_module1 EOF { [Module (None, $1) @@ at ()] }  /* Sugar */

script1 :
  | cmd { [$1] }

module1 :
  | module_ EOF { $1 }
  | inline_module EOF { None, $1 }  /* Sugar */
%%
