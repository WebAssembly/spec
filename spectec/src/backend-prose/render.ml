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
    mutable vars: Set.t;
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
  let ans = Macro.find_section env.macro link in
  ans

let inject_link s link = sprintf ":ref:`%s <%s>`" s link

let try_inject_link env s link =
  if find_section env link then Some (inject_link s link)
  else None

let type_with_link env e =
  let* text, iter = Prose_util.extract_desc e in
  let typ_name = Il.Print.string_of_typ e.note in
  let link =
    if typ_name = "context" then "context"
    else "syntax-" ^ typ_name in
  match try_inject_link env text link with
  | Some ref -> Some (ref ^ iter)
  | None -> Some (text ^ iter)

let valid_link env e =
  let bt, _ = Prose_util.unwrap_itert e.note in
  let typ_name = Il.Print.string_of_typ bt in
  let text = "valid" in
  let link = "valid-" ^ typ_name in
  match try_inject_link env text link with
  | Some ref -> ref
  | None -> inject_link text "valid-val"

let match_link env e =
  let bt, _ = Prose_util.unwrap_itert e.note in
  let typ_name = Il.Print.string_of_typ bt in
  let text = "matches" in
  let link = "match-" ^ typ_name in
  match try_inject_link env text link with
  | Some ref -> ref
  | None -> inject_link text "match"

