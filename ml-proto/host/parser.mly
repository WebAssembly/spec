/*
 * (c) 2015 Andreas Rossberg
 */

%{
open Source
open Ast
open Sugar
open Types
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
    | Int32Type -> Values.Int32 (I32.of_string s.it) @@ s.at
    | Int64Type -> Values.Int64 (I64.of_string s.it) @@ s.at
    | Float32Type -> Values.Float32 (F32.of_string s.it) @@ s.at
    | Float64Type -> Values.Float64 (F64.of_string s.it) @@ s.at
  with
    | Failure reason -> Error.error s.at ("constant out of range: " ^ reason)
    | _ -> Error.error s.at "constant out of range"

let int32 s =
  try I32.of_string s.it with
    | Failure reason -> Error.error s.at ("constant out of range: " ^ reason)
    | _ -> Error.error s.at "constant out of range"


(* Memory operands *)

let memop m offset align =
  assert (m.offset = 0L);
  assert (m.align = None);
  {m with offset; align}

let extop (e : extop) offset align =
  assert (e.memop.offset = 0L);
  assert (e.memop.align = None);
  {e with memop = {e.memop with offset; align}}

let wrapop (w : wrapop) offset align =
  assert (w.memop.offset = 0L);
  assert (w.memop.align = None);
  {w with memop = {w.memop with offset; align}}


(* Symbolic variables *)

module VarMap = Map.Make(String)

type space = {mutable map : int VarMap.t; mutable count : int}
let empty () = {map = VarMap.empty; count = 0}

type types = {mutable tmap : int VarMap.t; mutable tlist : Types.func_type list}
let empty_types () = {tmap = VarMap.empty; tlist = []}

type context =
  {types : types; funcs : space; imports : space; locals : space;
   labels : int VarMap.t}

let c0 () =
  {types = empty_types (); funcs = empty (); imports = empty ();
   locals = empty (); labels = VarMap.empty}

let enter_func c =
  assert (VarMap.is_empty c.labels);
  {c with labels = VarMap.add "return" 0 c.labels; locals = empty ()}

let type_ c x =
  try VarMap.find x.it c.types.tmap
  with Not_found -> Error.error x.at ("unknown type " ^ x.it)

let lookup category space x =
  try VarMap.find x.it space.map
  with Not_found -> Error.error x.at ("unknown " ^ category ^ " " ^ x.it)

let func c x = lookup "function" c.funcs x
let import c x = lookup "import" c.imports x
let local c x = lookup "local" c.locals x
let label c x =
  try VarMap.find x.it c.labels
  with Not_found -> Error.error x.at ("unknown label " ^ x.it)

let bind_type c x ty =
  if VarMap.mem x.it c.types.tmap then
    Error.error x.at ("duplicate type " ^ x.it);
  c.types.tmap <- VarMap.add x.it (List.length c.types.tlist) c.types.tmap;
  c.types.tlist <- c.types.tlist @ [ty]

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
  if x.it < List.length c.types.tlist &&
     t <> empty_type &&
     t <> List.nth c.types.tlist x.it then
    Error.error at "signature mismatch";
  x

let implicit_decl c t at =
  match Lib.List.index_of t c.types.tlist with
  | None -> let i = List.length c.types.tlist in anon_type c t; i @@ at
  | Some i -> i @@ at

%}

%token INT FLOAT TEXT VAR VALUE_TYPE LPAR RPAR
%token NOP BLOCK IF IF_ELSE LOOP LABEL BRANCH SWITCH CASE DEFAULT
%token IF_BRANCH CASE_BRANCH DEFAULT_BRANCH
%token CALL CALL_IMPORT CALL_INDIRECT RETURN
%token GET_LOCAL SET_LOCAL LOAD STORE LOAD_EXTEND STORE_WRAP OFFSET ALIGN
%token CONST UNARY BINARY COMPARE CONVERT
%token FUNC TYPE PARAM RESULT LOCAL
%token MODULE MEMORY SEGMENT IMPORT EXPORT TABLE
%token PAGE_SIZE MEMORY_SIZE GROW_MEMORY HAS_FEATURE
%token ASSERT_INVALID ASSERT_RETURN ASSERT_RETURN_NAN ASSERT_TRAP INVOKE
%token EOF

%token<string> INT
%token<string> FLOAT
%token<string> TEXT
%token<string> VAR
%token<Types.value_type> VALUE_TYPE
%token<Types.value_type> CONST
%token<Ast.unop> UNARY
%token<Ast.binop> BINARY
%token<Ast.relop> COMPARE
%token<Ast.cvt> CONVERT
%token<Ast.memop> LOAD
%token<Ast.memop> STORE
%token<Ast.extop> LOAD_EXTEND
%token<Ast.wrapop> STORE_WRAP
%token<Memory.offset> OFFSET
%token<int> ALIGN

%nonassoc LOW
%nonassoc VAR

