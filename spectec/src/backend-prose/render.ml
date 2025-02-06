open Xl
open Prose
open Printf
open Util.Source


(* Errors *)

let error at msg = Util.Error.error at "prose rendering" msg


(* Environment *)

module Set = Set.Make(String)
module Map = Map.Make(String)

type env =
  {
    config : Config.config;
    render_latex: Backend_latex.Render.env;
    macro: Macro.env;
    vars: Set.t;
    uncond_concl: bool; (* Indicates if currently rendering an unconditional concl *)
  }

let env config inputs outputs render_latex : env =
  let macro = Macro.env inputs outputs in
  let env = { config; render_latex; macro; vars=Set.empty; uncond_concl=false } in
  env

(* Helpers *)

let indent = "   "

let rec repeat str num =
  if num = 0 then ""
  else if Int.rem num 2 = 0 then repeat (str ^ str) (num / 2)
  else str ^ repeat (str ^ str) (num / 2)

let math = ":math:"

let render_math s =
  if (String.length s > 0) then math ^ sprintf "`%s`" s
  else s

let render_opt prefix stringifier suffix = function
  | None -> ""
  | Some x -> prefix ^ stringifier x ^ suffix

let render_list stringifier sep = function
  | [] -> ""
  | hd :: tl -> List.fold_left (fun acc x -> acc ^ sep ^ (stringifier x)) (stringifier hd) tl

let render_order index depth =
  index := !index + 1;

  let num_idx = if !index = 1 then string_of_int !index else "#" in
  let alp_idx = if !index = 1 then Char.escaped (Char.chr (96 + !index)) else "#" in

  match depth mod 4 with
  | 0 -> num_idx ^ "."
  | 1 -> alp_idx ^ "."
  | 2 -> num_idx ^ ")"
  | 3 -> alp_idx ^ ")"
  | _ -> assert false

let rec is_additive_bine expr = match expr.it with
  | Al.Ast.BinE ((`AddOp | `SubOp), _, _) -> true
  | Al.Ast.CvtE (e, _, _) -> is_additive_bine e
  | _ -> false

and is_bine expr = match expr.it with
  | Al.Ast.BinE _ -> true
  | Al.Ast.CvtE (e, _, _) -> is_bine e
  | _ -> false

let (let*) = Option.bind
  
let find_section env link =
  (* print_endline ("link: " ^ link); *)
  let ans = Macro.find_section env.macro link in
  (* print_endline ("ans: " ^ (if ans then "true" else "false")); *)
  ans

let inject_link s link = sprintf ":ref:`%s <%s>`" s link

let try_inject_link env s link =
  if find_section env link then Some (inject_link s link)
  else None

let type_with_link env e =
  let typ, iter = match e.note.it with
  | Il.Ast.IterT (typ, Il.Ast.Opt) -> typ, ""
  | Il.Ast.IterT (typ, Il.Ast.List) -> typ, " sequence"
  | _ -> e.note, "" in
  let s = Prose_util.extract_desc typ ^ iter in
  let typ_name = Il.Print.string_of_typ typ in
  let* ref = try_inject_link env s ("syntax-" ^ typ_name) in
  Some (ref ^ iter)

let valid_link env e =
  let s = Il.Print.string_of_typ e.note in
  match try_inject_link env "valid" ("valid-" ^ s) with
  | Some s -> s
  | None -> inject_link "valid" "valid-val"

let match_link env e =
  let s = Il.Print.string_of_typ e.note in
  match try_inject_link env "matches" ("match-" ^ s) with
  | Some s -> s
  | None -> inject_link "matches" "match"

(* Translation from Al inverse call exp to Al binary exp *)
let e2a e = Al.Ast.ExpA e $ e.at
let a2e a =
  match a.it with
  | Al.Ast.ExpA e -> e
  | Al.Ast.TypA _ -> error a.at "Cannot render inverse function with type argument"
  | Al.Ast.DefA _ -> error a.at "Cannot render inverse function with def argument"

let al_invcalle_to_al_bine e id nl al =
  let efree = (match e.it with Al.Ast.TupE el -> el | _ -> [ e ]) in
  let abound, arhs =
    let nbound = List.length nl - List.length efree in
    Util.Lib.List.split nbound al
  in

  let args, _, _ =
    List.fold_left
      (fun (args, efree, abound) n ->
        match n with
        | Some _ -> args @ [ List.hd efree |> e2a ], List.tl efree, abound
        | None ->   args @ [ List.hd abound ],       efree,         List.tl abound)
      ([], efree, abound) nl
  in
  let erhs = List.map a2e arhs in

  let elhs = Al.Al_util.callE (id, args) ~note:Al.Al_util.no_note in
  let erhs = (match erhs with
    | [ e ] -> e
    | _ -> Al.Al_util.tupE erhs ~note:Al.Al_util.no_note)
  in
  elhs, erhs

let render_type_desc f t =
  match Prose_util.extract_desc t with
  | "" -> f t
  | desc -> desc

(* Translation from Al exp to El exp *)

let al_to_el_unop = function
  | #Num.unop as op -> Some op
  | _ -> None

let rec al_to_el_iter iter = match iter with
  | Al.Ast.Opt -> Some El.Ast.Opt
  | Al.Ast.List -> Some El.Ast.List
  | Al.Ast.List1 -> Some El.Ast.List1
  | Al.Ast.ListN (e, id) ->
    let* ele = al_to_el_expr e in
    let elid = Option.map (fun id -> id $ no_region) id in
    Some (El.Ast.ListN (ele, elid))

and al_to_el_path pl =
  let fold_path p elp =
    let elp' = (match p.it with
      | Al.Ast.IdxP ei ->
        let* elei = al_to_el_expr ei in
        Some (El.Ast.IdxP (elp, elei))
      | Al.Ast.SliceP (el, eh) ->
        let* elel = al_to_el_expr el in
        let* eleh = al_to_el_expr eh in
        Some (El.Ast.SliceP (elp, elel, eleh))
      | Al.Ast.DotP a ->
        Some (El.Ast.DotP (elp, a)))
    in
    Option.map (fun elp' -> elp' $ no_region) elp'
  in
  List.fold_left
    (fun elp p -> Option.bind elp (fold_path p))
    (Some (El.Ast.RootP $ no_region)) pl

