open Util
open Source
open El.Ast
open Config


(* Errors *)

let error at msg = Source.error at "latex generation" msg


(* Environment *)

module Map = Map.Make(String)

type rel_sort = TypingRel | ReductionRel

type env =
  { config : config;
    show_syn : exp Map.t ref;
    show_var : exp Map.t ref;
    show_rel : exp Map.t ref;
    show_def : exp Map.t ref;
    show_case : exp Map.t ref;
    show_field : exp Map.t ref;
    current_rel : string;
  }


let env_hints map id hints =
  List.iter (fun {hintid; hintexp} ->
    if hintid.it = "show" then map := Map.add id hintexp !map
  ) hints

let env_typfield env = function
  | Elem (Atom id, _, hints) -> env_hints env.show_field id hints
  | _ -> ()

let env_typcase env = function
  | Elem (Atom id, _, hints) -> env_hints env.show_case id hints
  | _ -> ()

let env_deftyp env deftyp =
  match deftyp.it with
  | NotationT _ -> ()
  | StructT typfields -> List.iter (env_typfield env) typfields
  | VariantT (_, _, typcases, _) -> List.iter (env_typcase env) typcases

let env_def env def =
  match def.it with
  | SynD (id, _, deftyp, hints) ->
    env_hints env.show_syn id.it hints;
    env_hints env.show_var id.it hints;
    env_deftyp env deftyp
  | RelD (id, _, hints) -> env_hints env.show_rel id.it hints
  | VarD (id, _, hints) -> env_hints env.show_var id.it hints
  | DecD (id, _, _, hints) -> env_hints env.show_def id.it hints
  | RuleD _ | DefD _ | SepD -> ()

let env config script : env =
  let env =
    { config;
      show_syn = ref Map.empty;
      show_var = ref Map.empty;
      show_rel = ref Map.empty;
      show_def = ref Map.empty;
      show_case = ref Map.empty;
      show_field = ref Map.empty;
      current_rel = "";
    }
  in
  List.iter (env_def env) script;
  env


(* Helpers *)

let concat = String.concat
let suffix s f x = f x ^ s
let space f x = " " ^ f x ^ " "

let rec has_nl = function
  | [] -> false
  | Nl::_ -> true
  | _::xs -> has_nl xs

let map_nl_list f xs = List.map (function Nl -> Nl | Elem x -> Elem (f x)) xs

let rec concat_map_nl sep br f = function
  | [] -> ""
  | [Elem x] -> f x
  | (Elem x)::xs -> f x ^ sep ^ concat_map_nl sep br f xs
  | Nl::xs -> br ^ concat_map_nl sep br f xs

let rec altern_map_nl sep br f = function
  | [] -> ""
  | [Elem x] -> f x
  | (Elem x)::Nl::xs -> f x ^ br ^ altern_map_nl sep br f xs
  | (Elem x)::xs -> f x ^ sep ^ altern_map_nl sep br f xs
  | Nl::xs -> br ^ altern_map_nl sep br f xs

let strip_nl = function
  | Nl::xs -> xs
  | xs -> xs


(* Identifiers *)

let render_expand_fwd = ref (fun _ -> assert false)

let is_digit c = '0' <= c && c <= '9'

let id_style = function
  | `Var -> "\\mathit"
  | `Func -> "\\mathrm"
  | `Atom -> "\\mathsf"
  | `Token -> "\\mathtt"

let render_id env style id =
  if env.config.macros_for_ids then
    "\\" ^ id
  else
    id_style style ^ "{" ^ id ^ "}"

let rec render_varid env show id =
  render_varid_sub env show id.at (String.split_on_char '_' id.it)

and render_varid_sub env show at = function
  | [] -> ""
  | s::ss ->
    let rec find_primes i =
      if i > 0 && s.[i - 1] = '\'' then find_primes (i - 1) else i
    in
    let n = String.length s in
    let i = find_primes n in
    let s' = String.sub s 0 i in
    let s'' =
      if String.for_all is_digit s' then s' else
      !render_expand_fwd env show (s' $ at) [] (fun () -> render_id env `Var s')
    in
    (if i = n then s'' else "{" ^ s'' ^ String.sub s i (n - i) ^ "}") ^
    (if ss = [] then "" else "_{" ^ render_varid_sub env show at ss ^ "}")


