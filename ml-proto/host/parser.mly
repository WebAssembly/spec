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

let int s at =
  try int_of_string s with Failure _ -> error at "int constant out of range"

let int32 s at =
  try I32.of_string s with Failure _ -> error at "i32 constant out of range"

let int64 s at =
  try I64.of_string s with Failure _ -> error at "i64 constant out of range"


(* Symbolic variables *)

module VarMap = Map.Make(String)

type space = {mutable map : int32 VarMap.t; mutable count : int32}
let empty () = {map = VarMap.empty; count = 0l}

type types = {mutable tmap : int32 VarMap.t; mutable tlist : Types.func_type list}
let empty_types () = {tmap = VarMap.empty; tlist = []}

type context =
  { types : types; tables : space; memories : space;
    funcs : space; locals : space; globals : space; labels : int32 VarMap.t }

let empty_context () =
  { types = empty_types (); tables = empty (); memories = empty ();
    funcs = empty (); locals = empty (); globals = empty ();
    labels = VarMap.empty }

let enter_func c =
  {c with labels = VarMap.empty; locals = empty ()}

let type_ c x =
  try VarMap.find x.it c.types.tmap
  with Not_found -> error x.at ("unknown type " ^ x.it)

let lookup category space x =
  try VarMap.find x.it space.map
  with Not_found -> error x.at ("unknown " ^ category ^ " " ^ x.it)

let func c x = lookup "function" c.funcs x
let local c x = lookup "local" c.locals x
let global c x = lookup "global" c.globals x
let table c x = lookup "table" c.tables x
let memory c x = lookup "memory" c.memories x
let label c x =
  try VarMap.find x.it c.labels
  with Not_found -> error x.at ("unknown label " ^ x.it)

let bind_module () x = Some x
let anon_module () = None

let bind_type c x ty =
  if VarMap.mem x.it c.types.tmap then
    error x.at ("duplicate type " ^ x.it);
  c.types.tmap <-
    VarMap.add x.it (Lib.List32.length c.types.tlist) c.types.tmap;
  c.types.tlist <- c.types.tlist @ [ty]

let anon_type c ty =
  c.types.tlist <- c.types.tlist @ [ty]

let anon_type c ty =
  c.types.tlist <- c.types.tlist @ [ty]

let bind category space x =
  if VarMap.mem x.it space.map then
    error x.at ("duplicate " ^ category ^ " " ^ x.it);
  space.map <- VarMap.add x.it space.count space.map;
  space.count <- Int32.add space.count 1l;
  if space.count = 0l then 
    error x.at ("too many " ^ category ^ " bindings")

let bind_func c x = bind "function" c.funcs x
let bind_local c x = bind "local" c.locals x
let bind_global c x = bind "global" c.globals x
let bind_table c x = bind "table" c.tables x
let bind_memory c x = bind "memory" c.memories x
let bind_label c x =
  {c with labels = VarMap.add x.it 0l (VarMap.map (Int32.add 1l) c.labels)}

let anon_type c ty =
  c.types.tlist <- c.types.tlist @ [ty]

let anon category space n =
  space.count <- Int32.add space.count n;
  if I32.lt_u space.count n then
    error no_region ("too many " ^ category ^ " bindings")

let anon_func c = anon "function" c.funcs 1l
let anon_locals c ts = anon "local" c.locals (Lib.List32.length ts)
let anon_global c = anon "global" c.globals 1l
let anon_table c = anon "table" c.tables 1l
let anon_memory c = anon "memory" c.memories 1l
let anon_label c = {c with labels = VarMap.map (Int32.add 1l) c.labels}

let empty_type = FuncType ([], [])

let explicit_sig c var t at =
  let x = var c type_ in
  if
    x.it < Lib.List32.length c.types.tlist &&
    t <> empty_type &&
    t <> Lib.List32.nth c.types.tlist x.it
  then
    error at "signature mismatch";
  x

