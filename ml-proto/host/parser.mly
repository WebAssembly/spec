%{
open Source
open Types
open Kernel
open Ast
open Script


(* Error handling *)

let error at msg = raise (Script.Syntax (at, msg))

let parse_error msg = error Source.no_region msg


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

type space = {mutable map : int VarMap.t; mutable count : int}
let empty () = {map = VarMap.empty; count = 0}

type types = {mutable tmap : int VarMap.t; mutable tlist : Types.func_type list}
let empty_types () = {tmap = VarMap.empty; tlist = []}

type context =
  { types : types; tables : space; memories : space;
    funcs : space; locals : space; globals : space; labels : int VarMap.t }

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
  c.types.tmap <- VarMap.add x.it (List.length c.types.tlist) c.types.tmap;
  c.types.tlist <- c.types.tlist @ [ty]

let anon_type c ty =
  c.types.tlist <- c.types.tlist @ [ty]

let bind category space x =
  if VarMap.mem x.it space.map then
    error x.at ("duplicate " ^ category ^ " " ^ x.it);
  space.map <- VarMap.add x.it space.count space.map;
  space.count <- space.count + 1

let bind_func c x = bind "function" c.funcs x
let bind_local c x = bind "local" c.locals x
let bind_global c x = bind "global" c.globals x
let bind_table c x = bind "table" c.tables x
let bind_memory c x = bind "memory" c.memories x
let bind_label c x =
  {c with labels = VarMap.add x.it 0 (VarMap.map ((+) 1) c.labels)}

let anon space n = space.count <- space.count + n

let anon_func c = anon c.funcs 1
let anon_locals c ts = anon c.locals (List.length ts)
let anon_global c = anon c.globals 1
let anon_table c = anon c.tables 1
let anon_memory c = anon c.memories 1
let anon_label c = {c with labels = VarMap.map ((+) 1) c.labels}

let empty_type = {ins = []; out = None}

let explicit_sig c var t at =
  let x = var c type_ in
  if
    x.it < List.length c.types.tlist &&
    t <> empty_type &&
    t <> List.nth c.types.tlist x.it
  then
    error at "signature mismatch";
  x

let inline_type c t at =
  match Lib.List.index_of t c.types.tlist with
  | None -> let i = List.length c.types.tlist in anon_type c t; i @@ at
  | Some i -> i @@ at

%}

%token NAT INT FLOAT TEXT VAR VALUE_TYPE ANYFUNC MUT LPAR RPAR
%token NOP DROP BLOCK IF THEN ELSE SELECT LOOP BR BR_IF BR_TABLE
%token CALL CALL_INDIRECT RETURN
%token GET_LOCAL SET_LOCAL TEE_LOCAL GET_GLOBAL SET_GLOBAL
%token LOAD STORE OFFSET ALIGN
%token CONST UNARY BINARY COMPARE CONVERT
%token UNREACHABLE CURRENT_MEMORY GROW_MEMORY
%token FUNC START TYPE PARAM RESULT LOCAL GLOBAL
%token MODULE TABLE ELEM MEMORY DATA IMPORT EXPORT TABLE
%token REGISTER INVOKE GET
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
%token<string Source.phrase -> Ast.expr' * Values.value> CONST
%token<Ast.expr -> Ast.expr'> UNARY
%token<Ast.expr * Ast.expr -> Ast.expr'> BINARY
%token<Ast.expr -> Ast.expr'> TEST
%token<Ast.expr * Ast.expr -> Ast.expr'> COMPARE
%token<Ast.expr -> Ast.expr'> CONVERT
%token<Memory.offset * int option * Ast.expr -> Ast.expr'> LOAD
%token<Memory.offset * int option * Ast.expr * Ast.expr -> Ast.expr'> STORE
%token<Memory.offset> OFFSET
%token<int> ALIGN

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
  | /* empty */ { {ins = []; out = None} }
  | LPAR RESULT VALUE_TYPE RPAR func_sig
    { if $5.out <> None then error (at ()) "multiple return types";
      {$5 with out = Some $3} }
  | LPAR PARAM value_type_list RPAR func_sig
    { {$5 with ins = $3 @ $5.ins} }
  | LPAR PARAM bind_var VALUE_TYPE RPAR func_sig  /* Sugar */
    { {$6 with ins = $4 :: $6.ins} }
