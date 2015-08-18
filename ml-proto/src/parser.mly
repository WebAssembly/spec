/*
 * (c) 2015 Andreas Rossberg
 */

%{
open Source
open Ast
open Script


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

let parse_error s = Error.error Source.no_region s


(* Literals *)

let literal at s t =
  try
    match t with
    | Types.Int32Type -> Values.Int32 (Int32.of_string s) @@ at
    | Types.Int64Type -> Values.Int64 (Int64.of_string s) @@ at
    | Types.Float32Type -> Values.Float32 (float_of_string s) @@ at
    | Types.Float64Type -> Values.Float64 (float_of_string s) @@ at
  with _ -> Error.error at "constant out of range"


(* Symbolic variables *)

module VarMap = Map.Make(String)
type space = {mutable map : int VarMap.t; mutable count : int}

type context =
  {funcs : space; globals : space;
   params : space; locals : space; labels : int VarMap.t}

let empty () = {map = VarMap.empty; count = 0}
let c0 =
  {funcs = empty (); globals = empty ();
   params = empty (); locals = empty (); labels = VarMap.empty}

let enter_func c =
  assert (VarMap.is_empty c.labels);
  {c with params = empty (); locals = empty ()}

let lookup category space x =
  try VarMap.find x.it space.map
  with Not_found -> Error.error x.at ("unknown " ^ category ^ " " ^ x.it)

let func c x = lookup "function" c.funcs x
let global c x = lookup "global" c.globals x
let param c x = lookup "parameter" c.params x
let local c x = lookup "local" c.locals x
let table c x = lookup "table" (empty ()) x
let label c x =
  try VarMap.find x.it c.labels
  with Not_found -> Error.error x.at ("unknown label " ^ x.it)

let bind category space x =
  if VarMap.mem x.it space.map then
    Error.error x.at ("duplicate " ^ category ^ " " ^ x.it);
  space.map <- VarMap.add x.it space.count space.map;
  space.count <- space.count + 1

let bind_func c x = bind "function" c.funcs x
let bind_global c x = bind "global" c.globals x
let bind_param c x = bind "parameter" c.params x
let bind_local c x = bind "local" c.locals x
let bind_label c x =
  if VarMap.mem x.it c.labels then
    Error.error x.at ("duplicate label " ^ x.it);
  {c with labels = VarMap.add x.it 0 (VarMap.map ((+) 1) c.labels)}

let anon space n = space.count <- space.count + n

let anon_func c = anon c.funcs 1
let anon_globals c ts = anon c.globals (List.length ts)
let anon_params c ts = anon c.params (List.length ts)
let anon_locals c ts = anon c.locals (List.length ts)
let anon_label c = {c with labels = VarMap.map ((+) 1) c.labels}
%}

%token INT FLOAT TEXT VAR TYPE LPAR RPAR
%token NOP BLOCK IF LOOP LABEL BREAK SWITCH CASE FALLTHRU
%token CALL DISPATCH RETURN DESTRUCT
%token GETPARAM GETLOCAL SETLOCAL GETGLOBAL SETGLOBAL GETMEMORY SETMEMORY
%token CONST UNARY BINARY COMPARE CONVERT
%token FUNC PARAM RESULT LOCAL MODULE MEMORY DATA GLOBAL IMPORT EXPORT TABLE
%token INVOKE ASSERTEQ
%token EOF

%token<string> INT
%token<string> FLOAT
%token<string> TEXT
%token<string> VAR
%token<Types.value_type> TYPE
%token<Types.value_type> CONST
%token<Types.value_type> SWITCH
%token<Ast.unop> UNARY
%token<Ast.binop> BINARY
%token<Ast.relop> COMPARE
%token<Ast.cvt> CONVERT
%token<Ast.memop> GETMEMORY
%token<Ast.memop> SETMEMORY

%start script
%type<Script.script> script

%%

/* Types */