let inline_type c t at =
  match Lib.List.index_of t c.types.tlist with
  | None -> let i = Lib.List32.length c.types.tlist in anon_type c t; i @@ at
  | Some i -> Int32.of_int i @@ at

%}

%token NAT INT FLOAT TEXT VAR VALUE_TYPE ANYFUNC MUT LPAR RPAR
%token NOP DROP BLOCK END IF THEN ELSE SELECT LOOP BR BR_IF BR_TABLE
%token CALL CALL_INDIRECT RETURN
%token GET_LOCAL SET_LOCAL TEE_LOCAL GET_GLOBAL SET_GLOBAL
%token LOAD STORE OFFSET_EQ_NAT ALIGN_EQ_NAT
%token CONST UNARY BINARY COMPARE CONVERT
%token UNREACHABLE CURRENT_MEMORY GROW_MEMORY
%token FUNC START TYPE PARAM RESULT LOCAL GLOBAL
%token MODULE TABLE ELEM MEMORY DATA OFFSET IMPORT EXPORT TABLE
%token SCRIPT REGISTER INVOKE GET
%token ASSERT_INVALID ASSERT_UNLINKABLE
%token ASSERT_RETURN ASSERT_RETURN_NAN ASSERT_TRAP
%token INPUT OUTPUT
%token EOF

%token<string> NAT
%token<string> INT
%token<string> FLOAT
%token<string> TEXT
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
%token<Memory.offset> OFFSET_EQ_NAT
%token<int> ALIGN_EQ_NAT

%nonassoc LOW
%nonassoc VAR

%start script script1 module1
%type<Script.script> script
%type<Script.script> script1
%type<Script.definition> module1

%%

/* Auxiliaries */

text_list :
  | /* empty */ { "" }
  | text_list TEXT { $1 ^ $2 }
;

/* Types */

value_type_list :
  | /* empty */ { [] }
  | VALUE_TYPE value_type_list { $1 :: $2 }
;

elem_type :
  | ANYFUNC { AnyFuncType }
;

global_type :
  | VALUE_TYPE { GlobalType ($1, Immutable) }
  | LPAR MUT VALUE_TYPE RPAR { GlobalType ($3, Mutable) }
;

func_type :
  | LPAR FUNC func_sig RPAR { $3 }
;

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
;

table_sig :
  | limits elem_type { TableType ($1, $2) }
;
memory_sig :
  | limits { MemoryType $1 }
;
limits :
  | NAT { {min = int32 $1 (ati 1); max = None} }
  | NAT NAT { {min = int32 $1 (ati 1); max = Some (int32 $2 (ati 2))} }
;

type_use :
  | LPAR TYPE var RPAR { $3 }
;


/* Expressions */

nat :
  | NAT { int_of_string $1 }
;

literal :
  | NAT { $1 @@ at () }
  | INT { $1 @@ at () }
  | FLOAT { $1 @@ at () }
;

var :
  | NAT { let at = at () in fun c lookup -> int32 $1 at @@ at }
  | VAR { let at = at () in fun c lookup -> lookup c ($1 @@ at) @@ at }
;
var_list :
  | /* empty */ { fun c lookup -> [] }
  | var var_list { fun c lookup -> $1 c lookup :: $2 c lookup }
;

bind_var_opt :
  | /* empty */ { fun c anon bind -> anon c }
  | bind_var { fun c anon bind -> bind c $1 }  /* Sugar */
;
bind_var :
  | VAR { $1 @@ at () }
;

labeling_opt :
  | /* empty */ %prec LOW { fun c -> anon_label c }
  | bind_var { fun c -> bind_label c $1 }
;

offset_opt :
  | /* empty */ { 0L }
  | OFFSET_EQ_NAT { $1 }
;
align_opt :
  | /* empty */ { None }
  | ALIGN_EQ_NAT { Some $1 }
;

instr :
  | plain_instr { let at = at () in fun c -> [$1 c @@ at] }
  | ctrl_instr { let at = at () in fun c -> [$1 c @@ at] }
  | expr { $1 } /* Sugar */
