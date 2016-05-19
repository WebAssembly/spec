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


(* Symbolic variables *)

module VarMap = Map.Make(String)

type space = {mutable map : int VarMap.t; mutable count : int}
let empty () = {map = VarMap.empty; count = 0}

type types = {mutable tmap : int VarMap.t; mutable tlist : Types.func_type list}
let empty_types () = {tmap = VarMap.empty; tlist = []}

type context =
  {types : types; funcs : space; imports : space;
   locals : space; labels : int VarMap.t}

let empty_context () =
  {types = empty_types (); funcs = empty (); imports = empty ();
   locals = empty (); labels = VarMap.empty}

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
let import c x = lookup "import" c.imports x
let local c x = lookup "local" c.locals x
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
let bind_import c x = bind "import" c.imports x
let bind_local c x = bind "local" c.locals x
let bind_label c x =
  {c with labels = VarMap.add x.it 0 (VarMap.map ((+) 1) c.labels)}

let anon_type c ty =
  c.types.tlist <- c.types.tlist @ [ty]

let anon space n = space.count <- space.count + n

let anon_func c = anon c.funcs 1
let anon_import c = anon c.imports 1
let anon_locals c ts = anon c.locals (List.length ts)
let anon_label c = {c with labels = VarMap.map ((+) 1) c.labels}

let empty_type = {ins = []; out = None}

let explicit_decl c name t at =
  let x = name c type_ in
  if
    x.it < List.length c.types.tlist &&
    t <> empty_type &&
    t <> List.nth c.types.tlist x.it
  then
    error at "signature mismatch";
  x

let implicit_decl c t at =
  match Lib.List.index_of t c.types.tlist with
  | None -> let i = List.length c.types.tlist in anon_type c t; i @@ at
  | Some i -> i @@ at

%}

%token INT FLOAT TEXT VAR VALUE_TYPE LPAR RPAR
%token NOP BLOCK IF THEN ELSE SELECT LOOP BR BR_IF BR_TABLE
%token CALL CALL_IMPORT CALL_INDIRECT RETURN
%token GET_LOCAL SET_LOCAL LOAD STORE OFFSET ALIGN
%token CONST UNARY BINARY COMPARE CONVERT
%token UNREACHABLE CURRENT_MEMORY GROW_MEMORY
%token FUNC START TYPE PARAM RESULT LOCAL
%token MODULE MEMORY SEGMENT IMPORT EXPORT TABLE
%token ASSERT_INVALID ASSERT_RETURN ASSERT_RETURN_NAN ASSERT_TRAP INVOKE
%token INPUT OUTPUT
%token EOF

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
  | TEXT { $1 }
  | text_list TEXT { $1 ^ $2 }
;

/* Types */

value_type_list :
  | /* empty */ { [] }
  | VALUE_TYPE value_type_list { $1 :: $2 }
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


/* Expressions */

literal :
  | INT { $1 @@ at () }
  | FLOAT { $1 @@ at () }
;

var :
  | INT { let at = at () in fun c lookup -> int_of_string $1 @@ at }
  | VAR { let at = at () in fun c lookup -> lookup c ($1 @@ at) @@ at }
;
var_list :
  | /* empty */ { fun c lookup -> [] }
  | var var_list { fun c lookup -> $1 c lookup :: $2 c lookup }
;
bind_var :
  | VAR { $1 @@ at () }
;

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
  | CALL_IMPORT var expr_list { fun c -> Call_import ($2 c import, $3 c) }
  | CALL_INDIRECT var expr expr_list
    { fun c -> Call_indirect ($2 c type_, $3 c, $4 c) }
  | GET_LOCAL var { fun c -> Get_local ($2 c local) }
  | SET_LOCAL var expr { fun c -> Set_local ($2 c local, $3 c) }
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
type_use :
  | LPAR TYPE var RPAR { $3 }
;
func :
  | LPAR FUNC export_opt type_use func_fields RPAR
    { let at = at () in
      fun c -> anon_func c; let t = explicit_decl c $4 (fst $5) at in
        let exs = $3 c in
        fun () -> {(snd $5 (enter_func c)) with ftype = t} @@ at, exs }
  | LPAR FUNC export_opt bind_var type_use func_fields RPAR  /* Sugar */
    { let at = at () in
      fun c -> bind_func c $4; let t = explicit_decl c $5 (fst $6) at in
        let exs = $3 c in
        fun () -> {(snd $6 (enter_func c)) with ftype = t} @@ at, exs }
  | LPAR FUNC export_opt func_fields RPAR  /* Sugar */
    { let at = at () in
      fun c -> anon_func c; let t = implicit_decl c (fst $4) at in
        let exs = $3 c in
        fun () -> {(snd $4 (enter_func c)) with ftype = t} @@ at, exs }
  | LPAR FUNC export_opt bind_var func_fields RPAR  /* Sugar */
    { let at = at () in
      fun c -> bind_func c $4; let t = implicit_decl c (fst $5) at in
        let exs = $3 c in
        fun () -> {(snd $5 (enter_func c)) with ftype = t} @@ at, exs }
