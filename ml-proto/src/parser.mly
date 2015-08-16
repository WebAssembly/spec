/*
 * (c) 2015 Andreas Rossberg
 */

%{
open Source
open Ast
open Script

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

let literal at s t =
  try
    match t with
    | Types.Int32Type -> Values.Int32 (Int32.of_string s) @@ at
    | Types.Int64Type -> Values.Int64 (Int64.of_string s) @@ at
    | Types.Float32Type -> Values.Float32 (float_of_string s) @@ at
    | Types.Float64Type -> Values.Float64 (float_of_string s) @@ at
  with _ -> Error.error at "constant out of range"
%}

%token INT FLOAT TEXT VAR TYPE LPAR RPAR
%token NOP BLOCK IF LOOP LABEL BREAK SWITCH CASE FALLTHRU
%token CALL DISPATCH RETURN DESTRUCT
%token GETPARAM GETLOCAL SETLOCAL GETGLOBAL SETGLOBAL GETMEMORY SETMEMORY
%token CONST UNARY BINARY COMPARE CONVERT
%token FUNC PARAM RESULT LOCAL MODULE GLOBAL IMPORT EXPORT TABLE
%token MEMORY DEFINE INVOKE
%token EOF

%token<string> INT
%token<string> FLOAT
%token<string> TEXT
%token<int> VAR
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
  | INT
    { try int_of_string $1 @@ at()
      with Invalid_argument _ -> Error.error (at ()) "invalid variable index" }
;
var_list :
  | /* empty */ { [] }
  | var var_list { $1 :: $2 }
;

expr :
  | LPAR expr1 RPAR { $2 @@ at() }
;
expr1 :
  | NOP { Nop }
  | BLOCK expr expr_list { Block ($2 :: $3) }
  | IF expr expr expr { If ($2, $3, $4) }
  | IF expr expr { If ($2, $3, Nop @@ ati 0) }  /* Sugar */
  | LOOP expr_block { Loop $2 }
  | LABEL expr_block { Label $2 }
  | BREAK var expr_list { Break ($2, $3) }
  | BREAK { Break (0 @@ at(), []) }  /* Sugar */
  | SWITCH expr arms
    { let x, y = $3 in Switch ($1 @@ ati 0, $2, List.map (fun a -> a $1) x, y) }
  | CALL var expr_list { Call ($2, $3) }
  | DISPATCH var expr expr_list { Dispatch ($2, $3, $4) }
  | RETURN expr_list { Return $2 }
  | DESTRUCT var_list expr { Destruct ($2, $3) }
  | GETPARAM var { GetParam $2 }
  | GETLOCAL var { GetLocal $2 }
  | SETLOCAL var expr { SetLocal ($2, $3) }
  | GETGLOBAL var { GetGlobal $2 }
  | SETGLOBAL var expr { SetGlobal ($2, $3) }
  | GETMEMORY expr { GetMemory ($1, $2) }
  | SETMEMORY expr expr { SetMemory ($1, $2, $3) }
  | CONST literal { Const (literal (ati 2) $2 $1) }
  | UNARY expr { Unary ($1, $2) }
  | BINARY expr expr { Binary ($1, $2, $3) }
  | COMPARE expr expr { Compare ($1, $2, $3) }
  | CONVERT expr { Convert ($1, $2) }
;
expr_list :
  | /* empty */ { [] }
  | expr expr_list { $1 :: $2 }
;
expr_block :
  | expr { $1 }
  | expr expr expr_list { Block ($1 :: $2 :: $3) @@ at() }  /* Sugar */
;

fallthru :
  | /* empty */ { false }
  | FALLTHRU { true }
;
arm :
  | LPAR CASE literal expr_block fallthru RPAR
    { fun t ->
        {value = literal (ati 3) $3 t; expr = $4; fallthru = $5} @@ at() }
  | LPAR CASE literal RPAR  /* Sugar */
    { fun t ->
        {value = literal (ati 3) $3 t; expr = Nop @@ ati 4; fallthru = true}
          @@ at() }
;
arms :
  | expr { [], $1 }
  | arm arms { let x, y = $2 in $1::x, y }
;


/* Functions */

func_fields :
  | /* empty */  /* Sugar */
    { {params = []; results = []; locals = []; body = Nop @@ at()} }
  | expr_block
    { {params = []; results = []; locals = []; body = $1} }
  | LPAR PARAM value_type_list RPAR func_fields
    { {$5 with params = $3 @ $5.params} }
  | LPAR RESULT value_type_list RPAR func_fields
    { {$5 with results = $3 @ $5.results} }
  | LPAR LOCAL value_type_list RPAR func_fields
    { {$5 with locals = $3 @ $5.locals} }
;
func :
  | LPAR FUNC func_fields RPAR { $3 @@ at() }
;


/* Modules */

module_fields :
  | /* empty */
    { let memory = (Int64.zero, Int64.zero) in
      {memory; funcs = []; exports = []; globals = []; tables = []} }
  | func module_fields
    { {$2 with funcs = $1 :: $2.funcs} }
  | LPAR GLOBAL value_type_list RPAR module_fields
    { {$5 with globals = $3 @ $5.globals} }
  | LPAR EXPORT var_list RPAR module_fields
    { {$5 with exports = $3 @ $5.exports} }
  | LPAR TABLE var_list RPAR module_fields
    { {$5 with tables = ($3 @@ ati 3) :: $5.tables} }
  | LPAR MEMORY INT INT RPAR module_fields
    { {$6 with memory = (Int64.of_string $3, Int64.of_string $4)} }
  | LPAR MEMORY INT RPAR module_fields  /* Sugar */
    { {$5 with memory = (Int64.of_string $3, Int64.of_string $3)} }
;
modul :
  | LPAR MODULE module_fields RPAR { $3 @@ at() }
  | func  /* Sugar */
    { let memory = (Int64.zero, Int64.zero) in
      {funcs = [$1]; exports = [0 @@ at()]; globals = []; tables = []; memory}
        @@ at() }
;


/* Scripts */

cmd :
  | modul { Define $1 @@ at() }
  | LPAR INVOKE INT expr_list RPAR { Invoke (int_of_string $3, $4) @@ at() }
  | LPAR INVOKE expr_list RPAR { Invoke (0, $3) @@ at() }  /* Sugar */
;
cmd_list :
  | /* empty */ { [] }
  | cmd cmd_list { $1 :: $2 }
;

script :
  | cmd_list EOF { $1 }
;

%%
  
