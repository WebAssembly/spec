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
    | Types.Int32Type -> Values.Int32 (I32.of_string s) @@ at
    | Types.Int64Type -> Values.Int64 (I64.of_string s) @@ at
    | Types.Float32Type -> Values.Float32 (F32.of_string s) @@ at
    | Types.Float64Type -> Values.Float64 (F64.of_string s) @@ at
  with _ -> Error.error at "constant out of range"


(* Symbolic variables *)

module VarMap = Map.Make(String)
type space = {mutable map : int VarMap.t; mutable count : int}

type context =
  {funcs : space; imports : space; locals : space; labels : int VarMap.t}

let empty () = {map = VarMap.empty; count = 0}
let c0 () =
  {funcs = empty (); imports = empty ();
   locals = empty (); labels = VarMap.empty}

let enter_func c =
  assert (VarMap.is_empty c.labels);
  {c with labels = VarMap.add "return" 0 c.labels; locals = empty ()}

let lookup category space x =
  try VarMap.find x.it space.map
  with Not_found -> Error.error x.at ("unknown " ^ category ^ " " ^ x.it)

let func c x = lookup "function" c.funcs x
let import c x = lookup "import" c.imports x
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
let bind_import c x = bind "import" c.imports x
let bind_local c x = bind "local" c.locals x
let bind_label c x =
  {c with labels = VarMap.add x.it 0 (VarMap.map ((+) 1) c.labels)}

let anon space n = space.count <- space.count + n

let anon_func c = anon c.funcs 1
let anon_import c = anon c.imports 1
let anon_locals c ts = anon c.locals (List.length ts)
let anon_label c = {c with labels = VarMap.map ((+) 1) c.labels}
%}

%token INT FLOAT TEXT VAR TYPE LPAR RPAR
%token NOP BLOCK IF LOOP LABEL BREAK SWITCH CASE FALLTHROUGH
%token CALL CALLIMPORT CALLINDIRECT RETURN
%token GETLOCAL SETLOCAL LOAD STORE
%token CONST UNARY BINARY COMPARE CONVERT
%token FUNC PARAM RESULT LOCAL MODULE MEMORY SEGMENT IMPORT EXPORT TABLE
%token PAGESIZE MEMORYSIZE RESIZEMEMORY
%token ASSERTINVALID ASSERTEQ ASSERTTRAP INVOKE
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
%token<Ast.memop> LOAD
%token<Ast.memop> STORE
%token<Ast.extendop> LOADEXTEND
%token<Ast.truncop> STORETRUNC

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
  | INT { let at = at() in fun c lookup -> int_of_string $1 @@ at }
  | VAR { let at = at() in fun c lookup -> lookup c ($1 @@ at) @@ at }
;
var_list :
  | /* empty */ { fun c lookup -> [] }
  | var var_list { fun c lookup -> $1 c lookup :: $2 c lookup }
;
bind_var :
  | VAR { $1 @@ at() }
;

expr :
  | LPAR oper RPAR { let at = at() in fun c -> $2 c @@ at }
