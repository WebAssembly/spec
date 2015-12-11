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
  {types : types; funcs : space; imports : space; locals : space;
   labels : int VarMap.t; cases : space}

let empty_context () =
  {types = empty_types (); funcs = empty (); imports = empty ();
   locals = empty (); labels = VarMap.empty; cases = empty ()}

let enter_func c =
  assert (VarMap.is_empty c.labels);
  {c with labels = VarMap.add "return" 0 c.labels; locals = empty ()}

let enter_switch c =
  {c with cases = empty ()}

let type_ c x =
  try VarMap.find x.it c.types.tmap
  with Not_found -> error x.at ("unknown type " ^ x.it)

let lookup category space x =
  try VarMap.find x.it space.map
  with Not_found -> error x.at ("unknown " ^ category ^ " " ^ x.it)

let func c x = lookup "function" c.funcs x
let import c x = lookup "import" c.imports x
let local c x = lookup "local" c.locals x
let case c x = lookup "case" c.cases x
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
let bind_case c x = bind "case" c.cases x
let bind_label c x =
  {c with labels = VarMap.add x.it 0 (VarMap.map ((+) 1) c.labels)}

let anon_type c ty =
  c.types.tlist <- c.types.tlist @ [ty]

let anon space n = space.count <- space.count + n

let anon_func c = anon c.funcs 1
let anon_import c = anon c.imports 1
let anon_locals c ts = anon c.locals (List.length ts)
let anon_case c = anon c.cases 1
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
%token NOP BLOCK IF IF_ELSE LOOP BR BR_IF TABLESWITCH CASE
%token CALL CALL_IMPORT CALL_INDIRECT RETURN
%token GET_LOCAL SET_LOCAL LOAD STORE OFFSET ALIGN
%token CONST UNARY BINARY COMPARE CONVERT
%token FUNC TYPE PARAM RESULT LOCAL
%token MODULE MEMORY SEGMENT IMPORT EXPORT TABLE
%token UNREACHABLE MEMORY_SIZE GROW_MEMORY HAS_FEATURE
%token ASSERT_INVALID ASSERT_RETURN ASSERT_RETURN_NAN ASSERT_TRAP INVOKE
%token EOF

%token<string> INT
%token<string> FLOAT
%token<string> TEXT
%token<string> VAR
%token<Types.value_type> VALUE_TYPE
%token<string Source.phrase -> Ast.expr' * Values.value> CONST
%token<Ast.expr -> Ast.expr'> UNARY
%token<Ast.expr * Ast.expr -> Ast.expr'> BINARY
%token<Ast.expr * Ast.expr * Ast.expr -> Ast.expr'> SELECT
%token<Ast.expr * Ast.expr -> Ast.expr'> COMPARE
%token<Ast.expr -> Ast.expr'> CONVERT
%token<Memory.offset * int option * Ast.expr -> Ast.expr'> LOAD
%token<Memory.offset * int option * Ast.expr * Ast.expr -> Ast.expr'> STORE
%token<Memory.offset> OFFSET
%token<int> ALIGN

%nonassoc LOW
%nonassoc VAR

%start script script1
%type<Script.script> script
%type<Script.script> script1

