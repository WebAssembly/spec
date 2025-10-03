open Ast
open Xl
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
let popsI ?(at = no) e _ = PopI e |> mk_instr at (* TODO *)
let popAllI ?(at = no) e = PopAllI e |> mk_instr at
let letI ?(at = no) (e1, e2) = LetI (e1, e2) |> mk_instr at
let trapI ?(at = no) () = TrapI |> mk_instr at
let failI ?(at = no) () = FailI |> mk_instr at
let throwI ?(at = no) e = ThrowI e |> mk_instr at
let nopI ?(at = no) () = NopI |> mk_instr at
let returnI ?(at = no) e_opt = ReturnI e_opt |> mk_instr at
let executeI ?(at = no) e = ExecuteI e |> mk_instr at
let executeSeqI ?(at = no) e = ExecuteSeqI e |> mk_instr at
let performI ?(at = no) (id, el) = PerformI (id, el) |> mk_instr at
let exitI ?(at = no) a = ExitI a |> mk_instr at
let replaceI ?(at = no) (e1, p, e2) = ReplaceI (e1, p, e2) |> mk_instr at
let appendI ?(at = no) (e1, e2) = AppendI (e1, e2) |> mk_instr at
let forEachI ?(at = no) (xes, il) = ForEachI (xes, il) |> mk_instr at
let otherwiseI ?(at = no) il = OtherwiseI il |> mk_instr at
let yetI ?(at = no) s = YetI s |> mk_instr at

let mk_expr at note it = it $$ at % note

