%{
open Source
open Types
open Ast
open Operators
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
  {types : types; funcs : space; imports : space;
   locals : space; globals : space; labels : int VarMap.t}

let empty_context () =
  {types = empty_types (); funcs = empty (); imports = empty ();
   locals = empty (); globals = empty (); labels = VarMap.empty}

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
let global c x = lookup "global" c.globals x
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
let bind_global c x = bind "global" c.globals x
let bind_label c x =
  {c with labels = VarMap.add x.it 0 (VarMap.map ((+) 1) c.labels)}

let anon_type c ty =
  c.types.tlist <- c.types.tlist @ [ty]

let anon space n = space.count <- space.count + n

let anon_func c = anon c.funcs 1
let anon_import c = anon c.imports 1
let anon_locals c ts = anon c.locals (List.length ts)
let anon_global c = anon c.globals 1
let anon_label c = {c with labels = VarMap.map ((+) 1) c.labels}

let empty_type = FuncType ([], [])

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

%token NAT INT FLOAT TEXT VAR VALUE_TYPE ANYFUNC LPAR RPAR
%token NOP DROP BLOCK END IF THEN ELSE SELECT LOOP BR BR_IF BR_TABLE
%token CALL CALL_IMPORT CALL_INDIRECT RETURN
%token GET_LOCAL SET_LOCAL TEE_LOCAL GET_GLOBAL SET_GLOBAL
%token LOAD STORE OFFSET_EQ_NAT ALIGN_EQ_NAT
%token CONST UNARY BINARY COMPARE CONVERT
%token UNREACHABLE CURRENT_MEMORY GROW_MEMORY
%token FUNC START TYPE PARAM RESULT LOCAL GLOBAL
%token MODULE TABLE ELEM MEMORY DATA OFFSET IMPORT EXPORT TABLE
%token ASSERT_INVALID ASSERT_RETURN ASSERT_RETURN_NAN ASSERT_TRAP INVOKE
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

func_type :
  | /* empty */
    { FuncType ([], []) }
  | LPAR PARAM value_type_list RPAR
    { FuncType ($3, []) }
  | LPAR PARAM value_type_list RPAR LPAR RESULT value_type_list RPAR
    { FuncType ($3, $7) }
  | LPAR RESULT value_type_list RPAR
    { FuncType ([], $3) }
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

labeling :
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
  | RETURN { fun c -> return }
  | SELECT { fun c -> select }
  | CALL var { fun c -> call ($2 c func) }
  | CALL_IMPORT var { fun c -> call_import ($2 c import) }
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
  | BR nat var { fun c -> br $2 ($3 c label) }
  | BR_IF nat var { fun c -> br_if $2 ($3 c label) }
  | BR_TABLE nat var var_list
    { fun c -> let xs, x = Lib.List.split_last ($3 c label :: $4 c label) in
      br_table $2 xs x }
  | BLOCK labeling instr_list END
    { fun c -> let c' = $2 c in block ($3 c') }
  | LOOP labeling instr_list END
    { fun c -> let c' = $2 c in loop ($3 c') }
  | IF labeling instr_list END
    { fun c -> let c' = $2 c in if_ ($3 c') [] }
  | IF labeling instr_list ELSE labeling instr_list END
    { fun c -> let c1 = $2 c in let c2 = $5 c in if_ ($3 c1) ($6 c2) }
;

expr :  /* Sugar */
  | LPAR expr1 RPAR
    { let at = at () in fun c -> let es, e' = $2 c in es @ [e' @@ at] }