(* Operators *)

let render_atom env = function
  | Atom atomid when atomid.[0] = '_' && atomid <> "_" -> ""
  | Atom atomid ->
    let atomid' = Str.(global_replace (regexp "_") "\\_" atomid) in
    render_id env `Atom (String.lowercase_ascii atomid')
  | Bot -> "\\bot"
  | Dot -> "."
  | Dot2 -> ".."
  | Dot3 -> "\\dots"
  | Semicolon -> ";"
  | Arrow -> "\\rightarrow"
  | Colon -> ":"
  | Sub -> "\\leq"
  | SqArrow -> "\\hookrightarrow"
  | Tilesturn -> "\\dashv"
  | Turnstile ->
    if env.config.macros_for_vdash then
      "\\vdash" ^ env.current_rel
    else
      "\\vdash"

let render_brack = function
  | Paren -> "(", ")"
  | Brack -> "[", "]"
  | Brace -> "\\{", "\\}"

let render_unop = function
  | NotOp -> "\\neg"
  | PlusOp -> "+"
  | MinusOp -> "-"

let render_binop = function
  | AndOp -> "\\land"
  | OrOp -> "\\lor"
  | ImplOp -> "Rightarrow"
  | AddOp -> "+"
  | SubOp -> "-"
  | MulOp -> "\\cdot"
  | DivOp -> "/"
  | ExpOp -> assert false

let render_cmpop = function
  | EqOp -> "="
  | NeOp -> "\\neq"
  | LtOp -> "<"
  | GtOp -> ">"
  | LeOp -> "\\leq"
  | GeOp -> "\\geq"

let render_dots = function
  | Dots -> [Elem "..."]
  | NoDots -> []


(* Show expansions *)

exception Arity_mismatch

let rec expand_iter args iter =
  match iter with
  | Opt | List | List1 -> iter
  | ListN exp -> ListN (expand_exp args exp)

and expand_exp args exp = expand_exp' args exp.it $ exp.at
and expand_exp' args exp' =
  match exp' with
  | VarE _ | AtomE _ | BoolE _ | NatE _ | TextE _ | EpsE -> exp'
  | UnE (unop, exp) -> UnE (unop, expand_exp args exp)
  | BinE (exp1, binop, exp2) ->
    let exp1' = expand_exp args exp1 in
    let exp2' = expand_exp args exp2 in
    BinE (exp1', binop, exp2')
  | CmpE (exp1, cmpop, exp2) ->
    let exp1' = expand_exp args exp1 in
    let exp2' = expand_exp args exp2 in
    CmpE (exp1', cmpop, exp2')
  | SeqE exps -> SeqE (List.map (expand_exp args) exps)
  | IdxE (exp1, exp2) ->
    let exp1' = expand_exp args exp1 in
    let exp2' = expand_exp args exp2 in
    IdxE (exp1', exp2')
  | SliceE (exp1, exp2, exp3) ->
    let exp1' = expand_exp args exp1 in
    let exp2' = expand_exp args exp2 in
    let exp3' = expand_exp args exp3 in
    SliceE (exp1', exp2', exp3')
  | UpdE (exp1, path, exp2) ->
    let exp1' = expand_exp args exp1 in
    let path' = expand_path args path in
    let exp2' = expand_exp args exp2 in
    UpdE (exp1', path', exp2')
  | ExtE (exp1, path, exp2) ->
    let exp1' = expand_exp args exp1 in
    let path' = expand_path args path in
    let exp2' = expand_exp args exp2 in
    ExtE (exp1', path', exp2')
  | StrE expfields -> StrE (map_nl_list (expand_expfield args) expfields)
  | DotE (exp, atom) -> DotE (expand_exp args exp, atom)
  | CommaE (exp1, exp2) ->
    let exp1' = expand_exp args exp1 in
    let exp2' = expand_exp args exp2 in
    CommaE (exp1', exp2')
  | CompE (exp1, exp2) ->
    let exp1' = expand_exp args exp1 in
    let exp2' = expand_exp args exp2 in
    CompE (exp1', exp2')
  | LenE exp -> LenE (expand_exp args exp)
  | ParenE exp -> ParenE (expand_exp args exp)
  | TupE exps -> TupE (List.map (expand_exp args) exps)
  | InfixE (exp1, atom, exp2) ->
    let exp1' = expand_exp args exp1 in
    let exp2' = expand_exp args exp2 in
    InfixE (exp1', atom, exp2')
  | BrackE (brack, exp) -> BrackE (brack, expand_exp args exp)
  | CallE (id, exp) -> CallE (id, expand_exp args exp)
  | IterE (exp1, iter) ->
    let exp1' = expand_exp args exp1 in
    let iter' = expand_iter args iter in
    IterE (exp1', iter')
  | HoleE false ->
    (match !args with
    | [] -> raise Arity_mismatch
    | arg::args' -> args := args'; arg.it
    )
  | HoleE true -> let exps = !args in args := []; SeqE exps
  | FuseE (exp1, exp2) ->
    let exp1' = expand_exp args exp1 in
    let exp2' = expand_exp args exp2 in
    FuseE (exp1', exp2')

and expand_expfield args (atom, exp) = (atom, expand_exp args exp)

and expand_path args path = expand_path' args path.it $ path.at
and expand_path' args path' =
  match path' with
  | RootP -> RootP
  | IdxP (path1, exp2) ->
    let path1' = expand_path args path1 in
    let exp2' = expand_exp args exp2 in
    IdxP (path1', exp2')
  | DotP (path1, atom) -> DotP (expand_path args path1, atom)


and render_expand env show id args f =
  match Map.find_opt id.it !show with
  | None -> f ()
  | Some showexp ->
    try
      let rargs = ref args in
      let exp = expand_exp rargs showexp in
      if !rargs <> [] then raise Arity_mismatch;
      render_exp env exp
    with Arity_mismatch -> f ()


(* Iteration *)

and render_iter env = function
  | Opt -> "^?"
  | List -> "^\\ast"
  | List1 -> "^{+}"
  | ListN {it = ParenE exp; _} | ListN exp -> "^{" ^ render_exp env exp ^ "}"


(* Types *)

and render_typ env typ =
  match typ.it with
  | VarT id -> render_varid env env.show_syn id
  | BoolT -> render_id env `Var "bool"
  | NatT -> render_id env `Var "nat"
  | TextT -> render_id env `Var "text"
  | ParenT typ -> "("^ render_typ env typ ^")"
  | TupT typs -> "("^ render_typs ",\\; " env typs ^")"
  | IterT (typ1, iter) -> render_typ env typ1 ^ render_iter env iter