value_type :
  | TYPE { $1 @@ at() }
;
value_type_list :
  | /* empty */ { [] }
  | value_type value_type_list { $1 :: $2 }
;


/* Expressions */

literal :
  | INT { $1 }
  | FLOAT { $1 }
;

var :
  | INT { fun c lookup -> let i = int_of_string $1 in lazy i @@ at() }
  | VAR { fun c lookup -> let at = at() in lazy (lookup c ($1 @@ at)) @@ at }
;
var_list :
  | /* empty */ { fun c lookup -> [] }
  | var var_list { fun c lookup -> $1 c lookup :: $2 c lookup }
;
bind_var :
  | VAR { $1 @@ at() }
;

expr :
  | LPAR oper RPAR { fun c -> $2 c @@ at() }
;
oper :
  | NOP { fun c -> Nop }
  | BLOCK expr expr_list { fun c -> Block ($2 c :: $3 c) }
  | IF expr expr expr { fun c -> If ($2 c, $3 c, $4 c) }
  | IF expr expr { fun c -> If ($2 c, $3 c, Nop @@ ati 1) }  /* Sugar */
  | LOOP expr_block { fun c -> Loop ($2 c) }
  | LABEL expr_block { fun c -> Label ($2 (anon_label c)) }
  | LABEL bind_var expr_block  /* Sugar */
    { fun c -> Label ($3 (bind_label c $2)) }
  | BREAK var expr_list { fun c -> Break ($2 c label, $3 c) }
  | BREAK { fun c -> Break (lazy 0 @@ at(), []) }  /* Sugar */
  | SWITCH expr arms
    { fun c -> let x, y = $3 c in
        Switch ($1 @@ ati 1, $2 c, List.map (fun a -> a $1) x, y) }
  | CALL var expr_list { fun c -> Call ($2 c func, $3 c) }
  | DISPATCH var expr expr_list { fun c -> Dispatch ($2 c table, $3 c, $4 c) }
  | RETURN expr_list { fun c -> Return ($2 c) }
  | DESTRUCT var_list expr { fun c -> Destruct ($2 c local, $3 c) }
  | GETPARAM var { fun c -> GetParam ($2 c param) }
  | GETLOCAL var { fun c -> GetLocal ($2 c local) }
  | SETLOCAL var expr { fun c -> SetLocal ($2 c local, $3 c) }
  | GETGLOBAL var { fun c -> GetGlobal ($2 c global) }
  | SETGLOBAL var expr { fun c -> SetGlobal ($2 c global, $3 c) }
  | GETMEMORY expr { fun c -> GetMemory ($1, $2 c) }
  | SETMEMORY expr expr { fun c -> SetMemory ($1, $2 c, $3 c) }
  | CONST literal { fun c -> Const (literal (ati 2) $2 $1) }
  | UNARY expr { fun c -> Unary ($1, $2 c) }
  | BINARY expr expr { fun c -> Binary ($1, $2 c, $3 c) }
  | COMPARE expr expr { fun c -> Compare ($1, $2 c, $3 c) }
  | CONVERT expr { fun c -> Convert ($1, $2 c) }
;
expr_list :
  | /* empty */ { fun c -> [] }
  | expr expr_list { fun c -> $1 c :: $2 c }
;
expr_block :
  | expr { $1 }
  | expr expr expr_list { fun c -> Block ($1 c :: $2 c :: $3 c) @@ at() } 
      /* Sugar */
;

fallthru :
  | /* empty */ { false }
  | FALLTHRU { true }
;
arm :
  | LPAR CASE literal expr_block fallthru RPAR
    { fun c t ->
        {value = literal (ati 3) $3 t; expr = $4 c; fallthru = $5} @@ at() }
  | LPAR CASE literal RPAR  /* Sugar */
    { fun c t ->
        {value = literal (ati 3) $3 t; expr = Nop @@ ati 4; fallthru = true}
          @@ at() }