;

table_sig :
  | limits elem_type { TableType ($1, $2) }
;
memory_sig :
  | limits { MemoryType $1 }
;
limits :
  | NAT { {min = int32 $1 (ati 1); max = None} }
  | NAT NAT
    { {min = int32 $1 (ati 1); max = Some (int32 $2 (ati 2))} }
;

type_use :
  | LPAR TYPE var RPAR { $3 }
;


/* Expressions */

literal :
  | NAT { $1 @@ at () }
  | INT { $1 @@ at () }
  | FLOAT { $1 @@ at () }
;

var :
  | NAT { let at = at () in fun c lookup -> int $1 at @@ at }
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
  | labeling { $1 }
;
labeling :
  | bind_var { fun c -> bind_label c $1 }
;

offset :
  | /* empty */ { 0L }
  | OFFSET { $1 }
;
align :
  | /* empty */ { None }
  | ALIGN { Some $1 }
;

expr :
  | LPAR expr1 RPAR { let at = at () in fun c -> $2 c @@ at }
;
expr1 :
  | NOP { fun c -> Nop }
  | UNREACHABLE { fun c -> Unreachable }
  | DROP expr { fun c -> Drop ($2 c) }
  | BLOCK labeling_opt expr_list { fun c -> let c' = $2 c in Block ($3 c') }
  | LOOP labeling_opt expr_list
    { fun c -> let c' = anon_label c in let c'' = $2 c' in Loop ($3 c'') }
  | LOOP labeling labeling expr_list
    { fun c -> let c' = $2 c in let c'' = $3 c' in Loop ($4 c'') }
  | BR var expr_opt { fun c -> Br ($2 c label, $3 c) }
  | BR_IF var expr { fun c -> Br_if ($2 c label, None, $3 c) }
  | BR_IF var expr expr { fun c -> Br_if ($2 c label, Some ($3 c), $4 c) }
  | BR_TABLE var var_list expr
    { fun c -> let xs, x = Lib.List.split_last ($2 c label :: $3 c label) in
      Br_table (xs, x, None, $4 c) }
  | BR_TABLE var var_list expr expr
    { fun c -> let xs, x = Lib.List.split_last ($2 c label :: $3 c label) in
      Br_table (xs, x, Some ($4 c), $5 c) }
  | RETURN expr_opt { fun c -> Return ($2 c) }
  | IF expr expr { fun c -> let c' = anon_label c in If ($2 c, [$3 c'], []) }
  | IF expr expr expr
    { fun c -> let c' = anon_label c in If ($2 c, [$3 c'], [$4 c']) }
  | IF expr LPAR THEN labeling_opt expr_list RPAR
    { fun c -> let c' = $5 c in If ($2 c, $6 c', []) }
  | IF expr LPAR THEN labeling_opt expr_list RPAR LPAR ELSE labeling_opt expr_list RPAR
    { fun c -> let c1 = $5 c in let c2 = $10 c in If ($2 c, $6 c1, $11 c2) }
  | SELECT expr expr expr { fun c -> Select ($2 c, $3 c, $4 c) }
  | CALL var expr_list { fun c -> Call ($2 c func, $3 c) }
  | CALL_INDIRECT var expr expr_list
    { fun c -> Call_indirect ($2 c type_, $3 c, $4 c) }
  | GET_LOCAL var { fun c -> Get_local ($2 c local) }
  | SET_LOCAL var expr { fun c -> Set_local ($2 c local, $3 c) }
  | TEE_LOCAL var expr { fun c -> Tee_local ($2 c local, $3 c) }
  | GET_GLOBAL var { fun c -> Get_global ($2 c global) }
  | SET_GLOBAL var expr { fun c -> Set_global ($2 c global, $3 c) }
  | LOAD offset align expr { fun c -> $1 ($2, $3, $4 c) }
  | STORE offset align expr expr { fun c -> $1 ($2, $3, $4 c, $5 c) }
  | CONST literal { fun c -> fst (literal $1 $2) }
  | UNARY expr { fun c -> $1 ($2 c) }
  | BINARY expr expr { fun c -> $1 ($2 c, $3 c) }
  | TEST expr { fun c -> $1 ($2 c) }
  | COMPARE expr expr { fun c -> $1 ($2 c, $3 c) }
  | CONVERT expr { fun c -> $1 ($2 c) }
  | CURRENT_MEMORY { fun c -> Current_memory }
  | GROW_MEMORY expr { fun c -> Grow_memory ($2 c) }