and render_typs sep env typs =
  concat sep (List.filter ((<>) "") (List.map (render_typ env) typs))


and render_deftyp env deftyp =
  match deftyp.it with
  | NotationT nottyp -> render_nottyp env nottyp
  | StructT typfields ->
    "\\{\\; " ^
    "\\begin{array}[t]{@{}l@{}}\n" ^
    concat_map_nl ",\\; " "\\\\\n  " (render_typfield env) typfields ^ " \\;\\}" ^
    "\\end{array}"
  | VariantT (dots1, ids, typcases, dots2) ->
    altern_map_nl " ~|~ " " \\\\ &&|&\n" Fun.id
      (render_dots dots1 @ map_nl_list it ids @
        map_nl_list (render_typcase env deftyp.at) typcases @ render_dots dots2)

and render_nottyp env nottyp =
  match nottyp.it with
  | TypT typ -> render_typ env typ
  | AtomT atom -> render_typcase env nottyp.at (atom, [], [])
  | SeqT [] -> "\\epsilon"
  | SeqT ({it = AtomT atom; at}::typs) -> render_typcase env at (atom, typs, [])
  | SeqT nottyps -> render_nottyps "~" env nottyps
  | InfixT ({it = SeqT []; _}, atom, nottyp2) ->
    "{" ^ space (render_atom env) atom ^ "}\\;" ^ render_nottyp env nottyp2
  | InfixT (nottyp1, atom, nottyp2) ->
    render_nottyp env nottyp1 ^ space (render_atom env) atom ^
    render_nottyp env nottyp2
  | BrackT (brack, nottyp1) ->
    let l, r = render_brack brack in l ^ render_nottyp env nottyp1 ^ r
  | ParenNT nottyp1 -> "(" ^ render_nottyp env nottyp1 ^ ")"
  | IterNT (nottyp1, iter) -> render_nottyp env nottyp1 ^ render_iter env iter