;
oper :
  | NOP { fun c -> Nop }
  | BLOCK expr expr_list { fun c -> Block ($2 c :: $3 c) }
  | BLOCK bind_var expr expr_list  /* Sugar */
    { let at = at() in
      fun c -> let c' = bind_label c $2 in
        Label (Block ($3 c' :: $4 c') @@ at) }
  | IF expr expr expr { fun c -> If ($2 c, $3 c, $4 c) }
  | IF expr expr  /* Sugar */
    { let at1 = ati 1 in fun c -> If ($2 c, $3 c, Nop @@ at1) }
  | LOOP expr_block { fun c -> Loop ($2 c) }
  | LOOP bind_var expr_block  /* Sugar */
    { let at = at() in
      fun c -> let c' = bind_label c $2 in Label (Loop ($3 c') @@ at) }
  | LOOP bind_var bind_var expr_block  /* Sugar */
    { let at = at() in
      fun c -> let c' = bind_label (bind_label c $2) $3 in
        Label (Loop (Label ($4 c') @@ at) @@ at) }
  | LABEL expr { fun c -> let c' = anon_label c in Label ($2 c') }
  | LABEL bind_var expr  /* Sugar */
    { fun c -> let c' = bind_label c $2 in Label ($3 c') }
  | BREAK var expr_opt { fun c -> Break ($2 c label, $3 c) }
  | SWITCH expr arms
    { let at1 = ati 1 in
      fun c -> let x, y = $3 c in
        Switch ($1 @@ at1, $2 c, List.map (fun a -> a $1) x, y) }
  | SWITCH bind_var expr arms  /* Sugar */
    { let at = at() in let at2 = ati 2 in
      fun c -> let c' = bind_label c $2 in let x, y = $4 c' in
        Label (Switch ($1 @@ at2, $3 c', List.map (fun a -> a $1) x, y) @@ at) }
  | CALL var expr_list { fun c -> Call ($2 c func, $3 c) }
  | CALLIMPORT var expr_list { fun c -> CallImport ($2 c import, $3 c) }
  | CALLINDIRECT var expr expr_list
    { fun c -> CallIndirect ($2 c table, $3 c, $4 c) }
  | RETURN expr_opt  /* Sugar */
    { let at1 = ati 1 in
      fun c -> Break (label c ("return" @@ at1) @@ at1, $2 c) }
  | GETLOCAL var { fun c -> GetLocal ($2 c local) }
  | SETLOCAL var expr { fun c -> SetLocal ($2 c local, $3 c) }
  | LOAD expr { fun c -> Load ($1, $2 c) }
  | STORE expr expr { fun c -> Store ($1, $2 c, $3 c) }
  | LOADEXTEND expr { fun c -> LoadExtend ($1, $2 c) }
  | STORETRUNC expr expr { fun c -> StoreTrunc ($1, $2 c, $3 c) }
  | CONST literal { let at = at() in fun c -> Const (literal at $2 $1) }
  | UNARY expr { fun c -> Unary ($1, $2 c) }
  | BINARY expr expr { fun c -> Binary ($1, $2 c, $3 c) }
  | COMPARE expr expr { fun c -> Compare ($1, $2 c, $3 c) }
  | CONVERT expr { fun c -> Convert ($1, $2 c) }
  | PAGESIZE { fun c -> PageSize }
  | MEMORYSIZE { fun c -> MemorySize }
  | RESIZEMEMORY expr { fun c -> ResizeMemory ($2 c) }
;
expr_opt :
  | /* empty */ { fun c -> None }
  | expr { fun c -> Some ($1 c) }
;
expr_list :
  | /* empty */ { fun c -> [] }
  | expr expr_list { fun c -> $1 c :: $2 c }
;
expr_block :
  | expr { $1 }
  | expr expr expr_list  /* Sugar */
    { let at = at() in fun c -> Block ($1 c :: $2 c :: $3 c) @@ at }
;

fallthrough :
  | /* empty */ { false }
  | FALLTHROUGH { true }
;
arm :
  | LPAR CASE literal expr_block fallthrough RPAR
    { let at = at() in let at3 = ati 3 in
      fun c t ->
      {value = literal at3 $3 t; expr = $4 c; fallthru = $5} @@ at }
  | LPAR CASE literal RPAR  /* Sugar */
    { let at = at() in let at3 = ati 3 in let at4 = ati 4 in
      fun c t ->
      {value = literal at3 $3 t; expr = Nop @@ at4; fallthru = true} @@ at }
;
arms :
  | expr { fun c -> [], $1 c }
  | arm arms { fun c -> let x, y = $2 c in $1 c :: x, y }
;


/* Functions */

func_fields :
  | /* empty */  /* Sugar */
    { let at = at() in
      fun c -> {params = []; result = None; locals = []; body = Nop @@ at} }
  | expr_block
    { let at = at() in
      fun c ->
        {params = []; result = None; locals = []; body = Label ($1 c) @@ at} }
  | LPAR PARAM value_type_list RPAR func_fields
    { fun c -> anon_locals c $3; let f = $5 c in
      {f with params = $3 @ f.params} }
  | LPAR PARAM bind_var value_type RPAR func_fields  /* Sugar */
    { fun c -> bind_local c $3; let f = $6 c in
      {f with params = $4 :: f.params} }
  | LPAR RESULT value_type RPAR func_fields
    { let at = at() in
      fun c -> let f = $5 c in
        match f.result with
        | Some _ -> Error.error at "more than one return type"
        | None -> {f with result = Some $3} }
  | LPAR LOCAL value_type_list RPAR func_fields
    { fun c -> anon_locals c $3; let f = $5 c in
      {f with locals = $3 @ f.locals} }
  | LPAR LOCAL bind_var value_type RPAR func_fields  /* Sugar */
    { fun c -> bind_local c $3; let f = $6 c in
      {f with locals = $4 :: f.locals} }
;
func :
  | LPAR FUNC func_fields RPAR
    { let at = at() in
      fun c -> anon_func c; fun () -> $3 (enter_func c) @@ at }
  | LPAR FUNC bind_var func_fields RPAR  /* Sugar */
    { let at = at() in
      fun c -> bind_func c $3; fun () -> $4 (enter_func c) @@ at }
;


/* Modules */

segment :
  | LPAR SEGMENT INT TEXT RPAR
    { {Memory.addr = int_of_string $3; Memory.data = $4} @@ at() }
;
segment_list :
  | /* empty */ { [] }
  | segment segment_list { $1 :: $2 }
;

memory :
  | LPAR MEMORY INT INT segment_list RPAR
    { {initial = int_of_string $3; max = int_of_string $4; segments = $5 }
        @@ at() }
  | LPAR MEMORY INT segment_list RPAR
    { {initial = int_of_string $3; max = int_of_string $3; segments = $4 }
        @@ at() }
;

func_params :
  | LPAR PARAM value_type_list RPAR { $3 }
;
func_result :
  | /* empty */ { None }
  | LPAR RESULT value_type RPAR { Some $3 }
;
import :
  | LPAR IMPORT bind_var TEXT TEXT func_params func_result RPAR
    { let at = at() in fun c -> bind_import c $3;
      {module_name = $4; func_name = $5; func_params = $6; func_result = $7 }
        @@ at }
  | LPAR IMPORT TEXT TEXT func_params func_result RPAR  /* Sugar */
    { let at = at() in fun c -> anon_import c;
      {module_name = $3; func_name = $4; func_params = $5; func_result = $6 }
        @@ at }
;

export :
  | LPAR EXPORT TEXT var RPAR
    { let at = at() in fun c -> {name = $3; func = $4 c func} @@ at }
;

module_fields :
  | /* empty */
    { fun c ->
      {imports = []; exports = []; tables = []; funcs = [];
       memory = None} }
  | func module_fields
    { fun c -> let f = $1 c in let m = $2 c in
      {m with funcs = f () :: m.funcs} }
  | import module_fields
    { fun c -> let i = $1 c in let m = $2 c in
      {m with imports = i :: m.imports} }
  | export module_fields
    { fun c -> let m = $2 c in
      {m with exports = $1 c :: m.exports} }
  | LPAR TABLE var_list RPAR module_fields
    { fun c -> let m = $5 c in
      {m with tables = ($3 c func @@ ati 3) :: m.tables} }
  | memory module_fields
    { fun c -> let m = $2 c in
      match m.memory with
      | Some _ -> Error.error $1.at "more than one memory section"
      | None -> {m with memory = Some $1} }
;
modul :
  | LPAR MODULE module_fields RPAR { $3 (c0 ()) @@ at() }
;


/* Scripts */

cmd :
  | modul { Define $1 @@ at() }
  | LPAR ASSERTINVALID modul TEXT RPAR { AssertInvalid ($3, $4) @@ at() }
  | LPAR INVOKE TEXT expr_list RPAR
    { Invoke ($3, $4 (c0 ())) @@ at() }
  | LPAR ASSERTEQ LPAR INVOKE TEXT expr_list RPAR expr RPAR
    { AssertEq ($5, $6 (c0 ()), $8 (c0 ())) @@ at() }
  | LPAR ASSERTTRAP LPAR INVOKE TEXT expr_list RPAR TEXT RPAR
    { AssertTrap ($5, $6 (c0 ()), $8) @@ at() }
;
cmd_list :
  | /* empty */ { [] }
  | cmd cmd_list { $1 :: $2 }
;

script :
  | cmd_list EOF { $1 }
;

%%