%%

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
  | BLOCK labeling expr expr_list
    { fun c -> let c' = $2 c in Block ($3 c' :: $4 c') }
  | LOOP labeling expr_list
    { fun c -> let c' = anon_label c in let c'' = $2 c' in Loop ($3 c'') }
  | LOOP labeling1 labeling1 expr_list
    { fun c -> let c' = $2 c in let c'' = $3 c' in Loop ($4 c'') }
  | BR var expr_opt { fun c -> Br ($2 c label, $3 c) }
  | BR_IF expr var expr_opt { fun c -> Br_if ($2 c, $3 c label, $4 c) }
  | RETURN expr_opt
    { let at1 = ati 1 in
      fun c -> Return (label c ("return" @@ at1) @@ at1, $2 c) }
  | IF expr expr { fun c -> If ($2 c, $3 c) }
  | IF_ELSE expr expr expr { fun c -> If_else ($2 c, $3 c, $4 c) }
  | TABLESWITCH labeling expr LPAR TABLE target_list RPAR target case_list
    { fun c -> let c' = $2 c in let e = $3 c' in
      let c'' = enter_switch c' in let es = $9 c'' in
      Tableswitch (e, $6 c'', $8 c'', es) }
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
  | SELECT expr expr expr { fun c -> $1 ($2 c, $3 c, $4 c) }
  | COMPARE expr expr { fun c -> $1 ($2 c, $3 c) }
  | CONVERT expr { fun c -> $1 ($2 c) }
  | MEMORY_SIZE { fun c -> Memory_size }
  | GROW_MEMORY expr { fun c -> Grow_memory ($2 c) }
  | HAS_FEATURE TEXT { fun c -> Has_feature $2 }
;
expr_opt :
  | /* empty */ { fun c -> None }
  | expr { fun c -> Some ($1 c) }
;
expr_list :
  | /* empty */ { fun c -> [] }
  | expr expr_list { fun c -> $1 c :: $2 c }
;

target :
  | LPAR CASE var RPAR { let at = at () in fun c -> Case ($3 c case) @@ at }
  | LPAR BR var RPAR { let at = at () in fun c -> Case_br ($3 c label) @@ at }
;
target_list :
  | /* empty */ { fun c -> [] }
  | target target_list { fun c -> $1 c :: $2 c }
;
case :
  | LPAR CASE expr_list RPAR { fun c -> anon_case c; $3 c }
  | LPAR CASE bind_var expr_list RPAR { fun c -> bind_case c $3; $4 c }
;
case_list :
  | /* empty */ { fun c -> [] }
  | case case_list { fun c -> let e = $1 c in let es = $2 c in e :: es }
;


/* Functions */

func_fields :
  | expr_list
    { empty_type,
      fun c -> {ftype = -1 @@ at(); locals = []; body = $1 c} }
  | LPAR PARAM value_type_list RPAR func_fields
    { {(fst $5) with ins = $3 @ (fst $5).ins},
      fun c -> anon_locals c $3; (snd $5) c }
  | LPAR PARAM bind_var VALUE_TYPE RPAR func_fields  /* Sugar */
    { {(fst $6) with ins = $4 :: (fst $6).ins},
      fun c -> bind_local c $3; (snd $6) c }
  | LPAR RESULT VALUE_TYPE RPAR func_fields
    { if (fst $5).out <> None then error (at ()) "multiple return types";
      {(fst $5) with out = Some $3},
      fun c -> (snd $5) c }
  | LPAR LOCAL value_type_list RPAR func_fields
    { fst $5,
      fun c -> anon_locals c $3; let f = (snd $5) c in
        {f with locals = $3 @ f.locals} }
  | LPAR LOCAL bind_var VALUE_TYPE RPAR func_fields  /* Sugar */
    { fst $6,
      fun c -> bind_local c $3; let f = (snd $6) c in
        {f with locals = $4 :: f.locals} }
;
type_use :
  | LPAR TYPE var RPAR { $3 }
;
func :
  | LPAR FUNC type_use func_fields RPAR
    { let at = at () in
      fun c -> anon_func c; let t = explicit_decl c $3 (fst $4) at in
        fun () -> {((snd $4) (enter_func c)) with ftype = t} @@ at }
  | LPAR FUNC bind_var type_use func_fields RPAR  /* Sugar */
    { let at = at () in
      fun c -> bind_func c $3; let t = explicit_decl c $4 (fst $5) at in
        fun () -> {((snd $5) (enter_func c)) with ftype = t} @@ at }
  | LPAR FUNC func_fields RPAR  /* Sugar */
    { let at = at () in
      fun c -> anon_func c; let t = implicit_decl c (fst $3) at in
        fun () -> {((snd $3) (enter_func c)) with ftype = t} @@ at }
  | LPAR FUNC bind_var func_fields RPAR  /* Sugar */
    { let at = at () in
      fun c -> bind_func c $3; let t = implicit_decl c (fst $4) at in
        fun () -> {((snd $4) (enter_func c)) with ftype = t} @@ at }
;


/* Modules */

segment :
  | LPAR SEGMENT INT TEXT RPAR
    { {Memory.addr = Int64.of_string $3; Memory.data = $4} @@ at () }
;
segment_list :
  | /* empty */ { [] }
  | segment segment_list { $1 :: $2 }
;

memory :
  | LPAR MEMORY INT INT segment_list RPAR
    { {initial = Int64.of_string $3; max = Int64.of_string $4; segments = $5}
        @@ at () }
  | LPAR MEMORY INT segment_list RPAR
    { {initial = Int64.of_string $3; max = Int64.of_string $3; segments = $4}
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
    { let at = at () in fun c -> {name = $3; func = $4 c func} @@ at }
;

module_fields :
  | /* empty */
    { fun c ->
      {memory = None; types = c.types.tlist; funcs = []; imports = [];
       exports = []; table = []} }
  | func module_fields
    { fun c -> let f = $1 c in let m = $2 c in
      {m with funcs = f () :: m.funcs} }
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
;
module_ :
  | LPAR MODULE module_fields RPAR { $3 (empty_context ()) @@ at () }
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
%%