let get_context_var e =
  match e.it with
  | Al.Ast.CaseE (_, [_; {it = Al.Ast.VarE x; _} as e']) when x <> "_" -> e' (* HARDCODE for frame *)
  | Al.Ast.CaseE (mixop, _) ->
    let x = mixop
      |> List.hd
      |> List.hd
      |> Atom.to_string
      |> (fun s -> String.sub s 0 1)
    in
    {e with it = VarE x}
  | _ -> assert false (* It is expected that the context is a CaseE *)

let to_fresh_var env e =
  match e.it with
  | Al.Ast.VarE x ->
    let (e', x') = if Set.mem x env.vars then
      let x' = x ^ "'" in
      let e' = {e with it = Al.Ast.VarE x'} in
      (e', x')
    else
      (e, x)
    in
    env.vars <- Set.add x' env.vars;
    e'
  | _ -> e


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
    | Al.Ast.BinE (`LeOp, { it = LenE _; _ }, { it = NumE (`Nat z | `Int z); _ })
    when z = Z.zero -> None
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
      (match Prose_util.extract_call_hint id with
      | Some {it = TextE _; _} -> (* Use customized prose hint for this call *)
        None
      | _ ->
        match Prose_util.find_relation id with
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
    | Al.Ast.StrE r ->
      let* elexpfield = al_to_el_record r in
      Some (El.Ast.StrE elexpfield)
    | Al.Ast.VarE id when String.ends_with ~suffix:"*" id ->
      let l = String.split_on_char '*' id in
      let id, iters = Util.Lib.List.split_hd l in
      let elid = id $ no_region in
      let ele = El.Ast.VarE (elid, []) in
      let wrap_iter e _ = El.Ast.IterE (e $ no_region, El.Ast.List) in
      Some (List.fold_left wrap_iter ele iters)
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
    | Al.Ast.CaseE _  when Al.Valid.sub_typ expr.note Al.Al_util.evalctxT -> None
    | Al.Ast.CaseE (op, el) ->
      (match Prose_util.extract_case_hint expr.note op with
      | Some {it = TextE _; _} -> None
      | _ ->
        (* Current rules for omitting parenthesis around a CaseE:
          1) Has no argument
          2) Is infix notation
          3) Is bracketed -> render into BrackE
          4) Is argument of CallE -> add first, omit later at CallE *)
        let atom_of atom = atom $$ no_region % (Atom.info "") in
        let find_brace_opt mixop =
          let s = Mixop.to_string mixop in
          let first = String.get s 1 in
          let last = String.get s (String.length s - 2) in
          match first, last with
          | '(', ')' -> Some (atom_of Atom.LParen, atom_of Atom.RParen)
          | '[', ']' -> Some (atom_of Atom.LBrack, atom_of Atom.RBrack)
          | '{', '}' -> Some (atom_of Atom.LBrace, atom_of Atom.RBrace)
          | _ -> None
        in
        let elal = mixop_to_el_exprs op in
        let* elel = al_to_el_exprs el in
        let eles = case_to_el_exprs elal elel in
        let ele = El.Ast.SeqE eles in
        (match elal, elel with
        | _, [] -> Some ele
        | None :: Some _ :: _, _ -> Some ele
        | _ ->
          (match find_brace_opt op with
          | Some (lbr, rbr) ->
            (* Split braces of el expressions *)
            let _, eles = Util.Lib.List.split_hd eles in
            let eles, _ = Util.Lib.List.split_last eles in
            let eles =
              (match eles with
              | [e1; { it = El.Ast.AtomE atom; _ }; e2] when atom.it = Xl.Atom.Dot2 ->
                (* HARDCODE: postprocess limits to infix notation *)
                El.Ast.InfixE (e1, atom, e2)
              | _ -> El.Ast.SeqE eles
              ) in
            Some (El.Ast.BrackE (lbr, eles $ no_region, rbr))
          | None -> Some (El.Ast.ParenE (ele $ no_region))
          )
        )
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
    List.fold_left2
      (fun acc a e ->
        match e.it with
        (* Remove epsilon argument for case *)
        | El.Ast.EpsE when hd <> None -> a::None::acc
        | _ -> a::Some(e)::acc
      )
      [ hd ]
      tl
      el
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

let render_arith_cmpop = function
  | `EqOp -> "is equal to"
  | `NeOp -> "is not equal to"
  | `LtOp -> "is less than"
  | `GtOp -> "is greater than"
  | `LeOp -> "is less than or equal to"
  | `GeOp -> "is greater than or equal to"

let render_prose_cmpop = function
  | `EqOp -> "is of the form"
  | `NeOp -> "is not of the form"
  | cmpop -> render_arith_cmpop cmpop

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

let render_el_typ env typ =
  Backend_latex.Render.render_typ env.render_latex typ |> render_math

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
  | Some elt -> render_el_typ env elt
  | None -> Il.Print.string_of_typ typ

(* Categories 2 and 3 are rendered by the prose backend,
   yet EL subexpressions are still rendered by the Latex backend *)

and render_expr' env expr =
  match expr.it with
  | Al.Ast.BoolE b -> string_of_bool b
  | Al.Ast.CvtE (e, _, _) -> render_expr' env e
  | Al.Ast.UnE (`NotOp, { it = Al.Ast.IsCaseOfE (e, a); _ }) ->
    let se = render_expr env e in
    let sts =
      Prose_util.find_case_typ (Il.Print.string_of_typ_name e.note) a
      |> render_el_typ env
    in
    sprintf "%s is not some %s" se sts
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
  | Al.Ast.BinE (`LeOp, { it = LenE e1; _ }, { it = NumE (`Nat z | `Int z); _ })
    when z = Z.zero -> sprintf "%s is empty" (render_expr env e1)
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
    let prep =
      match e1.it with
      | ExtE _ -> "and"
      | _ -> "with"
    in
    (match dir with
    | Al.Ast.Front -> sprintf "%s %s %s prepended by %s" se1 prep sps se2
    | Al.Ast.Back -> sprintf "%s %s %s appended by %s" se1 prep sps se2)
  | Al.Ast.CallE (("concat_" | "concatn_" as id), al) ->
    (* HARDCODE: rendering of concat_ *)
    let args = List.map (render_arg env) al in
    (match args with
    | [_; expr] | [_; expr; _] ->
      "the :ref:`concatenation <notation-concat>` of " ^ expr
    | _ -> error expr.at "Invalid arity for function " ^ id;
    )
  | Al.Ast.CallE (id, al) ->
    let args = List.map (render_arg env) al in
    (match Prose_util.extract_call_hint id with
    | Some {it = TextE template; _} -> Prose_util.apply_prose_hint template args
    | _ ->
      (* HARDCODE: relation call *)
      if id = "Eval_expr" then
        match args with
        | [arg] ->
          sprintf "the result of :ref:`evaluating <exec-expr>` %s" arg
        | _ -> error expr.at (Printf.sprintf "Invalid arity for relation call: %d ([ %s ])" (List.length args) (String.concat " " args))
      else if id = "Expand" || id = "Expand_use" then
        (match args with
        | [arg1] ->
          sprintf "the :ref:`expansion <aux-expand-deftype>` of %s" arg1
        | _ -> error expr.at "Invalid arity for relation call";
        )
      else if String.ends_with ~suffix:"_type" id || String.ends_with ~suffix:"_ok" id then
        (match args with
        | [arg1; arg2] ->
          sprintf "%s is :ref:`valid <valid-val>` with type %s" arg1 arg2
        | [arg] -> sprintf "the type of %s" arg
        | _ -> error expr.at "Invalid arity for relation call";
        )
      else error expr.at ("Not supported relation call: " ^ id)
    )
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
  | Al.Ast.CaseE (mixop, [ arity; arg ]) when Al.Valid.sub_typ expr.note Al.Al_util.evalctxT ->
    let atom_name = mixop |> List.hd |> List.hd |> Atom.to_string in
    let context_var = get_context_var expr in
    let rendered_arity =
      match arity.it with
      | NumE (`Nat z) when z = Z.zero -> ""
      | _ -> sprintf "whose arity is %s" (render_expr env arity) in
    let rendered_arg =
      (match atom_name with
      | "LABEL_" ->
        let continuation =
          match arg.it with
          | ListE [] -> "end"
          | _ -> "start" in
        sprintf "whose continuation is the %s of the block" continuation
      | "FRAME_" -> ""
      | "HANDLER_" ->
        sprintf "whose catch handler is %s" (render_expr env arg)
      | _ ->
        expr
        |> Al.Print.string_of_expr
        |> sprintf "Rendering control frame %s failed: rendering control frame requires hardcoding"
        |> failwith
      )
    in
    let space_opt = if (rendered_arg ^ rendered_arity) = "" then "" else " " in
    let and_opt = if rendered_arg <> "" && rendered_arity <> "" then " and " else "" in
    sprintf "%s%s%s%s%s"
      (render_expr env context_var)
      space_opt
      rendered_arity
      and_opt
      rendered_arg
  | Al.Ast.CaseE (mixop, es) ->
    (match Prose_util.extract_case_hint expr.note mixop with
    | Some {it = TextE template; _} ->
      let args = List.map (render_expr env) es in
      Prose_util.apply_prose_hint template args
    | _ -> error expr.at (Printf.sprintf "Cannot render %s" (Al.Print.string_of_expr expr))
    )
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
      let iters = List.map (fun (e1, e2) -> (Al.Al_util.varE e1 ~note:Al.Al_util.no_note, e2)) xes in
      let render_iter env (e1, e2) = (render_expr env e1) ^ " in " ^ (render_expr env e2) in
      let render_iters env iters = List.map (render_iter env) iters |> String.concat ", and corresponding " in
      sprintf "for all %s, %s" (render_iters env iters) se)
  | Al.Ast.GetCurStateE -> "the current state"
  | Al.Ast.GetCurContextE a ->
    sprintf "the topmost %s" (render_atom env a)
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
    let sts =
      Prose_util.find_case_typ (Il.Print.string_of_typ_name e.note) a
      |> render_el_typ env
    in
    sprintf "%s is some %s" se sts
  | Al.Ast.HasTypeE (e, t) ->
    let se = render_expr env e in
    let te = Al.Ast.VarE "" $$ no_region % t in
    let st = match Prose_util.extract_desc te with
    | None -> render_typ env t
    | Some (desc, seq) -> desc ^ seq in
    sprintf "%s is %s" se st
  | Al.Ast.IsValidE e ->
    let vref = valid_link env e in
    let se = render_expr env e in
    sprintf "%s is %s" se vref
  | Al.Ast.TopValueE (Some e) ->
    let ty =
      match type_with_link env e with
      | Some tyref -> tyref
      | None -> Il.Print.string_of_typ_name e.note
    in

    let value =
      if String.ends_with ~suffix:"type" ty || String.ends_with ~suffix:"type>`" ty then
        let se = render_expr env e in
        sprintf "a value of %s %s" ty se
      else
        sprintf "a %s" ty
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
  match type_with_link env e with
  | Some lt -> "the " ^ lt ^ " " ^ s
  | None -> s


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
  | Some text -> text
  | None -> "with"