and render_nottyps sep env nottyps =
  concat sep (List.filter ((<>) "") (List.map (render_nottyp env) nottyps))


and render_typfield env (atom, typ, _hints) =
  render_fieldname env atom typ.at  ^ "~" ^ render_typ env typ

and render_typcase env at (atom, nottyps, _hints) =
  let ss = List.map (render_nottyp env) nottyps in
  (* Hack: turn rendered types into literal atoms *)
  let exps = List.map2 (fun s t -> AtomE (Atom s) $ t.at) ss nottyps in
  render_expand env env.show_case (El.Print.string_of_atom atom $ at) exps
    (fun () ->
      let s1 = render_atom env atom in
      let s2 = render_nottyps "~" env nottyps in
      if s1 <> "" && s2 <> "" then s1 ^ "~" ^ s2 else s1 ^ s2
    )


(* Expressions *)

and unparen_exp exp =
  match exp.it with
  | ParenE exp1 -> exp1
  | _ -> exp

and render_exp env exp =
  match exp.it with
  | VarE id -> render_varid env env.show_var id
  | AtomE atom -> render_expcase env atom [] exp.at
  | BoolE b -> render_id env `Atom (string_of_bool b)
  | NatE n -> string_of_int n
  | TextE t -> "``" ^ t ^ "''"
  | UnE (unop, exp2) -> render_unop unop ^ render_exp env exp2
  | BinE (exp1, ExpOp, ({it = ParenE exp2; _ } | exp2)) ->
    render_exp env exp1 ^ "^{" ^ render_exp env exp2 ^ "}"
  | BinE (exp1, binop, exp2) ->
    render_exp env exp1 ^ space render_binop binop ^ render_exp env exp2
  | CmpE (exp1, cmpop, exp2) ->
    render_exp env exp1 ^ space render_cmpop cmpop ^ render_exp env exp2
  | EpsE -> "\\epsilon"
  | SeqE ({it = AtomE atom; at}::exps) -> render_expcase env atom exps at
  | SeqE exps -> render_exps "~" env exps
  | IdxE (exp1, exp2) -> render_exp env exp1 ^ "[" ^ render_exp env exp2 ^ "]"
  | SliceE (exp1, exp2, exp3) ->
    render_exp env exp1 ^
      "[" ^ render_exp env exp2 ^ " : " ^ render_exp env exp3 ^ "]"
  | UpdE (exp1, path, exp2) ->
    render_exp env exp1 ^
      "[" ^ render_path env path ^ " = " ^ render_exp env exp2 ^ "]"
  | ExtE (exp1, path, exp2) ->
    render_exp env exp1 ^
      "[" ^ render_path env path ^ " = .." ^ render_exp env exp2 ^ "]"
  | StrE expfields ->
    "\\{ " ^
    "\\begin{array}[t]{@{}l@{}}\n" ^
    concat_map_nl ",\\; " "\\\\\n  " (render_expfield env) expfields ^ " \\}" ^
    "\\end{array}"
  | DotE (exp1, atom) ->
    render_exp env exp1 ^ "." ^ render_fieldname env atom exp.at
  | CommaE (exp1, exp2) -> render_exp env exp1 ^ ", " ^ render_exp env exp2
  | CompE (exp1, exp2) -> render_exp env exp1 ^ " \\oplus " ^ render_exp env exp2
  | LenE exp1 -> "|" ^ render_exp env exp1 ^ "|"
  | ParenE exp -> "(" ^ render_exp env exp ^ ")"
  | TupE exps -> "(" ^ render_exps ",\\, " env exps ^ ")"
  | InfixE ({it = SeqE []; _}, atom, exp2) ->
    "{" ^ space (render_atom env) atom ^ "}\\;" ^ render_exp env exp2
  | InfixE (exp1, atom, exp2) ->
    render_exp env exp1 ^ space (render_atom env) atom ^ render_exp env exp2
  | BrackE (brack, exp) ->
    let l, r = render_brack brack in l ^ render_exp env exp ^ r
  | CallE (id, exp) ->
    render_expand env env.show_def id [unparen_exp exp]
      (fun () -> render_id env `Func id.it ^ render_exp env exp)
  | IterE (exp1, iter) -> render_exp env exp1 ^ render_iter env iter
  | FuseE (exp1, exp2) ->
    (* HACK. Is there a cleaner way? *)
    let exp1', subscript =
      match exp1.it with
      | VarE {it = id; at} when id.[String.length id - 1] = '_' ->
        VarE (String.sub id 0 (String.length id - 1) $ at) $ exp1.at, true
      | AtomE (Atom id) when id.[String.length id - 1] = '_' ->
        AtomE (Atom (String.sub id 0 (String.length id - 1))) $ exp1.at, true
      | _ -> exp1, false
    in
    "{" ^ render_exp env exp1' ^ "}" ^ (if subscript then "_" else "") ^
      "{" ^ render_exp env exp2 ^ "}"
  | HoleE _ -> assert false