;
expr1 :  /* Sugar */
  | plain_instr expr_list { fun c -> snd ($2 c), $1 c }
  | BR var expr_list { fun c -> let n, es = $3 c in es, br n ($2 c label) }
  | BR_IF var expr expr_list
    { fun c ->
      let es1 = $3 c and n, es2 = $4 c in es1 @ es2, br_if n ($2 c label) }
  | BR_TABLE var var_list expr expr_list
    { fun c -> let xs, x = Lib.List.split_last ($2 c label :: $3 c label) in
      let es1 = $4 c and n, es2 = $5 c in es1 @ es2, br_table n xs x }
  | BLOCK labeling instr_list
    { fun c -> let c' = $2 c in [], block ($3 c') }
  | LOOP labeling instr_list
    { fun c -> let c' = $2 c in [], loop ($3 c') }
  | IF expr expr { fun c -> let c' = anon_label c in $2 c, if_ ($3 c') [] }
  | IF expr expr expr
    { fun c -> let c' = anon_label c in $2 c, if_ ($3 c') ($4 c') }
  | IF expr LPAR THEN labeling instr_list RPAR
    { fun c -> let c' = $5 c in $2 c, if_ ($6 c') [] }
  | IF expr LPAR THEN labeling instr_list RPAR LPAR ELSE labeling instr_list RPAR
    { fun c -> let c1 = $5 c in let c2 = $10 c in $2 c, if_ ($6 c1) ($11 c2) }
  | IF LPAR THEN labeling instr_list RPAR
    { fun c -> let c' = $4 c in [], if_ ($5 c') [] }
  | IF LPAR THEN labeling instr_list RPAR LPAR ELSE labeling instr_list RPAR
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


/* Tables & Memories */

offset :
  | LPAR OFFSET const_expr RPAR { $3 }
  | expr { let at = at () in fun c -> $1 c @@ at }  /* Sugar */
;

elem :
  | LPAR ELEM offset var_list RPAR
    { let at = at () in
      fun c -> {offset = $3 c; init = $4 c func} @@ at }
;

table_limits :
  | NAT { {min = int32 $1 (ati 1); max = None} @@ at () }
  | NAT NAT
    { {min = int32 $1 (ati 1); max = Some (int32 $2 (ati 2))} @@ at () }
;
table :
  | LPAR TABLE table_limits elem_type RPAR
    { let at = at () in fun c -> {tlimits = $3; etype = $4} @@ at, [] }
  | LPAR TABLE elem_type LPAR ELEM var_list RPAR RPAR  /* Sugar */
    { let at = at () in
      fun c -> let init = $6 c func in
      let size = Int32.of_int (List.length init) in
      {tlimits = {min = size; max = Some size} @@ at; etype = $3} @@ at,
      [{offset = [i32_const (0l @@ at) @@ at] @@ at; init} @@ at] }
;

data :
  | LPAR DATA offset text_list RPAR
    { fun c -> {offset = $3 c; init = $4} @@ at () }
;

memory_limits :
  | NAT { {min = int32 $1 (ati 1); max = None} @@ at () }
  | NAT NAT
    { {min = int32 $1 (ati 1); max = Some (int32 $2 (ati 2))} @@ at () }
;
memory :
  | LPAR MEMORY memory_limits RPAR
    { fun c -> {mlimits = $3} @@ at (), [] }
  | LPAR MEMORY LPAR DATA text_list RPAR RPAR  /* Sugar */
    { let at = at () in
      fun c ->
      let size = Int32.(div (add (of_int (String.length $5)) 65535l) 65536l) in
      {mlimits = {min = size; max = Some size} @@ at} @@ at,
      [{offset = [i32_const (0l @@ at) @@ at] @@ at; init = $5} @@ at] }
;


/* Modules */

type_def :
  | LPAR TYPE LPAR FUNC func_type RPAR RPAR
    { fun c -> anon_type c $5 }
  | LPAR TYPE bind_var LPAR FUNC func_type RPAR RPAR
    { fun c -> bind_type c $3 $6 }
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

global :
  | LPAR GLOBAL VALUE_TYPE const_expr RPAR
    { let at = at () in
      fun c -> anon_global c; fun () -> {gtype = $3; value = $4 c} @@ at }
  | LPAR GLOBAL bind_var VALUE_TYPE const_expr RPAR  /* Sugar */
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
        table = None;
        memory = None;
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
      {m with globals = g () :: m.globals} }
  | table module_fields
    { fun c -> let m = $2 c in let tab, elems = $1 c in
      match m.table with
      | Some _ -> error tab.at "multiple table sections"
      | None -> {m with table = Some tab; elems = elems @ m.elems} }
  | memory module_fields
    { fun c -> let m = $2 c in let mem, data = $1 c in
      match m.memory with
      | Some _ -> error mem.at "multiple memory sections"
      | None -> {m with memory = Some mem; data = data @ m.data} }
  | func module_fields
    { fun c -> let f = $1 c in let m = $2 c in let func, exs = f () in
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
  | LPAR ASSERT_RETURN LPAR INVOKE TEXT const_list RPAR const_list RPAR
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