let rec render_single_stmt ?(with_type=true) env stmt  =
  let render_hd_expr = if with_type then render_expr_with_type else render_expr in
  match stmt with
    | LetS (lhs, { it = LenE e; _ }) ->
    sprintf "let %s be the length of %s."
      (render_expr env lhs)
      (render_expr env e)
    | LetS (e1, e2) ->
      sprintf "%s is %s"
        (render_expr_with_type env e1)
        (render_expr env e2)
    | CondS e ->
      sprintf "%s"
        (render_expr env e)
    | CmpS ({ it = LenE e1; _ }, cmpop, { it = LenE e2; _ }) ->
      sprintf "The length of %s %s the length of %s"
        (render_expr env e1)
        (render_arith_cmpop cmpop)
        (render_expr env e2)
    | CmpS ({ it = LenE e1; _ }, `LeOp, { it = NumE (`Nat z | `Int z); _ })
    when z = Z.zero -> sprintf "%s is empty" (render_expr env e1)
    | CmpS ({ it = LenE e1; _ }, cmpop, e2) ->
      sprintf "The length of %s %s %s"
        (render_expr env e1)
        (render_arith_cmpop cmpop)
        (render_expr env e2)
    | CmpS (e1, cmpop, { it = LenE e2; _ }) ->
      sprintf "%s %s the length of %s"
        (render_expr env e1)
        (render_arith_cmpop cmpop)
        (render_expr env e2)
    | CmpS (e1, cmpop, e2) ->
      let cmpop, rhs =
        match e2.it with
        | OptE None -> render_prose_cmpop_eps cmpop, "absent"
        | ListE [] -> render_prose_cmpop_eps cmpop, "empty"
        | BoolE _ -> render_prose_cmpop_eps cmpop, render_expr env e2
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
        (if es = [] || prep = "" then "" else " " ^ prep ^ " " ^ render_list (render_expr_with_type env) " and " es)
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
    | IsConcatS (e1, e2) ->
      sprintf "%s is the concatenation of all such %s"
        (render_expr env e1)
        (render_expr env e2)
    | ContextS (e1, e2) -> render_context env e1 e2
    | RelS (s, es) ->
      let args = List.map (render_expr env) es in
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

let render_control_frame env expr =
  let open Al in
  match expr.it with
  | Ast.CaseE (mixop, [ arity; arg ]) ->
    let atom = mixop |> List.hd |> List.hd in
    let atom_name = Atom.to_string atom in
    let control_frame_name, rendered_arg =
      match atom_name with
      | "LABEL_" ->
        let continuation =
          match arg.it with
          | ListE [] -> "end"
          | _ -> "start" in
        sprintf "the %s" (render_atom env atom),
          sprintf "whose continuation is the %s of the block" continuation
      | "FRAME_" ->
        sprintf "the %s %s" (render_atom env atom) (render_expr env arg),
          ""
      | "HANDLER_" ->
        sprintf "the %s" (render_atom env atom),
          sprintf "whose catch handler is %s" (render_expr env arg)
      | _ ->
        expr
        |> Al.Print.string_of_expr
        |> sprintf "Rendering control frame %s failed: rendering control frame requires hardcoding"
        |> failwith
    in
    let rendered_arity =
      match arity.it with
      | NumE (`Nat z) when z = Z.zero -> ""
      | _ -> sprintf "whose arity is %s" (render_expr env arity) in
    let space_opt = if (rendered_arg ^ rendered_arity) = "" then "" else " " in
    let and_opt = if rendered_arg <> "" && rendered_arity <> "" then " and " else "" in
    sprintf "%s%s%s%s%s"
      control_frame_name
      space_opt
      rendered_arity
      and_opt
      rendered_arg
  | _ ->
    expr
    |> Print.string_of_expr
    |> sprintf "Invalid control frame: %s"
    |> failwith

