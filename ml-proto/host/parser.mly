/*
 * (c) 2015 Andreas Rossberg
 */

%{
open Source
open Ast
open Sugar
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

let literal s t =
  try
    match t with
    | Types.Int32Type -> Values.Int32 (I32.of_string s.it) @@ s.at
    | Types.Int64Type -> Values.Int64 (I64.of_string s.it) @@ s.at
    | Types.Float32Type -> Values.Float32 (F32.of_string s.it) @@ s.at
    | Types.Float64Type -> Values.Float64 (F64.of_string s.it) @@ s.at
  with
    | Failure reason -> Error.error s.at ("constant out of range: " ^ reason)
    | _ -> Error.error s.at "constant out of range"


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
%token BR_IF BR_SWITCH
%token CALL CALL_IMPORT CALL_INDIRECT RETURN
%token GET_LOCAL SET_LOCAL LOAD STORE
%token CONST UNARY BINARY COMPARE CONVERT
%token FUNC PARAM RESULT LOCAL MODULE MEMORY SEGMENT IMPORT EXPORT TABLE
%token PAGE_SIZE MEMORY_SIZE RESIZE_MEMORY
%token ASSERT_INVALID ASSERT_RETURN ASSERT_RETURN_NAN ASSERT_TRAP INVOKE
%token EOF

%token<string> INT
%token<string> FLOAT
%token<string> TEXT
%token<string> VAR
%token<Types.value_type> TYPE
%token<Types.value_type> CONST
%token<Types.value_type> SWITCH
%token<Types.value_type> BR_SWITCH
%token<Ast.unop> UNARY
%token<Ast.binop> BINARY
%token<Ast.relop> COMPARE
%token<Ast.cvt> CONVERT
%token<Ast.memop> LOAD
%token<Ast.memop> STORE
%token<Ast.extop> LOAD_EXTEND
%token<Ast.wrapop> STORE_WRAP

%nonassoc LOW
%nonassoc VAR

%start script
%type<Script.script> script

%%

/* Types */

value_type :
  | TYPE { $1 @@ at () }
;
value_type_list :
  | /* empty */ { [] }
  | value_type value_type_list { $1 :: $2 }
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
  | /* empty */ %prec LOW { let at = at () in fun c -> c, Unlabelled @@ at }
  | bind_var { let at = at () in fun c -> bind_label c $1, Labelled @@ at }
;

expr :
  | LPAR expr1 RPAR { let at = at () in fun c -> $2 c @@ at }
;
expr1 :
  | NOP { fun c -> nop }
  | BLOCK labeling expr expr_list
    { fun c -> let c', l = $2 c in block (l, $3 c' :: $4 c') }
  | IF expr expr expr_opt { fun c -> if_ ($2 c, $3 c, $4 c) }
  | LOOP labeling labeling expr_list
    { fun c -> let c', l1 = $2 c in let c'', l2 = $3 c' in
      loop (l1, l2, $4 c'') }
  | LABEL labeling expr
    { fun c -> let c', l = $2 c in
      let c'' = if l.it = Unlabelled then anon_label c' else c' in
      Sugar.label ($3 c'') }
  | BREAK var expr_opt { fun c -> break ($2 c label, $3 c) }
  | RETURN expr_opt
    { let at1 = ati 1 in
      fun c -> return (label c ("return" @@ at1) @@ at1, $2 c) }
  | SWITCH labeling expr cases
    { let at1 = ati 1 in
      fun c -> let c', l = $2 c in let cs, e = $4 c' in
      switch (l, $1 @@ at1, $3 c', List.map (fun a -> a $1) cs, e) }
  | BR_IF var expr expr_opt { fun c -> br_if ($2 c label, $3 c, $4 c) }
  | BR_SWITCH expr var br_switch_arms expr_opt
    { let at1 = ati 1 in
      let t = $1 in
      fun c -> br_switch (t @@ at1, $2 c, $3 c label,
                          List.map (fun (s, a) -> (literal s t, a c label)) $4, $5 c) }
  | CALL var expr_list { fun c -> call ($2 c func, $3 c) }
  | CALL_IMPORT var expr_list { fun c -> call_import ($2 c import, $3 c) }
  | CALL_INDIRECT var expr expr_list
    { fun c -> call_indirect ($2 c table, $3 c, $4 c) }
  | GET_LOCAL var { fun c -> get_local ($2 c local) }
  | SET_LOCAL var expr { fun c -> set_local ($2 c local, $3 c) }
  | LOAD expr { fun c -> load ($1, $2 c) }
  | STORE expr expr { fun c -> store ($1, $2 c, $3 c) }
  | LOAD_EXTEND expr { fun c -> load_extend ($1, $2 c) }
  | STORE_WRAP expr expr { fun c -> store_wrap ($1, $2 c, $3 c) }
  | CONST literal { fun c -> const (literal $2 $1) }
  | UNARY expr { fun c -> unary ($1, $2 c) }
  | BINARY expr expr { fun c -> binary ($1, $2 c, $3 c) }
  | COMPARE expr expr { fun c -> compare ($1, $2 c, $3 c) }
  | CONVERT expr { fun c -> convert ($1, $2 c) }
  | PAGE_SIZE { fun c -> page_size }
  | MEMORY_SIZE { fun c -> memory_size }
  | RESIZE_MEMORY expr { fun c -> resize_memory ($2 c) }
;
expr_opt :
  | /* empty */ { fun c -> None }
  | expr { fun c -> Some ($1 c) }
;
expr_list :
  | /* empty */ { fun c -> [] }
  | expr expr_list { fun c -> $1 c :: $2 c }
;

fallthrough :
  | /* empty */ { false }
  | FALLTHROUGH { true }
;

case :
  | LPAR case1 RPAR { let at = at () in fun c t -> $2 c t @@ at }
;
case1 :
  | CASE literal expr expr_list fallthrough
    { fun c t -> case (literal $2 t, Some ($3 c :: $4 c, $5)) }
  | CASE literal
    { fun c t -> case (literal $2 t, None) }
;
cases :
  | expr { fun c -> [], $1 c }
  | case cases { fun c -> let x, y = $2 c in $1 c :: x, y }
;

br_switch_arms :
  | /* empty */ { [] }
  | INT var br_switch_arms { let at = at () in ($1 @@ at, $2) :: $3 }
;


/* Functions */

func_fields :
  | expr_list
    { let at = at () in
      fun c ->
      {params = []; result = None; locals = [];
       body = Sugar.func_body ($1 c) @@ at} }
  | LPAR PARAM value_type_list RPAR func_fields
    { fun c -> anon_locals c $3; let f = $5 c in
      {f with params = $3 @ f.params} }
  | LPAR PARAM bind_var value_type RPAR func_fields  /* Sugar */
    { fun c -> bind_local c $3; let f = $6 c in
      {f with params = $4 :: f.params} }
  | LPAR RESULT value_type RPAR func_fields
    { let at = at () in
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
    { let at = at () in
      fun c -> anon_func c; fun () -> $3 (enter_func c) @@ at }
  | LPAR FUNC bind_var func_fields RPAR  /* Sugar */
    { let at = at () in
      fun c -> bind_func c $3; fun () -> $4 (enter_func c) @@ at }
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

func_params :
  | LPAR PARAM value_type_list RPAR { $3 }
;
func_result :
  | /* empty */ { None }
  | LPAR RESULT value_type RPAR { Some $3 }
;
import :
  | LPAR IMPORT bind_var TEXT TEXT func_params func_result RPAR
    { let at = at () in fun c -> bind_import c $3;
      {module_name = $4; func_name = $5; func_params = $6; func_result = $7 }
        @@ at }
  | LPAR IMPORT TEXT TEXT func_params func_result RPAR  /* Sugar */
    { let at = at () in fun c -> anon_import c;
      {module_name = $3; func_name = $4; func_params = $5; func_result = $6 }
        @@ at }
;

export :
  | LPAR EXPORT TEXT var RPAR
    { let at = at () in fun c -> {name = $3; func = $4 c func} @@ at }
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
module_ :
  | LPAR MODULE module_fields RPAR { $3 (c0 ()) @@ at () }
;


/* Scripts */

cmd :
  | module_ { Define $1 @@ at () }
  | LPAR ASSERT_INVALID module_ TEXT RPAR { AssertInvalid ($3, $4) @@ at () }
  | LPAR INVOKE TEXT expr_list RPAR { Invoke ($3, $4 (c0 ())) @@ at () }
  | LPAR ASSERT_RETURN LPAR INVOKE TEXT expr_list RPAR expr RPAR
    { AssertReturn ($5, $6 (c0 ()), $8 (c0 ())) @@ at () }
  | LPAR ASSERT_RETURN_NAN LPAR INVOKE TEXT expr_list RPAR RPAR
    { AssertReturnNaN ($5, $6 (c0 ())) @@ at () }
  | LPAR ASSERT_TRAP LPAR INVOKE TEXT expr_list RPAR TEXT RPAR
    { AssertTrap ($5, $6 (c0 ()), $8) @@ at () }
;
cmd_list :
  | /* empty */ { [] }
  | cmd cmd_list { $1 :: $2 }
;

script :
  | cmd_list EOF { $1 }
;

%%
