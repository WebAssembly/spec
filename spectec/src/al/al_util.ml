open Ast
open Util

(* Constructor Shorthands *)

let no = Util.Source.no_region

let _nid_count = ref 0
let gen_nid () =
  let nid = !_nid_count in
  _nid_count := nid + 1;
  nid

let mk_instr at it = Util.Source.($$) it (at, gen_nid())

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
let exitI ?(at = no) () = ExitI |> mk_instr at
let replaceI ?(at = no) (e1, p, e2) = ReplaceI (e1, p, e2) |> mk_instr at
let appendI ?(at = no) (e1, e2) = AppendI (e1, e2) |> mk_instr at
let otherwiseI ?(at = no) il = OtherwiseI il |> mk_instr at
let yetI ?(at = no) s = YetI s |> mk_instr at

let mk_expr at it = Util.Source.($) it at

let varE ?(at = no) id = VarE id |> mk_expr at
let boolE ?(at = no) b = BoolE b |> mk_expr at
let numE ?(at = no) i = NumE i |> mk_expr at
let unE ?(at = no) (unop, e) = UnE (unop, e) |> mk_expr at
let binE ?(at = no) (binop, e1, e2) = BinE (binop, e1, e2) |> mk_expr at
let accE ?(at = no) (e, p) = AccE (e, p) |> mk_expr at
let updE ?(at = no) (e1, pl, e2) = UpdE (e1, pl, e2) |> mk_expr at
let extE ?(at = no) (e1, pl, e2, dir) = ExtE (e1, pl, e2, dir) |> mk_expr at
let strE ?(at = no) r = StrE r |> mk_expr at
let catE ?(at = no) (e1, e2) = CatE (e1, e2) |> mk_expr at
let lenE ?(at = no) e = LenE e |> mk_expr at
let tupE ?(at = no) el = TupE el |> mk_expr at
let caseE ?(at = no) (kwd, el) = CaseE (kwd, el) |> mk_expr at
let callE ?(at = no) (id, el) = CallE (id, el) |> mk_expr at
let iterE ?(at = no) (e, idl, it) = IterE (e, idl, it) |> mk_expr at
let optE ?(at = no) e_opt = OptE e_opt |> mk_expr at
let listE ?(at = no) el = ListE el |> mk_expr at
let infixE ?(at = no) (e1, infix, e2) = InfixE (e1, infix, e2) |> mk_expr at
let arityE ?(at = no) e = ArityE e |> mk_expr at
let frameE ?(at = no) (e_opt, e) = FrameE (e_opt, e) |> mk_expr at
let labelE ?(at = no) (e1, e2) = LabelE (e1, e2) |> mk_expr at
let getCurFrameE ?(at = no) () = GetCurFrameE |> mk_expr at
let getCurLabelE ?(at = no) () = GetCurLabelE |> mk_expr at
let getCurContextE ?(at = no) () = GetCurContextE |> mk_expr at
let contE ?(at = no) e = ContE e |> mk_expr at
let isCaseOfE ?(at = no) (e, kwd) = IsCaseOfE (e, kwd) |> mk_expr at
let isValidE ?(at = no) e = IsValidE e |> mk_expr at
let contextKindE ?(at = no) (kwd, e) = ContextKindE (kwd, e) |> mk_expr at
let isDefinedE ?(at = no) e = IsDefinedE e |> mk_expr at
let matchE ?(at = no) (e1, e2) = MatchE (e1, e2) |> mk_expr at
let hasTypeE ?(at = no) (e, ty) = HasTypeE (e, ty) |> mk_expr at
let topLabelE ?(at = no) () = TopLabelE |> mk_expr at
let topFrameE ?(at = no) () = TopFrameE |> mk_expr at
let topValueE ?(at = no) e_opt = TopValueE e_opt |> mk_expr at
let topValuesE ?(at = no) e = TopValuesE e |> mk_expr at
let subE ?(at = no) (id, ty) = SubE (id, ty) |> mk_expr at
let yetE ?(at = no) s = YetE s |> mk_expr at

let mk_path at it = Util.Source.($) it at

let idxP ?(at = no) e = IdxP e |> mk_path at
let sliceP ?(at = no) (e1, e2) = SliceP (e1, e2) |> mk_path at
let dotP ?(at = no) kwd = DotP kwd |> mk_path at

let numV i = NumV i
let numV_of_int i = Z.of_int i |> numV
let boolV b = BoolV b
let vecV vec = VecV vec
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


(* Helper functions *)

let listv_map f = function
  | ListV arr_ref -> ListV (ref (Array.map f !arr_ref))
  | _ -> failwith "Not a list"


let listv_find f = function
  | ListV arr_ref -> Array.find_opt f !arr_ref |> Option.get
  | _ -> failwith "Not a list"

let listv_nth l n =
  match l with
  | ListV arr_ref -> Array.get !arr_ref n
  | _ -> failwith "Not a list"

let strv_access field = function
  | StrV r -> Record.find field r
  | _ -> failwith "Not a record"

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


(* Destruct *)

(* TODO: move to error file *)
let fail ty v =
  Print.string_of_value v
  |> Printf.sprintf "Invalid %s: %s" ty
  |> failwith

let unwrap_optv: value -> value option = function
  | OptV opt -> opt
  | v -> fail "OptV" v
let unwrap_listv: value -> value growable_array = function
  | ListV ga -> ga
  | v -> fail "ListV" v
let unwrap_listv_to_array (v: value): value array = !(unwrap_listv v)
let unwrap_listv_to_list (v: value): value list = unwrap_listv_to_array v |> Array.to_list

let get_name = function
  | RuleA ((name, _), _, _) -> name
  | FuncA (name, _, _) -> name

let get_param = function
  | RuleA (_, params, _) -> params
  | FuncA (_, params, _) -> params

let get_body = function
  | RuleA (_, _, body) -> body
  | FuncA (_, _, body) -> body

let unwrap_textv: value -> string = function
  | TextV str -> str
  | v -> fail "text" v
let unwrap_numv: value -> Z.t = function
  | NumV i -> i
  | v -> fail "int64" v
let unwrap_numv_to_int (v: value): int = unwrap_numv v |> Z.to_int
let unwrap_boolv: value -> bool = function
  | BoolV b -> b
  | v -> fail "boolean" v
let unwrap_vecv: value -> vec128 = function
  | VecV v -> v
  | v -> fail "vector" v
let unwrap_tupv: value -> value list = function
  | TupV l -> l
  | v -> fail "tuple" v
let casev_of_case = function
  | CaseV (s, _) -> s
  | v -> fail "case" v
let casev_replace_nth_arg i v = function
  | CaseV (s, args) -> CaseV (s, List.mapi (fun index e -> if index = i then v else e) args)
  | v -> fail "case" v
let casev_nth_arg n = function
  | CaseV (_, l) when List.length l > n -> List.nth l n
  | v -> fail "case" v
let unwrap_strv = function
  | StrV r -> r
  | v -> fail "struct" v

let arity_of_frame: value -> value = function
  | FrameV (Some v, _) -> v
  | v -> fail "frame" v
let unwrap_frame: value -> value = function
  | FrameV (_, v) -> v
  | v -> fail "frame" v
