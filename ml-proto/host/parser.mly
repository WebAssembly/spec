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
  try f s with
  | Failure msg -> error s.at ("constant out of range: " ^ msg)
  | _ -> error s.at "constant out of range"

let int s at =
  try int_of_string s with Failure _ ->
    error at "int constant out of range"

let int32 s at =
  try I32.of_string s with Failure _ ->
    error at "i32 constant out of range"

let int64 s at =
  try I64.of_string s with Failure _ ->
    error at "i64 constant out of range"


(* Symbolic variables *)

module VarMap = Map.Make(String)

type space = {mutable map : int VarMap.t; mutable count : int}
let empty () = {map = VarMap.empty; count = 0}

type types = {mutable tmap : int VarMap.t; mutable tlist : Types.func_type list}
let empty_types () = {tmap = VarMap.empty; tlist = []}

type context =
  {types : types; tables : space; memories : space; funcs : space;
   locals : space; globals : space; labels : int VarMap.t}

let empty_context () =
  {types = empty_types (); tables = empty (); memories = empty ();
   funcs = empty (); locals = empty (); globals = empty (); labels = VarMap.empty}

let enter_func c =
  assert (VarMap.is_empty c.labels);
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

let bind_type c x ty =
  if VarMap.mem x.it c.types.tmap then
    error x.at ("duplicate type " ^ x.it);
  c.types.tmap <- VarMap.add x.it (List.length c.types.tlist) c.types.tmap;
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

let anon_type c ty =
  c.types.tlist <- c.types.tlist @ [ty]

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

%token NAT INT FLOAT TEXT VAR VALUE_TYPE ANYFUNC LPAR RPAR
%token NOP DROP BLOCK IF THEN ELSE SELECT LOOP BR BR_IF BR_TABLE
%token CALL CALL_INDIRECT RETURN
%token GET_LOCAL SET_LOCAL TEE_LOCAL GET_GLOBAL SET_GLOBAL
%token LOAD STORE OFFSET ALIGN
%token CONST UNARY BINARY COMPARE CONVERT
%token UNREACHABLE CURRENT_MEMORY GROW_MEMORY
%token FUNC START TYPE PARAM RESULT LOCAL GLOBAL
%token MODULE TABLE ELEM MEMORY DATA IMPORT EXPORT TABLE
%token ASSERT_INVALID ASSERT_RETURN ASSERT_RETURN_NAN ASSERT_TRAP INVOKE
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

func_type :
  | /* empty */
    { {ins = []; out = None} }
  | LPAR PARAM value_type_list RPAR
    { {ins = $3; out = None} }
  | LPAR PARAM value_type_list RPAR LPAR RESULT VALUE_TYPE RPAR
    { {ins = $3; out = Some $7} }
  | LPAR RESULT VALUE_TYPE RPAR
    { {ins = []; out = Some $3} }
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
bind_var :
  | VAR { $1 @@ at () }
;
/* TODO: refactor repetition into bind_var_opt */

labeling :
  | /* empty */ %prec LOW { fun c -> anon_label c }
  | labeling1 { $1 }
;
labeling1 :
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
  | BLOCK labeling expr_list { fun c -> let c' = $2 c in Block ($3 c') }
  | LOOP labeling expr_list
    { fun c -> let c' = anon_label c in let c'' = $2 c' in Loop ($3 c'') }
  | LOOP labeling1 labeling1 expr_list
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
  | IF expr LPAR THEN labeling expr_list RPAR
    { fun c -> let c' = $5 c in If ($2 c, $6 c', []) }
  | IF expr LPAR THEN labeling expr_list RPAR LPAR ELSE labeling expr_list RPAR
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
  | LPAR FUNC export_name_opt type_use func_fields RPAR
    { let at = at () in
      fun c -> anon_func c; let t = explicit_sig c $4 (fst $5) at in
      let exs = $3 FuncExport c in
      fun () -> {(snd $5 (enter_func c)) with ftype = t} @@ at, exs }
  | LPAR FUNC export_name_opt bind_var type_use func_fields RPAR  /* Sugar */
    { let at = at () in
      fun c -> bind_func c $4; let t = explicit_sig c $5 (fst $6) at in
      let exs = $3 FuncExport c in
      fun () -> {(snd $6 (enter_func c)) with ftype = t} @@ at, exs }
  | LPAR FUNC export_name_opt func_fields RPAR  /* Sugar */
    { let at = at () in
      fun c -> anon_func c; let t = inline_type c (fst $4) at in
      let exs = $3 FuncExport c in
      fun () -> {(snd $4 (enter_func c)) with ftype = t} @@ at, exs }
  | LPAR FUNC export_name_opt bind_var func_fields RPAR  /* Sugar */
    { let at = at () in
      fun c -> bind_func c $4; let t = inline_type c (fst $5) at in
      let exs = $3 FuncExport c in
      fun () -> {(snd $5 (enter_func c)) with ftype = t} @@ at, exs }
