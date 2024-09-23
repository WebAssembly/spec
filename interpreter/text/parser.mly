%{
open Source
open Types
open Ast
open Operators
open Script


(* Error handling *)

let error at msg = raise (Parse_error.Syntax (at, msg))

let thd (_, _, x) = x


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

let at (l, r) = positions_to_region l r

let (@@@) = Source.(@@)
let (@@) x loc = x @@@ at loc


(* Literals *)

let num f s =
  try f s with Failure _ -> error s.at "constant out of range"

let vec f shape ss loc =
  try f shape ss (at loc) with
  | Failure _ -> error (at loc) "constant out of range"
  | Invalid_argument _ -> error (at loc) "wrong number of lane literals"

let vec_lane_nan shape l at =
  let open Value in
  match shape with
  | V128.F32x4 () -> NanPat (F32 l @@@ at)
  | V128.F64x2 () -> NanPat (F64 l @@@ at)
  | _ -> error at "invalid vector constant"

let vec_lane_lit shape l at =
  let open Value in
  match shape with
  | V128.I8x16 () -> NumPat (I32 (I8.of_string l) @@@ at)
  | V128.I16x8 () -> NumPat (I32 (I16.of_string l) @@@ at)
  | V128.I32x4 () -> NumPat (I32 (I32.of_string l) @@@ at)
  | V128.I64x2 () -> NumPat (I64 (I64.of_string l) @@@ at)
  | V128.F32x4 () -> NumPat (F32 (F32.of_string l) @@@ at)
  | V128.F64x2 () -> NumPat (F64 (F64.of_string l) @@@ at)

let vec_lane_index s at =
  match int_of_string s with
  | n when 0 <= n && n < 256 -> n
  | _ | exception Failure _ -> error at "malformed lane index"

let shuffle_lit ss loc =
  if not (List.length ss = 16) then
    error (at loc) "invalid lane length";
  List.map (fun s -> vec_lane_index s.it s.at) ss

let nanop f nan =
  let open Source in
  let open Value in
  match snd (f ("0" @@ no_region)) with
  | F32 _ -> F32 nan.it @@ nan.at
  | F64 _ -> F64 nan.it @@ nan.at
  | I32 _ | I64 _ -> error nan.at "NaN pattern with non-float type"

let nat32 s loc =
  try I32.of_string_u s with Failure _ -> error (at loc) "i32 constant out of range"

let nat64 s loc =
  try I64.of_string_u s with Failure _ -> error (at loc) "i64 constant out of range"

let name s loc =
  try Utf8.decode s with Utf8.Utf8 -> error (at loc) "malformed UTF-8 encoding"

let var s loc =
  let r = at loc in
  try ignore (Utf8.decode s); Source.(s @@ r)
  with Utf8.Utf8 -> error r "malformed UTF-8 encoding"


(* Symbolic variables *)

module VarMap = Map.Make(String)

type space = {mutable map : int32 VarMap.t; mutable count : int32}
let empty () = {map = VarMap.empty; count = 0l}

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


type types =
  { space : space;
    mutable fields : space list;
    mutable list : type_ list;
    mutable ctx : def_type list;
  }
let empty_types () = {space = empty (); fields = []; list = []; ctx = []}

type context =
  { types : types; tables : space; memories : space; tags : space;
    funcs : space; locals : space; globals : space;
    datas : space; elems : space; labels : space;
    deferred_locals : (unit -> unit) list ref
  }

let empty_context () =
  { types = empty_types (); tables = empty (); memories = empty ();
    tags = empty (); funcs = empty (); locals = empty (); globals = empty ();
    datas = empty (); elems = empty (); labels = empty ();
    deferred_locals = ref []
  }

let enter_block (c : context) loc = {c with labels = scoped "label" 1l c.labels (at loc)}
let enter_let (c : context) loc = {c with locals = empty (); deferred_locals = ref []}
let enter_func (c : context) loc = {(enter_let c loc) with labels = empty ()}

let defer_locals (c : context) f =
  c.deferred_locals := (fun () -> ignore (f ())) :: !(c.deferred_locals)

let force_locals (c : context) =
  List.fold_right Stdlib.(@@) !(c.deferred_locals) ();
  c.deferred_locals := []


let print_char = function
  | 0x09 -> "\\t"
  | 0x0a -> "\\n"
  | 0x22 -> "\\\""
  | 0x5c -> "\\\\"
  | c when 0x20 <= c && c < 0x7f -> String.make 1 (Char.chr c)
  | c -> Printf.sprintf "\\u{%02x}" c

let print x =
  "$" ^
  if String.for_all (fun c -> Lib.Char.is_alphanum_ascii c || c = '_') x.it
  then x.it
  else "\"" ^ String.concat "" (List.map print_char (Utf8.decode x.it)) ^ "\""


let lookup category space x =
  try VarMap.find x.it space.map
  with Not_found -> error x.at ("unknown " ^ category ^ " " ^ print x)

let type_ (c : context) x = lookup "type" c.types.space x
let func (c : context) x = lookup "function" c.funcs x
let local (c : context) x = lookup "local" c.locals x
let global (c : context) x = lookup "global" c.globals x
let table (c : context) x = lookup "table" c.tables x
let memory (c : context) x = lookup "memory" c.memories x
let tag (c : context) x = lookup "tag" c.tags x
let elem (c : context) x = lookup "elem segment" c.elems x
let data (c : context) x = lookup "data segment" c.datas x
let label (c : context) x = lookup "label " c.labels x
let field x (c : context) y =
  lookup "field " (Lib.List32.nth c.types.fields x) y

let func_type (c : context) x =
  match expand_def_type (Lib.List32.nth c.types.ctx x.it) with
  | DefFuncT ft -> ft
  | _ -> error x.at ("non-function type " ^ Int32.to_string x.it)
  | exception Failure _ -> error x.at ("unknown type " ^ Int32.to_string x.it)


let bind_abs category space x =
  if VarMap.mem x.it space.map then
    error x.at ("duplicate " ^ category ^ " " ^ print x);
  let i = bind category space 1l x.at in
  space.map <- VarMap.add x.it i space.map;
  i

let bind_rel category space x =
  ignore (bind category space 1l x.at);
  space.map <- VarMap.add x.it 0l space.map;
  0l

let new_fields (c : context) =
  c.types.fields <- c.types.fields @ [empty ()]

let bind_type (c : context) x = new_fields c; bind_abs "type" c.types.space x
let bind_func (c : context) x = bind_abs "function" c.funcs x
let bind_local (c : context) x = force_locals c; bind_abs "local" c.locals x
let bind_global (c : context) x = bind_abs "global" c.globals x
let bind_table (c : context) x = bind_abs "table" c.tables x
let bind_memory (c : context) x = bind_abs "memory" c.memories x
let bind_tag (c : context) x = bind_abs "tag" c.tags x
let bind_elem (c : context) x = bind_abs "elem segment" c.elems x
let bind_data (c : context) x = bind_abs "data segment" c.datas x
let bind_label (c : context) x = bind_rel "label" c.labels x
let bind_field (c : context) x y =
  bind_abs "field" (Lib.List32.nth c.types.fields x) y

let define_type (c : context) (ty : type_) =
  c.types.list <- c.types.list @ [ty]

let define_def_type (c : context) (dt : def_type) =
  assert (c.types.space.count > Lib.List32.length c.types.ctx);
  c.types.ctx <- c.types.ctx @ [dt]

let anon_type (c : context) loc = new_fields c; bind "type" c.types.space 1l (at loc)
let anon_func (c : context) loc = bind "function" c.funcs 1l (at loc)
let anon_locals (c : context) n loc =
  defer_locals c (fun () -> bind "local" c.locals n (at loc))
let anon_global (c : context) loc = bind "global" c.globals 1l (at loc)
let anon_table (c : context) loc = bind "table" c.tables 1l (at loc)
let anon_memory (c : context) loc = bind "memory" c.memories 1l (at loc)
let anon_tag (c : context) loc = bind "tag" c.tags 1l (at loc)
let anon_elem (c : context) loc = bind "elem segment" c.elems 1l (at loc)
let anon_data (c : context) loc = bind "data segment" c.datas 1l (at loc)
let anon_label (c : context) loc = bind "label" c.labels 1l (at loc)
let anon_fields (c : context) x n loc =
  bind "field" (Lib.List32.nth c.types.fields x) n (at loc)


let inline_func_type (c : context) ft loc =
  let st = SubT (Final, [], DefFuncT ft) in
  match
    Lib.List.index_where (function
      | DefT (RecT [st'], 0l) -> st = st'
      | _ -> false
      ) c.types.ctx
  with
  | Some i -> Int32.of_int i @@ loc
  | None ->
    let i = anon_type c loc in
    define_type c (RecT [st] @@ loc);
    define_def_type c (DefT (RecT [st], 0l));
    i @@ loc

let inline_func_type_explicit (c : context) x ft loc =
  if ft = FuncT ([], []) then
    (* Deferring ensures that type lookup is only triggered when
       symbolic identifiers are used, and not for desugared functions *)
    defer_locals c (fun () ->
      let FuncT (ts1, _ts2) = func_type c x in
      bind "local" c.locals (Lib.List32.length ts1) (at loc)
    )
  else if ft <> func_type c x then
    error (at loc) "inline function type does not match explicit type";
  x

let index_type_of_num_type t loc =
  match t with
  | I32T -> I32IndexType
  | I64T -> I64IndexType
  | _ -> error (at loc) "illegal index type"

let index_type_of_value_type t loc =
  match t with
  | NumT t -> index_type_of_num_type t loc
  | _ -> error (at loc) "illegal index type"

let memory_data init it c x loc =
  let size = Int64.(div (add (of_int (String.length init)) 65535L) 65536L) in
  let instr = match it with
    | I32IndexType -> i32_const (0l @@ loc)
    | I64IndexType -> i64_const (0L @@ loc) in
  let offset = [instr @@ loc] @@ loc in
  [{mtype = MemoryT ({min = size; max = Some size}, it)} @@ loc],
  [{dinit = init; dmode = Active {index = x; offset} @@ loc} @@ loc],
  [], []

let table_data tinit init it etype c x loc =
  let instr = match it with
    | I32IndexType -> i32_const (0l @@ loc)
    | I64IndexType -> i64_const (0L @@ loc) in
  let offset = [instr @@ loc] @@ loc in
  let einit = init c in
  let size = Lib.List32.length einit in
  let size64 = Int64.of_int32 size in
  let emode = Active {index = x; offset} @@ loc in
  [{ttype = TableT ({min = size64; max = Some size64}, it, etype); tinit} @@ loc],
  [{etype; einit; emode} @@ loc],
  [], []

(* Custom annotations *)

let parse_annots (m : module_) : Custom.section list =
  let bs = Annot.get_source () in
  let annots = Annot.get m.at in
  let secs =
    Annot.NameMap.fold (fun name anns secs ->
      match Custom.handler name with
      | Some (module Handler) ->
        let secs' = Handler.parse m bs anns in
        List.map (fun fmt ->
          let module S = struct module Handler = Handler let it = fmt end in
          (module S : Custom.Section)
        ) secs' @ secs
      | None ->
        if !Flags.custom_reject then
          raise (Custom.Syntax ((List.hd anns).at,
            "unknown annotation @" ^ Utf8.encode name))
        else []
    ) annots []
  in
   List.stable_sort Custom.compare_section secs

%}

%token LPAR RPAR
%token<string> NAT INT FLOAT STRING VAR
%token<Types.num_type> NUM_TYPE
%token<Types.vec_type> VEC_TYPE
%token<Pack.pack_size> PACK_TYPE
%token<V128.shape> VEC_SHAPE
%token ANYREF NULLREF EQREF I31REF STRUCTREF ARRAYREF
%token FUNCREF NULLFUNCREF EXNREF NULLEXNREF EXTERNREF NULLEXTERNREF
%token ANY NONE EQ I31 REF NOFUNC EXN NOEXN EXTERN NOEXTERN NULL
%token MUT FIELD STRUCT ARRAY SUB FINAL REC
%token UNREACHABLE NOP DROP SELECT
%token BLOCK END IF THEN ELSE LOOP
%token BR BR_IF BR_TABLE
%token<Ast.idx -> Ast.instr'> BR_ON_NULL
%token<Ast.idx -> Types.ref_type -> Types.ref_type -> Ast.instr'> BR_ON_CAST
%token CALL CALL_REF CALL_INDIRECT
%token RETURN RETURN_CALL RETURN_CALL_REF RETURN_CALL_INDIRECT
%token THROW THROW_REF TRY_TABLE CATCH CATCH_REF CATCH_ALL CATCH_ALL_REF
%token LOCAL_GET LOCAL_SET LOCAL_TEE GLOBAL_GET GLOBAL_SET
%token TABLE_GET TABLE_SET
%token TABLE_SIZE TABLE_GROW TABLE_FILL TABLE_COPY TABLE_INIT ELEM_DROP
%token MEMORY_SIZE MEMORY_GROW MEMORY_FILL MEMORY_COPY MEMORY_INIT DATA_DROP
%token<Ast.idx -> int option -> Memory.offset -> Ast.instr'> LOAD STORE
%token<string> OFFSET_EQ_NAT ALIGN_EQ_NAT
%token<string Source.phrase -> Ast.instr' * Value.num> CONST
%token<Ast.instr'> UNARY BINARY TEST COMPARE CONVERT
%token REF_NULL REF_FUNC REF_I31 REF_STRUCT REF_ARRAY REF_EXN REF_EXTERN REF_HOST
%token REF_EQ REF_IS_NULL REF_AS_NON_NULL REF_TEST REF_CAST
%token<Ast.instr'> I31_GET
%token<Ast.idx -> Ast.instr'> STRUCT_NEW ARRAY_NEW ARRAY_GET
%token STRUCT_SET
%token<Ast.idx -> Ast.idx -> Ast.instr'> STRUCT_GET
%token ARRAY_NEW_FIXED ARRAY_NEW_ELEM ARRAY_NEW_DATA
%token ARRAY_SET ARRAY_LEN
%token ARRAY_COPY ARRAY_FILL ARRAY_INIT_DATA ARRAY_INIT_ELEM
%token<Ast.instr'> EXTERN_CONVERT
%token<Ast.idx -> int option -> Memory.offset -> Ast.instr'> VEC_LOAD VEC_STORE
%token<Ast.idx -> int option -> Memory.offset -> int -> Ast.instr'> VEC_LOAD_LANE VEC_STORE_LANE
%token<V128.shape -> string Source.phrase list -> Source.region -> Ast.instr' * Value.vec> VEC_CONST
%token<Ast.instr'> VEC_UNARY VEC_BINARY VEC_TERNARY VEC_TEST
%token<Ast.instr'> VEC_SHIFT VEC_BITMASK VEC_SPLAT
%token VEC_SHUFFLE
%token<int -> Ast.instr'> VEC_EXTRACT VEC_REPLACE
%token FUNC START TYPE PARAM RESULT LOCAL GLOBAL
%token TABLE ELEM MEMORY TAG DATA DECLARE OFFSET ITEM IMPORT EXPORT
%token MODULE BIN QUOTE DEFINITION INSTANCE
%token SCRIPT REGISTER INVOKE GET
%token ASSERT_MALFORMED ASSERT_INVALID ASSERT_UNLINKABLE
%token ASSERT_RETURN ASSERT_TRAP ASSERT_EXCEPTION ASSERT_EXHAUSTION
%token ASSERT_MALFORMED_CUSTOM ASSERT_INVALID_CUSTOM
%token<Script.nan> NAN
%token INPUT OUTPUT
%token EOF

%start script script1 module1
%type<Script.script> script
%type<Script.script> script1
%type<Script.var option * Script.definition> module1

%%

/* Auxiliaries */

name :
  | STRING { name $1 $sloc }

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
  | EXN { fun c -> ExnHT }
  | NOEXN { fun c -> NoExnHT }
  | EXTERN { fun c -> ExternHT }
  | NOEXTERN { fun c -> NoExternHT }
  | var { fun c -> VarHT (StatX ($1 c type_).it) }

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
  | EXNREF { fun c -> (Null, ExnHT) }  /* Sugar */
  | NULLEXNREF { fun c -> (Null, NoExnHT) }  /* Sugar */
  | EXTERNREF { fun c -> (Null, ExternHT) }  /* Sugar */
  | NULLEXTERNREF { fun c -> (Null, NoExternHT) }  /* Sugar */

val_type :
  | NUM_TYPE { fun c -> NumT $1 }
  | VEC_TYPE { fun c -> VecT $1 }
  | ref_type { fun c -> RefT ($1 c) }

val_type_list :
  | list(val_type)
    { Lib.List32.length $1, fun c -> List.map (fun f -> f c) $1 }

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
  | /* empty */ { fun c x -> [] }
  | LPAR FIELD field_type_list RPAR struct_field_list
    { fun c x -> let fts = $3 c in
      ignore (anon_fields c x (Lib.List32.length fts) $loc($3)); fts @ $5 c x }
  | LPAR FIELD bind_var field_type RPAR struct_field_list
    { fun c x -> ignore (bind_field c x $3); $4 c :: $6 c x }

struct_type :
  | struct_field_list { fun c x -> StructT ($1 c x) }

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
  | LPAR STRUCT struct_type RPAR { fun c x -> DefStructT ($3 c x) }
  | LPAR ARRAY array_type RPAR { fun c x -> DefArrayT ($3 c) }
  | LPAR FUNC func_type RPAR { fun c x -> DefFuncT ($3 c) }

sub_type :
  | str_type { fun c x -> SubT (Final, [], $1 c x) }
  | LPAR SUB var_list str_type RPAR
    { fun c x -> SubT (NoFinal,
        List.map (fun y -> VarHT (StatX y.it)) ($3 c type_), $4 c x) }
  | LPAR SUB FINAL var_list str_type RPAR
    { fun c x -> SubT (Final,
        List.map (fun y -> VarHT (StatX y.it)) ($4 c type_), $5 c x) }

table_type :
  | val_type limits ref_type { fun c -> TableT ($2, index_type_of_value_type ($1 c) $sloc, $3 c) }
  | limits ref_type { fun c -> TableT ($1, I32IndexType, $2 c) }

memory_type :
  | val_type limits { fun c -> MemoryT ($2, index_type_of_value_type ($1 c) $sloc) }
  | limits { fun c -> MemoryT ($1, I32IndexType) }

limits :
  | NAT { {min = nat64 $1 $loc($1); max = None} }
  | NAT NAT { {min = nat64 $1 $loc($1); max = Some (nat64 $2 $loc($2))} }

type_use :
  | LPAR TYPE var RPAR { fun c -> $3 c type_ }


/* Immediates */

nat32 :
  | NAT { nat32 $1 $sloc }

num :
  | NAT { $1 @@ $sloc }
  | INT { $1 @@ $sloc }
  | FLOAT { $1 @@ $sloc }

var :
  | NAT { fun c lookup -> nat32 $1 $sloc @@ $sloc }
  | VAR { fun c lookup -> lookup c (var $1 $sloc) @@ $sloc }

var_opt :
  | /* empty */ { fun c lookup at -> 0l @@ at }
  | var { fun c lookup at -> $1 c lookup }

var_var_opt :
  | /* empty */ { fun c lookup at -> 0l @@ at, 0l @@ at }
  | var var { fun c lookup at -> $1 c lookup, $2 c lookup }

var_list :
  | /* empty */ { fun c lookup -> [] }
  | var var_list { fun c lookup -> $1 c lookup :: $2 c lookup }

bind_var_opt :
  | /* empty */ { fun c anon bind -> anon c $sloc }
  | bind_var { fun c anon bind -> bind c $1 }  /* Sugar */

bind_var :
  | VAR { var $1 $sloc }

labeling_opt :
  | /* empty */
    { fun c xs ->
      List.iter (fun x -> error x.at "mismatching label") xs;
      let c' = enter_block c $sloc in ignore (anon_label c' $sloc); c' }
  | bind_var
    { fun c xs ->
      List.iter
        (fun x -> if x.it <> $1.it then error x.at "mismatching label") xs;
      let c' = enter_block c $sloc in ignore (bind_label c' $1); c' }

labeling_end_opt :
  | /* empty */ { [] }
  | bind_var { [$1] }

offset_ :
  | OFFSET_EQ_NAT { nat64 $1 $sloc }

offset_opt :
  | /* empty */ { 0L }
  | offset_ { $1 }

align :
  | ALIGN_EQ_NAT
    { let n = nat64 $1 $sloc in
      if not (Lib.Int64.is_power_of_two_unsigned n) then
        error (at $sloc) "alignment must be a power of two";
      Some (Int64.to_int (Lib.Int64.log2_unsigned n)) }

align_opt :
  | /* empty */ { None }
  | align { $1 }


/* Instructions & Expressions */

instr_list :
  | /* empty */ { fun c -> [] }
  | instr1 instr_list { fun c -> $1 c @ $2 c }
  | select_instr_instr_list { $1 }
  | call_instr_instr_list { $1 }

instr1 :
  | plain_instr { fun c -> [$1 c @@ $sloc] }
  | block_instr { fun c -> [$1 c @@ $sloc] }
  | expr { $1 }  /* Sugar */

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
  | RETURN_CALL var { fun c -> return_call ($2 c func) }
  | RETURN_CALL_REF var { fun c -> return_call_ref ($2 c type_) }
  | THROW var { fun c -> throw ($2 c tag) }
  | THROW_REF { fun c -> throw_ref }
  | LOCAL_GET var { fun c -> local_get ($2 c local) }
  | LOCAL_SET var { fun c -> local_set ($2 c local) }
  | LOCAL_TEE var { fun c -> local_tee ($2 c local) }
  | GLOBAL_GET var { fun c -> global_get ($2 c global) }
  | GLOBAL_SET var { fun c -> global_set ($2 c global) }
  | TABLE_GET var_opt { fun c -> table_get ($2 c table $loc($1)) }
  | TABLE_SET var_opt { fun c -> table_set ($2 c table $loc($1)) }
  | TABLE_SIZE var_opt { fun c -> table_size ($2 c table $loc($1)) }
  | TABLE_GROW var_opt { fun c -> table_grow ($2 c table $loc($1)) }
  | TABLE_FILL var_opt { fun c -> table_fill ($2 c table $loc($1)) }
  | TABLE_COPY var_var_opt
    { fun c -> let x, y = $2 c table $loc($1) in table_copy x y }
  | TABLE_INIT var var
    { fun c -> table_init ($2 c table) ($3 c elem) }
  | TABLE_INIT var  /* Sugar */
    { fun c -> table_init (0l @@ $loc($1)) ($2 c elem) }
  | ELEM_DROP var { fun c -> elem_drop ($2 c elem) }
  | LOAD var_opt offset_opt align_opt
    { fun c -> $1 ($2 c memory $loc($1)) $4 $3 }
  | STORE var_opt offset_opt align_opt
    { fun c -> $1 ($2 c memory $loc($1)) $4 $3 }
  | VEC_LOAD var_opt offset_opt align_opt
    { fun c -> $1 ($2 c memory $loc($1)) $4 $3 }
  | VEC_STORE var_opt offset_opt align_opt
    { fun c -> $1 ($2 c memory $loc($1)) $4 $3 }
  | VEC_LOAD_LANE lane_imms { fun c -> $2 $1 $loc($1) c }
  | VEC_STORE_LANE lane_imms { fun c -> $2 $1 $loc($1) c }
  | MEMORY_SIZE var_opt { fun c -> memory_size ($2 c memory $loc($1)) }
  | MEMORY_GROW var_opt { fun c -> memory_grow ($2 c memory $loc($1)) }
  | MEMORY_FILL var_opt { fun c -> memory_fill ($2 c memory $loc($1)) }
  | MEMORY_COPY var_var_opt
    { fun c -> let x, y = $2 c memory $loc($1) in memory_copy x y }
  | MEMORY_INIT var var
    { fun c -> memory_init ($2 c memory) ($3 c data) }
  | MEMORY_INIT var  /* Sugar */
    { fun c -> memory_init (0l @@ $loc($1)) ($2 c data) }
  | DATA_DROP var { fun c -> data_drop ($2 c data) }
  | REF_NULL heap_type { fun c -> ref_null ($2 c) }
  | REF_FUNC var { fun c -> ref_func ($2 c func) }
  | REF_IS_NULL { fun c -> ref_is_null }
  | REF_AS_NON_NULL { fun c -> ref_as_non_null }
  | REF_TEST ref_type { fun c -> ref_test ($2 c) }
  | REF_CAST ref_type { fun c -> ref_cast ($2 c) }
  | REF_EQ { fun c -> ref_eq }
  | REF_I31 { fun c -> ref_i31 }
  | I31_GET { fun c -> $1 }
  | STRUCT_NEW var { fun c -> $1 ($2 c type_) }
  | STRUCT_GET var var { fun c -> let x = $2 c type_ in $1 x ($3 c (field x.it)) }
  | STRUCT_SET var var { fun c -> let x = $2 c type_ in struct_set x ($3 c (field x.it)) }
  | ARRAY_NEW var { fun c -> $1 ($2 c type_) }
  | ARRAY_NEW_FIXED var nat32 { fun c -> array_new_fixed ($2 c type_) $3 }
  | ARRAY_NEW_ELEM var var { fun c -> array_new_elem ($2 c type_) ($3 c elem) }
  | ARRAY_NEW_DATA var var { fun c -> array_new_data ($2 c type_) ($3 c data) }
  | ARRAY_GET var { fun c -> $1 ($2 c type_) }
  | ARRAY_SET var { fun c -> array_set ($2 c type_) }
  | ARRAY_LEN { fun c -> array_len }
  | ARRAY_COPY var var { fun c -> array_copy ($2 c type_) ($3 c type_) }
  | ARRAY_FILL var { fun c -> array_fill ($2 c type_) }
  | ARRAY_INIT_DATA var var { fun c -> array_init_data ($2 c type_) ($3 c data) }
  | ARRAY_INIT_ELEM var var { fun c -> array_init_elem ($2 c type_) ($3 c elem) }
  | EXTERN_CONVERT { fun c -> $1 }
  | CONST num { fun c -> fst (num $1 $2) }
  | TEST { fun c -> $1 }
  | COMPARE { fun c -> $1 }
  | UNARY { fun c -> $1 }
  | BINARY { fun c -> $1 }
  | CONVERT { fun c -> $1 }
  | VEC_CONST VEC_SHAPE list(num) { fun c -> fst (vec $1 $2 $3 $sloc) }
  | VEC_UNARY { fun c -> $1 }
  | VEC_BINARY { fun c -> $1 }
  | VEC_TERNARY { fun c -> $1 }
  | VEC_TEST { fun c -> $1 }
  | VEC_SHIFT { fun c -> $1 }
  | VEC_BITMASK { fun c -> $1 }
  | VEC_SHUFFLE list(num) { fun c -> i8x16_shuffle (shuffle_lit $2 $sloc) }
  | VEC_SPLAT { fun c -> $1 }
  | VEC_EXTRACT NAT { fun c -> $1 (vec_lane_index $2 (at $sloc)) }
  | VEC_REPLACE NAT { fun c -> $1 (vec_lane_index $2 (at $sloc)) }


lane_imms :
  /* Need to multiply out options and var to avoid spurious conflicts */
  | NAT offset_opt align_opt NAT
    { fun instr at0 c ->
      instr (nat32 $1 $loc($1) @@ $loc($1)) $3 $2
        (vec_lane_index $4 (at $loc($4))) }
  | VAR offset_opt align_opt NAT  /* Sugar */
    { fun instr at0 c -> instr (memory c ($1 @@ $loc($1)) @@ $loc($1)) $3 $2
        (vec_lane_index $4 (at $loc($4))) }
  | offset_ align_opt NAT  /* Sugar */
    { fun instr at0 c -> instr (0l @@ at0) $2 $1
        (vec_lane_index $3 (at $loc($3))) }
  | align NAT  /* Sugar */
    { fun instr at0 c -> instr (0l @@ at0) $1 0L
       (vec_lane_index $2 (at $loc($2))) }
  | NAT  /* Sugar */
    { fun instr at0 c -> instr (0l @@ at0) None 0L
        (vec_lane_index $1 (at $loc($1))) }


select_instr_instr_list :
  | SELECT select_instr_results_instr_list
    { fun c -> let b, ts, es = $2 c in
      (select (if b then (Some ts) else None) @@ $loc($1)) :: es }

select_instr_results_instr_list :
  | LPAR RESULT val_type_list RPAR select_instr_results_instr_list
    { fun c -> let _, ts, es = $5 c in true, snd $3 c @ ts, es }
  | instr_list
    { fun c -> false, [], $1 c }


call_instr_instr_list :
  | CALL_INDIRECT var call_instr_type_instr_list
    { fun c -> let x, es = $3 c in
      (call_indirect ($2 c table) x @@ $loc($1)) :: es }
  | CALL_INDIRECT call_instr_type_instr_list  /* Sugar */
    { fun c -> let x, es = $2 c in
      (call_indirect (0l @@ $loc($1)) x @@ $loc($1)) :: es }
  | RETURN_CALL_INDIRECT var call_instr_type_instr_list
    { fun c -> let x, es = $3 c in
      (return_call_indirect ($2 c table) x @@ $loc($1)) :: es }
  | RETURN_CALL_INDIRECT call_instr_type_instr_list  /* Sugar */
    { fun c -> let x, es = $2 c in
      (return_call_indirect (0l @@ $loc($1)) x @@ $loc($1)) :: es }

call_instr_type_instr_list :
  | type_use call_instr_params_instr_list
    { fun c ->
      match $2 c with
      | FuncT ([], []), es -> $1 c, es
      | ft, es -> inline_func_type_explicit c ($1 c) ft $loc($1), es }
  | call_instr_params_instr_list
    { fun c -> let ft, es = $1 c in inline_func_type c ft $sloc, es }

call_instr_params_instr_list :
  | LPAR PARAM val_type_list RPAR call_instr_params_instr_list
    { fun c -> let FuncT (ts1, ts2), es = $5 c in
      FuncT (snd $3 c @ ts1, ts2), es }
  | call_instr_results_instr_list
    { fun c -> let ts, es = $1 c in FuncT ([], ts), es }

call_instr_results_instr_list :
  | LPAR RESULT val_type_list RPAR call_instr_results_instr_list
    { fun c -> let ts, es = $5 c in snd $3 c @ ts, es }
  | instr_list
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
  | TRY_TABLE labeling_opt handler_block END labeling_end_opt
    { fun c -> let c' = $2 c $5 in
      let bt, (cs, es) = $3 c c' in try_table bt cs es }

block :
  | type_use block_param_body
    { fun c -> let ft, es = $2 c in
      let x = inline_func_type_explicit c ($1 c) ft $loc($1) in
      VarBlockType x, es }
  | block_param_body  /* Sugar */
    { fun c -> let ft, es = $1 c in
      let bt =
        match ft with
        | FuncT ([], []) -> ValBlockType None
        | FuncT ([], [t]) -> ValBlockType (Some t)
        | ft ->  VarBlockType (inline_func_type c ft $sloc)
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


handler_block :
  | type_use handler_block_param_body
    { fun c c' -> let ft, esh = $2 c c' in
      VarBlockType (inline_func_type_explicit c ($1 c) ft $loc($1)), esh }
  | handler_block_param_body  /* Sugar */
    { fun c c' -> let ft, esh = $1 c c' in
      let bt =
        match ft with
        | FuncT ([], []) -> ValBlockType None
        | FuncT ([], [t]) -> ValBlockType (Some t)
        | ft ->  VarBlockType (inline_func_type c ft $sloc)
      in bt, esh }

handler_block_param_body :
  | handler_block_result_body { $1 }
  | LPAR PARAM val_type_list RPAR handler_block_param_body
    { fun c c' -> let FuncT (ts1, ts2), esh = $5 c c' in
      FuncT (snd $3 c @ ts1, ts2), esh }

handler_block_result_body :
  | handler_block_body { fun c c' -> FuncT ([], []), $1 c c' }
  | LPAR RESULT val_type_list RPAR handler_block_result_body
    { fun c c' -> let FuncT (ts1, ts2), esh = $5 c c' in
      FuncT (ts1, snd $3 c @ ts2), esh }

handler_block_body :
  | instr_list
    { fun c c' -> [], $1 c' }
  | LPAR CATCH var var RPAR handler_block_body
    { fun c c' -> let cs, es = $6 c c' in
      (catch ($3 c tag) ($4 c label) @@ $loc($2)) :: cs, es }
  | LPAR CATCH_REF var var RPAR handler_block_body
    { fun c c' -> let cs, es = $6 c c' in
      (catch_ref ($3 c tag) ($4 c label) @@ $loc($2)) :: cs, es }
  | LPAR CATCH_ALL var RPAR handler_block_body
    { fun c c' -> let cs, es = $5 c c' in
      (catch_all ($3 c label) @@ $loc($2)) :: cs, es }
  | LPAR CATCH_ALL_REF var RPAR handler_block_body
    { fun c c' -> let cs, es = $5 c c' in
      (catch_all_ref ($3 c label) @@ $loc($2)) :: cs, es }


expr :  /* Sugar */
  | LPAR expr1 RPAR
    { fun c -> let es, e' = $2 c in es @ [e' @@ $sloc] }

expr1 :  /* Sugar */
  | plain_instr expr_list { fun c -> $2 c, $1 c }
  | SELECT select_expr_results
    { fun c -> let b, ts, es = $2 c in es, select (if b then (Some ts) else None) }
  | CALL_INDIRECT var call_expr_type
    { fun c -> let x, es = $3 c in es, call_indirect ($2 c table) x }
  | CALL_INDIRECT call_expr_type  /* Sugar */
    { fun c -> let x, es = $2 c in es, call_indirect (0l @@ $loc($1)) x }
  | RETURN_CALL_INDIRECT var call_expr_type
    { fun c -> let x, es = $3 c in es, return_call_indirect ($2 c table) x }
  | RETURN_CALL_INDIRECT call_expr_type  /* Sugar */
    { fun c -> let x, es = $2 c in es, return_call_indirect (0l @@ $loc($1)) x }
  | BLOCK labeling_opt block
    { fun c -> let c' = $2 c [] in let bt, es = $3 c' in [], block bt es }
  | LOOP labeling_opt block
    { fun c -> let c' = $2 c [] in let bt, es = $3 c' in [], loop bt es }
  | IF labeling_opt if_block
    { fun c -> let c' = $2 c [] in
      let bt, (es, es1, es2) = $3 c c' in es, if_ bt es1 es2 }
  | TRY_TABLE labeling_opt try_block
    { fun c -> let c' = $2 c [] in
      let bt, (cs, es) = $3 c c' in [], try_table bt cs es }

select_expr_results :
  | LPAR RESULT val_type_list RPAR select_expr_results
    { fun c -> let _, ts, es = $5 c in true, snd $3 c @ ts, es }
  | expr_list
    { fun c -> false, [], $1 c }

call_expr_type :
  | type_use call_expr_params
    { fun c ->
      match $2 c with
      | FuncT ([], []), es -> $1 c, es
      | ft, es -> inline_func_type_explicit c ($1 c) ft $loc($1), es }
  | call_expr_params
    { fun c -> let ft, es = $1 c in inline_func_type c ft $loc($1), es }

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
    { fun c c' -> let ft, es = $2 c c' in
      let x = inline_func_type_explicit c ($1 c) ft $sloc in
      VarBlockType x, es }
  | if_block_param_body  /* Sugar */
    { fun c c' -> let ft, es = $1 c c' in
      let bt =
        match ft with
        | FuncT ([], []) -> ValBlockType None
        | FuncT ([], [t]) -> ValBlockType (Some t)
        | ft ->  VarBlockType (inline_func_type c ft $sloc)
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


try_block :
  | type_use try_block_param_body
    { fun c c' ->
      let ft, esh = $2 c c' in
      let bt = VarBlockType (inline_func_type_explicit c' ($1 c') ft $sloc) in
      bt, esh }
  | try_block_param_body  /* Sugar */
    { fun c c' ->
      let ft, esh = $1 c c' in
      let bt =
        match ft with
        | FuncT ([], []) -> ValBlockType None
        | FuncT ([], [t]) -> ValBlockType (Some t)
        | _ ->  VarBlockType (inline_func_type c' ft $sloc)
      in bt, esh }

try_block_param_body :
  | try_block_result_body { $1 }
  | LPAR PARAM val_type_list RPAR try_block_param_body
    { fun c c' -> let FuncT (ts1, ts2), esh = $5 c c' in
      FuncT (snd $3 c @ ts1, ts2), esh }

try_block_result_body :
  | try_block_handler_body { fun c c' -> FuncT ([], []), $1 c c' }
  | LPAR RESULT val_type_list RPAR try_block_result_body
    { fun c c' -> let FuncT (ts1, ts2), esh = $5 c c' in
      FuncT (ts1, snd $3 c @ ts2), esh }

try_block_handler_body :
  | instr_list
    { fun c c' -> [], $1 c' }
  | LPAR CATCH var var RPAR try_block_handler_body
    { fun c c' -> let cs, es = $6 c c' in
      (catch ($3 c tag) ($4 c label) @@ $loc($2)) :: cs, es }
  | LPAR CATCH_REF var var RPAR try_block_handler_body
    { fun c c' -> let cs, es = $6 c c' in
      (catch_ref ($3 c tag) ($4 c label) @@ $loc($2)) :: cs, es }
  | LPAR CATCH_ALL var RPAR try_block_handler_body
    { fun c c' -> let cs, es = $5 c c' in
      (catch_all ($3 c label) @@ $loc($2)) :: cs, es }
  | LPAR CATCH_ALL_REF var RPAR try_block_handler_body
    { fun c c' -> let cs, es = $5 c c' in
      (catch_all_ref ($3 c label) @@ $loc($2)) :: cs, es }


expr_list :
  | /* empty */ { fun c -> [] }
  | expr expr_list { fun c -> $1 c @ $2 c }

const_expr :
  | instr_list { fun c -> $1 c @@ $sloc }

const_expr1 :
  | instr1 instr_list { fun c -> ($1 c @ $2 c) @@ $sloc }


/* Functions */

func :
  | LPAR FUNC bind_var_opt func_fields RPAR
    { fun c -> let x = $3 c anon_func bind_func @@ $sloc in
      fun () -> $4 c x $sloc }

func_fields :
  | type_use func_fields_body
    { fun c x loc ->
      let c' = enter_func c loc in
      let y = inline_func_type_explicit c' ($1 c') (fst $2 c') $loc($1) in
      [{(snd $2 c') with ftype = y} @@ loc], [], [] }
  | func_fields_body  /* Sugar */
    { fun c x loc ->
      let c' = enter_func c loc in
      let y = inline_func_type c' (fst $1 c') loc in
      [{(snd $1 c') with ftype = y} @@ loc], [], [] }
  | inline_import type_use func_fields_import  /* Sugar */
    { fun c x loc ->
      let y = inline_func_type_explicit c ($2 c) ($3 c) $loc($2) in
      [],
      [{ module_name = fst $1; item_name = snd $1;
         idesc = FuncImport y @@ loc } @@ loc ], [] }
  | inline_import func_fields_import  /* Sugar */
    { fun c x loc ->
      let y = inline_func_type c ($2 c) loc in
      [],
      [{ module_name = fst $1; item_name = snd $1;
         idesc = FuncImport y @@ loc } @@ loc ], [] }
  | inline_export func_fields  /* Sugar */
    { fun c x loc ->
      let fns, ims, exs = $2 c x loc in fns, ims, $1 (FuncExport x) c :: exs }

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
    { (fun c -> let FuncT (ts1, ts2) = fst $5 c in
        FuncT (snd $3 c @ ts1, ts2)),
      (fun c -> anon_locals c (fst $3) $loc($3); snd $5 c) }
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
    { fun c -> ignore (anon_label c $sloc);
      {ftype = -1l @@ $sloc; locals = []; body = $1 c} }
  | LPAR LOCAL local_type_list RPAR func_body
    { fun c -> anon_locals c (fst $3) $loc($3); let f = $5 c in
      {f with locals = snd $3 c @ f.Ast.locals} }
  | LPAR LOCAL bind_var local_type RPAR func_body  /* Sugar */
    { fun c -> ignore (bind_local c $3); let f = $6 c in
      {f with locals = $4 c :: f.Ast.locals} }

local_type :
  | val_type { fun c -> {ltype = $1 c} @@ $sloc }

local_type_list :
  | list(local_type)
    { Lib.List32.length $1, fun c -> List.map (fun f -> f c) $1 }


/* Tables, Memories & Globals */

table_use :
  | LPAR TABLE var RPAR { fun c -> $3 c }

memory_use :
  | LPAR MEMORY var RPAR { fun c -> $3 c }

offset :
  | LPAR OFFSET const_expr RPAR { $3 }
  | expr { fun c -> $1 c @@ $sloc }  /* Sugar */

elem_kind :
  | FUNC { (NoNull, FuncHT) }

elem_expr :
  | LPAR ITEM const_expr RPAR { $3 }
  | expr { fun c -> $1 c @@ $sloc }  /* Sugar */

elem_expr_list :
  | /* empty */ { fun c -> [] }
  | elem_expr elem_expr_list { fun c -> $1 c :: $2 c }

elem_var_list :
  | var_list
    { let f = function {at; _} as x -> [ref_func x @@@ at] @@@ at in
      fun c -> List.map f ($1 c func) }

elem_list :
  | elem_kind elem_var_list
    { fun c -> $1, $2 c }
  | ref_type elem_expr_list
    { fun c -> $1 c, $2 c }


elem :
  | LPAR ELEM bind_var_opt elem_list RPAR
    { fun c -> ignore ($3 c anon_elem bind_elem);
      fun () -> let etype, einit = $4 c in
      { etype; einit; emode = Passive @@ $sloc } @@ $sloc }
  | LPAR ELEM bind_var_opt table_use offset elem_list RPAR
    { fun c -> ignore ($3 c anon_elem bind_elem);
      fun () -> let etype, einit = $6 c in
      { etype; einit;
        emode = Active {index = $4 c table; offset = $5 c} @@ $sloc } @@ $sloc }
  | LPAR ELEM bind_var_opt DECLARE elem_list RPAR
    { fun c -> ignore ($3 c anon_elem bind_elem);
      fun () -> let etype, einit = $5 c in
      { etype; einit; emode = Declarative @@ $sloc } @@ $sloc }
  | LPAR ELEM bind_var_opt offset elem_list RPAR  /* Sugar */
    { fun c -> ignore ($3 c anon_elem bind_elem);
      fun () -> let etype, einit = $5 c in
      { etype; einit;
        emode = Active {index = 0l @@ $sloc; offset = $4 c} @@ $sloc } @@ $sloc }
  | LPAR ELEM bind_var_opt offset elem_var_list RPAR  /* Sugar */
    { fun c -> ignore ($3 c anon_elem bind_elem);
      fun () ->
      { etype = (NoNull, FuncHT); einit = $5 c;
        emode = Active {index = 0l @@ $sloc; offset = $4 c} @@ $sloc } @@ $sloc }

table :
  | LPAR TABLE bind_var_opt table_fields RPAR
    { fun c -> let x = $3 c anon_table bind_table @@ $sloc in
      fun () -> $4 c x $sloc }

table_fields :
  | table_type const_expr1
    { fun c x loc -> [{ttype = $1 c; tinit = $2 c} @@ loc], [], [], [] }
  | table_type  /* Sugar */
    { fun c x loc -> let TableT (_, _, (_, ht)) as ttype = $1 c in
      [{ttype; tinit = [RefNull ht @@ loc] @@ loc} @@ loc], [], [], [] }
  | inline_import table_type  /* Sugar */
    { fun c x loc ->
      [], [],
      [{ module_name = fst $1; item_name = snd $1;
        idesc = TableImport ($2 c) @@ loc } @@ loc], [] }
  | inline_export table_fields  /* Sugar */
    { fun c x loc -> let tabs, elems, ims, exs = $2 c x loc in
      tabs, elems, ims, $1 (TableExport x) c :: exs }
  | ref_type LPAR ELEM elem_expr elem_expr_list RPAR  /* Sugar */
    { fun c x loc ->
      let offset = [i32_const (0l @@ loc) @@ loc] @@ loc in
      let einit = $4 c :: $5 c in
      let size = Lib.List32.length einit in
      let size64 = Int64.of_int32 size in
      let emode = Active {index = x; offset} @@ loc in
      let (_, ht) as etype = $1 c in
      let tinit = [RefNull ht @@ loc] @@ loc in
      [{ttype = TableT ({min = size64; max = Some size64}, I32IndexType, etype); tinit} @@ loc],
      [{etype; einit; emode} @@ loc],
      [], [] }
  | ref_type LPAR ELEM elem_var_list RPAR  /* Sugar */
    { fun c x loc ->
      let (_, ht) as etype = $1 c in
      let tinit = [RefNull ht @@ loc] @@ loc in
      table_data tinit $4 I32IndexType etype c x loc }
  | val_type ref_type LPAR ELEM elem_var_list RPAR  /* Sugar */
    { fun c x loc ->
      let (_, ht) as etype = $2 c in
      let tinit = [RefNull ht @@ loc] @@ loc in
      table_data tinit $5 (index_type_of_value_type ($1 c) loc) etype c x loc }

data :
  | LPAR DATA bind_var_opt string_list RPAR
    { fun c -> ignore ($3 c anon_data bind_data);
      fun () -> {dinit = $4; dmode = Passive @@ $sloc} @@ $sloc }
  | LPAR DATA bind_var_opt memory_use offset string_list RPAR
    { fun c -> ignore ($3 c anon_data bind_data);
      fun () ->
      {dinit = $6; dmode = Active {index = $4 c memory; offset = $5 c} @@ $sloc} @@ $sloc }
  | LPAR DATA bind_var_opt offset string_list RPAR  /* Sugar */
    { fun c -> ignore ($3 c anon_data bind_data);
      fun () ->
      {dinit = $5; dmode = Active {index = 0l @@ $sloc; offset = $4 c} @@ $sloc} @@ $sloc }

memory :
  | LPAR MEMORY bind_var_opt memory_fields RPAR
    { fun c -> let x = $3 c anon_memory bind_memory @@ $sloc in
      fun () -> $4 c x $sloc }

memory_fields :
  | memory_type
    { fun c x loc -> [{mtype = $1 c} @@ loc], [], [], [] }
  | inline_import memory_type  /* Sugar */
    { fun c x loc ->
      [], [],
      [{ module_name = fst $1; item_name = snd $1;
         idesc = MemoryImport ($2 c) @@ loc } @@ loc], [] }
  | inline_export memory_fields  /* Sugar */
    { fun c x loc -> let mems, data, ims, exs = $2 c x loc in
      mems, data, ims, $1 (MemoryExport x) c :: exs }
  | LPAR DATA string_list RPAR  /* Sugar */
    { memory_data $3 I32IndexType }
  | val_type LPAR DATA string_list RPAR  /* Sugar */
    { fun c x loc -> memory_data $4 (index_type_of_value_type ($1 c) $sloc) c x loc }

tag :
  | LPAR TAG bind_var_opt tag_fields RPAR
    { fun c -> let x = $3 c anon_tag bind_tag @@ $sloc in fun () -> $4 c x $sloc }

tag_fields :
  | type_use func_type
    { fun c x loc ->
      let tgtype = inline_func_type_explicit c ($1 c) ($2 c) $loc($1) in
      [{tgtype} @@ loc], [], [] }
  | func_type  /* Sugar */
    { fun c x loc ->
      let tgtype = inline_func_type c ($1 c) $sloc in
      [{tgtype} @@ loc], [], [] }
  | inline_import type_use func_type  /* Sugar */
    { fun c x loc ->
      let y = inline_func_type_explicit c ($2 c) ($3 c) $loc($2) in
      [],
      [{ module_name = fst $1; item_name = snd $1;
         idesc = TagImport y @@ loc } @@ loc ], [] }
  | inline_import func_type  /* Sugar */
    { fun c x loc ->
      let y = inline_func_type c ($2 c) $loc($2) in
      [],
      [{ module_name = fst $1; item_name = snd $1;
         idesc = TagImport y @@ loc } @@ loc ], [] }
  | inline_export tag_fields  /* Sugar */
    { fun c x loc ->
      let tgs, ims, exs = $2 c x loc in tgs, ims, $1 (TagExport x) c :: exs }


global :
  | LPAR GLOBAL bind_var_opt global_fields RPAR
    { fun c -> let x = $3 c anon_global bind_global @@ $sloc in
      fun () -> $4 c x $sloc }

global_fields :
  | global_type const_expr
    { fun c x loc -> [{gtype = $1 c; ginit = $2 c} @@ loc], [], [] }
  | inline_import global_type  /* Sugar */
    { fun c x loc ->
      [],
      [{ module_name = fst $1; item_name = snd $1;
         idesc = GlobalImport ($2 c) @@ loc } @@ loc], [] }
  | inline_export global_fields  /* Sugar */
    { fun c x loc -> let globs, ims, exs = $2 c x loc in
      globs, ims, $1 (GlobalExport x) c :: exs }


/* Imports & Exports */

import_desc :
  | LPAR FUNC bind_var_opt type_use RPAR
    { fun c -> ignore ($3 c anon_func bind_func);
      fun () -> FuncImport ($4 c) }
  | LPAR FUNC bind_var_opt func_type RPAR  /* Sugar */
    { fun c -> ignore ($3 c anon_func bind_func);
      fun () -> FuncImport (inline_func_type c ($4 c) $loc($4)) }
  | LPAR TABLE bind_var_opt table_type RPAR
    { fun c -> ignore ($3 c anon_table bind_table);
      fun () -> TableImport ($4 c) }
  | LPAR MEMORY bind_var_opt memory_type RPAR
    { fun c -> ignore ($3 c anon_memory bind_memory);
      fun () -> MemoryImport ($4 c) }
  | LPAR GLOBAL bind_var_opt global_type RPAR
    { fun c -> ignore ($3 c anon_global bind_global);
      fun () -> GlobalImport ($4 c) }
  | LPAR TAG bind_var_opt type_use RPAR
    { fun c -> ignore ($3 c anon_tag bind_tag);
      fun () -> TagImport ($4 c) }
  | LPAR TAG bind_var_opt func_type RPAR  /* Sugar */
    { fun c -> ignore ($3 c anon_tag bind_tag);
      fun () -> TagImport (inline_func_type c ($4 c) $loc($4)) }

import :
  | LPAR IMPORT name name import_desc RPAR
    { fun c -> let df = $5 c in
      fun () -> {module_name = $3; item_name = $4; idesc = df () @@ $loc($5)} @@ $sloc }

inline_import :
  | LPAR IMPORT name name RPAR { $3, $4 }

export_desc :
  | LPAR FUNC var RPAR { fun c -> FuncExport ($3 c func) }
  | LPAR TABLE var RPAR { fun c -> TableExport ($3 c table) }
  | LPAR MEMORY var RPAR { fun c -> MemoryExport ($3 c memory) }
  | LPAR TAG var RPAR { fun c -> TagExport ($3 c tag) }
  | LPAR GLOBAL var RPAR { fun c -> GlobalExport ($3 c global) }

export :
  | LPAR EXPORT name export_desc RPAR
    { fun c -> {name = $3; edesc = $4 c @@ $loc($4)} @@ $sloc }

inline_export :
  | LPAR EXPORT name RPAR
    { fun d c -> {name = $3; edesc = d @@ $sloc} @@ $sloc }


/* Modules */

type_def :
  | LPAR TYPE sub_type RPAR
    { fun c -> let x = anon_type c $sloc in fun () -> $3 c x }
  | LPAR TYPE bind_var sub_type RPAR  /* Sugar */
    { fun c -> let x = bind_type c $3 in fun () -> $4 c x }

type_def_list :
  | /* empty */ { fun c () -> [] }
  | type_def type_def_list
    { fun c -> let tf = $1 c in let tsf = $2 c in fun () ->
      let st = tf () and sts = tsf () in st::sts }

rec_type :
  | type_def
    { fun c -> let tf = $1 c in fun () ->
      let st = tf () in
      define_def_type c (DefT (RecT [st], 0l));
      RecT [st] }
  | LPAR REC type_def_list RPAR
    { fun c -> let tf = $3 c in fun () ->
      let sts = tf () in
      Lib.List32.iteri (fun i _ -> define_def_type c (DefT (RecT sts, i))) sts;
      RecT sts }

type_ :
  | rec_type
    { fun c -> let tf = $1 c in fun () -> define_type c (tf () @@ $sloc) }

start :
  | LPAR START var RPAR
    { fun c -> {sfunc = $3 c func} @@ $sloc }

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
  | tag module_fields
    { fun c -> let ef = $1 c in let mff = $2 c in
      fun () -> let mf = mff () in
      fun () -> let tags, ims, exs = ef () in let m = mf () in
      if tags <> [] && m.imports <> [] then
        error (List.hd m.imports).at "import after tag definition";
      { m with tags = tags @ m.tags;
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
      {m with elems = elems :: m.Ast.elems} }
  | data module_fields
    { fun c -> let df = $1 c in let mff = $2 c in
      fun () -> let mf = mff () in
      fun () -> let data = df () in let m = mf () in
      {m with datas = data :: m.Ast.datas} }
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

module_var :
  | VAR { var $1 $sloc }  /* Sugar */

module_ :
  | LPAR MODULE option(module_var) module_fields RPAR
    { let m = $4 (empty_context ()) () () @@ $sloc in
      $3, Textual (m, parse_annots m) @@ $sloc }

inline_module :  /* Sugar */
  | module_fields
    { let m = $1 (empty_context ()) () () @@ $sloc in
      (* Hack to handle annotations before first and after last token *)
      let all = all_region (at $sloc).left.file in
      Textual (m, parse_annots Source.(m.it @@ all)) @@ $sloc }

inline_module1 :  /* Sugar */
  | module_fields1
    { let m = $1 (empty_context ()) () () @@ $sloc in
      (* Hack to handle annotations before first and after last token *)
      let all = all_region (at $sloc).left.file in
      Textual (m, parse_annots Source.(m.it @@ all)) @@ $sloc }


/* Scripts */

script_var :
  | VAR { var $1 $sloc }  /* Sugar */

instance_var :
  | VAR { var $1 $sloc }  /* Sugar */

definition_opt :
  | DEFINITION { true }
  | /* empty */ { false }

script_module :
  | LPAR MODULE definition_opt option(module_var) module_fields RPAR
    { let m = $5 (empty_context ()) () () @@ $sloc in
      $3, $4, Textual (m, parse_annots m) @@ $sloc }
  | LPAR MODULE definition_opt option(module_var) BIN string_list RPAR
    { let s = $6 @@ $loc($5) in
      $3, $4, Encoded ("binary:" ^ string_of_pos (at $sloc).left, s) @@ $sloc }
  | LPAR MODULE definition_opt option(module_var) QUOTE string_list RPAR
    { let s = $6 @@ $loc($5) in
      $3, $4, Quoted ("quote:" ^ string_of_pos (at $sloc).left, s) @@ $sloc }

script_instance :
  | instance { [], $1 }
  | script_module  /* sugar */
    { let isdef, var_opt, m = $1 in
      if isdef then error (at $sloc) "misplaced module definition";
      [Module (None, m) @@ $sloc], (var_opt, None) }

instance :
  | LPAR MODULE INSTANCE instance_var module_var RPAR
    { Some $4, Some $5 }
  | LPAR MODULE INSTANCE module_var RPAR
    { None, Some $4 }
  | LPAR MODULE INSTANCE RPAR
    { None, None }

action :
  | LPAR INVOKE option(instance_var) name list(literal) RPAR
    { Invoke ($3, $4, $5) @@ $sloc }
  | LPAR GET option(instance_var) name RPAR
    { Get ($3, $4) @@ $sloc }

assertion :
  | LPAR ASSERT_MALFORMED script_module STRING RPAR
    { [], AssertMalformed (thd $3, $4) @@ $sloc }
  | LPAR ASSERT_INVALID script_module STRING RPAR
    { [], AssertInvalid (thd $3, $4) @@ $sloc }
  | LPAR ASSERT_MALFORMED_CUSTOM script_module STRING RPAR
    { [], AssertMalformedCustom (thd $3, $4) @@ $sloc }
  | LPAR ASSERT_INVALID_CUSTOM script_module STRING RPAR
    { [], AssertInvalidCustom (thd $3, $4) @@ $sloc }
  | LPAR ASSERT_UNLINKABLE script_instance STRING RPAR
    { fst $3, AssertUnlinkable (snd (snd $3), $4) @@ $sloc }
  | LPAR ASSERT_TRAP script_instance STRING RPAR
    { fst $3, AssertUninstantiable (snd (snd $3), $4) @@ $sloc }
  | LPAR ASSERT_RETURN action list(result) RPAR
    { [], AssertReturn ($3, $4) @@ $sloc }
  | LPAR ASSERT_EXCEPTION action RPAR
    { [], AssertException $3 @@ $sloc }
  | LPAR ASSERT_TRAP action STRING RPAR
    { [], AssertTrap ($3, $4) @@ $sloc }
  | LPAR ASSERT_EXHAUSTION action STRING RPAR
    { [], AssertExhaustion ($3, $4) @@ $sloc }

cmd :
  | action { [Action $1 @@ $sloc] }
  | assertion { fst $1 @ [Assertion (snd $1) @@ $sloc] }
  | script_module
    { let isdef, var_opt, m = $1 in
      if isdef then
        [Module (var_opt, m) @@ $sloc]
      else (* sugar *)
        [Module (var_opt, m) @@ $sloc; Instance (var_opt, var_opt) @@ $sloc] }
  | instance { [Instance (fst $1, snd $1) @@ $sloc] }
  | LPAR REGISTER name option(instance_var) RPAR { [Register ($3, $4) @@ $sloc] }
  | meta { [Meta $1 @@ $sloc] }

meta :
  | LPAR SCRIPT option(script_var) list(cmd) RPAR { Script ($3, List.concat $4) @@ $sloc }
  | LPAR INPUT option(script_var) STRING RPAR { Input ($3, $4) @@ $sloc }
  | LPAR OUTPUT option(script_var) STRING RPAR { Output ($3, Some $4) @@ $sloc }
  | LPAR OUTPUT option(script_var) RPAR { Output ($3, None) @@ $sloc }

literal_num :
  | LPAR CONST num RPAR { snd (num $2 $3) }

literal_vec :
  | LPAR VEC_CONST VEC_SHAPE list(num) RPAR { snd (vec $2 $3 $4 $sloc) }

literal_ref :
  | LPAR REF_NULL heap_type RPAR { Value.NullRef ($3 (empty_context ())) }
  | LPAR REF_HOST NAT RPAR { Script.HostRef (nat32 $3 $loc($3)) }
  | LPAR REF_EXTERN NAT RPAR { Extern.ExternRef (Script.HostRef (nat32 $3 $loc($3))) }

literal :
  | literal_num { Value.Num $1 @@ $sloc }
  | literal_vec { Value.Vec $1 @@ $sloc }
  | literal_ref { Value.Ref $1 @@ $sloc }

numpat :
  | num { fun sh -> vec_lane_lit sh $1.it $1.at }
  | NAN { fun sh -> vec_lane_nan sh $1 (at $sloc) }

result :
  | literal_num { NumResult (NumPat ($1 @@ $sloc)) @@ $sloc }
  | LPAR CONST NAN RPAR { NumResult (NanPat (nanop $2 ($3 @@ $loc($3)))) @@ $sloc }
  | literal_ref { RefResult (RefPat ($1 @@ $sloc)) @@ $sloc }
  | LPAR REF RPAR { RefResult (RefTypePat AnyHT) @@ $sloc }
  | LPAR REF_EQ RPAR { RefResult (RefTypePat EqHT) @@ $sloc }
  | LPAR REF_I31 RPAR { RefResult (RefTypePat I31HT) @@ $sloc }
  | LPAR REF_STRUCT RPAR { RefResult (RefTypePat StructHT) @@ $sloc }
  | LPAR REF_ARRAY RPAR { RefResult (RefTypePat ArrayHT) @@ $sloc }
  | LPAR REF_FUNC RPAR { RefResult (RefTypePat FuncHT) @@ $sloc }
  | LPAR REF_EXN RPAR { RefResult (RefTypePat ExnHT) @@ $sloc }
  | LPAR REF_EXTERN RPAR { RefResult (RefTypePat ExternHT) @@ $sloc }
  | LPAR REF_NULL RPAR { RefResult NullPat @@ $sloc }
  | LPAR VEC_CONST VEC_SHAPE list(numpat) RPAR
    { if V128.num_lanes $3 <> List.length $4 then
        error (at $sloc) "wrong number of lane literals";
      VecResult (VecPat
        (Value.V128 ($3, List.map (fun lit -> lit $3) $4))) @@ $sloc }

script :
  | list(cmd) EOF { List.concat $1 }
  | inline_module1 EOF { [Module (None, $1) @@ $sloc] }  /* Sugar */

script1 :
  | cmd { $1 }

module1 :
  | module_ EOF { $1 }
  | inline_module EOF { None, $1 }  /* Sugar */
%%
