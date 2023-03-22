%{
open Source
open Types
open Ast
open Operators
open Script


(* Error handling *)

let error at msg = raise (Script.Syntax (at, msg))

let parse_error msg =
  error Source.no_region
    (if msg = "syntax error" then "unexpected token" else msg)


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

let num f s =
  try f s with Failure _ -> error s.at "constant out of range"

let vec f shape ss at =
  try f shape ss at with
  | Failure _ -> error at "constant out of range"
  | Invalid_argument _ -> error at "wrong number of lane literals"

let vec_lane_nan shape l at =
  let open Value in
  match shape with
  | V128.F32x4 () -> NanPat (F32 l @@ at)
  | V128.F64x2 () -> NanPat (F64 l @@ at)
  | _ -> error at "invalid vector constant"

let vec_lane_lit shape l at =
  let open Value in
  match shape with
  | V128.I8x16 () -> NumPat (I32 (I8.of_string l) @@ at)
  | V128.I16x8 () -> NumPat (I32 (I16.of_string l) @@ at)
  | V128.I32x4 () -> NumPat (I32 (I32.of_string l) @@ at)
  | V128.I64x2 () -> NumPat (I64 (I64.of_string l) @@ at)
  | V128.F32x4 () -> NumPat (F32 (F32.of_string l) @@ at)
  | V128.F64x2 () -> NumPat (F64 (F64.of_string l) @@ at)

let vec_lane_index s at =
  match int_of_string s with
  | n when 0 <= n && n < 256 -> n
  | _ | exception Failure _ -> error at "malformed lane index"

let shuffle_lit ss at =
  if not (List.length ss = 16) then
    error at "invalid lane length";
  List.map (fun s -> vec_lane_index s.it s.at) ss

let nanop f nan =
  let open Source in
  let open Value in
  match snd (f ("0" @@ no_region)) with
  | F32 _ -> F32 nan.it @@ nan.at
  | F64 _ -> F64 nan.it @@ nan.at
  | I32 _ | I64 _ -> error nan.at "NaN pattern with non-float type"

let nat s at =
  try
    let n = int_of_string s in
    if n >= 0 then n else raise (Failure "")
  with Failure _ -> error at "integer constant out of range"

let nat32 s at =
  try I32.of_string_u s with Failure _ -> error at "i32 constant out of range"

let name s at =
  try Utf8.decode s with Utf8.Utf8 -> error at "malformed UTF-8 encoding"


(* Symbolic variables *)

module VarMap = Map.Make(String)

type space = {mutable map : int32 VarMap.t; mutable count : int32}
let empty () = {map = VarMap.empty; count = 0l}

let reset space = space.count <- 0l

let shift category at n i =
  let i' = Int32.add i n in
  if I32.lt_u i' n then
    error at ("too many " ^ category ^ " bindings");
  i'

let bind category space n at =
  let i = space.count in
  space.count <- shift category at n i;
  i

let scoped category n space at =
  {map = VarMap.map (shift category at n) space.map; count = space.count}


type types = {space : space; mutable list : type_ list; mutable ctx : ctx_type list}
let empty_types () = {space = empty (); list = []; ctx = []}

type context =
  { types : types; tables : space; memories : space;
    funcs : space; locals : space; globals : space;
    datas : space; elems : space; labels : space;
    fields : space; deferred_locals : (unit -> unit) list ref
  }

let empty_context () =
  { types = empty_types (); tables = empty (); memories = empty ();
    funcs = empty (); locals = empty (); globals = empty ();
    datas = empty (); elems = empty (); labels = empty ();
    fields = empty (); deferred_locals = ref []
  }

let enter_block (c : context) at = {c with labels = scoped "label" 1l c.labels at}
let enter_let (c : context) at = {c with locals = empty (); deferred_locals = ref []}
let enter_func (c : context) at = {(enter_let c at) with labels = empty ()}
let enter_struct (c : context) = reset c.fields; c

let defer_locals (c : context) f =
  c.deferred_locals := (fun () -> ignore (f ())) :: !(c.deferred_locals)

let force_locals (c : context) =
  List.fold_right Stdlib.(@@) !(c.deferred_locals) ();
  c.deferred_locals := []


let lookup category space x =
  try VarMap.find x.it space.map
  with Not_found -> error x.at ("unknown " ^ category ^ " " ^ x.it)

let type_ (c : context) x = lookup "type" c.types.space x
let func (c : context) x = lookup "function" c.funcs x
let local (c : context) x = lookup "local" c.locals x
let global (c : context) x = lookup "global" c.globals x
let table (c : context) x = lookup "table" c.tables x
let memory (c : context) x = lookup "memory" c.memories x
let elem (c : context) x = lookup "elem segment" c.elems x
let data (c : context) x = lookup "data segment" c.datas x
let label (c : context) x = lookup "label " c.labels x
let field (c : context) x = lookup "field " c.fields x

let func_type (c : context) x =
  match expand_ctx_type (Lib.List32.nth c.types.ctx x.it) with
  | DefFuncT ft -> ft
  | _ -> error x.at ("non-function type " ^ Int32.to_string x.it)
  | exception Failure _ -> error x.at ("unknown type " ^ Int32.to_string x.it)


let bind_abs category space x =
  if VarMap.mem x.it space.map then
    error x.at ("duplicate " ^ category ^ " " ^ x.it);
  let i = bind category space 1l x.at in
  space.map <- VarMap.add x.it i space.map;
  i

let bind_rel category space x =
  ignore (bind category space 1l x.at);
  space.map <- VarMap.add x.it 0l space.map;
  0l

let bind_type (c : context) x = bind_abs "type" c.types.space x
let bind_func (c : context) x = bind_abs "function" c.funcs x
let bind_local (c : context) x = force_locals c; bind_abs "local" c.locals x
let bind_global (c : context) x = bind_abs "global" c.globals x
let bind_table (c : context) x = bind_abs "table" c.tables x
let bind_memory (c : context) x = bind_abs "memory" c.memories x
let bind_elem (c : context) x = bind_abs "elem segment" c.elems x
let bind_data (c : context) x = bind_abs "data segment" c.datas x
let bind_label (c : context) x = bind_rel "label" c.labels x
let bind_field (c : context) x = bind_abs "field" c.fields x

let define_type (c : context) (ty : type_) =
  c.types.list <- c.types.list @ [ty]

let define_ctx_type (c : context) (ct : ctx_type) =
  assert (c.types.space.count > Lib.List32.length c.types.ctx);
  c.types.ctx <- c.types.ctx @ [ct]

let anon_type (c : context) at = bind "type" c.types.space 1l at
let anon_func (c : context) at = bind "function" c.funcs 1l at
let anon_locals (c : context) n at =
  defer_locals c (fun () -> bind "local" c.locals n at)
let anon_global (c : context) at = bind "global" c.globals 1l at
let anon_table (c : context) at = bind "table" c.tables 1l at
let anon_memory (c : context) at = bind "memory" c.memories 1l at
let anon_elem (c : context) at = bind "elem segment" c.elems 1l at
let anon_data (c : context) at = bind "data segment" c.datas 1l at
let anon_label (c : context) at = bind "label" c.labels 1l at
let anon_fields (c : context) n at = bind "field" c.fields n at


let inline_func_type (c : context) ft at =
  let st = SubT (Final, [], DefFuncT ft) in
  match
    Lib.List.index_where (function
      | CtxT ([(_, st')], 0l) -> st = st'
      | _ -> false
      ) c.types.ctx
  with
  | Some i -> Int32.of_int i @@ at
  | None ->
    let i = anon_type c at in
    let x = Types.alloc_uninit () in
    Types.init x (CtxT ([(DynX x, st)], 0l));
    define_type c (RecT [st] @@ at);
    define_ctx_type c (def_of x);
    i @@ at

let inline_func_type_explicit (c : context) x ft at =
  if ft = FuncT ([], []) then
    (* Deferring ensures that type lookup is only triggered when
       symbolic identifiers are used, and not for desugared functions *)
    defer_locals c (fun () ->
      let FuncT (ts1, _ts2) = func_type c x in
      bind "local" c.locals (Lib.List32.length ts1) at
    )
  else if ft <> func_type c x then
    error at "inline function type does not match explicit type";
  x

%}

%token LPAR RPAR
%token NAT INT FLOAT STRING VAR
%token NUM_TYPE PACK_TYPE VEC_TYPE VEC_SHAPE
%token ANYREF NULLREF EQREF I31REF STRUCTREF ARRAYREF
%token FUNCREF NULLFUNCREF EXTERNREF NULLEXTERNREF
%token ANY NONE EQ I31 REF NOFUNC EXTERN NOEXTERN NULL
%token MUT FIELD STRUCT ARRAY SUB FINAL REC
%token UNREACHABLE NOP DROP SELECT
%token BLOCK END IF THEN ELSE LOOP
%token BR BR_IF BR_TABLE BR_ON_NULL BR_ON_NON_NULL BR_ON_CAST
%token CALL CALL_REF CALL_INDIRECT RETURN RETURN_CALL_REF
%token LOCAL_GET LOCAL_SET LOCAL_TEE GLOBAL_GET GLOBAL_SET
%token TABLE_GET TABLE_SET
%token TABLE_SIZE TABLE_GROW TABLE_FILL TABLE_COPY TABLE_INIT ELEM_DROP
%token MEMORY_SIZE MEMORY_GROW MEMORY_FILL MEMORY_COPY MEMORY_INIT DATA_DROP
%token LOAD STORE OFFSET_EQ_NAT ALIGN_EQ_NAT
%token CONST UNARY BINARY TEST COMPARE CONVERT
%token REF_NULL REF_FUNC REF_I31 REF_STRUCT REF_ARRAY REF_EXTERN REF_HOST
%token REF_EQ REF_IS_NULL REF_AS_NON_NULL REF_TEST REF_CAST
%token I31_NEW I32_GET
%token STRUCT_NEW STRUCT_GET STRUCT_SET
%token ARRAY_NEW ARRAY_NEW_FIXED ARRAY_NEW_ELEM ARRAY_NEW_DATA
%token ARRAY_GET ARRAY_SET ARRAY_LEN
%token EXTERN_CONVERT
%token VEC_LOAD VEC_STORE VEC_LOAD_LANE VEC_STORE_LANE
%token VEC_CONST VEC_UNARY VEC_BINARY VEC_TERNARY VEC_TEST
%token VEC_SHIFT VEC_BITMASK VEC_SHUFFLE
%token VEC_EXTRACT VEC_REPLACE
%token FUNC START TYPE PARAM RESULT LOCAL GLOBAL
%token TABLE ELEM MEMORY DATA DECLARE OFFSET ITEM IMPORT EXPORT
%token MODULE BIN QUOTE
%token SCRIPT REGISTER INVOKE GET
%token ASSERT_MALFORMED ASSERT_INVALID ASSERT_SOFT_INVALID ASSERT_UNLINKABLE
%token ASSERT_RETURN ASSERT_TRAP ASSERT_EXHAUSTION
%token NAN
%token INPUT OUTPUT
%token EOF

%token<string> NAT
%token<string> INT
%token<string> FLOAT
%token<string> STRING
%token<string> VAR
%token<Types.num_type> NUM_TYPE
%token<Types.vec_type> VEC_TYPE
%token<Pack.pack_size> PACK_TYPE
%token<Ast.idx -> Ast.instr'> BR_ON_NULL
%token<Ast.idx -> Types.ref_type -> Types.ref_type -> Ast.instr'> BR_ON_CAST
%token<Ast.instr'> I31_GET
%token<Ast.idx -> Ast.idx -> Ast.instr'> STRUCT_GET
%token<Ast.idx -> Ast.instr'> ARRAY_GET
%token<Ast.idx -> Ast.instr'> STRUCT_NEW ARRAY_NEW
%token<string Source.phrase -> Ast.instr' * Value.num> CONST
%token<V128.shape -> string Source.phrase list -> Source.region -> Ast.instr' * Value.vec> VEC_CONST
%token<Ast.instr'> UNARY
%token<Ast.instr'> BINARY
%token<Ast.instr'> TEST
%token<Ast.instr'> COMPARE
%token<Ast.instr'> CONVERT
%token<Ast.instr'> EXTERN_CONVERT
%token<int option -> Memory.offset -> Ast.instr'> LOAD
%token<int option -> Memory.offset -> Ast.instr'> STORE
%token<int option -> Memory.offset -> Ast.instr'> VEC_LOAD
%token<int option -> Memory.offset -> Ast.instr'> VEC_STORE
%token<int option -> Memory.offset -> int -> Ast.instr'> VEC_LOAD_LANE
%token<int option -> Memory.offset -> int -> Ast.instr'> VEC_STORE_LANE
%token<Ast.instr'> VEC_UNARY
%token<Ast.instr'> VEC_BINARY
%token<Ast.instr'> VEC_TERNARY
%token<Ast.instr'> VEC_TEST
%token<Ast.instr'> VEC_SHIFT
%token<Ast.instr'> VEC_BITMASK
%token<Ast.instr'> VEC_SPLAT
%token<int -> Ast.instr'> VEC_EXTRACT
%token<int -> Ast.instr'> VEC_REPLACE
%token<string> OFFSET_EQ_NAT
%token<string> ALIGN_EQ_NAT
%token<V128.shape> VEC_SHAPE

%token<Script.nan> NAN

%nonassoc LOW
%nonassoc VAR

%start script script1 module1
%type<Script.script> script
%type<Script.script> script1
%type<Script.var option * Script.definition> module1

%%

/* Auxiliaries */

name :
  | STRING { name $1 (at ()) }

string_list :
  | /* empty */ { "" }
  | string_list STRING { $1 ^ $2 }


/* Types */

null_opt :
  | /* empty */ { NoNull }
  | NULL { Null }

heap_type :
  | ANY { fun c -> AnyHT }
  | NONE { fun c -> NoneHT }
  | EQ { fun c -> EqHT }
  | I31 { fun c -> I31HT }
  | STRUCT { fun c -> StructHT }
  | ARRAY { fun c -> ArrayHT }
  | FUNC { fun c -> FuncHT }
  | NOFUNC { fun c -> NoFuncHT }
  | EXTERN { fun c -> ExternHT }
  | NOEXTERN { fun c -> NoExternHT }
  | var { fun c -> DefHT (StatX ($1 c type_).it) }

ref_type :
  | LPAR REF null_opt heap_type RPAR { fun c -> ($3, $4 c) }
  | ANYREF { fun c -> (Null, AnyHT) }  /* Sugar */
  | NULLREF { fun c -> (Null, NoneHT) }  /* Sugar */
  | EQREF { fun c -> (Null, EqHT) }  /* Sugar */
  | I31REF { fun c -> (Null, I31HT) }  /* Sugar */
  | STRUCTREF { fun c -> (Null, StructHT) }  /* Sugar */
  | ARRAYREF { fun c -> (Null, ArrayHT) }  /* Sugar */
  | FUNCREF { fun c -> (Null, FuncHT) }  /* Sugar */
  | NULLFUNCREF { fun c -> (Null, NoFuncHT) }  /* Sugar */
  | EXTERNREF { fun c -> (Null, ExternHT) }  /* Sugar */
  | NULLEXTERNREF { fun c -> (Null, NoExternHT) }  /* Sugar */

val_type :
  | NUM_TYPE { fun c -> NumT $1 }
  | VEC_TYPE { fun c -> VecT $1 }
  | ref_type { fun c -> RefT ($1 c) }

val_type_list :
  | /* empty */ { 0l, fun c -> [] }
  | val_type val_type_list { I32.add (fst $2) 1l, fun c -> $1 c :: snd $2 c }

global_type :
  | val_type { fun c -> GlobalT (Cons, $1 c) }
  | LPAR MUT val_type RPAR { fun c -> GlobalT (Var, $3 c) }

storage_type :
  | val_type { fun c -> ValStorageT ($1 c) }
  | PACK_TYPE { fun c -> PackStorageT $1 }

field_type :
  | storage_type { fun c -> FieldT (Cons, $1 c) }
  | LPAR MUT storage_type RPAR { fun c -> FieldT (Var, $3 c) }

field_type_list :
  | /* empty */ { fun c -> [] }
  | field_type field_type_list { fun c -> $1 c :: $2 c }

struct_field_list :
  | /* empty */ { fun c -> [] }
  | LPAR FIELD field_type_list RPAR struct_field_list
    { let at3 = ati 3 in
      fun c -> let fts = $3 c in
      ignore (anon_fields c (Lib.List32.length fts) at3); fts @ $5 c }
  | LPAR FIELD bind_var field_type RPAR struct_field_list
    { fun c -> ignore (bind_field c $3); $4 c :: $6 c }

struct_type :
  | struct_field_list { fun c -> let c' = enter_struct c in StructT ($1 c') }

array_type :
  | field_type { fun c -> ArrayT ($1 c) }

func_type :
  | func_type_result
    { fun c -> FuncT ([], $1 c) }
  | LPAR PARAM val_type_list RPAR func_type
    { fun c -> let FuncT (ts1, ts2) = $5 c in
      FuncT (snd $3 c @ ts1, ts2) }
  | LPAR PARAM bind_var val_type RPAR func_type  /* Sugar */
    { fun c -> let FuncT (ts1, ts2) = $6 c in
      FuncT ($4 c :: ts1, ts2) }

func_type_result :
  | /* empty */
    { fun c -> [] }
  | LPAR RESULT val_type_list RPAR func_type_result
    { fun c -> snd $3 c @ $5 c }

str_type :
  | LPAR STRUCT struct_type RPAR { fun c -> DefStructT ($3 c) }
  | LPAR ARRAY array_type RPAR { fun c -> DefArrayT ($3 c) }
  | LPAR FUNC func_type RPAR { fun c -> DefFuncT ($3 c) }

sub_type :
  | str_type { fun c -> SubT (Final, [], $1 c) }
  | LPAR SUB var_list str_type RPAR
    { fun c -> SubT (NoFinal, List.map (fun x -> StatX x.it) ($3 c type_), $4 c) }
  | LPAR SUB FINAL var_list str_type RPAR
    { fun c -> SubT (Final, List.map (fun x -> StatX x.it) ($4 c type_), $5 c) }

table_type :
  | limits ref_type { fun c -> TableT ($1, $2 c) }

memory_type :
  | limits { fun c -> MemoryT $1 }

limits :
  | NAT { {min = nat32 $1 (ati 1); max = None} }
  | NAT NAT { {min = nat32 $1 (ati 1); max = Some (nat32 $2 (ati 2))} }

type_use :
  | LPAR TYPE var RPAR { fun c -> $3 c type_ }


/* Immediates */

nat32 :
  | NAT { nat32 $1 (at ()) }

num :
  | NAT { $1 @@ at () }
  | INT { $1 @@ at () }
  | FLOAT { $1 @@ at () }

num_list:
  | /* empty */ { [] }
  | num num_list { $1 :: $2 }

var :
  | NAT { let at = at () in fun c lookup -> nat32 $1 at @@ at }
  | VAR { let at = at () in fun c lookup -> lookup c ($1 @@ at) @@ at }

var_list :
  | /* empty */ { fun c lookup -> [] }
  | var var_list { fun c lookup -> $1 c lookup :: $2 c lookup }

bind_var_opt :
  | /* empty */ { let at = at () in fun c anon bind -> anon c at }
  | bind_var { fun c anon bind -> bind c $1 }  /* Sugar */

bind_var :
  | VAR { $1 @@ at () }

labeling_opt :
  | /* empty */ %prec LOW
    { let at = at () in
      fun c xs ->
      List.iter (fun x -> error x.at "mismatching label") xs;
      let c' = enter_block c at in ignore (anon_label c' at); c' }
  | bind_var
    { let at = at () in
      fun c xs ->
      List.iter
        (fun x -> if x.it <> $1.it then error x.at "mismatching label") xs;
      let c' = enter_block c at in ignore (bind_label c' $1); c' }

labeling_end_opt :
  | /* empty */ %prec LOW { [] }
  | bind_var { [$1] }

offset_opt :
  | /* empty */ { 0l }
  | OFFSET_EQ_NAT { nat32 $1 (at ()) }

align_opt :
  | /* empty */ { None }
  | ALIGN_EQ_NAT
    { let n = nat $1 (at ()) in
      if not (Lib.Int.is_power_of_two n) then
        error (at ()) "alignment must be a power of two";
      Some (Lib.Int.log2 n) }


/* Instructions & Expressions */

instr :
  | plain_instr { let at = at () in fun c -> [$1 c @@ at] }
  | select_instr_instr { fun c -> let e, es = $1 c in e :: es }
  | call_instr_instr { fun c -> let e, es = $1 c in e :: es }
  | block_instr { let at = at () in fun c -> [$1 c @@ at] }
  | expr { $1 } /* Sugar */

plain_instr :
  | UNREACHABLE { fun c -> unreachable }
  | NOP { fun c -> nop }
  | DROP { fun c -> drop }
  | BR var { fun c -> br ($2 c label) }
  | BR_IF var { fun c -> br_if ($2 c label) }
  | BR_TABLE var var_list
    { fun c -> let xs, x = Lib.List.split_last ($2 c label :: $3 c label) in
      br_table xs x }
  | BR_ON_NULL var { fun c -> $1 ($2 c label) }
  | BR_ON_CAST var ref_type ref_type { fun c -> $1 ($2 c label) ($3 c) ($4 c) }
  | RETURN { fun c -> return }
  | CALL var { fun c -> call ($2 c func) }
  | CALL_REF var { fun c -> call_ref ($2 c type_) }
  | RETURN_CALL_REF var { fun c -> return_call_ref ($2 c type_) }
  | LOCAL_GET var { fun c -> local_get ($2 c local) }
  | LOCAL_SET var { fun c -> local_set ($2 c local) }
  | LOCAL_TEE var { fun c -> local_tee ($2 c local) }
  | GLOBAL_GET var { fun c -> global_get ($2 c global) }
  | GLOBAL_SET var { fun c -> global_set ($2 c global) }
  | TABLE_GET var { fun c -> table_get ($2 c table) }
  | TABLE_SET var { fun c -> table_set ($2 c table) }
  | TABLE_SIZE var { fun c -> table_size ($2 c table) }
  | TABLE_GROW var { fun c -> table_grow ($2 c table) }
  | TABLE_FILL var { fun c -> table_fill ($2 c table) }
  | TABLE_COPY var var { fun c -> table_copy ($2 c table) ($3 c table) }
  | TABLE_INIT var var { fun c -> table_init ($2 c table) ($3 c elem) }
  | TABLE_GET { let at = at () in fun c -> table_get (0l @@ at) }  /* Sugar */
  | TABLE_SET { let at = at () in fun c -> table_set (0l @@ at) }  /* Sugar */
  | TABLE_SIZE { let at = at () in fun c -> table_size (0l @@ at) }  /* Sugar */
  | TABLE_GROW { let at = at () in fun c -> table_grow (0l @@ at) }  /* Sugar */
  | TABLE_FILL { let at = at () in fun c -> table_fill (0l @@ at) }  /* Sugar */
  | TABLE_COPY  /* Sugar */
    { let at = at () in fun c -> table_copy (0l @@ at) (0l @@ at) }
  | TABLE_INIT var  /* Sugar */
    { let at = at () in fun c -> table_init (0l @@ at) ($2 c elem) }
  | ELEM_DROP var { fun c -> elem_drop ($2 c elem) }
  | LOAD offset_opt align_opt { fun c -> $1 $3 $2 }
  | STORE offset_opt align_opt { fun c -> $1 $3 $2 }
  | VEC_LOAD offset_opt align_opt { fun c -> $1 $3 $2 }
  | VEC_STORE offset_opt align_opt { fun c -> $1 $3 $2 }
  | VEC_LOAD_LANE offset_opt align_opt NAT
    { let at = at () in fun c -> $1 $3 $2 (vec_lane_index $4 at) }
  | VEC_STORE_LANE offset_opt align_opt NAT
    { let at = at () in fun c -> $1 $3 $2 (vec_lane_index $4 at) }
  | MEMORY_SIZE { fun c -> memory_size }
  | MEMORY_GROW { fun c -> memory_grow }
  | MEMORY_FILL { fun c -> memory_fill }
  | MEMORY_COPY { fun c -> memory_copy }
  | MEMORY_INIT var { fun c -> memory_init ($2 c data) }
  | DATA_DROP var { fun c -> data_drop ($2 c data) }
  | REF_NULL heap_type { fun c -> ref_null ($2 c) }
  | REF_FUNC var { fun c -> ref_func ($2 c func) }
  | REF_IS_NULL { fun c -> ref_is_null }
  | REF_AS_NON_NULL { fun c -> ref_as_non_null }
  | REF_TEST ref_type { fun c -> ref_test ($2 c) }
  | REF_CAST ref_type { fun c -> ref_cast ($2 c) }
  | REF_EQ { fun c -> ref_eq }
  | I31_NEW { fun c -> i31_new }
  | I31_GET { fun c -> $1 }
  | STRUCT_NEW var { fun c -> $1 ($2 c type_) }
  | STRUCT_GET var var { fun c -> $1 ($2 c type_) ($3 c field) }
  | STRUCT_SET var var { fun c -> struct_set ($2 c type_) ($3 c field) }
  | ARRAY_NEW var { fun c -> $1 ($2 c type_) }
  | ARRAY_NEW_FIXED var nat32 { fun c -> array_new_fixed ($2 c type_) $3 }
  | ARRAY_NEW_ELEM var var { fun c -> array_new_elem ($2 c type_) ($3 c elem) }
  | ARRAY_NEW_DATA var var { fun c -> array_new_data ($2 c type_) ($3 c data) }
  | ARRAY_GET var { fun c -> $1 ($2 c type_) }
  | ARRAY_SET var { fun c -> array_set ($2 c type_) }
  | ARRAY_LEN { fun c -> array_len }
  | EXTERN_CONVERT { fun c -> $1 }
  | CONST num { fun c -> fst (num $1 $2) }
  | TEST { fun c -> $1 }
  | COMPARE { fun c -> $1 }
  | UNARY { fun c -> $1 }
  | BINARY { fun c -> $1 }
  | CONVERT { fun c -> $1 }
  | VEC_CONST VEC_SHAPE num_list { let at = at () in fun c -> fst (vec $1 $2 $3 at) }
  | VEC_UNARY { fun c -> $1 }
  | VEC_BINARY { fun c -> $1 }
  | VEC_TERNARY { fun c -> $1 }
  | VEC_TEST { fun c -> $1 }
  | VEC_SHIFT { fun c -> $1 }
  | VEC_BITMASK { fun c -> $1 }
  | VEC_SHUFFLE num_list { let at = at () in fun c -> i8x16_shuffle (shuffle_lit $2 at) }
  | VEC_SPLAT { fun c -> $1 }
  | VEC_EXTRACT NAT { let at = at () in fun c -> $1 (vec_lane_index $2 at) }
  | VEC_REPLACE NAT { let at = at () in fun c -> $1 (vec_lane_index $2 at) }


select_instr :
  | SELECT select_instr_results
    { let at = at () in fun c -> let b, ts = $2 c in
      select (if b then (Some ts) else None) @@ at }

select_instr_results :
  | LPAR RESULT val_type_list RPAR select_instr_results
    { fun c -> let _, ts = $5 c in true, snd $3 c @ ts }
  | /* empty */
    { fun c -> false, [] }

select_instr_instr :
  | SELECT select_instr_results_instr
    { let at1 = ati 1 in
      fun c -> let b, ts, es = $2 c in
      select (if b then (Some ts) else None) @@ at1, es }

select_instr_results_instr :
  | LPAR RESULT val_type_list RPAR select_instr_results_instr
    { fun c -> let _, ts, es = $5 c in true, snd $3 c @ ts, es }
  | instr
    { fun c -> false, [], $1 c }


call_instr :
  | CALL_INDIRECT var call_instr_type
    { let at = at () in fun c -> call_indirect ($2 c table) ($3 c) @@ at }
  | CALL_INDIRECT call_instr_type  /* Sugar */
    { let at = at () in fun c -> call_indirect (0l @@ at) ($2 c) @@ at }

call_instr_type :
  | type_use call_instr_params
    { let at1 = ati 1 in
      fun c ->
      match $2 c with
      | FuncT ([], []) -> $1 c
      | ft -> inline_func_type_explicit c ($1 c) ft at1 }
  | call_instr_params
    { let at = at () in fun c -> inline_func_type c ($1 c) at }

call_instr_params :
  | LPAR PARAM val_type_list RPAR call_instr_params
    { fun c -> let FuncT (ts1, ts2) = $5 c in FuncT (snd $3 c @ ts1, ts2) }
  | call_instr_results
    { fun c -> FuncT ([], $1 c) }

call_instr_results :
  | LPAR RESULT val_type_list RPAR call_instr_results
    { fun c -> snd $3 c @ $5 c }
  | /* empty */
    { fun c -> [] }


call_instr_instr :
  | CALL_INDIRECT var call_instr_type_instr
    { let at1 = ati 1 in
      fun c -> let x, es = $3 c in call_indirect ($2 c table) x @@ at1, es }
  | CALL_INDIRECT call_instr_type_instr  /* Sugar */
    { let at1 = ati 1 in
      fun c -> let x, es = $2 c in call_indirect (0l @@ at1) x @@ at1, es }

call_instr_type_instr :
  | type_use call_instr_params_instr
    { let at1 = ati 1 in
      fun c ->
      match $2 c with
      | FuncT ([], []), es -> $1 c, es
      | ft, es -> inline_func_type_explicit c ($1 c) ft at1, es }
  | call_instr_params_instr
    { let at = at () in
      fun c -> let ft, es = $1 c in inline_func_type c ft at, es }

call_instr_params_instr :
  | LPAR PARAM val_type_list RPAR call_instr_params_instr
    { fun c -> let FuncT (ts1, ts2), es = $5 c in
      FuncT (snd $3 c @ ts1, ts2), es }
  | call_instr_results_instr
    { fun c -> let ts, es = $1 c in FuncT ([], ts), es }

call_instr_results_instr :
  | LPAR RESULT val_type_list RPAR call_instr_results_instr
    { fun c -> let ts, es = $5 c in snd $3 c @ ts, es }
  | instr
    { fun c -> [], $1 c }


block_instr :
  | BLOCK labeling_opt block END labeling_end_opt
    { fun c -> let c' = $2 c $5 in let bt, es = $3 c' in block bt es }
  | LOOP labeling_opt block END labeling_end_opt
    { fun c -> let c' = $2 c $5 in let bt, es = $3 c' in loop bt es }
  | IF labeling_opt block END labeling_end_opt
    { fun c -> let c' = $2 c $5 in let bt, es = $3 c' in if_ bt es [] }
  | IF labeling_opt block ELSE labeling_end_opt instr_list END labeling_end_opt
    { fun c -> let c' = $2 c ($5 @ $8) in
      let ts, es1 = $3 c' in if_ ts es1 ($6 c') }

block :
  | type_use block_param_body
    { let at1 = ati 1 in
      fun c -> let ft, es = $2 c in
      let x = inline_func_type_explicit c ($1 c) ft at1 in
      VarBlockType x, es }
  | block_param_body  /* Sugar */
    { let at = at () in
      fun c -> let ft, es = $1 c in
      let bt =
        match ft with
        | FuncT ([], []) -> ValBlockType None
        | FuncT ([], [t]) -> ValBlockType (Some t)
        | ft ->  VarBlockType (inline_func_type c ft at)
      in bt, es }

block_param_body :
  | block_result_body { $1 }
  | LPAR PARAM val_type_list RPAR block_param_body
    { fun c -> let FuncT (ts1, ts2), es = $5 c in
      FuncT (snd $3 c @ ts1, ts2), es }

block_result_body :
  | instr_list { fun c -> FuncT ([], []), $1 c }
  | LPAR RESULT val_type_list RPAR block_result_body
    { fun c -> let FuncT (ts1, ts2), es = $5 c in
      FuncT (ts1, snd $3 c @ ts2), es }


expr :  /* Sugar */
  | LPAR expr1 RPAR
    { let at = at () in fun c -> let es, e' = $2 c in es @ [e' @@ at] }

