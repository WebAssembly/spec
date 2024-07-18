open Ast
open Util
open Source


(* Constructor Shorthands *)

let no = no_region
let no_note = Il.Ast.VarT ("TODO" $ no_region, []) $ no_region

let _nid_count = ref 0
let gen_nid () =
  let nid = !_nid_count in
  _nid_count := nid + 1;
  nid

let mk_instr at it = it $$ (at, gen_nid())

let ifI ?(at = no) (c, il1, il2) = IfI (c, il1, il2) |> mk_instr at
let eitherI ?(at = no) (il1, il2) = EitherI (il1, il2) |> mk_instr at
let enterI ?(at = no) (e1, e2, il) = EnterI (e1, e2, il) |> mk_instr at
let assertI ?(at = no) c = AssertI c |> mk_instr at
let pushI ?(at = no) e = PushI e |> mk_instr at
let popI ?(at = no) e = PopI e |> mk_instr at
let popallI ?(at = no) e = PopAllI e |> mk_instr at
let letI ?(at = no) (e1, e2) = LetI (e1, e2) |> mk_instr at
let trapI ?(at = no) () = TrapI |> mk_instr at
let nopI ?(at = no) () = NopI |> mk_instr at
let returnI ?(at = no) e_opt = ReturnI e_opt |> mk_instr at
let executeI ?(at = no) e = ExecuteI e |> mk_instr at
let executeseqI ?(at = no) e = ExecuteSeqI e |> mk_instr at
let performI ?(at = no) (id, el) = PerformI (id, el) |> mk_instr at
let exitI ?(at = no) a = ExitI a |> mk_instr at
let replaceI ?(at = no) (e1, p, e2) = ReplaceI (e1, p, e2) |> mk_instr at
let appendI ?(at = no) (e1, e2) = AppendI (e1, e2) |> mk_instr at
let otherwiseI ?(at = no) il = OtherwiseI il |> mk_instr at
let yetI ?(at = no) s = YetI s |> mk_instr at

let mk_expr at note it = it $$ at % note

let varE ?(at = no) ?(note = no_note) id = VarE id |> mk_expr at note
let boolE ?(at = no) ?(note = no_note) b = BoolE b |> mk_expr at note
let numE ?(at = no) ?(note = no_note) i = NumE i |> mk_expr at note
let unE ?(at = no) ?(note = no_note) (unop, e) = UnE (unop, e) |> mk_expr at note
let binE ?(at = no) ?(note = no_note) (binop, e1, e2) = BinE (binop, e1, e2) |> mk_expr at note
let accE ?(at = no) ?(note = no_note) (e, p) = AccE (e, p) |> mk_expr at note
let updE ?(at = no) ?(note = no_note) (e1, pl, e2) = UpdE (e1, pl, e2) |> mk_expr at note
let extE ?(at = no) ?(note = no_note) (e1, pl, e2, dir) = ExtE (e1, pl, e2, dir) |> mk_expr at note
let strE ?(at = no) ?(note = no_note) r = StrE r |> mk_expr at note
let catE ?(at = no) ?(note = no_note) (e1, e2) = CatE (e1, e2) |> mk_expr at note
let memE ?(at = no) ?(note = no_note) (e1, e2) = MemE (e1, e2) |> mk_expr at note
let lenE ?(at = no) ?(note = no_note) e = LenE e |> mk_expr at note
let tupE ?(at = no) ?(note = no_note) el = TupE el |> mk_expr at note
let caseE ?(at = no) ?(note = no_note) (a, el) = CaseE (a, el) |> mk_expr at note
let callE ?(at = no) ?(note = no_note) (id, el) = CallE (id, el) |> mk_expr at note
let invCallE ?(at = no) ?(note = no_note) (id, il, el) = InvCallE (id, il, el) |> mk_expr at note
let iterE ?(at = no) ?(note = no_note) (e, idl, it) = IterE (e, idl, it) |> mk_expr at note
let optE ?(at = no) ?(note = no_note) e_opt = OptE e_opt |> mk_expr at note
let listE ?(at = no) ?(note = no_note) el = ListE el |> mk_expr at note
let infixE ?(at = no) ?(note = no_note) (e1, infix, e2) = InfixE (e1, infix, e2) |> mk_expr at note
let arityE ?(at = no) ?(note = no_note) e = ArityE e |> mk_expr at note
let frameE ?(at = no) ?(note = no_note) (e_opt, e) = FrameE (e_opt, e) |> mk_expr at note
let labelE ?(at = no) ?(note = no_note) (e1, e2) = LabelE (e1, e2) |> mk_expr at note
let getCurStateE ?(at = no) ?(note = no_note) () = GetCurStateE |> mk_expr at note
let getCurFrameE ?(at = no) ?(note = no_note) () = GetCurFrameE |> mk_expr at note
let getCurLabelE ?(at = no) ?(note = no_note) () = GetCurLabelE |> mk_expr at note
let getCurContextE ?(at = no) ?(note = no_note) () = GetCurContextE |> mk_expr at note
let contE ?(at = no) ?(note = no_note) e = ContE e |> mk_expr at note
let isCaseOfE ?(at = no) ?(note = no_note) (e, a) = IsCaseOfE (e, a) |> mk_expr at note
let isValidE ?(at = no) ?(note = no_note) e = IsValidE e |> mk_expr at note
let contextKindE ?(at = no) ?(note = no_note) (a, e) = ContextKindE (a, e) |> mk_expr at note
let isDefinedE ?(at = no) ?(note = no_note) e = IsDefinedE e |> mk_expr at note
let matchE ?(at = no) ?(note = no_note) (e1, e2) = MatchE (e1, e2) |> mk_expr at note
let hasTypeE ?(at = no) ?(note = no_note) (e, ty) = HasTypeE (e, ty) |> mk_expr at note
let topLabelE ?(at = no) ?(note = no_note) () = TopLabelE |> mk_expr at note
let topFrameE ?(at = no) ?(note = no_note) () = TopFrameE |> mk_expr at note
let topValueE ?(at = no) ?(note = no_note) e_opt = TopValueE e_opt |> mk_expr at note
let topValuesE ?(at = no) ?(note = no_note) e = TopValuesE e |> mk_expr at note
let subE ?(at = no) ?(note = no_note) (id, ty) = SubE (id, ty) |> mk_expr at note
let yetE ?(at = no) ?(note = no_note) s = YetE s |> mk_expr at note