and render_exps sep env exps =
  concat sep (List.filter ((<>) "") (List.map (render_exp env) exps))

and render_expfield env (atom, exp) =
  render_fieldname env atom exp.at ^ "~" ^ render_exp env exp

and render_path env path =
  match path.it with
  | RootP -> ""
  | IdxP (path1, exp) -> render_path env path1 ^ "[" ^ render_exp env exp ^ "]"
  | DotP ({it = RootP; _}, atom) -> render_fieldname env atom path.at
  | DotP (path1, atom) ->
    render_path env path1 ^ "." ^ render_fieldname env atom path.at

and render_fieldname env atom at =
  render_expand env env.show_field (El.Print.string_of_atom atom $ at) []
    (fun () -> render_atom env atom)

and render_expcase env atom exps at =
  render_expand env env.show_case (El.Print.string_of_atom atom $ at) exps
    (fun () ->
      let s1 = render_atom env atom in
      let s2 = render_exps "~" env exps in
      assert (s1 <> "" || s2 <> "");
      if s1 <> "" && s2 <> "" then s1 ^ "~" ^ s2 else s1 ^ s2
    )


let () = render_expand_fwd := render_expand


(* Definitions *)

let word s = "\\mbox{" ^ s ^ "}"

let render_premise env prem =
  match prem.it with
  | RulePr (id, exp, None) ->
    render_exp {env with current_rel = id.it} exp
  | RulePr (id, exp, Some iter) ->
    let env' = {env with current_rel = id.it} in
    "(" ^ render_exp env' exp ^ ")" ^ render_iter env' iter
  | IffPr (exp, None) ->
    render_exp env exp
  | IffPr (exp, Some iter) ->
    "(" ^ render_exp env exp ^ ")" ^ render_iter env iter
  | ElsePr ->
    error prem.at "misplaced `otherwise` premise"


let merge_deftyp deftyp1 deftyp2 =
  match deftyp1.it, deftyp2.it with
  | VariantT (dots1, ids1, cases1, _), VariantT (_, ids2, cases2, dots2) ->
    VariantT( dots1, ids1 @ strip_nl ids2, cases1 @ strip_nl cases2, dots2) $ deftyp1.at
  | _, _ -> assert false