;


/* Tables & Memories */

limits :
  | NAT { {min = int32 $1 (ati 1); max = None} @@ at () }
  | NAT NAT
    { {min = int32 $1 (ati 1); max = Some (int32 $2 (ati 2))} @@ at () }
;

elem :
  | LPAR ELEM var expr var_list RPAR
    { let at = at () in
      fun c -> {index = $3 c table; offset = $4 c; init = $5 c func} @@ at }
  | LPAR ELEM expr var_list RPAR  /* Sugar */
    { let at = at () in
      fun c -> {index = 0 @@ at; offset = $3 c; init = $4 c func} @@ at }
;

table :  /* TODO: allow export_opt */
  | LPAR TABLE limits elem_type RPAR
    { let at = at () in
      fun c -> anon_table c; {tlimits = $3; etype = $4} @@ at, [] }
  | LPAR TABLE bind_var limits elem_type RPAR  /* Sugar */
    { let at = at () in
      fun c -> bind_table c $3; {tlimits = $4; etype = $5} @@ at, [] }
  | LPAR TABLE elem_type LPAR ELEM var_list RPAR RPAR  /* Sugar */
    { let at = at () in
      fun c -> anon_table c; let init = $6 c func in
      let size = Int32.of_int (List.length init) in
      {tlimits = {min = size; max = Some size} @@ at; etype = $3} @@ at,
      [{index = c.tables.count - 1 @@ at; offset = I32_const (0l @@ at) @@ at; init} @@ at] }
  | LPAR TABLE bind_var elem_type LPAR ELEM var_list RPAR RPAR  /* Sugar */
    { let at = at () in
      fun c -> bind_table c $3; let init = $7 c func in
      let size = Int32.of_int (List.length init) in
      {tlimits = {min = size; max = Some size} @@ at; etype = $4} @@ at,
      [{index = c.tables.count - 1 @@ at; offset = I32_const (0l @@ at) @@ at; init} @@ at] }
;

data :
  | LPAR DATA var expr text_list RPAR
    { let at = at () in
      fun c -> {index = $3 c memory; offset = $4 c; init = $5} @@ at }
  | LPAR DATA expr text_list RPAR  /* Sugar */
    { let at = at () in
      fun c -> {index = 0 @@ at; offset = $3 c; init = $4} @@ at }
;

memory :  /* TODO: allow export_opt */
  | LPAR MEMORY limits RPAR
    { fun c -> anon_memory c; {mlimits = $3} @@ at (), [] }
  | LPAR MEMORY bind_var limits RPAR  /* Sugar */
    { fun c -> bind_memory c $3; {mlimits = $4} @@ at (), [] }
  | LPAR MEMORY LPAR DATA text_list RPAR RPAR  /* Sugar */
    { let at = at () in
      fun c -> anon_memory c;
      let size = Int32.(div (add (of_int (String.length $5)) 65535l) 65536l) in
      {mlimits = {min = size; max = Some size} @@ at} @@ at,
      [{index = c.memories.count - 1 @@ at; offset = I32_const (0l @@ at) @@ at; init = $5} @@ at] }
  | LPAR MEMORY bind_var LPAR DATA text_list RPAR RPAR  /* Sugar */
    { let at = at () in
      fun c -> bind_memory c $3;
      let size = Int32.(div (add (of_int (String.length $6)) 65535l) 65536l) in
      {mlimits = {min = size; max = Some size} @@ at} @@ at,
      [{index = c.memories.count - 1 @@ at; offset = I32_const (0l @@ at) @@ at; init = $6} @@ at] }
;


/* Imports & Exports */