;
arms :
  | expr { fun c -> [], $1 c }
  | arm arms { fun c -> let x, y = $2 c in $1 c :: x, y }
;


/* Functions */

func_fields :
  | /* empty */  /* Sugar */
    { fun c -> {params = []; results = []; locals = []; body = Nop @@ at()} }
  | expr_block
    { fun c -> {params = []; results = []; locals = []; body = $1 c} }
  | LPAR PARAM value_type_list RPAR func_fields
    { fun c -> anon_params c $3; let f = $5 c in
        {f with params = $3 @ f.params} }
  | LPAR PARAM bind_var value_type RPAR func_fields  /* Sugar */
    { fun c -> bind_param c $3; let f = $6 c in
        {f with params = $4 :: f.params} }
  | LPAR RESULT value_type_list RPAR func_fields
    { fun c -> let f = $5 c in {f with results = $3 @ f.results} }
  | LPAR LOCAL value_type_list RPAR func_fields
    { fun c -> anon_locals c $3; let f = $5 c in
        {f with locals = $3 @ f.locals} }
  | LPAR LOCAL bind_var value_type RPAR func_fields  /* Sugar */
    { fun c -> bind_local c $3; let f = $6 c in
        {f with locals = $4 :: f.locals} }
;
func :
  | LPAR FUNC func_fields RPAR
    { fun c -> anon_func c; $3 (enter_func c) @@ at() }
  | LPAR FUNC bind_var func_fields RPAR  /* Sugar */
    { fun c -> bind_func c $3; $4 (enter_func c) @@ at() }
;


/* Modules */

export :
  | LPAR EXPORT TEXT var RPAR { fun c -> {name = $3; func = $4 c func} @@ at() }
;

module_fields :
  | /* empty */
    { fun c -> let memory = (Int64.zero, Int64.zero) in
      {memory; data = ""; funcs = []; exports = []; globals = []; tables = []} }
  | func module_fields
    { fun c -> let f = $1 c in let m = $2 c in {m with funcs = f :: m.funcs} }
  | export module_fields
    { fun c -> let m = $2 c in {m with exports = $1 c :: m.exports} }
  | LPAR GLOBAL value_type_list RPAR module_fields
    { fun c -> anon_globals c $3; let m = $5 c in
        {m with globals = $3 @ m.globals} }
  | LPAR GLOBAL bind_var value_type RPAR module_fields  /* Sugar */
    { fun c -> bind_global c $3; let m = $6 c in
        {m with globals = $4 :: m.globals} }
  | LPAR TABLE var_list RPAR module_fields
    { fun c -> let m = $5 c in
        {m with tables = ($3 c func @@ ati 3) :: m.tables} }
  | LPAR MEMORY INT INT RPAR module_fields
    { fun c -> let m = $6 c in
        {m with memory = (Int64.of_string $3, Int64.of_string $4)} }
  | LPAR MEMORY INT RPAR module_fields  /* Sugar */
    { fun c -> let m = $5 c in
        {m with memory = (Int64.of_string $3, Int64.of_string $3)} }
  | LPAR DATA TEXT RPAR module_fields
    { fun c -> let m = $5 c in {m with data = $3 ^ m.data} }
;
modul :
  | LPAR MODULE module_fields RPAR { $3 c0 @@ at() }
;


/* Scripts */

cmd :
  | modul { Define $1 @@ at() }
  | LPAR INVOKE TEXT expr_list RPAR
    { Invoke ($3, $4 c0) @@ at() }
  | LPAR ASSERTEQ LPAR INVOKE TEXT expr_list RPAR expr_list RPAR
    { AssertEqInvoke ($5, $6 c0, $8 c0) @@ at() }
;
cmd_list :
  | /* empty */ { [] }
  | cmd cmd_list { $1 :: $2 }
;

script :
  | cmd_list EOF { $1 }
;

%%