let rec merge_syndefs = function
  | [] -> []
  | {it = SynD (id1, id', deftyp1, _); at}::
    {it = SynD (id2, _, deftyp2, _); _}::defs when id1.it = id2.it ->
    let def' = SynD (id1, id', merge_deftyp deftyp1 deftyp2, []) $ at in
    merge_syndefs (def'::defs)
  | def::defs ->
    def :: merge_syndefs defs

let render_syndef env def =
  match def.it with
  | SynD (id1, _id2, deftyp, _hints) ->
    (* TODO: include grammar descriptions *)
    "& " ^ render_varid env env.show_syn id1 ^ " &::=& " ^
      render_deftyp env deftyp
  | _ -> assert false

let split_redexp exp =
  match exp.it with
  | InfixE (exp1, SqArrow, exp2) -> exp1, exp2
  | _ -> error exp.at "unrecognized format for reduction rule"

let render_reddef env def =
  match def.it with
  | RuleD (_id1, _id2, exp, prems) ->
    let exp1, exp2 = split_redexp exp in
    render_exp env exp1 ^ " &" ^ render_atom env SqArrow ^ "& " ^
    render_exp env exp2 ^
    (match prems with
    | [] -> ""
    | [Elem {it = ElsePr; _}] -> " &\n  " ^ word "otherwise"
    | _ ->
      " &\n  " ^ word "if" ^ "~" ^
      concat_map_nl "\\\\\n &&& {\\land}~" "" (render_premise env) prems
    )
  | _ -> failwith "render_reddef"


let rec classify_rel exp : rel_sort option =
  match exp.it with
  | InfixE (_, Turnstile, _) -> Some TypingRel
  | InfixE (_, SqArrow, _) -> Some ReductionRel
  | InfixE (exp1, _, exp2) ->
    (match classify_rel exp1 with
    | None -> classify_rel exp2
    | some -> some
    )
  | _ -> None


let rec render_defs env = function
  | [] -> ""
  | def::defs' as defs ->
    match def.it with
    | SynD _ ->
      let syndefs = merge_syndefs defs in
      "\\begin{array}{@{}l@{}rrl@{}}\n" ^
        concat " \\\\[0.5ex]\n" (List.map (render_syndef env) syndefs) ^
          " \\\\\n" ^
      "\\end{array}"

    | RelD (id, nottyp, _hints) ->
      "\\boxed{" ^
        render_nottyp {env with current_rel = id.it} nottyp ^
      "}" ^
      (if defs' = [] then "" else " \\; " ^ render_defs env defs')

    | RuleD (id1, _id2, exp, prems) ->
      (* TODO: include rule name *)
      (match classify_rel exp with
      | Some TypingRel ->
        "\\frac{\n" ^
          (if has_nl prems then "\\begin{array}{@{}c@{}}\n" else "") ^
          altern_map_nl " \\qquad\n" " \\\\\n" (suffix "\n" (render_premise env)) prems ^
          (if has_nl prems then "\\end{array}\n" else "") ^
        "}{\n" ^
          render_exp {env with current_rel = id1.it} exp ^ "\n" ^
        "}" ^
        (if defs' = [] then "" else "\n\\qquad\n" ^ render_defs env defs')
      | Some ReductionRel ->
        "\\begin{array}{@{}lcll@{}}\n" ^
          concat "\\\\\n" (List.map (render_reddef env) defs) ^ "\\\\\n" ^
        "\\end{array}"
      | None -> error def.at "unrecognized form of relation"
      )

    | VarD _ ->
      render_defs env defs

    | DecD _ ->
      (* TODO: definitions *)
      render_defs env defs

    | DefD _ ->
      (* TODO: definitions *)
      render_defs env defs

    | SepD ->
      render_defs env defs

let render_def env def = render_defs env [def]


(* Scripts *)

let rec split_syndefs syndefs = function
  | [] -> List.rev syndefs, []
  | def::defs ->
    match def.it with
    | SynD _ -> split_syndefs (def::syndefs) defs
    | _ -> List.rev syndefs, def::defs

let rec split_reddefs id reddefs = function
  | [] -> List.rev reddefs, []
  | def::defs ->
    match def.it with
    | RuleD (id1, _, _, _) when id1.it = id -> split_reddefs id (def::reddefs) defs
    | _ -> List.rev reddefs, def::defs

let rec render_script env = function
  | [] -> ""
  | def::defs ->
    match def.it with
    | SynD _ ->
      let syndefs, defs' = split_syndefs [def] defs in
      "$$\n" ^ render_defs env syndefs ^ "\n$$\n\n" ^
      render_script env defs'
    | RelD _ ->
      "$" ^ render_def env def ^ "$\n\n" ^
      render_script env defs
    | RuleD (id1, _, exp, _) ->
      (match classify_rel exp with
      | Some TypingRel ->
        "$$\n" ^ render_def env def ^ "\n$$\n\n" ^
        render_script env defs
      | Some ReductionRel ->
        let reddefs, defs' = split_reddefs id1.it [def] defs in
        "$$\n" ^ render_defs env reddefs ^ "\n$$\n\n" ^
        render_script env defs'
      | None -> error def.at "unrecognized form of relation"
      )
    | VarD _ ->
      render_script env defs
    | DecD _ ->
      (* TODO: definitions *)
      render_script env defs
    | DefD _ ->
      (* TODO: definitions *)
      render_script env defs
    | SepD ->
      "\\vspace{1ex}\n\n" ^
      render_script env defs