%start script
%type<Script.script> script

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
  | /* empty */ %prec LOW { let at = at () in fun c -> c, Unlabelled @@ at }
  | bind_var { let at = at () in fun c -> bind_label c $1, Labelled @@ at }
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
  | NOP { fun c -> nop }
  | BLOCK labeling expr expr_list
    { fun c -> let c', l = $2 c in block (l, $3 c' :: $4 c') }
  | IF_ELSE expr expr expr { fun c -> if_else ($2 c, $3 c, $4 c) }
  | IF expr expr { fun c -> if_ ($2 c, $3 c) }
  | IF_BRANCH expr var { fun c -> if_branch ($2 c, $3 c label) }
  | LOOP labeling labeling expr_list
    { fun c -> let c', l1 = $2 c in let c'', l2 = $3 c' in
      let c''' = if l1.it = Unlabelled then anon_label c'' else c'' in
      loop (l1, l2, $4 c''') }
  | LABEL labeling expr
    { fun c -> let c', l = $2 c in
      let c'' = if l.it = Unlabelled then anon_label c' else c' in
      Sugar.label ($3 c'') }
  | BRANCH var expr_opt { fun c -> branch ($2 c label, $3 c) }
  | RETURN expr_opt
    { let at1 = ati 1 in
      fun c -> return (label c ("return" @@ at1) @@ at1, $2 c) }
  | SWITCH labeling expr case_list
    { fun c -> let c', l = $2 c in switch (l, $3 c', $4 c') }
  | CALL var expr_list { fun c -> call ($2 c func, $3 c) }
  | CALL_IMPORT var expr_list { fun c -> call_import ($2 c import, $3 c) }
  | CALL_INDIRECT var expr expr_list
    { fun c -> call_indirect ($2 c type_, $3 c, $4 c) }
  | GET_LOCAL var { fun c -> get_local ($2 c local) }
  | SET_LOCAL var expr { fun c -> set_local ($2 c local, $3 c) }
  | LOAD offset align expr
    { fun c -> load (memop $1 $2 $3, $4 c) }
  | STORE offset align expr expr
    { fun c -> store (memop $1 $2 $3, $4 c, $5 c) }
  | LOAD_EXTEND offset align expr
    { fun c -> load_extend (extop $1 $2 $3, $4 c) }
  | STORE_WRAP offset align expr expr
    { fun c -> store_wrap (wrapop $1 $2 $3, $4 c, $5 c) }
  | CONST literal { fun c -> const (literal $2 $1) }
  | UNARY expr { fun c -> unary ($1, $2 c) }
  | BINARY expr expr { fun c -> binary ($1, $2 c, $3 c) }
  | COMPARE expr expr { fun c -> compare ($1, $2 c, $3 c) }
  | CONVERT expr { fun c -> convert ($1, $2 c) }
  | PAGE_SIZE { fun c -> host (PageSize, []) }
  | MEMORY_SIZE { fun c -> host (MemorySize, []) }
  | GROW_MEMORY expr { fun c -> host (GrowMemory, [$2 c]) }
  | HAS_FEATURE TEXT { fun c -> host (HasFeature $2, []) }
;
expr_opt :
  | /* empty */ { fun c -> None }
  | expr { fun c -> Some ($1 c) }
;
expr_list :
  | /* empty */ { fun c -> [] }
  | expr expr_list { fun c -> $1 c :: $2 c }
;

case :
  | LPAR case1 RPAR { let at = at () in fun c -> $2 c @@ at }
;
case1 :
  | CASE literal expr_list { fun c -> case (Some (int32 $2), $3 c) }
  | DEFAULT expr_list { fun c -> case (None, $2 c) }
  | CASE_BRANCH literal var
    { fun c -> case_branch (Some (int32 $2), $3 c label) }
  | DEFAULT_BRANCH var { fun c -> case_branch (None, $2 c label) }
;
case_list :
  | case { fun c -> [$1 c] }
  | case case_list { fun c -> $1 c :: $2 c }
;


/* Functions */

func_fields :
  | expr_list
    { let at = at () in
      empty_type,
      fun c -> let body = Sugar.func_body ($1 c) @@ at in
        {ftype = -1 @@ at; locals = []; body} }
  | LPAR PARAM value_type_list RPAR func_fields
    { {(fst $5) with ins = $3 @ (fst $5).ins},
      fun c -> anon_locals c $3; (snd $5) c }
  | LPAR PARAM bind_var VALUE_TYPE RPAR func_fields  /* Sugar */
    { {(fst $6) with ins = $4 :: (fst $6).ins},
      fun c -> bind_local c $3; (snd $6) c }
  | LPAR RESULT VALUE_TYPE RPAR func_fields
    { if (fst $5).out <> None then
        Error.error (at ()) "more than one return type";
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
      | Some _ -> Error.error $1.at "more than one memory section"
      | None -> {m with memory = Some $1} }
;
module_ :
  | LPAR MODULE module_fields RPAR { $3 (c0 ()) @@ at () }
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
  | LPAR CONST literal RPAR { literal $3 $2 }
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

%%