;
export_opt :
  | /* empty */ { fun c -> [] }
  | TEXT
    { let at = at () in
      fun c -> [{name = $1; kind = `Func (c.funcs.count - 1 @@ at)} @@ at] }
;


/* Modules */

start :
  | LPAR START var RPAR
    { fun c -> $3 c func }

segment :
  | LPAR SEGMENT INT text_list RPAR
    { {Memory.addr = Int64.of_string $3; Memory.data = $4} @@ at () }
;
segment_list :
  | /* empty */ { [] }
  | segment segment_list { $1 :: $2 }
;

memory :
  | LPAR MEMORY INT INT segment_list RPAR
    { {min = Int64.of_string $3; max = Int64.of_string $4; segments = $5}
        @@ at () }
  | LPAR MEMORY INT segment_list RPAR
    { {min = Int64.of_string $3; max = Int64.of_string $3; segments = $4}
        @@ at () }
;

type_def :
  | LPAR TYPE LPAR FUNC func_type RPAR RPAR
    { fun c -> anon_type c $5 }
  | LPAR TYPE bind_var LPAR FUNC func_type RPAR RPAR
    { fun c -> bind_type c $3 $6 }
;

table :
  | LPAR TABLE var_list RPAR
    { fun c -> $3 c func }
;

import :
  | LPAR IMPORT TEXT TEXT type_use RPAR
    { let at = at () in
      fun c -> anon_import c; let itype = explicit_decl c $5 empty_type at in
        {itype; module_name = $3; func_name = $4} @@ at }
  | LPAR IMPORT bind_var TEXT TEXT type_use RPAR  /* Sugar */
    { let at = at () in
      fun c -> bind_import c $3; let itype = explicit_decl c $6 empty_type at in
        {itype; module_name = $4; func_name = $5} @@ at }
  | LPAR IMPORT TEXT TEXT func_type RPAR  /* Sugar */
    { let at = at () in
      fun c -> anon_import c; let itype = implicit_decl c $5 at in
        {itype; module_name = $3; func_name = $4} @@ at }
  | LPAR IMPORT bind_var TEXT TEXT func_type RPAR  /* Sugar */
    { let at = at () in
      fun c -> bind_import c $3; let itype = implicit_decl c $6 at in
        {itype; module_name = $4; func_name = $5} @@ at }
;

export :
  | LPAR EXPORT TEXT var RPAR
    { let at = at () in fun c -> {name = $3; kind = `Func ($4 c func)} @@ at }
  | LPAR EXPORT TEXT MEMORY RPAR
    { let at = at () in fun c -> {name = $3; kind = `Memory} @@ at }
;

module_fields :
  | /* empty */
    { fun c ->
      {memory = None; types = c.types.tlist; funcs = []; start = None; imports = [];
       exports = []; table = []} }
  | func module_fields
    { fun c -> let f = $1 c in let m = $2 c in let func, exs = f () in
      {m with funcs = func :: m.funcs; exports = exs @ m.exports} }
  | import module_fields
    { fun c -> let i = $1 c in let m = $2 c in
      {m with imports = i :: m.imports} }
  | export module_fields
    { fun c -> let m = $2 c in
      {m with exports = $1 c :: m.exports} }
  | table module_fields
    { fun c -> let m = $2 c in
      {m with table = ($1 c) @ m.table} }
  | type_def module_fields
    { fun c -> $1 c; $2 c }
  | memory module_fields
    { fun c -> let m = $2 c in
      match m.memory with
      | Some _ -> error $1.at "multiple memory sections"
      | None -> {m with memory = Some $1} }
  | start module_fields
    { fun c -> let m = $2 c in
      {m with start = Some ($1 c)} }
;
module_ :
  | LPAR MODULE module_fields RPAR
    { Textual ($3 (empty_context ()) @@ at ()) @@ at() }
  | LPAR MODULE text_list RPAR { Binary $3 @@ at() }
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