;
plain_instr :
  | UNREACHABLE { fun c -> unreachable }
  | NOP { fun c -> nop }
  | DROP { fun c -> drop }
  | SELECT { fun c -> select }
  | BR nat var { fun c -> br $2 ($3 c label) }
  | BR_IF nat var { fun c -> br_if $2 ($3 c label) }
  | BR_TABLE var /*nat*/ var var_list
    { fun c -> let xs, x = Lib.List.split_last ($3 c label :: $4 c label) in
      (* TODO: remove hack once arities are gone *)
      let n = $2 c (fun _ -> error x.at "syntax error") in
      br_table (Int32.to_int n.it) xs x }
  | RETURN { fun c -> return }
  | CALL var { fun c -> call ($2 c func) }
  | CALL_INDIRECT var { fun c -> call_indirect ($2 c type_) }
  | GET_LOCAL var { fun c -> get_local ($2 c local) }
  | SET_LOCAL var { fun c -> set_local ($2 c local) }
  | TEE_LOCAL var { fun c -> tee_local ($2 c local) }
  | GET_GLOBAL var { fun c -> get_global ($2 c global) }
  | SET_GLOBAL var { fun c -> set_global ($2 c global) }
  | LOAD offset_opt align_opt { fun c -> $1 $3 $2 }
  | STORE offset_opt align_opt { fun c -> $1 $3 $2 }
  | CONST literal { fun c -> fst (literal $1 $2) }
  | UNARY { fun c -> $1 }
  | BINARY { fun c -> $1 }
  | TEST { fun c -> $1 }
  | COMPARE { fun c -> $1 }
  | CONVERT { fun c -> $1 }
  | CURRENT_MEMORY { fun c -> current_memory }
  | GROW_MEMORY { fun c -> grow_memory }
;
ctrl_instr :
  | BLOCK labeling_opt instr_list END
    { fun c -> let c' = $2 c in block ($3 c') }
  | LOOP labeling_opt instr_list END
    { fun c -> let c' = $2 c in loop ($3 c') }
  | IF labeling_opt instr_list END
    { fun c -> let c' = $2 c in if_ ($3 c') [] }
  | IF labeling_opt instr_list ELSE labeling_opt instr_list END
    { fun c -> let c1 = $2 c in let c2 = $5 c in if_ ($3 c1) ($6 c2) }
;

expr :  /* Sugar */
  | LPAR expr1 RPAR
    { let at = at () in fun c -> let es, e' = $2 c in es @ [e' @@ at] }
;
expr1 :  /* Sugar */
  | plain_instr expr_list { fun c -> snd ($2 c), $1 c }
  /* TODO: remove special-casing of branches here once arities are gone */
  | BR var expr_list { fun c -> let n, es = $3 c in es, br n ($2 c label) }
  | BR_IF var expr expr_list
    { fun c ->
      let es1 = $3 c and n, es2 = $4 c in es1 @ es2, br_if n ($2 c label) }
  | BR_TABLE var var_list expr expr_list
    { fun c -> let xs, x = Lib.List.split_last ($2 c label :: $3 c label) in
      let es1 = $4 c and n, es2 = $5 c in es1 @ es2, br_table n xs x }
  | BLOCK labeling_opt instr_list
    { fun c -> let c' = $2 c in [], block ($3 c') }
  | LOOP labeling_opt instr_list
    { fun c -> let c' = $2 c in [], loop ($3 c') }
  | IF expr expr { fun c -> let c' = anon_label c in $2 c, if_ ($3 c') [] }
  | IF expr expr expr
    { fun c -> let c' = anon_label c in $2 c, if_ ($3 c') ($4 c') }
  | IF expr LPAR THEN labeling_opt instr_list RPAR
    { fun c -> let c' = $5 c in $2 c, if_ ($6 c') [] }
  | IF expr LPAR THEN labeling_opt instr_list RPAR LPAR
    ELSE labeling_opt instr_list RPAR
    { fun c -> let c1 = $5 c in let c2 = $10 c in $2 c, if_ ($6 c1) ($11 c2) }
  | IF LPAR THEN labeling_opt instr_list RPAR
    { fun c -> let c' = $4 c in [], if_ ($5 c') [] }
  | IF LPAR THEN labeling_opt instr_list RPAR
       LPAR ELSE labeling_opt instr_list RPAR
    { fun c -> let c1 = $4 c in let c2 = $9 c in [], if_ ($5 c1) ($10 c2) }