;
expr_opt :
  | /* empty */ { fun c -> None }
  | expr { fun c -> Some ($1 c) }
;
expr_list :
  | /* empty */ { fun c -> [] }
  | expr expr_list { fun c -> $1 c :: $2 c }
;


/* Functions */

func_fields :
  | func_body { $1 }
  | LPAR RESULT VALUE_TYPE RPAR func_body
    { if (fst $5).out <> None then error (at ()) "multiple return types";
      {(fst $5) with out = Some $3},
      fun c -> (snd $5) c }
  | LPAR PARAM value_type_list RPAR func_fields
    { {(fst $5) with ins = $3 @ (fst $5).ins},
      fun c -> anon_locals c $3; (snd $5) c }
  | LPAR PARAM bind_var VALUE_TYPE RPAR func_fields  /* Sugar */
    { {(fst $6) with ins = $4 :: (fst $6).ins},
      fun c -> bind_local c $3; (snd $6) c }
;
func_body :
  | expr_list
    { empty_type,
      fun c -> let c' = anon_label c in
      {ftype = -1 @@ at(); locals = []; body = $1 c'} }
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
  /* Need to duplicate above for empty inline_export_opt to avoid LR(1) conflict. */
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
  /* Need to duplicate above for empty inline_export_opt to avoid LR(1) conflict. */
  | LPAR FUNC bind_var_opt func_fields RPAR  /* Sugar */
    { let at = at () in
      fun c -> $3 c anon_func bind_func;
      let t = inline_type c (fst $4) at in
      (fun () -> {(snd $4 (enter_func c)) with ftype = t} @@ at),
      [] }
;


/* Tables, Memories & Globals */

elem :
  | LPAR ELEM var expr var_list RPAR
    { let at = at () in
      fun c -> {index = $3 c table; offset = $4 c; init = $5 c func} @@ at }
  | LPAR ELEM expr var_list RPAR  /* Sugar */
    { let at = at () in
      fun c -> {index = 0 @@ at; offset = $3 c; init = $4 c func} @@ at }
;

table :
  | LPAR TABLE bind_var_opt inline_export_opt table_sig RPAR
    { let at = at () in
      fun c -> $3 c anon_table bind_table;
      {ttype = $5} @@ at, [], $4 TableExport c.tables.count c }
  | LPAR TABLE bind_var_opt inline_export_opt elem_type LPAR ELEM var_list RPAR RPAR  /* Sugar */
    { let at = at () in
      fun c -> $3 c anon_table bind_table;
      let init = $8 c func in let size = Int32.of_int (List.length init) in
      {ttype = TableType ({min = size; max = Some size}, $5)} @@ at,
      [{index = c.tables.count - 1 @@ at; offset = I32_const (0l @@ at) @@ at; init} @@ at],
      $4 TableExport c.tables.count c }
;

data :
  | LPAR DATA var expr text_list RPAR
    { let at = at () in
      fun c -> {index = $3 c memory; offset = $4 c; init = $5} @@ at }
  | LPAR DATA expr text_list RPAR  /* Sugar */
    { let at = at () in
      fun c -> {index = 0 @@ at; offset = $3 c; init = $4} @@ at }
;

memory :
  | LPAR MEMORY bind_var_opt inline_export_opt memory_sig RPAR
    { let at = at () in
      fun c -> $3 c anon_memory bind_memory;
      {mtype = $5} @@ at, [], $4 MemoryExport c.memories.count c }
  | LPAR MEMORY bind_var_opt inline_export LPAR DATA text_list RPAR RPAR  /* Sugar */
    { let at = at () in
      fun c -> $3 c anon_memory bind_memory;
      let size = Int32.(div (add (of_int (String.length $7)) 65535l) 65536l) in
      {mtype = MemoryType {min = size; max = Some size}} @@ at,
      [{index = c.memories.count - 1 @@ at; offset = I32_const (0l @@ at) @@ at; init = $7} @@ at],
      $4 MemoryExport c.memories.count c }
  /* Need to duplicate above for empty inline_export_opt to avoid LR(1) conflict. */
  | LPAR MEMORY bind_var_opt LPAR DATA text_list RPAR RPAR  /* Sugar */
    { let at = at () in
      fun c -> $3 c anon_memory bind_memory;
      let size = Int32.(div (add (of_int (String.length $6)) 65535l) 65536l) in
      {mtype = MemoryType {min = size; max = Some size}} @@ at,
      [{index = c.memories.count - 1 @@ at; offset = I32_const (0l @@ at) @@ at; init = $6} @@ at],
      [] }
;

global :
  | LPAR GLOBAL bind_var_opt inline_export global_type expr RPAR
    { let at = at () in
      fun c -> $3 c anon_global bind_global;
      (fun () -> {gtype = $5; value = $6 c} @@ at),
      $4 GlobalExport c.globals.count c }
  /* Need to duplicate above for empty inline_export_opt to avoid LR(1) conflict. */
  | LPAR GLOBAL bind_var_opt global_type expr RPAR
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
      fun k count c -> [{name = $3; ekind = k @@ at; item = count - 1 @@ at} @@ at] }
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
  | LPAR MODULE module_var_opt module_fields RPAR
    { $3, Textual ($4 (empty_context ()) @@ at ()) @@ at () }
  | LPAR MODULE module_var_opt TEXT text_list RPAR
    { $3, Binary ($4 ^ $5) @@ at() }
;


/* Scripts */

module_var_opt :
  | /* empty */ { None }
  | VAR { Some ($1 @@ at ()) }  /* Sugar */
;
action :
  | LPAR INVOKE module_var_opt TEXT const_list RPAR
    { Invoke ($3, $4, $5) @@ at () }
  | LPAR GET module_var_opt TEXT RPAR
    { Get ($3, $4) @@ at() }
;
cmd :
  | module_ { Define (fst $1, snd $1) @@ at () }
  | action { Action $1 @@ at () }
  | LPAR REGISTER TEXT module_var_opt RPAR { Register ($3, $4) @@ at () }
  | LPAR ASSERT_INVALID module_ TEXT RPAR
    { AssertInvalid (snd $3, $4) @@ at () }
  | LPAR ASSERT_UNLINKABLE module_ TEXT RPAR
    { AssertUnlinkable (snd $3, $4) @@ at () }
  | LPAR ASSERT_RETURN action const_opt RPAR { AssertReturn ($3, $4) @@ at () }
  | LPAR ASSERT_RETURN_NAN action RPAR { AssertReturnNaN $3 @@ at () }
  | LPAR ASSERT_TRAP action TEXT RPAR { AssertTrap ($3, $4) @@ at () }
  | LPAR INPUT TEXT RPAR { Input $3 @@ at () }
  | LPAR OUTPUT module_var_opt TEXT RPAR { Output ($3, Some $4) @@ at () }
  | LPAR OUTPUT module_var_opt RPAR { Output ($3, None) @@ at () }
;
cmd_list :
  | /* empty */ { [] }
  | cmd cmd_list { $1 :: $2 }
;

const :
  | LPAR CONST literal RPAR { snd (literal $2 $3) @@ ati 3 }
;
const_opt :
  | /* empty */ { None }
  | const { Some $1 }
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