let varE ?(at = no) ~note id = VarE id |> mk_expr at note
let boolE ?(at = no) ~note b = BoolE b |> mk_expr at note
let numE ?(at = no) ~note i = NumE i |> mk_expr at note
let natE ?(at = no) ~note i = NumE (`Nat i) |> mk_expr at note
let cvtE ?(at = no) ~note (e, nt1, nt2) = CvtE (e, nt1, nt2) |> mk_expr at note
let unE ?(at = no) ~note (unop, e) = UnE (unop, e) |> mk_expr at note
let binE ?(at = no) ~note (binop, e1, e2) = BinE (binop, e1, e2) |> mk_expr at note
let accE ?(at = no) ~note (e, p) = AccE (e, p) |> mk_expr at note
let updE ?(at = no) ~note (e1, pl, e2) = UpdE (e1, pl, e2) |> mk_expr at note
let extE ?(at = no) ~note (e1, pl, e2, dir) = ExtE (e1, pl, e2, dir) |> mk_expr at note
let strE ?(at = no) ~note r = StrE r |> mk_expr at note
let compE ?(at = no) ~note (e1, e2) = CompE (e1, e2) |> mk_expr at note
let liftE ?(at = no) ~note e = LiftE e |> mk_expr at note
let catE ?(at = no) ~note (e1, e2) = CatE (e1, e2) |> mk_expr at note
let memE ?(at = no) ~note (e1, e2) = MemE (e1, e2) |> mk_expr at note
let lenE ?(at = no) ~note e = LenE e |> mk_expr at note
let tupE ?(at = no) ~note el = TupE el |> mk_expr at note
let caseE ?(at = no) ~note (op, el) = CaseE (op, el) |> mk_expr at note
let callE ?(at = no) ~note (id, el) = CallE (id, el) |> mk_expr at note
let invCallE ?(at = no) ~note (id, il, el) = InvCallE (id, il, el) |> mk_expr at note
let iterE ?(at = no) ~note (e, ite) = IterE (e, ite) |> mk_expr at note
let optE ?(at = no) ~note e_opt = OptE e_opt |> mk_expr at note
let listE ?(at = no) ~note el = ListE el |> mk_expr at note
let getCurStateE ?(at = no) ~note () = GetCurStateE |> mk_expr at note
let getCurContextE ?(at = no) ~note e = GetCurContextE e |> mk_expr at note
let chooseE ?(at = no) ~note e = ChooseE e |> mk_expr at note
let isCaseOfE ?(at = no) ~note (e, a) = IsCaseOfE (e, a) |> mk_expr at note
let isValidE ?(at = no) ~note e = IsValidE e |> mk_expr at note
let contextKindE ?(at = no) ~note a = ContextKindE a |> mk_expr at note
let isDefinedE ?(at = no) ~note e = IsDefinedE e |> mk_expr at note
let matchE ?(at = no) ~note (e1, e2) = MatchE (e1, e2) |> mk_expr at note
let hasTypeE ?(at = no) ~note (e, ty) = HasTypeE (e, ty) |> mk_expr at note
let topValueE ?(at = no) ~note e_opt = TopValueE e_opt |> mk_expr at note
let topValuesE ?(at = no) ~note e = TopValuesE e |> mk_expr at note
let subE ?(at = no) ~note (id, ty) = SubE (id, ty) |> mk_expr at note
let yetE ?(at = no) ~note s = YetE s |> mk_expr at note

let expA ?(at = no) e = ExpA e $ at
let typA ?(at = no) ty = TypA ty $ at
let defA ?(at = no) id = DefA id $ at

let mk_path at it = Util.Source.($) it at

let idxP ?(at = no) e = IdxP e |> mk_path at
let sliceP ?(at = no) (e1, e2) = SliceP (e1, e2) |> mk_path at
let dotP ?(at = no) a = DotP a |> mk_path at

let numV n = NumV n
let natV i = assert (i >= Z.zero); NumV (`Nat i)
let intV i = NumV (`Int i)
let natV_of_int i = Z.of_int i |> natV
let boolV b = BoolV b
let strV r = StrV r
let caseV (s, vl) = CaseV (s, vl)
let optV v_opt = OptV v_opt
let noneV = OptV None
let someV v = OptV (Some v)
let tupV vl = TupV vl
let nullary s = CaseV (String.uppercase_ascii s, [])
let listV a = ListV (ref a)
let listV_of_list l = Array.of_list l |> listV
let zero = natV Z.zero
let one = natV Z.one
let empty_list = listV [||]
let singleton v = listV [|v|]
let iter_var ?(at = no) x iter t =
  let xs = x ^ (match iter with Opt -> "?" | _ -> "*") in
  let il_iter = match iter with Opt -> Il.Ast.Opt | _ -> Il.Ast.List in
  let iter_note = Il.Ast.IterT (t, il_iter) $ t.at in
  iterE (varE x ~at:at ~note:t, (iter, [x, varE xs ~at:at ~note:iter_note]))
    ~at:at ~note:iter_note


let some x = optV (Some (caseV (x, [])))
let none _x = optV None


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

let listv_len = function
  | ListV arr_ref -> Array.length !arr_ref
  | v -> fail_value "listv_len" v

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

let listv_singleton l =
  match l with
  | ListV arr_ref when Array.length !arr_ref = 1 -> Array.get !arr_ref 0
  | v -> fail_value "listv_singleton" v

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

let rec typ_to_var_name ty =
  match ty.it with
  (* TODO: guess this for "var" in el? *)
  | Il.Ast.VarT (id, _) -> id.it
  | Il.Ast.BoolT -> "b"
  | Il.Ast.NumT `NatT -> "n"
  | Il.Ast.NumT `IntT -> "i"
  | Il.Ast.NumT `RatT -> "q"
  | Il.Ast.NumT `RealT -> "r"
  | Il.Ast.TextT -> "s"
  | Il.Ast.TupT tys -> List.map typ_to_var_name (List.map snd tys) |> String.concat "_"
  | Il.Ast.IterT (t, _) -> typ_to_var_name t

let context_names = [
  "FRAME_";
  "LABEL_";
  "HANDLER_";
]

let rec mk_access ps base =
  match ps with
  (* TODO: type *)
  | h :: t -> accE (base, h) ~note:no_note |> mk_access t
  | [] -> base

(* Destruct *)

let unwrap_optv: value -> value option = function
  | OptV opt -> opt
  | v -> fail_value "unwrap_optv" v

let unwrap_listv: value -> value growable_array = function
  | ListV ga -> ga
  | v -> fail_value "unwrap_listv" v

let unwrap_listv_to_array (v: value): value array = !(unwrap_listv v)
let unwrap_listv_to_list (v: value): value list = unwrap_listv_to_array v |> Array.to_list

let unwrap_seqv_to_list: value -> value list = function
  | OptV opt -> Option.to_list opt
  | ListV arr -> Array.to_list !arr
  | v -> fail_value "unwrap_seqv_to_list" v
let unwrap_seq_to_array: value -> value array = function
  | OptV opt -> opt |> Option.to_list |> Array.of_list
  | v -> unwrap_listv_to_array v

let unwrap_textv: value -> string = function
  | TextV str -> str
  | v -> fail_value "unwrap_textv" v

let unwrap_numv: value -> Num.num = function
  | NumV n -> n
  | v -> fail_value "unwrap_numv" v

let unwrap_natv v =
  match unwrap_numv v with
  | `Nat n -> assert (n >= Z.zero); n
  | n -> fail_value "unwrap_natv" (NumV n)

let unwrap_intv v =
  match unwrap_numv v with
  | `Int i -> i
  | n -> fail_value "unwrap_natv" (NumV n)

let unwrap_natv_to_int (v: value): int = unwrap_natv v |> Z.to_int

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
  | RuleA (name, _, _, _) -> Print.string_of_atom name
  | FuncA (name, _, _) -> name

let params_of_algo algo = match algo.it with
  | RuleA (_, _, params, _) -> params
  | FuncA (_, params, _) -> params

let body_of_algo algo = match algo.it with
  | RuleA (_, _, _, body) -> body
  | FuncA (_, _, body) -> body

let args_of_casev = function
  | CaseV (_, vl) -> vl
  | v -> fail_value "args_of_casev" v

let arity_of_framev: value -> value = function
  | CaseV ("FRAME_", [v; _]) -> v
  | v -> fail_value "arity_of_framev" v

let unwrap_framev: value -> value = function
  | CaseV ("FRAME_", [_; v]) -> v
  | v -> fail_value "unwrap_framev" v


(* Mixop *)

let atom_of_name name typ = Atom.Atom name $$ no_region % (Atom.info typ)
let atom_of_atom' atom' typ = atom' $$ no_region % (Atom.info typ)

let frame_atom = atom_of_name "FRAME_" "evalctx"
let frameE ?(at = no) ~note (arity, e) =
  let frame_mixop = [[frame_atom]; [atom_of_atom' Atom.LBrace "evalctx"]; [atom_of_atom' Atom.RBrace "evalctx"]] in
  caseE (frame_mixop, [arity; e]) ~at:at ~note:note


let get_atom op =
  match List.find_opt (fun al -> al <> []) op with
  | Some al -> Some (List.hd al)
  | None -> None

let name_of_mixop = Mixop.name

(* Il Types *)

(* name for tuple type *)
let no_name = Il.Ast.VarE ("_" $ no_region) $$ no_region % (Il.Ast.TextT $ no_region)
let varT id args = Il.Ast.VarT (id $ no_region, args) $ no_region
let iterT ty iter = Il.Ast.IterT (ty, iter) $ no_region
let listT ty = iterT ty Il.Ast.List
let listnT ty n = Il.Ast.IterT (ty, Il.Ast.ListN (n, None)) $ no_region
let boolT = Il.Ast.BoolT $ no_region
let natT = Il.Ast.NumT `NatT $ no_region
let topT = varT "TOP" []
let valT = varT "val" []
let frameT = varT "frame" []
let stateT = varT "state" []
let storeT = varT "store" []
let instrT = varT "instr" []
let admininstrT = varT "admininstr" []
let evalctxT = varT "evalctx" []