let mk_path at it = Util.Source.($) it at

let idxP ?(at = no) e = IdxP e |> mk_path at
let sliceP ?(at = no) (e1, e2) = SliceP (e1, e2) |> mk_path at
let dotP ?(at = no) a = DotP a |> mk_path at

let numV i = NumV i
let numV_of_int i = Z.of_int i |> numV
let boolV b = BoolV b
let strV r = StrV r
let caseV (s, vl) = CaseV (s, vl)
let optV v_opt = OptV v_opt
let tupV vl = TupV vl
let nullary s = CaseV (String.uppercase_ascii s, [])
let listV a = ListV (ref a)
let listV_of_list l = Array.of_list l |> listV
let zero = numV Z.zero
let one = numV Z.one
let empty_list = listV [||]
let singleton v = listV [|v|]


let some x = caseV (x, [optV (Some (tupV []))])
let none x = caseV (x, [optV None])


(* Failures *)

let fail_value msg v =
  Print.string_of_value v
  |> Printf.sprintf "%s: %s" msg
  |> failwith

let fail_expr msg e =
  Print.string_of_expr e
  |> Printf.sprintf "%s: %s" msg
  |> failwith

let print_yet at category msg =
  (string_of_region at ^ ": ") ^ (category ^ ": Yet " ^ msg)
  |> print_endline

(* Helper functions *)

let listv_map f = function
  | ListV arr_ref -> ListV (ref (Array.map f !arr_ref))
  | v -> fail_value "listv_map" v

let listv_find f = function
  | ListV arr_ref -> Array.find_opt f !arr_ref |> Option.get
  | v -> fail_value "listv_find" v

let listv_nth l n =
  match l with
  | ListV arr_ref -> Array.get !arr_ref n
  | v -> fail_value "listv_nth" v

let strv_access field = function
  | StrV r -> Record.find field r
  | v -> fail_value "strv_access" v

let map
  (destruct: value -> 'a)
  (construct: 'b -> value)
  (op: 'a -> 'b)
  (v: value): value =
    destruct v |> op |> construct
let map2
  (destruct: value -> 'a)
  (construct: 'b -> value)
  (op: 'a -> 'a -> 'b)
  (v1: value)
  (v2: value): value =
    op (destruct v1) (destruct v2) |> construct

let iter_type_of_value: value -> iter = function
  | ListV _ -> List
  | OptV _ -> Opt
  | v -> fail_value "iter_type_of_value" v


(* Destruct *)

let unwrap_optv: value -> value option = function
  | OptV opt -> opt
  | v -> fail_value "unwrap_optv" v

let unwrap_listv: value -> value growable_array = function
  | ListV ga -> ga
  | v -> fail_value "unwrap_listv" v

let unwrap_listv_to_array (v: value): value array = !(unwrap_listv v)
let unwrap_listv_to_list (v: value): value list = unwrap_listv_to_array v |> Array.to_list

let unwrap_textv: value -> string = function
  | TextV str -> str
  | v -> fail_value "unwrap_textv" v

let unwrap_numv: value -> Z.t = function
  | NumV i -> i
  | v -> fail_value "unwrap_numv" v

let unwrap_numv_to_int (v: value): int = unwrap_numv v |> Z.to_int

let unwrap_boolv: value -> bool = function
  | BoolV b -> b
  | v -> fail_value "unwrap_boolv" v

let unwrap_tupv: value -> value list = function
  | TupV l -> l
  | v -> fail_value "unwrap_tupv" v

let unwrap_strv = function
  | StrV r -> r
  | v -> fail_value "unwrap_strv" v

let unwrap_cate e =
  match e.it with
  | CatE (e1, e2) -> e1, e2
  | _ -> fail_expr "unwrap_cate" e

let name_of_algo algo = match algo.it with
  | RuleA (name, _, _) -> Print.string_of_atom name
  | FuncA (name, _, _) -> name

let params_of_algo algo = match algo.it with
  | RuleA (_, params, _) -> params
  | FuncA (_, params, _) -> params

let body_of_algo algo = match algo.it with
  | RuleA (_, _, body) -> body
  | FuncA (_, _, body) -> body

let args_of_casev = function
  | CaseV (_, vl) -> vl
  | v -> fail_value "args_of_casev" v

let arity_of_framev: value -> value = function
  | FrameV (Some v, _) -> v
  | v -> fail_value "arity_of_framev" v

let unwrap_framev: value -> value = function
  | FrameV (_, v) -> v
  | v -> fail_value "unwrap_framev" v