and al_to_el_arg arg =
  match arg.it with
  | Al.Ast.ExpA e ->
    let* ele = al_to_el_expr e in
    Some (El.Ast.ExpA ele)
  | Al.Ast.TypA typ ->
    let* elt = il_to_el_typ typ in
    Some (El.Ast.(TypA elt))
  | Al.Ast.DefA id ->
    Some (El.Ast.DefA (id $ no_region))

and al_to_el_args args =
  List.fold_left
    (fun args a ->
      let* args = args in
      let* arg = al_to_el_arg a in
      Some (args @ [ arg ]))
    (Some []) args

and al_to_el_expr expr =
  let exp' =
    match expr.it with
    | Al.Ast.NumE i ->
      let natop =
        (match expr.note.it with
        | Il.Ast.VarT (id, []) when id.it = "byte" -> `HexOp
        | _ -> `DecOp
        )
      in
      Some (El.Ast.NumE (natop, i))
    | Al.Ast.CvtE (e, _, nt2) ->
      let* ele = al_to_el_expr e in
      Some (El.Ast.CvtE (ele, nt2))
    | Al.Ast.UnE (op, e) ->
      let* elop = al_to_el_unop op in
      let* ele = al_to_el_expr e in
      Some (El.Ast.UnE (elop, ele))
    | Al.Ast.BinE (op, e1, e2) ->
      (match op with
      | #Num.binop as elop ->
        let* ele1 = al_to_el_expr e1 in
        let* ele2 = al_to_el_expr e2 in
        (* Add parentheses when needed *)
        let pele1 = match op with
          | `MulOp | `DivOp | `ModOp when is_additive_bine e1 ->
            El.Ast.ParenE ele1 $ no_region
          | `PowOp when is_bine e1 ->
            El.Ast.ParenE ele1 $ no_region
          | _ -> ele1 in
        let pele2 = match op with
          | `SubOp | `MulOp when is_additive_bine e2 ->
            El.Ast.ParenE ele2 $ no_region
          | `DivOp | `ModOp when is_bine e2->
            El.Ast.ParenE ele2 $ no_region
          | _ -> ele2 in
        Some (El.Ast.BinE (pele1, elop, pele2))
      | #Num.cmpop | #Bool.cmpop as elop ->
        let* ele1 = al_to_el_expr e1 in
        let* ele2 = al_to_el_expr e2 in
        Some (El.Ast.CmpE (ele1, elop, ele2))
      | _ -> None
      )
    | Al.Ast.TupE el ->
      let* elel = al_to_el_exprs el in
      Some (El.Ast.TupE elel)
    | Al.Ast.CallE (id, al) ->
      (match Prose_util.find_relation id with
      | Some _ ->
        None
      | _ ->
          let elid = id $ no_region in
          let* elal = al_to_el_args al in
          (* Unwrap parenthsized args *)
          let elal = List.map
            (fun elarg ->
              let elarg = match elarg with
              | El.Ast.ExpA exp ->
                let exp = match exp.it with
                | ParenE exp' -> exp'
                | _ -> exp
                in
                El.Ast.ExpA exp
              | _ -> elarg
              in
              (ref elarg) $ no_region
            )
            elal
          in
          Some (El.Ast.CallE (elid, elal))
      )
    | Al.Ast.CatE (e1, e2) ->
      let* ele1 = al_to_el_expr e1 in
      let* ele2 = al_to_el_expr e2 in
      Some (El.Ast.SeqE [ ele1; ele2 ])
    | Al.Ast.LenE e ->
      let* ele = al_to_el_expr e in
      Some (El.Ast.LenE ele)
    | Al.Ast.ListE el ->
      let* elel = al_to_el_exprs el in
      if (List.length elel > 0) then Some (El.Ast.SeqE elel)
      else Some (El.Ast.EpsE)
    | Al.Ast.LiftE e ->
      let* ele = al_to_el_expr e in
      Some ele.it
    | Al.Ast.AccE (e, p) ->
      let* ele = al_to_el_expr e in
      (match p.it with
      | Al.Ast.IdxP ei ->
          let* elei = al_to_el_expr ei in
          Some (El.Ast.IdxE (ele, elei))
      | Al.Ast.SliceP (el, eh) ->
          let* elel = al_to_el_expr el in
          let* eleh = al_to_el_expr eh in
          Some (El.Ast.SliceE (ele, elel, eleh))
      | DotP a ->
          Some (El.Ast.DotE (ele, a)))
    | Al.Ast.UpdE (e1, pl, e2) ->
      let* ele1 = al_to_el_expr e1 in
      let* elp = al_to_el_path pl in
      let* ele2 = al_to_el_expr e2 in
      Some (El.Ast.UpdE (ele1, elp, ele2))
    | Al.Ast.ExtE (e1, pl, e2, _) ->
      let* ele1 = al_to_el_expr e1 in
      let* elp = al_to_el_path pl in
      let* ele2 = al_to_el_expr e2 in
      Some (El.Ast.ExtE (ele1, elp, ele2))
    | Al.Ast.StrE r ->
      let* elexpfield = al_to_el_record r in
      Some (El.Ast.StrE elexpfield)
    | Al.Ast.VarE id | Al.Ast.SubE (id, _) ->
      let elid = id $ no_region in
      Some (El.Ast.VarE (elid, []))
    | Al.Ast.IterE (e, (iter, _)) ->
      let* ele = al_to_el_expr e in
      let* eliter = al_to_el_iter iter in
      let ele =
        match ele.it with
        | El.Ast.BinE _ | El.Ast.CatE _ | El.Ast.CmpE _ | El.Ast.MemE _ ->
          El.Ast.ParenE ele $ ele.at
        | El.Ast.IterE (_, eliter2) when eliter2 <> eliter ->
          El.Ast.ParenE ele $ ele.at
        | _ -> ele
      in
      Some (El.Ast.IterE (ele, eliter))
    | Al.Ast.CaseE (op, el) ->
      (* Current rules for omitting parenthesis around a CaseE:
        1) Has no argument
        2) Is infix notation
        3) Is bracketed
        4) Is argument of CallE -> add first, omit later at CallE *)
      let is_bracked mixop =
        let s = Mixop.to_string mixop in
        let first = String.get s 1 in
        let last = String.get s (String.length s - 2) in
        match first, last with
        | '(', ')'
        | '[', ']'
        | '{', '}' -> true
        | _ -> false
      in
      let elal = mixop_to_el_exprs op in
      let* elel = al_to_el_exprs el in
      let ele = El.Ast.SeqE (case_to_el_exprs elal elel) in
      (match elal, elel with
      | _, [] -> Some ele
      | None :: Some _ :: _, _ -> Some ele
      | _ when is_bracked op -> Some ele
      | _ -> Some (El.Ast.ParenE (ele $ no_region))
      )
    | Al.Ast.OptE (Some e) ->
      let* ele = al_to_el_expr e in
      Some (ele.it)
    | Al.Ast.OptE None -> Some (El.Ast.EpsE)
    | _ -> None
  in
  Option.map (fun exp' -> exp' $ no_region) exp'