;

instr_list :
  | /* empty */ { fun c -> [] }
  | instr instr_list { fun c -> $1 c @ $2 c }
;
expr_list :
  | /* empty */ { fun c -> 0, [] }
  | expr expr_list
    { fun c -> let es1 = $1 c and n, es2 = $2 c in n + 1, es1 @ es2 }
;

const_expr :
  | instr_list { let at = at () in fun c -> $1 c @@ at }
;


/* Functions */

func_fields :
  | func_body { $1 }
  | LPAR RESULT value_type_list RPAR func_body
    { let FuncType (ins, out) = fst $5 in
      FuncType (ins, $3 @ out), fun c -> snd $5 c }
  | LPAR PARAM value_type_list RPAR func_fields
    { let FuncType (ins, out) = fst $5 in
      FuncType ($3 @ ins, out), fun c -> anon_locals c $3; (snd $5) c }
  | LPAR PARAM bind_var VALUE_TYPE RPAR func_fields  /* Sugar */
    { let FuncType (ins, out) = fst $6 in
      FuncType ($4 :: ins, out), fun c -> bind_local c $3; (snd $6) c }
;
func_body :
  | instr_list
    { empty_type,
      fun c -> let c' = anon_label c in
      {ftype = -1l @@ at(); locals = []; body = $1 c'} }
  | LPAR LOCAL value_type_list RPAR func_body
    { fst $5,
      fun c -> anon_locals c $3; let f = (snd $5) c in
        {f with locals = $3 @ f.locals} }
  | LPAR LOCAL bind_var VALUE_TYPE RPAR func_body  /* Sugar */
    { fst $6,
      fun c -> bind_local c $3; let f = (snd $6) c in
        {f with locals = $4 :: f.locals} }
;
func :
  | LPAR FUNC bind_var_opt inline_export type_use func_fields RPAR
    { let at = at () in
      fun c -> $3 c anon_func bind_func;
      let t = explicit_sig c $5 (fst $6) at in
      (fun () -> {(snd $6 (enter_func c)) with ftype = t} @@ at),
      $4 FuncExport c.funcs.count c }
  /* Duplicate above for empty inline_export_opt to avoid LR(1) conflict. */
  | LPAR FUNC bind_var_opt type_use func_fields RPAR
    { let at = at () in
      fun c -> $3 c anon_func bind_func;
      let t = explicit_sig c $4 (fst $5) at in
      (fun () -> {(snd $5 (enter_func c)) with ftype = t} @@ at),
      [] }
  | LPAR FUNC bind_var_opt inline_export func_fields RPAR  /* Sugar */
    { let at = at () in
      fun c -> $3 c anon_func bind_func;
      let t = inline_type c (fst $5) at in
      (fun () -> {(snd $5 (enter_func c)) with ftype = t} @@ at),
      $4 FuncExport c.funcs.count c }
  /* Duplicate above for empty inline_export_opt to avoid LR(1) conflict. */
  | LPAR FUNC bind_var_opt func_fields RPAR  /* Sugar */
    { let at = at () in
      fun c -> $3 c anon_func bind_func;
      let t = inline_type c (fst $4) at in
      (fun () -> {(snd $4 (enter_func c)) with ftype = t} @@ at),
      [] }
;


/* Tables, Memories & Globals */

offset :
  | LPAR OFFSET const_expr RPAR { $3 }
  | expr { let at = at () in fun c -> $1 c @@ at }  /* Sugar */
;

elem :
  | LPAR ELEM var offset var_list RPAR
    { let at = at () in
      fun c -> {index = $3 c table; offset = $4 c; init = $5 c func} @@ at }
  | LPAR ELEM offset var_list RPAR  /* Sugar */
    { let at = at () in
      fun c -> {index = 0l @@ at; offset = $3 c; init = $4 c func} @@ at }
;

table :
  | LPAR TABLE bind_var_opt inline_export_opt table_sig RPAR
    { let at = at () in
      fun c -> $3 c anon_table bind_table;
      {ttype = $5} @@ at, [], $4 TableExport c.tables.count c }
  | LPAR TABLE bind_var_opt inline_export_opt elem_type
      LPAR ELEM var_list RPAR RPAR  /* Sugar */
    { let at = at () in
      fun c -> let i = c.tables.count in $3 c anon_table bind_table;
      let init = $8 c func in let size = Int32.of_int (List.length init) in
      {ttype = TableType ({min = size; max = Some size}, $5)} @@ at,
      [{index = i @@ at;
        offset = [i32_const (0l @@ at) @@ at] @@ at; init} @@ at],
      $4 TableExport c.tables.count c }
;

data :
  | LPAR DATA var offset text_list RPAR
    { let at = at () in
      fun c -> {index = $3 c memory; offset = $4 c; init = $5} @@ at }
  | LPAR DATA offset text_list RPAR  /* Sugar */
    { let at = at () in
      fun c -> {index = 0l @@ at; offset = $3 c; init = $4} @@ at }
;

memory :
  | LPAR MEMORY bind_var_opt inline_export_opt memory_sig RPAR
    { let at = at () in
      fun c -> $3 c anon_memory bind_memory;
      {mtype = $5} @@ at, [], $4 MemoryExport c.memories.count c }
  | LPAR MEMORY bind_var_opt inline_export LPAR DATA text_list RPAR RPAR
      /* Sugar */
    { let at = at () in
      fun c -> let i = c.memories.count in $3 c anon_memory bind_memory;
      let size = Int32.(div (add (of_int (String.length $7)) 65535l) 65536l) in
      {mtype = MemoryType {min = size; max = Some size}} @@ at,
      [{index = i @@ at;
        offset = [i32_const (0l @@ at) @@ at] @@ at; init = $7} @@ at],
      $4 MemoryExport c.memories.count c }
  /* Duplicate above for empty inline_export_opt to avoid LR(1) conflict. */
  | LPAR MEMORY bind_var_opt LPAR DATA text_list RPAR RPAR  /* Sugar */
    { let at = at () in
      fun c -> let i = c.memories.count in $3 c anon_memory bind_memory;
      let size = Int32.(div (add (of_int (String.length $6)) 65535l) 65536l) in
      {mtype = MemoryType {min = size; max = Some size}} @@ at,
      [{index = i @@ at;
        offset = [i32_const (0l @@ at) @@ at] @@ at; init = $6} @@ at],
      [] }
;

global :
  | LPAR GLOBAL bind_var_opt inline_export global_type const_expr RPAR
    { let at = at () in
      fun c -> $3 c anon_global bind_global;
      (fun () -> {gtype = $5; value = $6 c} @@ at),
      $4 GlobalExport c.globals.count c }
  /* Duplicate above for empty inline_export_opt to avoid LR(1) conflict. */
  | LPAR GLOBAL bind_var_opt global_type const_expr RPAR
    { let at = at () in
      fun c -> $3 c anon_global bind_global;
      (fun () -> {gtype = $4; value = $5 c} @@ at), [] }
;


/* Imports & Exports */

import_kind :
  | LPAR FUNC bind_var_opt type_use RPAR
    { fun c -> $3 c anon_func bind_func; FuncImport ($4 c type_) }
  | LPAR FUNC bind_var_opt func_sig RPAR  /* Sugar */
    { let at4 = ati 4 in
      fun c -> $3 c anon_func bind_func; FuncImport (inline_type c $4 at4) }
  | LPAR TABLE bind_var_opt table_sig RPAR
    { fun c -> $3 c anon_table bind_table; TableImport $4 }
  | LPAR MEMORY bind_var_opt memory_sig RPAR
    { fun c -> $3 c anon_memory bind_memory; MemoryImport $4 }
  | LPAR GLOBAL bind_var_opt global_type RPAR
    { fun c -> $3 c anon_global bind_global; GlobalImport $4 }
;
import :
  | LPAR IMPORT TEXT TEXT import_kind RPAR
    { let at = at () and at5 = ati 5 in
      fun c -> {module_name = $3; item_name = $4; ikind = $5 c @@ at5} @@ at }
  | LPAR FUNC bind_var_opt inline_import type_use RPAR  /* Sugar */
    { let at = at () in
      fun c -> $3 c anon_func bind_func;
      {module_name = fst $4; item_name = snd $4; ikind = FuncImport ($5 c type_) @@ at} @@ at }
  | LPAR FUNC bind_var_opt inline_import func_sig RPAR  /* Sugar */
    { let at = at () and at5 = ati 5 in
      fun c -> $3 c anon_func bind_func;
      {module_name = fst $4; item_name = snd $4; ikind = FuncImport (inline_type c $5 at5) @@ at} @@ at }
  | LPAR TABLE bind_var_opt inline_import table_sig RPAR  /* Sugar */
    { let at = at () in
      fun c -> $3 c anon_table bind_table;
      {module_name = fst $4; item_name = snd $4; ikind = TableImport $5 @@ at} @@ at }
  | LPAR MEMORY bind_var_opt inline_import memory_sig RPAR  /* Sugar */
    { let at = at () in
      fun c -> $3 c anon_memory bind_memory;
      {module_name = fst $4; item_name = snd $4; ikind = MemoryImport $5 @@ at} @@ at }
  | LPAR GLOBAL bind_var_opt inline_import global_type RPAR  /* Sugar */
    { let at = at () in
      fun c -> $3 c anon_global bind_global;
      {module_name = fst $4; item_name = snd $4; ikind = GlobalImport $5 @@ at} @@ at }
;

inline_import :
  | LPAR IMPORT TEXT TEXT RPAR { $3, $4 }
;

export_kind :
  | LPAR FUNC var RPAR { fun c -> FuncExport, $3 c func }
  | LPAR TABLE var RPAR { fun c -> TableExport, $3 c table }
  | LPAR MEMORY var RPAR { fun c -> MemoryExport, $3 c memory }
  | LPAR GLOBAL var RPAR { fun c -> GlobalExport, $3 c global }
;
export :
  | LPAR EXPORT TEXT export_kind RPAR
    { let at = at () and at4 = ati 4 in
      fun c -> let k, x = $4 c in
      {name = $3; ekind = k @@ at4; item = x} @@ at }
;

inline_export_opt :
  | /* empty */ { fun k count c -> [] }
  | inline_export { $1 }
;
inline_export :
  | LPAR EXPORT TEXT RPAR
    { let at = at () in
      fun k count c ->
      [{name = $3; ekind = k @@ at; item = Int32.sub count 1l @@ at} @@ at] }
;


/* Modules */

type_def :
  | LPAR TYPE func_type RPAR
    { fun c -> anon_type c $3 }
  | LPAR TYPE bind_var func_type RPAR  /* Sugar */
    { fun c -> bind_type c $3 $4 }
;

start :
  | LPAR START var RPAR
    { fun c -> $3 c func }
;

module_fields :
  | /* empty */
    { fun c ->
      {
        types = c.types.tlist;
        globals = [];
        tables = [];
        memories = [];
        funcs = [];
        elems = [];
        data = [];
        start = None;
        imports = [];
        exports = []
      } }
  | type_def module_fields
    { fun c -> $1 c; $2 c }
  | global module_fields
    { fun c -> let g, exs = $1 c in let m = $2 c in
      if m.imports <> [] then
        error (List.hd m.imports).at "import after global definition";
      {m with globals = g () :: m.globals; exports = exs @ m.exports} }
  | table module_fields
    { fun c -> let m = $2 c in let tab, elems, exs = $1 c in
      if m.imports <> [] then
        error (List.hd m.imports).at "import after table definition";
      {m with tables = tab :: m.tables; elems = elems @ m.elems; exports = exs @ m.exports} }
  | memory module_fields
    { fun c -> let m = $2 c in let mem, data, exs = $1 c in
      if m.imports <> [] then
        error (List.hd m.imports).at "import after memory definition";
      {m with memories = mem :: m.memories; data = data @ m.data; exports = exs @ m.exports} }
  | func module_fields
    { fun c -> let f, exs = $1 c in let m = $2 c in let func = f () in
      if m.imports <> [] then
        error (List.hd m.imports).at "import after function definition";
      {m with funcs = func :: m.funcs; exports = exs @ m.exports} }
  | elem module_fields
    { fun c -> let m = $2 c in
      {m with elems = $1 c :: m.elems} }
  | data module_fields
    { fun c -> let m = $2 c in
      {m with data = $1 c :: m.data} }
  | start module_fields
    { fun c -> let m = $2 c in let x = $1 c in
      match m.start with
      | Some _ -> error x.at "multiple start sections"
      | None -> {m with start = Some x} }
  | import module_fields
    { fun c -> let i = $1 c in let m = $2 c in
      {m with imports = i :: m.imports} }
  | export module_fields
    { fun c -> let m = $2 c in
      {m with exports = $1 c :: m.exports} }
;
module_ :
  | LPAR MODULE script_var_opt module_fields RPAR
    { $3, Textual ($4 (empty_context ()) @@ at ()) @@ at () }
  | LPAR MODULE script_var_opt TEXT text_list RPAR
    { $3, Binary ($4 ^ $5) @@ at() }
;


/* Scripts */

script_var_opt :
  | /* empty */ { None }
  | VAR { Some ($1 @@ at ()) }  /* Sugar */
;

action :
  | LPAR INVOKE script_var_opt TEXT const_list RPAR
    { Invoke ($3, $4, $5) @@ at () }
  | LPAR GET script_var_opt TEXT RPAR
    { Get ($3, $4) @@ at() }
;
assertion :
  | LPAR ASSERT_INVALID module_ TEXT RPAR
    { AssertInvalid (snd $3, $4) @@ at () }
  | LPAR ASSERT_UNLINKABLE module_ TEXT RPAR
    { AssertUnlinkable (snd $3, $4) @@ at () }
  | LPAR ASSERT_RETURN action const_list RPAR { AssertReturn ($3, $4) @@ at () }
  | LPAR ASSERT_RETURN_NAN action RPAR { AssertReturnNaN $3 @@ at () }
  | LPAR ASSERT_TRAP action TEXT RPAR { AssertTrap ($3, $4) @@ at () }
;

cmd :
  | action { Action $1 @@ at () }
  | assertion { Assertion $1 @@ at () }
  | module_ { Module (fst $1, snd $1) @@ at () }
  | LPAR REGISTER TEXT script_var_opt RPAR { Register ($3, $4) @@ at () }
  | meta { Meta $1 @@ at () }
;
cmd_list :
  | /* empty */ { [] }
  | cmd cmd_list { $1 :: $2 }
;

meta :
  | LPAR SCRIPT script_var_opt cmd_list RPAR { Script ($3, $4) @@ at () }
  | LPAR INPUT script_var_opt TEXT RPAR { Input ($3, $4) @@ at () }
  | LPAR OUTPUT script_var_opt TEXT RPAR { Output ($3, Some $4) @@ at () }
  | LPAR OUTPUT script_var_opt RPAR { Output ($3, None) @@ at () }
;

const :
  | LPAR CONST literal RPAR { snd (literal $2 $3) @@ ati 3 }
;
const_list :
  | /* empty */ { [] }
  | const const_list { $1 :: $2 }
;

script :
  | cmd_list EOF { $1 }
;
script1 :
  | cmd { [$1] }
;
module1 :
  | module_ EOF { snd $1 }
;
%%
