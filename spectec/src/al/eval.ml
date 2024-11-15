open Ast
open Print
open Walk
open Util
open Source

let (let*) = Option.bind

module Subst = struct
  include Map.Make(String)

  let subst_exp s e =
    let subst_exp' walker e =
      match e.it with
      | VarE id when mem id s -> find id s
      | _ -> base_walker.walk_expr walker e
    in
    let walker = {base_walker with walk_expr = subst_exp'} in
    walker.walk_expr walker e
end

let rec get_subst lhs rhs s =
  match lhs.it, rhs.it with
  | VarE id, _ -> Some (Subst.add id rhs s)
  | UnE (op1, e1), UnE (op2, e2) when op1 = op2 -> get_subst e1 e2 s
  | OptE (Some e1), OptE (Some e2) ->
    get_subst e1 e2 s
  | BinE (op1, e11, e12), BinE (op2, e21, e22) when op1 = op2 ->
    let* s = s |> get_subst e11 e21 in
    get_subst e12 e22 s
  | CompE (e11, e12), CompE (e21, e22) | CatE (e11, e12), CatE (e21, e22) ->
    let* s = s |> get_subst e11 e21 in
    get_subst e12 e22 s
  | TupE el1, TupE el2 | ListE el1, ListE el2 ->
    List.fold_right2 (fun e1 e2 s -> let* s = s in get_subst e1 e2 s)
      el1 el2 (Some s)
  | CaseE (name1, el1), CaseE (name2, el2) when name1 = name2 ->
    List.fold_right2 (fun e1 e2 s -> let* s = s in get_subst e1 e2 s)
      el1 el2 (Some s)
  | StrE r1, StrE r2 ->
    List.fold_left (fun s (k, e) -> let* s = s in get_subst !e (Record.find k r2) s) (Some s) r1
  (* | IterE _, _ -> (* TODO *) s *)
  | _, _ when Eq.eq_expr lhs rhs -> Some s
  | _ -> None

let get_subst_arg param arg s =
  match param.it, arg.it with
  | ExpA e1, ExpA e2 -> get_subst e1 e2 s
  | _ -> Some s

let ($>) it e = {e with it}

let as_opt_exp e =
  match e.it with
  | OptE eo -> eo
  | _ -> failwith "as_opt_exp"

let as_list_exp e =
    match e.it with
    | ListE es -> es
    | _ -> failwith "as_list_exp"
    
let is_head_normal_exp e =
  match e.it with
  | BoolE _ | NumE _ | UnE (MinusOp, {it = NumE _; _}) | SubE _
  | OptE _ | ListE _ | TupE _ | CaseE _ | StrE _-> true
  | _ -> false
    
let rec is_normal_exp e =
  match e.it with
  | BoolE _ | NumE _ | UnE (MinusOp, {it = NumE _; _}) | SubE _ -> true
  | ListE es | TupE es | CaseE (_, es) -> List.for_all is_normal_exp es
  | OptE None -> true
  | OptE (Some e) -> is_normal_exp e
  | StrE efs -> List.for_all (fun (_, e) -> is_normal_exp !e) efs
  | _ -> false

let rec reduce_exp s e : expr =
  Debug_log.(log "al.reduce_exp"
    (fun _ -> fmt "%s" (string_of_expr e))
    (fun e' -> fmt "%s" (string_of_expr e'))
  ) @@ fun _ ->
  match e.it with
  | VarE _ | BoolE _ | NumE _ -> e
  | UnE (op, e1) ->
    let e1' = reduce_exp s e1 in
    (match op, e1'.it with
    | NotOp, BoolE b -> BoolE (not b) $> e
    | NotOp, UnE (NotOp, e11) -> e11
    | MinusOp, UnE (MinusOp, e11) -> e11
    | _ -> UnE (op, e1') $> e
    )
  | BinE (op, e1, e2) ->
    let e1' = reduce_exp s e1 in
    let e2' = reduce_exp s e2 in
    (match op, e1'.it, e2'.it with
    | AndOp, BoolE true, _ -> e2'
    | AndOp, BoolE false, _ -> e1'
    | AndOp, _, BoolE true -> e1'
    | AndOp, _, BoolE false -> e2'
    | OrOp, BoolE true, _ -> e1'
    | OrOp, BoolE false, _ -> e2'
    | OrOp, _, BoolE true -> e2'
    | OrOp, _, BoolE false -> e1'
    | ImplOp, BoolE b1, BoolE b2 -> BoolE (not b1 || b2) $> e
    | ImplOp, BoolE true, _ -> e2'
    | ImplOp, BoolE false, _ -> BoolE true $> e
    | ImplOp, _, BoolE true -> e2'
    | ImplOp, _, BoolE false -> UnE (NotOp, e1') $> e
    | EquivOp, BoolE b1, BoolE b2 -> BoolE (b1 = b2) $> e
    | EquivOp, BoolE true, _ -> e2'
    | EquivOp, BoolE false, _ -> UnE (NotOp, e2') $> e
    | EquivOp, _, BoolE true -> e1'
    | EquivOp, _, BoolE false -> UnE (NotOp, e1') $> e
    | AddOp, NumE n1, NumE n2 -> NumE Z.(n1 + n2) $> e
    | AddOp, NumE z0, _ when z0 = Z.zero -> e2'
    | AddOp, _, NumE z0 when z0 = Z.zero -> e1'
    | SubOp, NumE n1, NumE n2 when n1 >= n2 -> NumE Z.(n1 - n2) $> e
    | SubOp, NumE z0, _ when z0 = Z.zero -> UnE (MinusOp, e2') $> e
    | SubOp, _, NumE z0 when z0 = Z.zero -> e1'
    | MulOp, NumE n1, NumE n2 -> NumE Z.(n1 * n2) $> e
    | MulOp, NumE z1, _ when z1 = Z.one -> e2'
    | MulOp, _, NumE z1 when z1 = Z.one -> e1'
    | DivOp, NumE n1, NumE n2 when Z.(n2 <> zero && rem n1 n2 = zero) -> NumE Z.(n1 / n2) $> e
    | DivOp, NumE z0, _ when z0 = Z.zero -> e1'
    | DivOp, _, NumE z1 when z1 = Z.one -> e1'
    | ModOp, NumE n1, NumE n2 -> NumE Z.(rem n1 n2) $> e
    | ModOp, NumE z0, _ when z0 = Z.zero -> e1'
    | ModOp, _, NumE z1 when z1 = Z.one -> NumE Z.zero $> e
    | ExpOp, NumE n1, NumE n2 when n2 >= Z.zero -> NumE Z.(n1 ** to_int n2) $> e
    | ExpOp, NumE z01, _ when z01 = Z.zero || z01 = Z.one -> e1'
    | ExpOp, _, NumE z0 when z0 = Z.zero -> NumE Z.one $> e
    | ExpOp, _, NumE z1 when z1 = Z.one -> e1'
    | EqOp, _, _ when Eq.eq_expr e1' e2' -> BoolE true $> e
    | EqOp, _, _ when is_normal_exp e1' && is_normal_exp e2' -> BoolE false $> e
    | NeOp, _, _ when Eq.eq_expr e1' e2' -> BoolE false $> e
    | NeOp, _, _ when is_normal_exp e1' && is_normal_exp e2' -> BoolE true $> e
    | LtOp, NumE n1, NumE n2 -> BoolE (n1 < n2) $> e
    | LtOp, UnE (MinusOp, {it = NumE n1; _}), UnE (MinusOp, {it = NumE n2; _}) -> BoolE (n2 < n1) $> e
    | LtOp, UnE (MinusOp, {it = NumE _; _}), NumE _ -> BoolE true $> e
    | LtOp, NumE _, UnE (MinusOp, {it = NumE _; _}) -> BoolE false $> e
    | GtOp, NumE n1, NumE n2 -> BoolE (n1 > n2) $> e
    | GtOp, UnE (MinusOp, {it = NumE n1; _}), UnE (MinusOp, {it = NumE n2; _}) -> BoolE (n2 > n1) $> e
    | GtOp, UnE (MinusOp, {it = NumE _; _}), NumE _ -> BoolE false $> e
    | GtOp, NumE _, UnE (MinusOp, {it = NumE _; _}) -> BoolE true $> e
    | LeOp, NumE n1, NumE n2 -> BoolE (n1 <= n2) $> e
    | LeOp, UnE (MinusOp, {it = NumE n1; _}), UnE (MinusOp, {it = NumE n2; _}) -> BoolE (n2 <= n1) $> e
    | LeOp, UnE (MinusOp, {it = NumE _; _}), NumE _ -> BoolE true $> e
    | LeOp, NumE _, UnE (MinusOp, {it = NumE _; _}) -> BoolE false $> e
    | GeOp, NumE n1, NumE n2 -> BoolE (n1 >= n2) $> e
    | GeOp, UnE (MinusOp, {it = NumE n1; _}), UnE (MinusOp, {it = NumE n2; _}) -> BoolE (n2 >= n1) $> e
    | GeOp, UnE (MinusOp, {it = NumE _; _}), NumE _ -> BoolE false $> e
    | GeOp, NumE _, UnE (MinusOp, {it = NumE _; _}) -> BoolE true $> e
    | _ -> BinE (op, e1', e2') $> e
    )
  | AccE (e1, p) ->
    (match p.it with
    | IdxP e2 ->
      let e1' = reduce_exp s e1 in
      let e2' = reduce_exp s e2 in
      (match e1'.it, e2'.it with
      | ListE es, NumE i when i < Z.of_int (List.length es) -> List.nth es (Z.to_int i)
      | _ -> AccE (e1', IdxP e2' $ p.at) $> e
      )
    | SliceP (e2, e3) ->
      let e1' = reduce_exp s e1 in
      let e2' = reduce_exp s e2 in
      let e3' = reduce_exp s e3 in
      (match e1'.it, e2'.it, e3'.it with
      | ListE es, NumE i, NumE n when Z.(i + n) < Z.of_int (List.length es) ->
        ListE (Lib.List.take (Z.to_int n) (Lib.List.drop (Z.to_int i) es))
      | _ -> AccE (e1', SliceP (e2', e3') $ p.at)
      ) $> e
    | DotP atom ->
      let e1' = reduce_exp s e1 in
      (match e1'.it with
      | StrE efs -> !(snd (List.find (fun (atomN, _) -> El.Atom.eq atomN atom) efs))
      | _ -> AccE (e1', DotP atom $ p.at) $> e
      )
    )
  | UpdE (e1, p, e2) ->
    let e1' = reduce_exp s e1 in
    let e2' = reduce_exp s e2 in
    reduce_path s e1' p
      (fun e' ps -> if ps = [] then e2' else UpdE (e', ps, e2') $> e')
  | ExtE (_e1, _p, _e2, _dir) -> e
    (* TODO
    let e1' = reduce_exp s e1 in
    let e2' = reduce_exp s e2 in
    reduce_path s e1' p
      (fun e' p' ->
        if p'.it = RootP
        then reduce_exp s (CatE (e', e2') $> e')
        else ExtE (e', p', e2') $> e'
      )
      *)
  | StrE efs -> StrE (List.map (reduce_expfield s) efs) $> e
  | CompE (e1, e2) ->
    (* TODO(4, rossberg): avoid overlap with CatE? *)
    let e1' = reduce_exp s e1 in
    let e2' = reduce_exp s e2 in
    (match e1'.it, e2'.it with
    | ListE es1, ListE es2 -> ListE (es1 @ es2)
    | OptE None, OptE _ -> e2'.it
    | OptE _, OptE None -> e1'.it
    | StrE efs1, StrE efs2 ->
      let merge (atom1, e1) (atom2, e2) =
        assert (El.Atom.eq atom1 atom2);
        (atom1, ref (reduce_exp s (CompE (!e1, !e2) $> !e1)))
      in StrE (List.map2 merge efs1 efs2)
    | _ -> CompE (e1', e2')
    ) $> e
  | MemE (e1, e2) ->
    let e1' = reduce_exp s e1 in
    let e2' = reduce_exp s e2 in
    (match e2'.it with
    | OptE None -> BoolE false
    | OptE (Some e2') when Eq.eq_expr e1' e2' -> BoolE true
    | OptE (Some e2') when is_normal_exp e1' && is_normal_exp e2' -> BoolE false
    | ListE [] -> BoolE false
    | ListE es2' when List.exists (Eq.eq_expr e1') es2' -> BoolE true
    | ListE es2' when is_normal_exp e1' && List.for_all is_normal_exp es2' -> BoolE false
    | _ -> MemE (e1', e2')
    ) $> e
  | LenE e1 ->
    let e1' = reduce_exp s e1 in
    (match e1'.it with
    | ListE es -> NumE (Z.of_int (List.length es))
    | _ -> LenE e1'
    ) $> e
  | TupE es -> TupE (List.map (reduce_exp s) es) $> e
  | CallE (id, args) ->
    let args' = List.map (reduce_arg s) args in
    (match reduce_call id args' with
    | None -> CallE (id, args') $> e
    | Some e -> e
    )
  | IterE (e1, iterexp) ->
    let e1' = reduce_exp s e1 in
    let (iter', xes') as iterexp' = reduce_iterexp s iterexp in
    let ids, es' = List.split xes' in
    if not (List.for_all is_head_normal_exp es') || iter' <= List1 && es' = [] then
      IterE (e1', iterexp') $> e
    else
      (match iter' with
      | Opt ->
        let eos' = List.map as_opt_exp es' in
        if List.for_all Option.is_none eos' then
          OptE None $> e
        else if List.for_all Option.is_some eos' then
          let es1' = List.map Option.get eos' in
          let s = List.fold_right2 Subst.add ids es1' Subst.empty in
          reduce_exp s (Subst.subst_exp s e1')
        else
          IterE (e1', iterexp') $> e
      | List | List1 ->
        let n = List.length (as_list_exp (List.hd es')) in
        if iter' = List || n >= 1 then
          let en = NumE (Z.of_int n) $$ e.at % (Il.Ast.NumT NatT $ e.at) in
          reduce_exp s (IterE (e1', (ListN (en, None), xes')) $> e)
        else
          IterE (e1', iterexp') $> e
      | ListN ({it = NumE n'; _}, ido) ->
        let ess' = List.map as_list_exp es' in
        let ns = List.map List.length ess' in
        let n = Z.to_int n' in
        if List.for_all ((=) n) ns then
          (TupE (List.init n (fun i ->
            let esI' = List.map (fun es -> List.nth es i) ess' in
            let s = List.fold_right2 Subst.add ids esI' Subst.empty in
            let s' =
              Option.fold ido ~none:s ~some:(fun id ->
                let en = NumE (Z.of_int i) $$ no_region % (Il.Ast.NumT NatT $ no_region) in
                Subst.add id en s
              )
            in Subst.subst_exp s' e1'
          )) $> e) |> reduce_exp s
        else
          IterE (e1', iterexp') $> e
      | ListN _ ->
        IterE (e1', iterexp') $> e
      )
  | OptE eo -> OptE (Option.map (reduce_exp s) eo) $> e
  | ListE es -> ListE (List.map (reduce_exp s) es) $> e
  | CatE (e1, e2) ->
    let e1' = reduce_exp s e1 in
    let e2' = reduce_exp s e2 in
    (match e1'.it, e2'.it with
    | ListE es1, ListE es2 -> ListE (es1 @ es2)
    | OptE None, OptE _ -> e2'.it
    | OptE _, OptE None -> e1'.it
    | _ -> CatE (e1', e2')
    ) $> e
  | CaseE (op, es) -> CaseE (op, List.map (reduce_exp s) es) $> e
  | SubE _ -> e
  | _ -> e

and reduce_iter s = function
  | ListN (e, ido) -> ListN (reduce_exp s e, ido)
  | iter -> iter

and reduce_iterexp s (iter, xes) =
  (reduce_iter s iter, List.map (fun (id, e) -> id, reduce_exp s e) xes)

and reduce_expfield s (atom, e) : (atom * expr ref) = (atom, ref (reduce_exp s !e))

and reduce_path s e p f =
  match Lib.List.split_last_opt p with
  | None -> f e []
  | Some (ps, p') -> match p'.it with
    | IdxP e1 ->
      let e1' = reduce_exp s e1 in
      let f' e' p1' =
        match e'.it, e1'.it with
        | ListE es, NumE i when i < Z.of_int (List.length es) ->
          ListE (List.mapi (fun j eJ -> if Z.of_int j = i then f eJ p1' else eJ) es) $> e'
        | _ ->
          f e' (ps @ [IdxP (e1') $> p'])
      in
      reduce_path s e ps f'
    | SliceP (e1, e2) ->
      let e1' = reduce_exp s e1 in
      let e2' = reduce_exp s e2 in
      let f' e' p1' =
        match e'.it, e1'.it, e2'.it with
        | ListE es, NumE i, NumE n when Z.(i + n) < Z.of_int (List.length es) ->
          let e1' = ListE Lib.List.(take (Z.to_int i) es) $> e' in
          let e2' = ListE Lib.List.(take (Z.to_int n) (drop (Z.to_int i) es)) $> e' in
          let e3' = ListE Lib.List.(drop Z.(to_int (i + n)) es) $> e' in
          reduce_exp s (CatE (e1', CatE (f e2' p1', e3') $> e') $> e')
        | _ ->
          f e' (ps @ [SliceP (e1', e2') $> p'])
      in
      reduce_path s e ps f'
    | DotP atom ->
      let f' e' p1' =
        match e'.it with
        | StrE efs ->
          StrE (List.map (fun (atomI, eI) ->
            if El.Atom.eq atomI atom then (atomI, ref (f !eI p1')) else (atomI, eI)) efs) $> e'
        | _ ->
          f e' (ps @ [DotP (atom) $> p'])
      in
      reduce_path s e ps f'

and reduce_arg s a : arg =
  Debug_log.(log "al.reduce_arg"
    (fun _ -> fmt "%s" (string_of_arg a))
    (fun a' -> fmt "%s" (string_of_arg a'))
  ) @@ fun _ ->
  match a.it with
  | ExpA e -> ExpA (reduce_exp s e) $ a.at
  | TypA _t -> a  (* types are reduced on demand *)
  | DefA _id -> a
  (* | GramA _g -> a *)

and reduce_call id args : expr option =
  let func_finder = fun al -> match al.it with | FuncA (fname, _, _) -> fname = id | RuleA _ -> false in
  match (List.find func_finder !Lang.al).it with
  | FuncA (_, params, il) ->
    let* s = List.fold_right2
      (fun p a s -> let* s = s in get_subst_arg p a s)
      params args (Some Subst.empty) in
    reduce_instrs s il
  | _ -> assert (false)

and reduce_instrs s : instr list -> expr option = function
  | [] -> None
  | instr :: t ->
    match instr.it with
    | ReturnI expr_opt -> Option.map (reduce_exp s) expr_opt
    | LetI (expr1, expr2) ->
      let new_s = get_subst expr1 expr2 s in
      Option.fold ~some:(fun s -> reduce_instrs s t) ~none:None new_s
    | IfI (expr, il1, il2) ->
      (* TODO: consider iter *)
      (match (reduce_exp s expr).it with
      | BoolE true -> reduce_instrs s (il1@t)
      | BoolE false -> reduce_instrs s (il2@t)
      | _ -> None
      )
    (* Can have side effect *)
    | EitherI _ | PerformI _ | ReplaceI _ | AppendI _ | FieldWiseAppendI _ -> None
    (* Invalid instruction in FuncA *)
    | EnterI _  | PushI _ | PopI _ | PopAllI _ | TrapI | FailI | ThrowI _
    | ExecuteI _ | ExecuteSeqI _ | ExitI _ | OtherwiseI _ | YetI _ -> assert (false)
    (* Nop *)
    | (AssertI _ | NopI) -> reduce_instrs s t