let render_perform env fname args =
  (
    (* Use prose hint if it exists *)
    let* hint = Prose_util.extract_call_hint fname in
    let* args' = List.fold_left (fun acc a ->
      let* acc' = acc in
      let* ea = match a.it with | Al.Ast.ExpA e -> Some e | _ -> None in
      let* a' = al_to_el_expr ea in
      Some (acc' @ [a'])
    ) (Some []) args in
    let hint' = Prose_util.fill_hole args' hint in
    match hint'.it with
    | El.Ast.SeqE es ->
      let ss = List.map (fun e ->
        match e.it with
        | El.Ast.TextE s -> s
        | _ -> render_el_exp env e
      ) es in
      Some (String.concat " " ss)
    | _ -> None
  )
  |> Option.value ~default:(
    "Perform " ^ (render_expr env (Al.Al_util.callE (fname, args) ~at:no_region ~note:Al.Al_util.no_note))
  )

let render_rhs env lhs rhs =
  match rhs.it with
  | Al.Ast.LenE e -> sprintf "the length of %s" (render_expr env e)
  | Al.Ast.IterE ({ it = Al.Ast.InvCallE (id, nl, al); _ }, iterexp) ->
    let elhs, erhs = al_invcalle_to_al_bine lhs id nl al in
    let ebin = Al.Al_util.binE (`EqOp, elhs, erhs) ~note:Al.Al_util.no_note in
    let eiter = Al.Al_util.iterE (ebin, iterexp) ~note:Al.Al_util.no_note in
    sprintf "the result for which %s" (render_expr env eiter)
  | Al.Ast.IterE (e, (Al.Ast.ListN (ie, Some id), xes)) ->
    let se = render_expr env e in
    let ids = List.map fst xes in
    assert (ids = [ id ]);
    let eid = Al.Al_util.varE id ~note:Al.Al_util.no_note in
    let sid = render_expr env eid in
    let elb = Al.Al_util.natE Z.zero ~note:Al.Al_util.no_note in
    let selb = render_expr env elb in
    let eub =
      Al.Al_util.binE (
        `SubOp,
        ie,
        Al.Al_util.natE Z.one ~note:Al.Al_util.no_note)
      ~note:Al.Al_util.no_note
    in
    let seub = render_expr env eub in
    sprintf "%s for all %s from %s to %s" se sid selb seub
  | Al.Ast.InvCallE ("concat_", nl, al) ->
    let elhs, erhs = al_invcalle_to_al_bine lhs "concat_" nl al in
    sprintf "the result for which %s is %s"
      (render_expr' env elhs)
      (render_expr env erhs)
  (* HARDCODE: rendering of concat_ *)
  | Al.Ast.InvCallE ("concatn_", nl, al) ->
    let elhs, erhs = al_invcalle_to_al_bine lhs "concatn_" nl al in
    (match elhs.it with
    | CallE (_, [_; { it = Al.Ast.ExpA e'; _}; n]) ->
      (match e'.it with
      | Al.Ast.IterE (e'', _) ->
        sprintf "the result for which each %s has length %s, and %s is %s"
          (render_expr env e'')
          (render_arg env n)
          (render_expr' env elhs)
          (render_expr env erhs)
      | _ -> error rhs.at "Invalid argument for function concatn_"
      )
    | _ -> error rhs.at "Invalid arity for function concatn_"
    )
  | Al.Ast.InvCallE (id, nl, al) ->
    let elhs, erhs = al_invcalle_to_al_bine lhs id nl al in
    sprintf "the result for which %s %s %s"
      (render_expr env elhs)
      (render_math "=")
      (render_expr env erhs)
  | Al.Ast.CallE (("concat_" | "concatn_"), _) -> render_expr' env rhs
  | _ ->
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
    (match find_eval_expr rhs with
    | Some (z, al) ->
      let sz = render_arg env z in
      let sal = render_arg env al in
      let eval =
        "the result of :ref:`evaluating <exec-expr>` " ^ sal ^ " with state " ^ sz
      in
      eval
    | _ ->
      render_expr env rhs
    )

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
        let eiters = List.map (fun eid -> Al.Al_util.iterE (eid, (iter, [])) ~note:Al.Al_util.no_note) eids in
        let iters = List.map (fun (e1, e2) -> (Al.Al_util.varE e1 ~note:Al.Al_util.no_note, e2)) xes in
        let render_iter env (e1, e2) = (render_expr env e1) ^ " in " ^ (render_expr env e2) in
        let render_iters env iters = List.map (render_iter env) iters |> String.concat ", and corresponding " in
        sprintf "For all %s" (render_iters env iters), eiters
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
    (* HARDCODE: omit "Due to validation" for assertions from 9-module.spectec *)
    if String.ends_with ~suffix:"module.spectec" c.at.left.file then (
      sprintf "%s Assert: %s." (render_order index depth) (render_expr env c)
    ) else (
      let lname = String.lowercase_ascii algoname in
      let vref = match try_inject_link env "validation" ("valid-" ^ lname) with
      | Some s -> s
      | None -> "validation"
      in
      sprintf "%s Assert: Due to %s, %s." (render_order index depth)
      vref (render_expr env c)
    )
  | Al.Ast.PushI ({ it = Al.Ast.CaseE (mixop, _); _ } as e)
  when Al.Valid.sub_typ e.note Al.Al_util.evalctxT ->
    let atom = mixop |> List.hd |> List.hd in
    let context_var = get_context_var e in
    let context_var' = to_fresh_var env context_var in
    sprintf "%s Let %s be %s.\n\n%s%s Push the %s %s."
      (render_order index depth)
      (render_expr env context_var')
      (render_control_frame env e)
      (repeat indent depth)
      (render_order index depth)
      (render_atom env atom)
      (render_expr env context_var')
  | Al.Ast.PushI e ->
    sprintf "%s Push %s %s to the stack." (render_order index depth)
      (render_stack_prefix e) (render_expr env e)
  | Al.Ast.PopI ({ it = Al.Ast.CaseE (mixop, _); _ } as expr)
  when Al.Valid.sub_typ expr.note Al.Al_util.evalctxT ->
    let atom = mixop |> List.hd |> List.hd in
    let control_frame_kind = render_atom env atom in
    sprintf "%s Pop the %s from the stack."
      (render_order index depth)
      control_frame_kind
  | Al.Ast.PopI e ->
    sprintf "%s Pop %s %s from the stack." (render_order index depth)
      (render_stack_prefix e) (render_expr env e)
  | Al.Ast.PopAllI e ->
    sprintf "%s Pop all values %s from the top of the stack." (render_order index depth)
      (render_expr env e)
  (* HARDCODE: lsize *)
  | Al.Ast.LetI (e1, {it = Al.Ast.InvCallE (id, _, [{it = ExpA a; _}]); _}) when String.starts_with ~prefix:"lsize" id  ->
    let instr' = Al.Ast.LetI ({a with it = Al.Ast.CallE (id, [Al.Ast.ExpA e1 $ e1.at])}, a) in
    render_instr env algoname index depth {instr with it = instr'}
  | Al.Ast.LetI (e1, e2) ->
    (match e1.it with
    (* NOTE: This assumes that the first argument of control frame is arity *)
    | Al.Ast.CaseE (mixop, [ arity; arg ] ) when Al.Valid.sub_typ e1.note Al.Al_util.evalctxT ->
      let atom_name = mixop |> List.hd |> List.hd |> Atom.to_string in
      let context_var = get_context_var e1 in
      let rendered_let =
        sprintf "%s Let %s be %s."
          (render_order index depth)
          (render_expr env context_var)
          (render_expr env e2) in
      (* XXX: It could introduce dead assignment *)
      let rendered_arity =
        match render_expr env arity with
        | "" -> ""
        | s ->
          sprintf "\n\n%s%s Let %s be the arity of %s"
            (repeat indent depth)
            (render_order index depth)
            s
            (render_expr env context_var) in
      (* XXX: It could introduce dead assignment *)
      let rendered_arg =
        match atom_name with
        | "HANDLER_" ->
          sprintf "\n\n%s%s Let %s be the catch handler of %s"
            (repeat indent depth)
            (render_order index depth)
            (render_expr env arg)
            (render_expr env context_var)
        | _ -> "" in
      rendered_let ^ rendered_arity ^ rendered_arg
    | _ ->
      let pre_cond =
        match e2.it with
        | Al.Ast.CallE ("Module_ok", [{ it = ExpA arge; _ }]) ->
          (* HARDCODE: special function calls for LetI *)
          let to_expr exp' = exp' $$ (no_region, Il.Ast.BoolT $ no_region) in
          let to_instr instr' = instr' $$ (no_region, 0) in
          let is_valid = Al.Ast.IsValidE arge |> to_expr in
          let not_valid = Al.Ast.UnE (`NotOp, is_valid) |> to_expr in
          let faili = [Al.Ast.FailI |> to_instr] in
          let check_instr = Al.Ast.IfI (not_valid, faili, []) |> to_instr in
          let valid_check_string = render_instr env algoname index depth check_instr in
          valid_check_string ^ "\n\n"
        | Al.Ast.CallE ("Ref_type", [{ it = ExpA arge; _ }]) ->
          (* HARDCODE: special function calls for LetI *)
          let to_expr exp' = exp' $$ (no_region, Il.Ast.BoolT $ no_region) in
          let to_instr instr' = instr' $$ (no_region, 0) in
          let is_valid = Al.Ast.IsValidE arge |> to_expr in
          let assert_instr = Al.Ast.AssertI (is_valid) |> to_instr in
          let valid_check_string = render_instr env algoname index depth assert_instr in
          valid_check_string ^ "\n\n"
        | _ -> ""
      in

      let rhs = render_rhs env e1 e2 in

      let type_desc = (
        if String.starts_with ~prefix:":math:" rhs then (
          match type_with_link env e1 with
          | Some s ->
            "the " ^ s ^ " "
          | None -> ""
        )
        else ""
      ) in
      let desc = match e1.it with
      | VarE _ -> type_desc
      | CaseE (mixop, [_]) when (Mixop.to_string mixop).[0] = '_' -> type_desc
      | CaseE _ | StrE _ | TupE _ -> "the destructuring of "
      | _ -> ""
      in
      sprintf "%s%s Let %s be %s%s." pre_cond (render_order index depth) (render_expr env e1) desc rhs
    )
  | Al.Ast.TrapI -> sprintf "%s Trap." (render_order index depth)
  | Al.Ast.FailI -> sprintf "%s Fail." (render_order index depth)
  | Al.Ast.ThrowI e ->
    sprintf "%s Throw the exception %s as a result." (render_order index depth) (render_expr env e)
  | Al.Ast.NopI -> sprintf "%s Do nothing." (render_order index depth)
  | Al.Ast.ReturnI e_opt ->
    sprintf "%s Return%s." (render_order index depth)
      (render_opt " " (render_expr env) "" e_opt)
  | Al.Ast.EnterI ({ it = Al.Ast.CaseE (mixop, _); _ } as e1, e2, il) ->
    let atom = mixop |> List.hd |> List.hd in
    let context_var = (get_context_var e1) in
    sprintf "%s Let %s be %s.\n\n%s%s Enter the block %s with the %s %s.%s"
      (render_order index depth)
      (render_expr env context_var)
      (render_control_frame env e1)
      (repeat indent depth)
      (render_order index depth)
      (render_expr env e2)
      (render_atom env atom)
      (render_expr env context_var)
      (render_instrs env algoname (depth + 1) il)
  | Al.Ast.EnterI (e1, e2, il) ->
    sprintf "%s Enter the block %s with label %s.%s" (render_order index depth)
      (render_expr env e2) (render_expr env e1)
      (render_instrs env algoname (depth + 1) il)
  | Al.Ast.ExecuteI e ->
    sprintf "%s Execute the instruction %s." (render_order index depth) (render_expr env e)
  | Al.Ast.ExecuteSeqI ({ it = CallE ("__prose:_jump_to_the_cont", _); _}) ->
    let label = Al.Al_util.(varE "L" ~note:(varT "label" [])) in
    sprintf "%s Jump to the continuation of %s." (render_order index depth) (render_expr env label)
  | Al.Ast.ExecuteSeqI e ->
    sprintf "%s Execute the sequence %s." (render_order index depth) (render_expr env e)
  | Al.Ast.PerformI (n, es) ->
    sprintf "%s %s." (render_order index depth) (render_perform env n es)
  | Al.Ast.ExitI a ->
    sprintf "%s Exit from %s." (render_order index depth) (render_atom env a)
  | Al.Ast.ReplaceI (e1, p, e2) ->
    sprintf "%s Replace %s with %s." (render_order index depth)
      (render_expr env (Al.Al_util.accE (e1, p) ~note:Al.Al_util.no_note ~at:no_region)) (render_expr env e2)
  | Al.Ast.AppendI (e1, e2) ->
    sprintf "%s Append %s to %s." (render_order index depth)
      (render_expr env e2) (render_expr env e1)
  | Al.Ast.ForEachI (xes, il) ->
    sprintf "%s For each %s, do:%s" (render_order index depth)
      (xes |> List.map (fun (x, e) ->
        let t = match e.note.it with | Il.Ast.IterT (t, _) -> t | _ -> assert false in
        let e' = Al.Ast.VarE x $$ no_region % t in
        render_expr env e' ^ " in " ^ render_expr env e
      ) |> String.concat " and ")
      (render_instrs env algoname (depth + 1) il)
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