import_kind :
  | LPAR FUNC type_use RPAR
    { fun c -> bind_func, anon_func, FuncImport ($3 c type_) }
  | LPAR FUNC func_type RPAR  /* Sugar */
    { let at3 = ati 3 in
      fun c -> bind_func, anon_func, FuncImport (inline_type c $3 at3) }
  | LPAR TABLE limits elem_type RPAR
    { fun c -> bind_table, anon_table, TableImport ($3, $4) }
  | LPAR MEMORY limits RPAR
    { fun c -> bind_memory, anon_memory, MemoryImport $3 }
  | LPAR GLOBAL VALUE_TYPE RPAR
    { fun c -> bind_global, anon_global, GlobalImport $3 }
;
import :
  | LPAR IMPORT TEXT TEXT import_kind RPAR
    { let at = at () and at5 = ati 5 in
      fun c -> let _, anon, k = $5 c in
      anon c; {module_name = $3; item_name = $4; ikind = k @@ at5} @@ at }
  | LPAR IMPORT bind_var TEXT TEXT import_kind RPAR  /* Sugar */
    { let at = at () and at6 = ati 6 in
      fun c -> let bind, _, k = $6 c in
      bind c $3; {module_name = $4; item_name = $5; ikind = k @@ at6} @@ at }
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

export_name_opt :
  | /* empty */ { fun k c -> [] }
  | TEXT
    { let at = at () in
      fun k c -> [{name = $1; ekind = k @@ at; item = c.funcs.count - 1 @@ at} @@ at] }
;


/* Modules */

type_def :
  | LPAR TYPE LPAR FUNC func_type RPAR RPAR
    { fun c -> anon_type c $5 }
  | LPAR TYPE bind_var LPAR FUNC func_type RPAR RPAR
    { fun c -> bind_type c $3 $6 }
;

global :
  | LPAR GLOBAL VALUE_TYPE expr RPAR
    { let at = at () in
      fun c -> anon_global c; fun () -> {gtype = $3; value = $4 c} @@ at }
  | LPAR GLOBAL bind_var VALUE_TYPE expr RPAR  /* Sugar */
    { let at = at () in
      fun c -> bind_global c $3; fun () -> {gtype = $4; value = $5 c} @@ at }
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
    { fun c -> let g = $1 c in let m = $2 c in
      if m.imports <> [] then
        error (List.hd m.imports).at "import after global definition";
      {m with globals = g () :: m.globals} }
  | table module_fields
    { fun c -> let m = $2 c in let tab, elems = $1 c in
      if m.imports <> [] then
        error (List.hd m.imports).at "import after table definition";
      {m with tables = tab :: m.tables; elems = elems @ m.elems} }
  | memory module_fields
    { fun c -> let m = $2 c in let mem, data = $1 c in
      if m.imports <> [] then
        error (List.hd m.imports).at "import after memory definition";
      {m with memories = mem :: m.memories; data = data @ m.data} }
  | func module_fields
    { fun c -> let f = $1 c in let m = $2 c in let func, exs = f () in
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
  | LPAR MODULE module_fields RPAR
    { Textual ($3 (empty_context ()) @@ at ()) @@ at() }
  | LPAR MODULE TEXT text_list RPAR { Binary ($3 ^ $4) @@ at() }
;


/* Scripts */

cmd :
  | module_ { Define $1 @@ at () }
  | LPAR INVOKE TEXT const_list RPAR { Invoke ($3, $4) @@ at () }
  | LPAR ASSERT_INVALID module_ TEXT RPAR { AssertInvalid ($3, $4) @@ at () }
  | LPAR ASSERT_RETURN LPAR INVOKE TEXT const_list RPAR const_opt RPAR
    { AssertReturn ($5, $6, $8) @@ at () }
  | LPAR ASSERT_RETURN_NAN LPAR INVOKE TEXT const_list RPAR RPAR
    { AssertReturnNaN ($5, $6) @@ at () }
  | LPAR ASSERT_TRAP LPAR INVOKE TEXT const_list RPAR TEXT RPAR
    { AssertTrap ($5, $6, $8) @@ at () }
  | LPAR INPUT TEXT RPAR { Input $3 @@ at () }
  | LPAR OUTPUT TEXT RPAR { Output (Some $3) @@ at () }
  | LPAR OUTPUT RPAR { Output None @@ at () }
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
  | module_ EOF { $1 }
;
%%