expr1 :  /* Sugar */
  | plain_instr expr_list { fun c -> $2 c, $1 c }
  | SELECT select_expr_results
    { fun c -> let b, ts, es = $2 c in es, select (if b then (Some ts) else None) }
  | CALL_INDIRECT var call_expr_type
    { fun c -> let x, es = $3 c in es, call_indirect ($2 c table) x }
  | CALL_INDIRECT call_expr_type  /* Sugar */
    { let at1 = ati 1 in
      fun c -> let x, es = $2 c in es, call_indirect (0l @@ at1) x }
  | BLOCK labeling_opt block
    { fun c -> let c' = $2 c [] in let bt, es = $3 c' in [], block bt es }
  | LOOP labeling_opt block
    { fun c -> let c' = $2 c [] in let bt, es = $3 c' in [], loop bt es }
  | IF labeling_opt if_block
    { fun c -> let c' = $2 c [] in
      let bt, (es, es1, es2) = $3 c c' in es, if_ bt es1 es2 }

select_expr_results :
  | LPAR RESULT val_type_list RPAR select_expr_results
    { fun c -> let _, ts, es = $5 c in true, snd $3 c @ ts, es }
  | expr_list
    { fun c -> false, [], $1 c }

call_expr_type :
  | type_use call_expr_params
    { let at1 = ati 1 in
      fun c ->
      match $2 c with
      | FuncT ([], []), es -> $1 c, es
      | ft, es -> inline_func_type_explicit c ($1 c) ft at1, es }
  | call_expr_params
    { let at1 = ati 1 in
      fun c -> let ft, es = $1 c in inline_func_type c ft at1, es }

call_expr_params :
  | LPAR PARAM val_type_list RPAR call_expr_params
    { fun c -> let FuncT (ts1, ts2), es = $5 c in
      FuncT (snd $3 c @ ts1, ts2), es }
  | call_expr_results
    { fun c -> let ts, es = $1 c in FuncT ([], ts), es }

call_expr_results :
  | LPAR RESULT val_type_list RPAR call_expr_results
    { fun c -> let ts, es = $5 c in snd $3 c @ ts, es }
  | expr_list
    { fun c -> [], $1 c }


if_block :
  | type_use if_block_param_body
    { let at = at () in
      fun c c' -> let ft, es = $2 c c' in
      let x = inline_func_type_explicit c ($1 c) ft at in
      VarBlockType x, es }
  | if_block_param_body  /* Sugar */
    { let at = at () in
      fun c c' -> let ft, es = $1 c c' in
      let bt =
        match ft with
        | FuncT ([], []) -> ValBlockType None
        | FuncT ([], [t]) -> ValBlockType (Some t)
        | ft ->  VarBlockType (inline_func_type c ft at)
      in bt, es }

if_block_param_body :
  | if_block_result_body { $1 }
  | LPAR PARAM val_type_list RPAR if_block_param_body
    { fun c c' -> let FuncT (ts1, ts2), es = $5 c c' in
      FuncT (snd $3 c @ ts1, ts2), es }

if_block_result_body :
  | if_ { fun c c' -> FuncT ([], []), $1 c c' }
  | LPAR RESULT val_type_list RPAR if_block_result_body
    { fun c c' -> let FuncT (ts1, ts2), es = $5 c c' in
      FuncT (ts1, snd $3 c @ ts2), es }

if_ :
  | expr if_
    { fun c c' -> let es = $1 c in let es0, es1, es2 = $2 c c' in
      es @ es0, es1, es2 }
  | LPAR THEN instr_list RPAR LPAR ELSE instr_list RPAR  /* Sugar */
    { fun c c' -> [], $3 c', $7 c' }
  | LPAR THEN instr_list RPAR  /* Sugar */
    { fun c c' -> [], $3 c', [] }

instr_list :
  | /* empty */ { fun c -> [] }
  | select_instr { fun c -> [$1 c] }
  | call_instr { fun c -> [$1 c] }
  | instr instr_list { fun c -> $1 c @ $2 c }

expr_list :
  | /* empty */ { fun c -> [] }
  | expr expr_list { fun c -> $1 c @ $2 c }

const_expr :
  | instr_list { let at = at () in fun c -> $1 c @@ at }

const_expr1 :
  | instr instr_list { let at = at () in fun c -> ($1 c @ $2 c) @@ at }


/* Functions */

func :
  | LPAR FUNC bind_var_opt func_fields RPAR
    { let at = at () in
      fun c -> let x = $3 c anon_func bind_func @@ at in fun () -> $4 c x at }

func_fields :
  | type_use func_fields_body
    { fun c x at ->
      let c' = enter_func c at in
      let y = inline_func_type_explicit c' ($1 c') (fst $2 c') at in
      [{(snd $2 c') with ftype = y} @@ at], [], [] }
  | func_fields_body  /* Sugar */
    { fun c x at ->
      let c' = enter_func c at in
      let y = inline_func_type c' (fst $1 c') at in
      [{(snd $1 c') with ftype = y} @@ at], [], [] }
  | inline_import type_use func_fields_import  /* Sugar */
    { fun c x at ->
      let y = inline_func_type_explicit c ($2 c) ($3 c) at in
      [],
      [{ module_name = fst $1; item_name = snd $1;
         idesc = FuncImport y @@ at } @@ at ], [] }
  | inline_import func_fields_import  /* Sugar */
    { fun c x at ->
      let y = inline_func_type c ($2 c) at in
      [],
      [{ module_name = fst $1; item_name = snd $1;
         idesc = FuncImport y @@ at } @@ at ], [] }
  | inline_export func_fields  /* Sugar */
    { fun c x at ->
      let fns, ims, exs = $2 c x at in fns, ims, $1 (FuncExport x) c :: exs }

func_fields_import :  /* Sugar */
  | func_fields_import_result { $1 }
  | LPAR PARAM val_type_list RPAR func_fields_import
    { fun c -> let FuncT (ts1, ts2) = $5 c in FuncT (snd $3 c @ ts1, ts2) }
  | LPAR PARAM bind_var val_type RPAR func_fields_import  /* Sugar */
    { fun c -> let FuncT (ts1, ts2) = $6 c in FuncT ($4 c :: ts1, ts2) }

func_fields_import_result :  /* Sugar */
  | /* empty */ { fun c -> FuncT ([], []) }
  | LPAR RESULT val_type_list RPAR func_fields_import_result
    { fun c -> let FuncT (ts1, ts2) = $5 c in FuncT (ts1, snd $3 c @ ts2) }

func_fields_body :
  | func_result_body { $1 }
  | LPAR PARAM val_type_list RPAR func_fields_body
    { let at3 = ati 3 in
      (fun c -> let FuncT (ts1, ts2) = fst $5 c in
        FuncT (snd $3 c @ ts1, ts2)),
      (fun c -> anon_locals c (fst $3) at3; snd $5 c) }
  | LPAR PARAM bind_var val_type RPAR func_fields_body  /* Sugar */
    { (fun c -> let FuncT (ts1, ts2) = fst $6 c in
        FuncT ($4 c :: ts1, ts2)),
      (fun c -> ignore (bind_local c $3); snd $6 c) }

func_result_body :
  | func_body { (fun c -> FuncT ([], [])), $1 }
  | LPAR RESULT val_type_list RPAR func_result_body
    { (fun c -> let FuncT (ts1, ts2) = fst $5 c in
        FuncT (ts1, snd $3 c @ ts2)),
      snd $5 }

func_body :
  | instr_list
    { let at = at () in
      fun c -> ignore (anon_label c at);
      {ftype = -1l @@ at; locals = []; body = $1 c} }
  | LPAR LOCAL local_type_list RPAR func_body
    { let at3 = ati 3 in
      fun c -> anon_locals c (fst $3) at3; let f = $5 c in
      {f with locals = snd $3 c @ f.locals} }
  | LPAR LOCAL bind_var local_type RPAR func_body  /* Sugar */
    { fun c -> ignore (bind_local c $3); let f = $6 c in
      {f with locals = $4 c :: f.locals} }

local_type :
  | val_type { let at = at () in fun c -> {ltype = $1 c} @@ at }

local_type_list :
  | /* empty */ { 0l, fun c -> [] }
  | local_type local_type_list { I32.add (fst $2) 1l, fun c -> $1 c :: snd $2 c }


/* Tables, Memories & Globals */

table_use :
  | LPAR TABLE var RPAR { fun c -> $3 c }

memory_use :
  | LPAR MEMORY var RPAR { fun c -> $3 c }

offset :
  | LPAR OFFSET const_expr RPAR { $3 }
  | expr { let at = at () in fun c -> $1 c @@ at }  /* Sugar */

elem_kind :
  | FUNC { (NoNull, FuncHT) }

elem_expr :
  | LPAR ITEM const_expr RPAR { $3 }
  | expr { let at = at () in fun c -> $1 c @@ at }  /* Sugar */

elem_expr_list :
  | /* empty */ { fun c -> [] }
  | elem_expr elem_expr_list { fun c -> $1 c :: $2 c }

elem_var_list :
  | var_list
    { let f = function {at; _} as x -> [ref_func x @@ at] @@ at in
      fun c lookup -> List.map f ($1 c lookup) }

elem_list :
  | elem_kind elem_var_list
    { fun c -> $1, $2 c func }
  | ref_type elem_expr_list
    { fun c -> $1 c, $2 c }


elem :
  | LPAR ELEM bind_var_opt elem_list RPAR
    { let at = at () in
      fun c -> ignore ($3 c anon_elem bind_elem);
      fun () -> let etype, einit = $4 c in
      { etype; einit; emode = Passive @@ at } @@ at }
  | LPAR ELEM bind_var_opt table_use offset elem_list RPAR
    { let at = at () in
      fun c -> ignore ($3 c anon_elem bind_elem);
      fun () -> let etype, einit = $6 c in
      { etype; einit;
        emode = Active {index = $4 c table; offset = $5 c} @@ at } @@ at }
  | LPAR ELEM bind_var_opt DECLARE elem_list RPAR
    { let at = at () in
      fun c -> ignore ($3 c anon_elem bind_elem);
      fun () -> let etype, einit = $5 c in
      { etype; einit; emode = Declarative @@ at } @@ at }
  | LPAR ELEM bind_var_opt offset elem_list RPAR  /* Sugar */
    { let at = at () in
      fun c -> ignore ($3 c anon_elem bind_elem);
      fun () -> let etype, einit = $5 c in
      { etype; einit;
        emode = Active {index = 0l @@ at; offset = $4 c} @@ at } @@ at }
  | LPAR ELEM bind_var_opt offset elem_var_list RPAR  /* Sugar */
    { let at = at () in
      fun c -> ignore ($3 c anon_elem bind_elem);
      fun () ->
      { etype = (NoNull, FuncHT); einit = $5 c func;
        emode = Active {index = 0l @@ at; offset = $4 c} @@ at } @@ at }

table :
  | LPAR TABLE bind_var_opt table_fields RPAR
    { let at = at () in
      fun c -> let x = $3 c anon_table bind_table @@ at in
      fun () -> $4 c x at }

table_fields :
  | table_type const_expr1
    { fun c x at -> [{ttype = $1 c; tinit = $2 c} @@ at], [], [], [] }
  | table_type  /* Sugar */
    { fun c x at -> let TableT (_, (_, ht)) as ttype = $1 c in
      [{ttype; tinit = [RefNull ht @@ at] @@ at} @@ at], [], [], [] }
  | inline_import table_type  /* Sugar */
    { fun c x at ->
      [], [],
      [{ module_name = fst $1; item_name = snd $1;
        idesc = TableImport ($2 c) @@ at } @@ at], [] }
  | inline_export table_fields  /* Sugar */
    { fun c x at -> let tabs, elems, ims, exs = $2 c x at in
      tabs, elems, ims, $1 (TableExport x) c :: exs }
  | ref_type LPAR ELEM elem_var_list RPAR  /* Sugar */
    { fun c x at ->
      let offset = [i32_const (0l @@ at) @@ at] @@ at in
      let einit = $4 c func in
      let size = Lib.List32.length einit in
      let emode = Active {index = x; offset} @@ at in
      let (_, ht) as etype = $1 c in
      let tinit = [RefNull ht @@ at] @@ at in
      [{ttype = TableT ({min = size; max = Some size}, etype); tinit} @@ at],
      [{etype; einit; emode} @@ at],
      [], [] }
  | ref_type LPAR ELEM elem_expr elem_expr_list RPAR  /* Sugar */
    { fun c x at ->
      let offset = [i32_const (0l @@ at) @@ at] @@ at in
      let einit = (fun c -> $4 c :: $5 c) c in
      let size = Lib.List32.length einit in
      let emode = Active {index = x; offset} @@ at in
      let (_, ht) as etype = $1 c in
      let tinit = [RefNull ht @@ at] @@ at in
      [{ttype = TableT ({min = size; max = Some size}, etype); tinit} @@ at],
      [{etype; einit; emode} @@ at],
      [], [] }

data :
  | LPAR DATA bind_var_opt string_list RPAR
    { let at = at () in
      fun c -> ignore ($3 c anon_data bind_data);
      fun () -> {dinit = $4; dmode = Passive @@ at} @@ at }
  | LPAR DATA bind_var_opt memory_use offset string_list RPAR
    { let at = at () in
      fun c -> ignore ($3 c anon_data bind_data);
      fun () ->
      {dinit = $6; dmode = Active {index = $4 c memory; offset = $5 c} @@ at} @@ at }
  | LPAR DATA bind_var_opt offset string_list RPAR  /* Sugar */
    { let at = at () in
      fun c -> ignore ($3 c anon_data bind_data);
      fun () ->
      {dinit = $5; dmode = Active {index = 0l @@ at; offset = $4 c} @@ at} @@ at }

memory :
  | LPAR MEMORY bind_var_opt memory_fields RPAR
    { let at = at () in
      fun c -> let x = $3 c anon_memory bind_memory @@ at in
      fun () -> $4 c x at }

memory_fields :
  | memory_type
    { fun c x at -> [{mtype = $1 c} @@ at], [], [], [] }
  | inline_import memory_type  /* Sugar */
    { fun c x at ->
      [], [],
      [{ module_name = fst $1; item_name = snd $1;
         idesc = MemoryImport ($2 c) @@ at } @@ at], [] }
  | inline_export memory_fields  /* Sugar */
    { fun c x at -> let mems, data, ims, exs = $2 c x at in
      mems, data, ims, $1 (MemoryExport x) c :: exs }
  | LPAR DATA string_list RPAR  /* Sugar */
    { fun c x at ->
      let offset = [i32_const (0l @@ at) @@ at] @@ at in
      let size = Int32.(div (add (of_int (String.length $3)) 65535l) 65536l) in
      [{mtype = MemoryT {min = size; max = Some size}} @@ at],
      [{dinit = $3; dmode = Active {index = x; offset} @@ at} @@ at],
      [], [] }

global :
  | LPAR GLOBAL bind_var_opt global_fields RPAR
    { let at = at () in
      fun c -> let x = $3 c anon_global bind_global @@ at in
      fun () -> $4 c x at }

global_fields :
  | global_type const_expr
    { fun c x at -> [{gtype = $1 c; ginit = $2 c} @@ at], [], [] }
  | inline_import global_type  /* Sugar */
    { fun c x at ->
      [],
      [{ module_name = fst $1; item_name = snd $1;
         idesc = GlobalImport ($2 c) @@ at } @@ at], [] }
  | inline_export global_fields  /* Sugar */
    { fun c x at -> let globs, ims, exs = $2 c x at in
      globs, ims, $1 (GlobalExport x) c :: exs }


/* Imports & Exports */

import_desc :
  | LPAR FUNC bind_var_opt type_use RPAR
    { fun c -> ignore ($3 c anon_func bind_func);
      fun () -> FuncImport ($4 c) }
  | LPAR FUNC bind_var_opt func_type RPAR  /* Sugar */
    { let at4 = ati 4 in
      fun c -> ignore ($3 c anon_func bind_func);
      fun () -> FuncImport (inline_func_type c ($4 c) at4) }
  | LPAR TABLE bind_var_opt table_type RPAR
    { fun c -> ignore ($3 c anon_table bind_table);
      fun () -> TableImport ($4 c) }
  | LPAR MEMORY bind_var_opt memory_type RPAR
    { fun c -> ignore ($3 c anon_memory bind_memory);
      fun () -> MemoryImport ($4 c) }
  | LPAR GLOBAL bind_var_opt global_type RPAR
    { fun c -> ignore ($3 c anon_global bind_global);
      fun () -> GlobalImport ($4 c) }

import :
  | LPAR IMPORT name name import_desc RPAR
    { let at = at () and at5 = ati 5 in
      fun c -> let df = $5 c in
      fun () -> {module_name = $3; item_name = $4; idesc = df () @@ at5} @@ at }

inline_import :
  | LPAR IMPORT name name RPAR { $3, $4 }

export_desc :
  | LPAR FUNC var RPAR { fun c -> FuncExport ($3 c func) }
  | LPAR TABLE var RPAR { fun c -> TableExport ($3 c table) }
  | LPAR MEMORY var RPAR { fun c -> MemoryExport ($3 c memory) }
  | LPAR GLOBAL var RPAR { fun c -> GlobalExport ($3 c global) }

export :
  | LPAR EXPORT name export_desc RPAR
    { let at = at () and at4 = ati 4 in
      fun c -> {name = $3; edesc = $4 c @@ at4} @@ at }

inline_export :
  | LPAR EXPORT name RPAR
    { let at = at () in fun d c -> {name = $3; edesc = d @@ at} @@ at }


/* Modules */

type_def :
  | LPAR TYPE sub_type RPAR
    { let at = at () in
      fun c -> let i = anon_type c at in fun () -> i, $3 c }
  | LPAR TYPE bind_var sub_type RPAR  /* Sugar */
    { fun c -> let i = bind_type c $3 in fun () -> i, $4 c }

type_def_list :
  | /* empty */ { fun c () -> [] }
  | type_def type_def_list
    { fun c -> let tf = $1 c in let tsf = $2 c in fun () ->
      let st = tf () and sts = tsf () in st::sts }

def_type :
  | type_def
    { fun c -> let tf = $1 c in fun () ->
      let x, st = tf () in
      define_ctx_type c (CtxT ([(StatX x, st)], 0l));
      RecT [st] }
  | LPAR REC type_def_list RPAR
    { fun c -> let tf = $3 c in fun () ->
      let xsts = tf () in
      let rts = List.map (fun (x, st) -> (StatX x, st)) xsts in
      Lib.List32.iteri (fun i (x, _) -> define_ctx_type c (CtxT (rts, i))) xsts;
      RecT (snd (List.split xsts)) }

type_ :
  | def_type
    { let at = at () in
      fun c -> let tf = $1 c in fun () -> define_type c (tf () @@ at) }

start :
  | LPAR START var RPAR
    { let at = at () in fun c -> {sfunc = $3 c func} @@ at }

module_fields :
  | /* empty */
    { fun (c : context) () () -> {empty_module with types = c.types.list} }
  | module_fields1 { $1 }

module_fields1 :
  | type_ module_fields
    { fun c -> let tf = $1 c in let mff = $2 c in
      fun () -> tf (); mff () }
  | global module_fields
    { fun c -> let gf = $1 c in let mff = $2 c in
      fun () -> let mf = mff () in
      fun () -> let globs, ims, exs = gf () in let m = mf () in
      if globs <> [] && m.imports <> [] then
        error (List.hd m.imports).at "import after global definition";
      { m with globals = globs @ m.globals;
        imports = ims @ m.imports; exports = exs @ m.exports } }
  | table module_fields
    { fun c -> let tf = $1 c in let mff = $2 c in
      fun () -> let mf = mff () in
      fun () -> let tabs, elems, ims, exs = tf () in let m = mf () in
      if tabs <> [] && m.imports <> [] then
        error (List.hd m.imports).at "import after table definition";
      { m with tables = tabs @ m.tables; elems = elems @ m.elems;
        imports = ims @ m.imports; exports = exs @ m.exports } }
  | memory module_fields
    { fun c -> let mmf = $1 c in let mff = $2 c in
      fun () -> let mf = mff () in
      fun () -> let mems, data, ims, exs = mmf () in let m = mf () in
      if mems <> [] && m.imports <> [] then
        error (List.hd m.imports).at "import after memory definition";
      { m with memories = mems @ m.memories; datas = data @ m.datas;
        imports = ims @ m.imports; exports = exs @ m.exports } }
  | func module_fields
    { fun c -> let ff = $1 c in let mff = $2 c in
      fun () -> let mf = mff () in
      fun () -> let funcs, ims, exs = ff () in let m = mf () in
      if funcs <> [] && m.imports <> [] then
        error (List.hd m.imports).at "import after function definition";
      { m with funcs = funcs @ m.funcs;
        imports = ims @ m.imports; exports = exs @ m.exports } }
  | elem module_fields
    { fun c -> let ef = $1 c in let mff = $2 c in
      fun () -> let mf = mff () in
      fun () -> let elems = ef () in let m = mf () in
      {m with elems = elems :: m.elems} }
  | data module_fields
    { fun c -> let df = $1 c in let mff = $2 c in
      fun () -> let mf = mff () in
      fun () -> let data = df () in let m = mf () in
      {m with datas = data :: m.datas} }
  | start module_fields
    { fun c -> let mff = $2 c in
      fun () -> let mf = mff () in
      fun () -> let m = mf () in
      let x = $1 c in
      match m.start with
      | Some _ -> error x.at "multiple start sections"
      | None -> {m with start = Some x} }
  | import module_fields
    { fun c -> let imf = $1 c in let mff = $2 c in
      fun () -> let mf = mff () in
      fun () -> let im = imf () in let m = mf () in
      {m with imports = im :: m.imports} }
  | export module_fields
    { fun c -> let mff = $2 c in
      fun () -> let mf = mff () in
      fun () -> let m = mf () in
      {m with exports = $1 c :: m.exports} }

module_var_opt :
  | /* empty */ { None }
  | VAR { Some ($1 @@ at ()) }  /* Sugar */

module_ :
  | LPAR MODULE module_var_opt module_fields RPAR
    { $3, Textual ($4 (empty_context ()) () () @@ at ()) @@ at () }

inline_module :  /* Sugar */
  | module_fields { Textual ($1 (empty_context ()) () () @@ at ()) @@ at () }

inline_module1 :  /* Sugar */
  | module_fields1 { Textual ($1 (empty_context ()) () () @@ at ()) @@ at () }


/* Scripts */

script_var_opt :
  | /* empty */ { None }
  | VAR { Some ($1 @@ at ()) }  /* Sugar */

script_module :
  | module_ { $1 }
  | LPAR MODULE module_var_opt BIN string_list RPAR
    { $3, Encoded ("binary:" ^ string_of_pos (at()).left, $5) @@ at() }
  | LPAR MODULE module_var_opt QUOTE string_list RPAR
    { $3, Quoted ("quote:" ^ string_of_pos (at()).left, $5) @@ at() }

action :
  | LPAR INVOKE module_var_opt name literal_list RPAR
    { Invoke ($3, $4, $5) @@ at () }
  | LPAR GET module_var_opt name RPAR
    { Get ($3, $4) @@ at() }

assertion :
  | LPAR ASSERT_MALFORMED script_module STRING RPAR
    { AssertMalformed (snd $3, $4) @@ at () }
  | LPAR ASSERT_INVALID script_module STRING RPAR
    { AssertInvalid (snd $3, $4) @@ at () }
  | LPAR ASSERT_UNLINKABLE script_module STRING RPAR
    { AssertUnlinkable (snd $3, $4) @@ at () }
  | LPAR ASSERT_TRAP script_module STRING RPAR
    { AssertUninstantiable (snd $3, $4) @@ at () }
  | LPAR ASSERT_RETURN action result_list RPAR { AssertReturn ($3, $4) @@ at () }
  | LPAR ASSERT_TRAP action STRING RPAR { AssertTrap ($3, $4) @@ at () }
  | LPAR ASSERT_EXHAUSTION action STRING RPAR { AssertExhaustion ($3, $4) @@ at () }

cmd :
  | action { Action $1 @@ at () }
  | assertion { Assertion $1 @@ at () }
  | script_module { Module (fst $1, snd $1) @@ at () }
  | LPAR REGISTER name module_var_opt RPAR { Register ($3, $4) @@ at () }
  | meta { Meta $1 @@ at () }

cmd_list :
  | /* empty */ { [] }
  | cmd cmd_list { $1 :: $2 }

meta :
  | LPAR SCRIPT script_var_opt cmd_list RPAR { Script ($3, $4) @@ at () }
  | LPAR INPUT script_var_opt STRING RPAR { Input ($3, $4) @@ at () }
  | LPAR OUTPUT script_var_opt STRING RPAR { Output ($3, Some $4) @@ at () }
  | LPAR OUTPUT script_var_opt RPAR { Output ($3, None) @@ at () }

literal_num :
  | LPAR CONST num RPAR { snd (num $2 $3) }

literal_vec :
  | LPAR VEC_CONST VEC_SHAPE num_list RPAR { snd (vec $2 $3 $4 (at ())) }

literal_ref :
  | LPAR REF_NULL heap_type RPAR { Value.NullRef ($3 (empty_context ())) }
  | LPAR REF_HOST NAT RPAR { Script.HostRef (nat32 $3 (ati 3)) }
  | LPAR REF_EXTERN NAT RPAR { Extern.ExternRef (Script.HostRef (nat32 $3 (ati 3))) }

literal :
  | literal_num { Value.Num $1 @@ at () }
  | literal_vec { Value.Vec $1 @@ at () }
  | literal_ref { Value.Ref $1 @@ at () }

literal_list :
  | /* empty */ { [] }
  | literal literal_list { $1 :: $2 }

numpat :
  | num { fun sh -> vec_lane_lit sh $1.it $1.at }
  | NAN { fun sh -> vec_lane_nan sh $1 (ati 3) }

numpat_list:
  | /* empty */ { [] }
  | numpat numpat_list { $1 :: $2 }

result :
  | literal_num { NumResult (NumPat ($1 @@ at())) @@ at () }
  | LPAR CONST NAN RPAR { NumResult (NanPat (nanop $2 ($3 @@ ati 3))) @@ at () }
  | literal_ref { RefResult (RefPat ($1 @@ at ())) @@ at () }
  | LPAR REF RPAR { RefResult (RefTypePat AnyHT) @@ at () }
  | LPAR REF_EQ RPAR { RefResult (RefTypePat EqHT) @@ at () }
  | LPAR REF_I31 RPAR { RefResult (RefTypePat I31HT) @@ at () }
  | LPAR REF_STRUCT RPAR { RefResult (RefTypePat StructHT) @@ at () }
  | LPAR REF_ARRAY RPAR { RefResult (RefTypePat ArrayHT) @@ at () }
  | LPAR REF_NULL RPAR { RefResult NullPat @@ at () }
  | LPAR REF_FUNC RPAR { RefResult (RefTypePat FuncHT) @@ at () }
  | LPAR REF_EXTERN RPAR { RefResult (RefTypePat ExternHT) @@ at () }
  | LPAR VEC_CONST VEC_SHAPE numpat_list RPAR
    { if V128.num_lanes $3 <> List.length $4 then
        error (at ()) "wrong number of lane literals";
      VecResult (VecPat (Value.V128 ($3, List.map (fun lit -> lit $3) $4))) @@ at () }

result_list :
  | /* empty */ { [] }
  | result result_list { $1 :: $2 }

script :
  | cmd_list EOF { $1 }
  | inline_module1 EOF { [Module (None, $1) @@ at ()] }  /* Sugar */

script1 :
  | cmd { [$1] }

module1 :
  | module_ EOF { $1 }
  | inline_module EOF { None, $1 }  /* Sugar */
%%