and case_to_el_exprs al el =
  match al with
  | [] -> error no_region "empty mixop in a AL case expr"
  | hd::tl ->
    List.fold_left2 (fun acc a e -> a::Some(e)::acc) [ hd ] tl el
    |> List.filter_map (fun x -> x)
    |> List.rev

and mixop_to_el_exprs op =
  List.map
    (fun al ->
      match al with
      | [ a ] -> Some((El.Ast.AtomE a) $ no_region)
      | _ -> None
    )
  op

and al_to_el_exprs exprs =
  List.fold_left
    (fun exps e ->
      let* exps = exps in
      let* exp = al_to_el_expr e in
      Some (exps @ [ exp ]))
    (Some []) exprs

and al_to_el_record record =
  Util.Record.fold
    (fun a e expfield ->
      let* expfield = expfield in
      (* Don't list empty field *)
      if e.it = Al.Ast.ListE [] then Some (expfield)
      else
        let* ele = al_to_el_expr e in
        let elelem = El.Ast.Elem (a, ele) in
        Some (expfield @ [ elelem ]))
    record (Some [])

and il_to_el_iter iter =
  match iter with
  | Il.Ast.Opt -> Some El.Ast.Opt
  | Il.Ast.List -> Some El.Ast.List
  | Il.Ast.List1 -> Some El.Ast.List1
  | Il.Ast.ListN (e, id) ->
    let* ele =
      Il2al.Translate.translate_exp e
      |> al_to_el_expr
    in
    Some (El.Ast.ListN (ele, id))

and il_to_el_typ t =
  match t.it with
  | Il.Ast.VarT (id, args) ->
    let* elal =
      Il2al.Translate.translate_args args
      |> al_to_el_args
    in
    let elal = List.map (fun a -> (ref a) $ no_region) elal in
    Some (El.Ast.VarT (id, elal) $ no_region)
  | Il.Ast.BoolT -> Some (El.Ast.BoolT $ no_region)
  | Il.Ast.NumT numtyp -> Some (El.Ast.NumT numtyp $ no_region)
  | Il.Ast.TextT -> Some (El.Ast.TextT $ no_region)
  | Il.Ast.TupT ts ->
    let* elts =
      List.fold_left
      (fun typs (_, t) ->
        let* typs = typs in
        let* typ = il_to_el_typ t in
        Some (typs @ [ typ ]))
      (Some []) ts
    in
    Some (El.Ast.TupT elts $ no_region)
  | IterT (t', iter) ->
    let* eli = il_to_el_iter iter in
    let* elt = il_to_el_typ t' in
    Some (El.Ast.IterT (elt, eli) $ no_region)

(* Operators *)

let render_prose_cmpop = function
  | `EqOp -> "is equal to"
  | `NeOp -> "is not equal to"
  | `LtOp -> "is less than"
  | `GtOp -> "is greater than"
  | `LeOp -> "is less than or equal to"
  | `GeOp -> "is greater than or equal to"

let render_prose_cmpop_eps = function
  | `EqOp -> "is"
  | `NeOp -> "is not"
  | op -> render_prose_cmpop op

let render_prose_binop = function
  | `AndOp -> "and"
  | `OrOp -> "or"
  | `ImplOp -> "implies"
  | `EquivOp -> "if and only if"

let render_al_unop = function
  | `NotOp -> "not"
  | `PlusOp -> "plus"
  | `MinusOp -> "minus"

let render_al_binop = function
  | `AndOp -> "and"
  | `OrOp -> "or"
  | `ImplOp -> "implies"
  | `EquivOp -> "is equivalent to"
  | `AddOp -> "plus"
  | `SubOp -> "minus"
  | `MulOp -> "multiplied by"
  | `DivOp -> "divided by"
  | `ModOp -> "modulo"
  | `PowOp -> "to the power of"
  | `EqOp -> "is"
  | `NeOp -> "is not"
  | `LtOp -> "is less than"
  | `GtOp -> "is greater than"
  | `LeOp -> "is less than or equal to"
  | `GeOp -> "is greater than or equal to"

(* Names *)

let render_atom env a =
  let sela = Backend_latex.Render.render_atom env.render_latex a in
  render_math sela


(* Expressions and Paths *)

(* Invariant: All AL expressions fall into one of the three categories:
  1. EL-like expression, only containing EL subexpressions
  2. AL-only expression, possibly containing EL subexpressions
  3. pseudo-EL-like expression, containing at least one AL-only subexpression *)

(* Category 1 is translated to EL then rendered by the Latex backend *)

let render_el_exp env exp =
  (* embedded math blocks cannot have line-breaks *)
  let newline = Str.regexp "\n" in
  let sexp = Backend_latex.Render.render_exp env.render_latex exp in
  let sexp = Str.global_replace newline "" sexp in
  render_math sexp

let render_arg env arg =
  let el_arg = match al_to_el_arg arg with
  | None ->
    El.Ast.(TypA (VarT ("TODO" $ arg.at, []) $ arg.at))
  | Some arg' -> arg'
  in
  ref (el_arg) $ no_region
  |> Backend_latex.Render.render_arg env.render_latex
  |> render_math

let rec render_expr env expr = match al_to_el_expr expr with
  | Some exp -> render_el_exp env exp
  | None -> render_expr' env expr

and render_typ env typ =
  match il_to_el_typ typ with
  | Some elt -> Backend_latex.Render.render_typ env.render_latex elt |> render_math
  | None -> Il.Print.string_of_typ typ

(* Categories 2 and 3 are rendered by the prose backend,
   yet EL subexpressions are still rendered by the Latex backend *)

and render_expr' env expr =
  match expr.it with
  | Al.Ast.BoolE b -> string_of_bool b
  | Al.Ast.CvtE (e, _, _) -> render_expr' env e
  | Al.Ast.UnE (`NotOp, { it = Al.Ast.IsCaseOfE (e, a); _ }) ->
    let se = render_expr env e in
    let sa = render_atom env a in
    sprintf "%s is not %s" se sa
  | Al.Ast.UnE (`NotOp, { it = Al.Ast.IsDefinedE e; _ }) ->
    let se = render_expr env e in
    sprintf "%s is not defined" se
  | Al.Ast.UnE (`NotOp, { it = Al.Ast.IsValidE e; _ }) ->
    let typ_name = Il.Print.string_of_typ_name e.note in
    let vref =
      if find_section env ("valid-" ^ typ_name) then
        inject_link "valid" ("valid-" ^ typ_name)
      else
        inject_link "valid" "valid-val"
    in
    let se = render_expr env e in
    sprintf "%s is not %s" se vref
  | Al.Ast.UnE (`NotOp, { it = Al.Ast.MatchE (e1, e2); _ }) ->
    let se1 = render_expr env e1 in
    let se2 = render_expr env e2 in
    sprintf "%s does not match %s" se1 se2
  | Al.Ast.UnE (`NotOp, { it = Al.Ast.MemE (e1, e2); _ }) ->
    let se1 = render_expr env e1 in
    let se2 = render_expr env e2 in
    sprintf "%s is not contained in %s" se1 se2
  | Al.Ast.UnE (op, e) ->
    let sop = render_al_unop op in
    let se = render_expr env e in
    sprintf "%s %s" sop se
  | Al.Ast.BinE (op, e1, e2) ->
    let sop = render_al_binop op in
    let se1 = render_expr env e1 in
    let se2 = render_expr env e2 in
    sprintf "%s %s %s" se1 sop se2
  | Al.Ast.UpdE (e1, ps, e2) ->
    let se1 = render_expr env e1 in
    let sps = render_paths env ps in
    let se2 = render_expr env e2 in
    sprintf "%s with %s replaced by %s" se1 sps se2
  | Al.Ast.ExtE (e1, ps, e2, dir) ->
    let se1 = render_expr env e1 in
    let sps = render_paths env ps in
    let se2 = render_expr env e2 in
    (match dir with
    | Al.Ast.Front -> sprintf "%s with %s prepended by %s" se1 sps se2
    | Al.Ast.Back -> sprintf "%s with %s appended by %s" se1 sps se2)
  | Al.Ast.CallE (id, al) ->
    (* HARDCODE: relation call *)
    let args = List.map (render_arg env) al in
    if id = "Eval_expr" then
      (match args with
      | [instrs] ->
        "the result of :ref:`evaluating <exec-expr>` " ^ instrs
      | _ -> error expr.at (Printf.sprintf "Invalid arity for relation call: %d ([ %s ])" (List.length args) (String.concat " " args));
      )
    else if String.ends_with ~suffix:"_type" id || String.ends_with ~suffix:"_ok" id then
      (match args with
      | [arg1; arg2] ->
        arg1 ^ " is :ref:`valid <valid-val>` with type " ^ arg2
      | [arg] -> "the type of " ^ arg
      | _ -> error expr.at "Invalid arity for relation call";
      )
    else error expr.at ("Not supported relation call: " ^ id);
  | Al.Ast.InvCallE (id, nl, al) ->
    let lhs_variable =
      if id = "lsizenn" || id = "lsizenn1" || id = "lsizenn2" then
        Al.Al_util.varE "N" ~note:Al.Al_util.no_note
      else
        let params, _, _ = Il.Env.find_def !Al.Valid.il_env (id $ no_region) in
        let gen_var n_opt =
          let* n = n_opt in
          let* param = List.nth_opt params n in
          let* typ =
            match param.it with
            | ExpP (_, typ) -> Some typ
            | _ -> None
          in
          typ
          |> Il2al.Il2al_util.introduce_fresh_variable env.vars
          |> Al.Al_util.varE ~note:typ
          |> Option.some
        in
        Al.Al_util.tupE (List.filter_map gen_var nl) ~note:Al.Al_util.no_note
    in
    let elhs, erhs = al_invcalle_to_al_bine lhs_variable id nl al in
    sprintf "%s for which %s %s %s"
      (render_expr env lhs_variable)
      (render_expr env elhs)
      (render_math "=")
      (render_expr env erhs)
  | Al.Ast.MemE (e1, {it = ListE es; _}) ->
    let se1 = render_expr env e1 in
    let se2 = render_list (render_expr env) "; " es in
    sprintf "%s is contained in [%s]" se1 se2
  | Al.Ast.MemE (e1, e2) ->
    let se1 = render_expr env e1 in
    let se2 = render_expr env e2 in
    sprintf "%s is contained in %s" se1 se2
  | Al.Ast.LiftE e ->
    render_expr env e
  | Al.Ast.LenE e ->
    let se = render_expr env e in
    sprintf "the length of %s" se
  | Al.Ast.IterE (e, (iter, xes)) when al_to_el_expr e = None ->
    let se = render_expr env e in
    let ids = List.map fst xes in
    (match iter with
    | Al.Ast.ListN (e, Some id) ->
      assert (ids = [ id ]);
      let eid = Al.Al_util.varE id ~note:Al.Al_util.no_note in
      let sid = render_expr env eid in
      let elb = Al.Al_util.natE Z.zero ~note:Al.Al_util.no_note in
      let selb = render_expr env elb in
      let eub =
        Al.Al_util.binE (
          `SubOp,
          e,
          Al.Al_util.natE Z.one ~note:Al.Al_util.no_note)
        ~note:Al.Al_util.no_note
      in
      let seub = render_expr env eub in
      sprintf "for all %s from %s to %s, %s" sid selb seub se
    | _ ->
      let eids = List.map (fun id -> Al.Al_util.varE id ~note:Al.Al_util.no_note) ids in
      let sids = List.map (fun eid -> render_expr env eid) eids in
      let sids =
        match sids with
        | [] -> ""
        | [ sid ] -> sid
        | _ ->
            let sids, sid_last =
              List.rev sids |> List.tl |> List.rev,
              List.rev sids |> List.hd
            in
            String.concat ", " sids ^ ", and " ^ sid_last
      in
      let eiter =
        match eids with
        | [] -> assert false
        | [ eid ] -> eid
        | _ -> Al.Al_util.tupE eids ~note:Al.Al_util.no_note
      in
      let eiter = Al.Al_util.iterE (eiter, (iter, [])) ~note:Al.Al_util.no_note in
      let siter = render_expr env eiter in
      sprintf "for all %s in %s, %s" sids siter se)
  | Al.Ast.GetCurStateE -> "the current state"
  | Al.Ast.GetCurContextE None -> "the current context"
  | Al.Ast.GetCurContextE (Some a) ->
    sprintf "the current %s context" (render_atom env a)
  | Al.Ast.ChooseE e ->
    let se = render_expr env e in
    sprintf "an element of %s" se
  | Al.Ast.ContextKindE a ->
    let sa = render_atom env a in
    sprintf "the first non-value entry of the stack is a %s" sa
  | Al.Ast.IsDefinedE e ->
    let se = render_expr env e in
    sprintf "%s is defined" se
  | Al.Ast.IsCaseOfE (e, a) ->
    let se = render_expr env e in
    let sa = render_atom env a in
    sprintf "%s is %s" se sa
  | Al.Ast.HasTypeE (e, t) ->
    let se = render_expr env e in
    let st = render_type_desc (render_typ env) t in
    sprintf "%s is %s" se st
  | Al.Ast.IsValidE e ->
    let typ_name = Il.Print.string_of_typ_name e.note in
    let vref = match try_inject_link env "valid" ("valid-" ^ typ_name) with
    | Some s -> s
    | None -> inject_link "valid" "valid-val"
    in
    let se = render_expr env e in
    sprintf "%s is %s" se vref
  | Al.Ast.TopValueE (Some e) ->
    let value =
      (
      match type_with_link env e with
      | Some vtref when String.ends_with ~suffix:"type>`" vtref ->
        let se = render_expr env e in
        sprintf "a value of %s %s" vtref se
      | Some vtref ->
        let se = render_expr env e in
        sprintf "a %s %s" vtref se
      | None ->
        let desc_hint = Prose_util.extract_desc e.note in
        let desc_hint = if desc_hint = "" then "value type" else desc_hint in
        let first_letter = Char.lowercase_ascii (String.get desc_hint 0) in
        let article =
          if List.mem first_letter ['a'; 'e'; 'i'; 'o'; 'u'] then
            "an"
          else
            "a"
        in
        sprintf "%s :ref:`%s <syntax-%s>`" article desc_hint (Al.Print.string_of_expr e)
      )
    in
    sprintf "%s is on the top of the stack" value
  | Al.Ast.TopValueE None -> "a value is on the top of the stack"
  | Al.Ast.TopValuesE e ->
    let se = render_expr env e in
    sprintf "there are at least %s values on the top of the stack" se
  | Al.Ast.MatchE (e1, e2) ->
    let se1 = render_expr env e1 in
    let se2 = render_expr env e2 in
    sprintf "%s matches %s" se1 se2
  | Al.Ast.YetE s ->
    sprintf "YetE: %s" s
  | _ ->
    let se = "`" ^ (Al.Print.string_of_expr expr) ^ "`" in
    if env.config.panic_on_error then (
      let msg = sprintf "expr cannot be rendered %s" se in
      error expr.at msg);
    se

and render_path env path =
  match path.it with
  | Al.Ast.IdxP e ->
    let se = render_expr env e in
    let space = if (String.starts_with ~prefix:math se) then " " else "" in
    sprintf "the %s%s-th element" (render_expr env e) space
  | Al.Ast.SliceP (e1, e2) ->
    let se1 = render_expr env e1 in
    let se2 = render_expr env e2 in
    sprintf "the slice from %s to %s" se1 se2
  | Al.Ast.DotP a ->
    sprintf "the field %s" (render_atom env a)

and render_paths env paths =
  let spaths = List.map (render_path env) paths in
  String.concat " of " spaths

let typs = ref Map.empty
let init_typs () = typs := Map.empty
let render_expr_with_type env e =
  let s = render_expr env e in
  let t = Prose_util.extract_desc e.note in
  if t = "" then
    render_expr env e
  else
    let lt = match type_with_link env e with
    | Some lt -> lt
    | None -> t
    in
    "the " ^ lt ^ " " ^ s


(* Validation Statements *)

let render_context_ext_dir = function
  | Al.Ast.Front -> "prepended"
  | Al.Ast.Back -> "appended"

let render_context env e1 e2 =
  match e2.it with
  | Al.Ast.ExtE (({ it = VarE _; _ } as c'), ps, e, dir) ->
    sprintf "Let %s be the same context as %s, but with %s %s to %s"
      (render_expr env e1)
      (render_expr env c')
      (render_expr_with_type env e)
      (render_context_ext_dir dir)
      (render_paths env ps)
  | _ -> assert false

let render_pp_hint = function
  | Some text -> " " ^ text ^ " "
  | None -> " with "

let rec render_single_stmt ?(with_type=true) env stmt  =
  let render_hd_expr = if with_type then render_expr_with_type else render_expr in
  match stmt with
    | LetS (e1, e2) ->
      sprintf "let %s be %s"
        (render_expr env e1)
        (render_expr_with_type env e2)
    | CondS e ->
      sprintf "%s"
        (render_expr env e)
    | CmpS (e1, cmpop, e2) ->
      let cmpop, rhs =
        match e2.it with
        | OptE None -> render_prose_cmpop_eps cmpop, "absent"
        | _ -> render_prose_cmpop cmpop, render_expr env e2
      in
      sprintf "%s %s %s" (render_hd_expr env e1) cmpop rhs
    | IsValidS (c_opt, e, es, pphint) ->
      let prep = render_pp_hint pphint in
      let vref = valid_link env e in
      let always = env.uncond_concl && es = [] in
      sprintf "%s%s is %s%s%s"
        (render_opt "under the context " (render_expr env) ", " c_opt)
        (render_hd_expr env e)
        (if always then "always " else "")
        vref
        (if es = [] then "" else prep ^ render_list (render_expr_with_type env) " and " es)
    | MatchesS (e1, e2) when Al.Eq.eq_expr e1 e2 ->
      sprintf "%s %s only itself"
        (render_hd_expr env e1)
        (match_link env e1)
    | MatchesS (e1, e2) ->
      sprintf "%s %s %s"
        (render_hd_expr env e1)
        (match_link env e1)
        (render_expr_with_type env e2)
    | IsConstS (c_opt, e) ->
      sprintf "%s%s is constant"
        (render_opt "under the context " (render_expr_with_type env) ", " c_opt)
        (render_expr env e)
    | IsDefinedS e ->
      sprintf "%s exists"
        (render_hd_expr env e)
    | IsDefaultableS (e, cmpop) ->
      sprintf "%s %s defaultable"
        (render_hd_expr env e)
        (render_prose_cmpop_eps cmpop)
    | ContextS (e1, e2) -> render_context env e1 e2
    | RelS (s, es) ->
      let args = List.map (render_expr_with_type env) es in
      Prose_util.apply_prose_hint s args
    | YetS s -> sprintf "YetS: %s" s
    | _ -> assert false

and render_stmt env depth stmt =
  let prefix = if depth = 0 then "\n\n" else "* " in
  let render_block = render_stmts env (depth + 1) in
  let stmt' =
    match stmt with
    | IfS (c, sl) ->
      sprintf "if %s, then:%s"
        (render_expr env c)
        (render_block sl)
    | ForallS (iters, is) ->
      let render_iter env (e1, e2) = (render_expr env e1) ^ " in " ^ (render_expr env e2) in
      let render_iters env iters = List.map (render_iter env) iters |> String.concat ", and corresponding " in
      sprintf "for all %s:%s"
        (render_iters env iters)
        (render_block is)
    | EitherS sll ->
      let hd, tl = List.hd sll, List.tl sll in
      let hd' = render_block hd in
      let tl' =
        List.fold_left
          (fun ssll sl ->
            sprintf "%s\n%s%sOr:%s"
              ssll
              (repeat indent depth)
              prefix
              (render_block sl))
          "" tl
      in
      sprintf "either:%s\n%s" hd' tl'
    | BinS ((CmpS (e1, _, _) as s1), binop, (CmpS (e2, _, _) as s2)) when Al.Eq.eq_expr e1 e2 ->
      sprintf "%s %s %s."
        (render_single_stmt env s1)
        (render_prose_binop binop)
        (render_single_stmt env s2 ~with_type:false)
    | BinS (s1, binop, s2) ->
      sprintf "%s %s %s."
        (render_single_stmt env s1)
        (render_prose_binop binop)
        (render_single_stmt env s2)
    | _ -> render_single_stmt env stmt ^ "."
  in
  prefix ^ (stmt' |> String.capitalize_ascii)

and render_stmts env depth stmts =
  List.fold_left
    (fun stmts i ->
      stmts ^ "\n\n" ^ repeat indent depth ^ render_stmt env depth i)
    "" stmts


(* Instructions *)

(* Prefix for stack push/pop operations *)
let render_stack_prefix = Prose_util.string_of_stack_prefix

let rec render_instr env algoname index depth instr =
  match instr.it with
  | Al.Ast.IfI (c, il, []) ->
    (match c.it, il with
    | Al.Ast.UnE (`NotOp, ({ it = Al.Ast.IterE (e, (iter, xes)); _ } as itere)),
      ([{ it = Al.Ast.FailI; _ }] as faili) when al_to_el_expr itere = None ->
      let cond = render_expr env e in
      let ids = List.map fst xes in
      let loop_header, eiters = (match iter with
      | Al.Ast.ListN (e, Some id) ->
        assert (ids = [ id ]);
        let eid = Al.Al_util.varE id ~note:Al.Al_util.no_note in
        let sid = render_expr env eid in
        let elb = Al.Al_util.natE Z.zero ~note:Al.Al_util.no_note in
        let selb = render_expr env elb in
        let eub =
          Al.Al_util.binE (
            `SubOp,
            e,
            Al.Al_util.natE Z.one ~note:Al.Al_util.no_note)
          ~note:Al.Al_util.no_note
        in
        let seub = render_expr env eub in
        sprintf "For all %s from %s to %s" sid selb seub, [ eid ]
      | _ ->
        let eids = List.map (fun id -> Al.Al_util.varE id ~note:Al.Al_util.no_note) ids in
        let sids = List.map (fun eid -> render_expr env eid) eids in
        let sids =
          match sids with
          | [] -> ""
          | [ sid ] -> sid
          | _ ->
              let sids, sid_last =
                List.rev sids |> List.tl |> List.rev,
                List.rev sids |> List.hd
              in
              String.concat ", " sids ^ ", and " ^ sid_last
        in
        let eiter =
          match eids with
          | [] -> assert false
          | [ eid ] -> eid
          | _ -> Al.Al_util.tupE eids ~note:Al.Al_util.no_note
        in
        let eiter = Al.Al_util.iterE (eiter, (iter, [])) ~note:Al.Al_util.no_note in
        let eiters = List.map (fun eid -> Al.Al_util.iterE (eid, (iter, [])) ~note:Al.Al_util.no_note) eids in
        let siter = render_expr env eiter in
        sprintf "For all %s in %s" sids siter, eiters
      ) in

      let negate_cond cond =
        let rec aux idx =
          if idx > String.length cond - 2 then
            "not " ^ cond
          else if String.sub cond idx 2 = "is" then
            let before = String.sub cond 0 (idx + 2) in
            let after = String.sub cond (idx + 2) (String.length cond - (idx + 2)) in
            before ^ " not" ^ after
          else
            aux (idx + 1)
        in
        aux 0
      in
      let neg_cond = negate_cond cond in

      let length_check_string = (match eiters with
      | [eiter1; eiter2] ->
        let to_expr exp' = exp' $$ (no_region, Il.Ast.BoolT $ no_region) in
        let len1 = Al.Ast.LenE eiter1 |> to_expr in
        let len2 = Al.Ast.LenE eiter2 |> to_expr in
        let not_equal = Al.Ast.BinE (`NeOp, len1, len2) |> to_expr in
        let check_instr = Al.Ast.IfI (not_equal, faili, []) $$ (no_region, 0) in
        render_instr env algoname index depth check_instr ^ "\n\n"
      | _ -> ""
      ) in

      let for_index = render_order index (depth) in
      let if_index = render_order (ref 0) (depth + 1) in
      sprintf "%s%s %s:\n\n%s If %s, then:%s"
        length_check_string
        for_index
        loop_header
        (repeat indent (depth + 1) ^ if_index)
        neg_cond
        (render_instrs env algoname (depth + 2) faili)
    | _ ->
      sprintf "%s If %s, then:%s" (render_order index depth)
        (render_expr env c) (render_instrs env algoname (depth + 1) il)
  )
  | Al.Ast.IfI (c, il1, [ { it = IfI (inner_c, inner_il1, []); _ } ]) ->
    let if_index = render_order index depth in
    let else_if_index = render_order index depth in
    sprintf "%s If %s, then:%s\n\n%s Else if %s, then:%s"
      if_index
      (render_expr env c)
      (render_instrs env algoname (depth + 1) il1)
      (repeat indent depth ^ else_if_index)
      (render_expr env inner_c)
      (render_instrs env algoname (depth + 1) inner_il1)
  | Al.Ast.IfI (c, il1, [ { it = IfI (inner_c, inner_il1, inner_il2); _ } ]) ->
    let if_index = render_order index depth in
    let else_if_index = render_order index depth in
    let else_index = render_order index depth in
    sprintf "%s If %s, then:%s\n\n%s Else if %s, then:%s\n\n%s Else:%s"
      if_index
      (render_expr env c)
      (render_instrs env algoname (depth + 1) il1)
      (repeat indent depth ^ else_if_index)
      (render_expr env inner_c)
      (render_instrs env algoname (depth + 1) inner_il1)
      (repeat indent depth ^ else_index)
      (render_instrs env algoname (depth + 1) inner_il2)
  | Al.Ast.IfI (c, il1, il2) ->
    let if_index = render_order index depth in
    let else_index = render_order index depth in
    sprintf "%s If %s, then:%s\n\n%s Else:%s"
      if_index
      (render_expr env c)
      (render_instrs env algoname (depth + 1) il1)
      (repeat indent depth ^ else_index)
      (render_instrs env algoname (depth + 1) il2)
  | Al.Ast.OtherwiseI il ->
    sprintf "%s Otherwise:%s" (render_order index depth)
      (render_instrs env algoname (depth + 1) il)
  | Al.Ast.EitherI (il1, il2) ->
    let either_index = render_order index depth in
    let or_index = render_order index depth in
    sprintf "%s Either:%s\n\n%s Or:%s"
      either_index
      (render_instrs env algoname (depth + 1) il1)
      (repeat indent depth ^ or_index)
      (render_instrs env algoname (depth + 1) il2)
  | Al.Ast.AssertI c ->
    let lname = String.lowercase_ascii algoname in
    let vref = match try_inject_link env "validation" ("valid-" ^ lname) with
    | Some s -> s
    | None -> "validation"
    in
    sprintf "%s Assert: Due to %s, %s." (render_order index depth)
    vref (render_expr env c)
  | Al.Ast.PushI e ->
    sprintf "%s Push %s%s to the stack." (render_order index depth)
      (render_stack_prefix e) (render_expr env e)
  | Al.Ast.PopI e ->
    sprintf "%s Pop %s%s from the stack." (render_order index depth)
      (render_stack_prefix e) (render_expr env e)
  | Al.Ast.PopAllI e ->
    sprintf "%s Pop all values %s from the top of the stack." (render_order index depth)
      (render_expr env e)
  | Al.Ast.LetI (e, { it = Al.Ast.IterE ({ it = Al.Ast.InvCallE (id, nl, al); _ }, iterexp); _ }) ->
    let elhs, erhs = al_invcalle_to_al_bine e id nl al in
    let ebin = Al.Al_util.binE (`EqOp, elhs, erhs) ~note:Al.Al_util.no_note in
    let eiter = Al.Al_util.iterE (ebin, iterexp) ~note:Al.Al_util.no_note in
    sprintf "%s Let %s be the result for which %s."
      (render_order index depth)
      (render_expr env e)
      (render_expr env eiter)
  | Al.Ast.LetI (e, { it = Al.Ast.InvCallE (id, nl, al); _ }) ->
    let elhs, erhs = al_invcalle_to_al_bine e id nl al in
    sprintf "%s Let %s be the result for which %s %s %s."
      (render_order index depth)
      (render_expr env e)
      (render_expr env elhs)
      (render_math "=")
      (render_expr env erhs)
  | Al.Ast.LetI (n, ({ it = Al.Ast.CallE (("Module_ok"), [{ it = ExpA arge; _ }]); _ } as e)) ->
    (* HARDCODE: special function calls for LetI *)
    let to_expr exp' = exp' $$ (no_region, Il.Ast.BoolT $ no_region) in
    let to_instr instr' = instr' $$ (no_region, 0) in
    let is_valid = Al.Ast.IsValidE arge |> to_expr in
    let not_valid = Al.Ast.UnE (`NotOp, is_valid) |> to_expr in
    let faili = [Al.Ast.FailI |> to_instr] in
    let check_instr = Al.Ast.IfI (not_valid, faili, []) |> to_instr in
    let valid_check_string = render_instr env algoname index depth check_instr in
    sprintf "%s\n\n%s Let %s be %s."
      valid_check_string
      (render_order index depth) (render_expr env n)
      (render_expr env e)
  | Al.Ast.LetI (n, ({ it = Al.Ast.CallE (("Ref_type"), [{ it = ExpA arge; _ }]); _ } as e)) ->
    (* HARDCODE: special function calls for LetI *)
    let to_expr exp' = exp' $$ (no_region, Il.Ast.BoolT $ no_region) in
    let to_instr instr' = instr' $$ (no_region, 0) in
    let is_valid = Al.Ast.IsValidE arge |> to_expr in
    let assert_instr = Al.Ast.AssertI (is_valid) |> to_instr in
    let valid_check_string = render_instr env algoname index depth assert_instr in
    sprintf "%s\n\n%s Let %s be %s."
      valid_check_string
      (render_order index depth) (render_expr env n)
      (render_expr env e)
  | Al.Ast.LetI (n, ({ it = Al.Ast.CallE ("concat_", al); _ })) ->
    let args = List.map (render_arg env) al in
    let ce = (match args with
    | [_; expr] ->
      "the concatenation of " ^ expr
    | _ -> error instr.at "Invalid arity for relation call";
    ) in
    sprintf "%s Let %s be %s." (render_order index depth) (render_expr env n) ce
  | Al.Ast.LetI (n, e) ->
    let rec find_eval_expr e = match e.it with
      | Al.Ast.CallE ("Eval_expr", [z; arg]) ->
        Some (z, arg)
      | Al.Ast.IterE (expr, ie) ->
        let* z, arg = find_eval_expr expr in
        let* arg = match arg.it with
        | Al.Ast.ExpA e' ->
          Some { arg with it = Al.Ast.ExpA { e' with it = Al.Ast.IterE (e', ie) } }
        | _-> None
        in
        Some (z, arg)
      | _ -> None
    in
    (match find_eval_expr e with
    | Some (z, al) ->
      let sz = render_arg env z in
      let sal = render_arg env al in
      let eval =
        "the result of :ref:`evaluating <exec-expr>` " ^ sal ^ " with state " ^ sz
      in
      sprintf "%s Let %s be %s." (render_order index depth) (render_expr env n) eval
    | _ ->
      sprintf "%s Let %s be %s." (render_order index depth) (render_expr env n)
        (render_expr env e)
    )
  | Al.Ast.TrapI -> sprintf "%s Trap." (render_order index depth)
  | Al.Ast.FailI -> sprintf "%s Fail." (render_order index depth)
  | Al.Ast.ThrowI e ->
    sprintf "%s Throw the exception %s as a result." (render_order index depth) (render_expr env e)
  | Al.Ast.NopI -> sprintf "%s Do nothing." (render_order index depth)
  | Al.Ast.ReturnI e_opt ->
    sprintf "%s Return%s." (render_order index depth)
      (render_opt " " (render_expr env) "" e_opt)
  | Al.Ast.EnterI (e1, e2, il) ->
    sprintf "%s Enter %s with label %s.%s" (render_order index depth)
      (render_expr env e2) (render_expr env e1)
      (render_instrs env algoname (depth + 1) il)
  | Al.Ast.ExecuteI e ->
    sprintf "%s Execute the instruction %s." (render_order index depth) (render_expr env e)
  | Al.Ast.ExecuteSeqI e ->
    sprintf "%s Execute the sequence %s." (render_order index depth) (render_expr env e)
  | Al.Ast.PerformI (n, es) ->
    sprintf "%s Perform %s." (render_order index depth) (render_expr env (Al.Al_util.callE (n, es) ~at:no_region ~note:Al.Al_util.no_note))
  | Al.Ast.ExitI a ->
    sprintf "%s Exit from %s." (render_order index depth) (render_atom env a)
  | Al.Ast.ReplaceI (e1, p, e2) ->
    sprintf "%s Replace %s with %s." (render_order index depth)
      (render_expr env (Al.Al_util.accE (e1, p) ~note:Al.Al_util.no_note ~at:no_region)) (render_expr env e2)
  | Al.Ast.AppendI (e1, e2) ->
    sprintf "%s Append %s to %s." (render_order index depth)
      (render_expr env e2) (render_expr env e1)
  | Al.Ast.FieldWiseAppendI (e1, e2) ->
    sprintf "%s Append %s to %s, fieldwise" (render_order index depth)
      (render_expr env e2) (render_expr env e1)
  | Al.Ast.YetI s -> sprintf "%s YetI: %s." (render_order index depth) s

and render_instrs env algoname depth instrs =
  let index = ref 0 in
  List.fold_left
    (fun sinstrs i ->
      sinstrs ^ "\n\n" ^ repeat indent depth ^ render_instr env algoname index depth i)
    "" instrs

(* Prose *)

let render_atom_title env name params =
  (* TODO a workaround, for algorithms named label or name
     that are defined as LABEL_ or FRAME_ in the dsl *)
  let name' =
    match name.it with
    | Atom.Atom "label" -> Atom.Atom "LABEL_"
    | Atom.Atom "frame" -> Atom.Atom "FRAME_"
    | Atom.Atom s -> Atom.Atom (String.uppercase_ascii s)
    | _ -> name.it
  in
  let name = name' $$ no_region % name.note in
  let op = [name] :: List.init (List.length params) (fun _ -> []) in
  let params = List.filter_map (fun a -> match a.it with Al.Ast.ExpA e -> Some e | _ -> None) params in
  let expr = Al.Al_util.caseE (op, params) ~at:no_region ~note:Al.Al_util.no_note in
  match al_to_el_expr expr with
  | Some ({ it = El.Ast.ParenE exp; _ }) -> render_el_exp env exp
  | Some exp -> render_el_exp env exp
  | None -> render_expr' env expr

let render_funcname_title env fname params =
  render_expr env (Al.Al_util.callE (fname, params) ~at:no_region ~note:Al.Al_util.no_note)

let _render_pred env name params instrs =
  let title = render_atom_title env name params in
  title ^ "\n" ^
  String.make (String.length title) '.' ^ "\n" ^
  render_stmts env 0 instrs

let render_rule env concl prems =
  init_typs ();
  match prems with
  | [] ->
    render_stmt {env with uncond_concl = true} 0 concl
  | _ ->
    let sconcl = render_stmt env 0 concl in
    let sconcl = String.sub sconcl 0 (String.length sconcl - 1) in (*remove dot*)
    let sprems = render_stmts env 1 prems in
    sprintf "%s if:\n%s" sconcl sprems

let render_rule_algo env name params instrs =
  let title = render_atom_title env name params in
  let rname = Al.Print.string_of_atom name in
  title ^ "\n" ^
  String.make (String.length title) '.' ^ "\n" ^
  render_instrs env rname 0 instrs

let render_func_algo env fname params instrs =
  let title = render_funcname_title env fname params in
  title ^ "\n" ^
  String.make (String.length title) '.' ^ "\n" ^
  render_instrs env fname 0 instrs

let render_def env = function
  | RuleD (_, concl, prems) ->
    (* TODO: update env.vars *)
    "\n" ^ render_rule env concl prems ^ "\n\n"
  | AlgoD algo ->
    let env = { env with vars = Il2al.Il2al_util.get_var_set_in_algo algo } in
    (match algo.it with
    | Al.Ast.RuleA (name, _, params, instrs) ->
      "\n" ^ render_rule_algo env name params instrs ^ "\n\n"
    | Al.Ast.FuncA (name, params, instrs) ->
      "\n" ^ render_func_algo env name params instrs ^ "\n\n"
    )

let render_prose env prose = List.map (render_def env) prose |> String.concat ""
