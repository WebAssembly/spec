open Util
open Source
open El.Ast
open Config


(* Errors *)

let error at msg = Source.error at "latex generation" msg


(* Environment *)

module Set = Set.Make(String)
module Map = Map.Make(String)

type rel_sort = TypingRel | ReductionRel

type env =
  { config : config;
    vars : Set.t ref;
    show_syn : exp Map.t ref;
    show_var : exp Map.t ref;
    show_rel : exp Map.t ref;
    show_def : exp Map.t ref;
    show_case : exp Map.t ref;
    show_field : exp Map.t ref;
    deco_syn : bool;
    deco_rule : bool;
    current_rel : string;
  }

let new_env config =
  { config;
    vars = ref Set.empty;
    show_syn = ref Map.empty;
    show_var = ref Map.empty;
    show_rel = ref Map.empty;
    show_def = ref Map.empty;
    show_case = ref Map.empty;
    show_field = ref Map.empty;
    deco_syn = false;
    deco_rule = false;
    current_rel = "";
  }

let with_syntax_decoration b env = {env with deco_syn = b}
let with_rule_decoration b env = {env with deco_rule = b}


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
    env.vars := Set.add id.it !(env.vars);
    env_hints env.show_syn id.it hints;
    env_hints env.show_var id.it hints;
    env_deftyp env deftyp
  | RelD (id, _, hints) ->
    env_hints env.show_rel id.it hints
  | VarD (id, _, hints) ->
    env.vars := Set.add id.it !(env.vars);
    env_hints env.show_var id.it hints
  | DecD (id, _, _, hints) ->
    env_hints env.show_def id.it hints
  | RuleD _ | DefD _ | SepD -> ()

let env config script : env =
  let env = new_env config in
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
let is_upper c = 'A' <= c && c <= 'Z'
let lower = String.lowercase_ascii

let ends_sub id = id <> "" && id.[String.length id - 1] = '_'
let chop_sub id = String.sub id 0 (String.length id - 1)

let dash_id = Str.(global_replace (regexp "-") "{-}")
let quote_id = Str.(global_replace (regexp "_") "\\_")
let shrink_id = Str.(global_replace (regexp "[0-9]+") "{\\\\scriptstyle\\0}")

let id_style = function
  | `Var -> "\\mathit"
  | `Func -> "\\mathrm"
  | `Atom -> "\\mathsf"
  | `Token -> "\\mathtt"

let render_id' env style id =
  if env.config.macros_for_ids then
    "\\" ^ id
  else
    id_style style ^ "{" ^ shrink_id id ^ "}"

let rec render_id_sub env style show at = function
  | [] -> ""
  | ""::ss -> render_id_sub env style show at ss
  | s::ss when style = `Var && is_upper s.[0] && not (Set.mem s !(env.vars)) ->
    render_id_sub env `Atom show at (lower s ::ss)  (* subscripts may be atoms *)
  | s1::""::ss -> render_id_sub env style show at (s1::ss)
  | s1::s2::ss when style = `Atom && is_upper s2.[0] ->
    render_id_sub env `Atom show at ((s1 ^ "_" ^ lower s2)::ss)
  | s::ss ->
    let rec find_primes i =
      if i > 0 && s.[i - 1] = '\'' then find_primes (i - 1) else i
    in
    let n = String.length s in
    let i = find_primes n in
    let s' = String.sub s 0 i in
    let s'' =
      if String.for_all is_digit s' then s' else
      !render_expand_fwd env show (s' $ at) [] (fun () -> render_id' env style s')
    in
    (if i = n then s'' else "{" ^ s'' ^ String.sub s i (n - i) ^ "}") ^
    (if ss = [] then "" else "_{" ^ render_id_sub env `Var env.show_var at ss ^ "}")

let render_id env style show id =
  render_id_sub env style show id.at (String.split_on_char '_' id.it)

let render_synid env id = render_id env `Var env.show_syn id
let render_varid env id = render_id env `Var env.show_var id
let render_defid env id = render_id env `Func (ref Map.empty) id

let render_atomid env id =
  render_id' env `Atom (lower (quote_id id))

let render_ruleid env id1 id2 =
  let id1' =
    match Map.find_opt id1.it !(env.show_rel) with
    | None -> id1.it
    | Some {it = TextE s; _} -> s
    | Some {at; _} ->
      error at "malformed `show` hint for relation"
  in
  let id2' = if id2.it = "" then "" else "-" ^ id2.it in
  "\\textsc{\\scriptsize " ^ dash_id (quote_id (id1' ^ id2')) ^ "}"

let render_rule_deco env pre id1 id2 post =
  if not env.deco_rule then "" else
  pre ^ "{[" ^ render_ruleid env id1 id2 ^ "]}" ^ post


(* Operators *)

let render_atom env = function
  | Atom id when id.[0] = '_' && id <> "_" -> ""
  | Atom id -> render_atomid env id
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
  | ImplOp -> "\\Rightarrow"
  | EquivOp -> "\\Leftrightarrow"
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
  | ParenE (exp, b) -> ParenE (expand_exp args exp, b)
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
      (* Avoid cyclic expansion *)
      show := Map.remove id.it !show;
      Fun.protect (fun () -> render_exp env exp)
        ~finally:(fun () -> show := Map.add id.it showexp !show)
    with Arity_mismatch -> f ()
      (* HACK: Ignore arity mismatches, such that overloading notation works,
       * e.g., using CONST for both instruction and relation. *)


(* Iteration *)

and render_iter env = function
  | Opt -> "^?"
  | List -> "^\\ast"
  | List1 -> "^{+}"
  | ListN {it = ParenE (exp, _); _} | ListN exp ->
    "^{" ^ render_exp env exp ^ "}"


(* Types *)

and render_typ env typ =
  match typ.it with
  | VarT id -> render_synid env id
  | BoolT -> render_synid env ("bool" $ typ.at)
  | NatT -> render_synid env ("nat" $ typ.at)
  | TextT -> render_synid env ("text" $ typ.at)
  | ParenT typ -> "(" ^ render_typ env typ ^ ")"
  | TupT typs -> "(" ^ render_typs ",\\; " env typs ^ ")"
  | IterT (typ1, iter) -> "{" ^ render_typ env typ1 ^ render_iter env iter ^ "}"

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
      (render_dots dots1 @ map_nl_list (render_synid env) ids @
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
  | IterNT (nottyp1, iter) ->
    "{" ^ render_nottyp env nottyp1 ^ render_iter env iter ^ "}"

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
      match atom, nottyps with
      | Atom id, nottyp1::nottyps2 when ends_sub id ->
        (* Handle subscripting *)
        "{" ^ render_atomid env (chop_sub id) ^
          "}_{" ^ render_nottyp env nottyp1 ^ "}\\," ^
          (if nottyps2 = [] then "" else "\\," ^ render_nottyps "~" env nottyps2)
      | _ ->
        let s1 = render_atom env atom in
        let s2 = render_nottyps "~" env nottyps in
        assert (s1 <> "" || s2 <> "");
        if s1 <> "" && s2 <> "" then s1 ^ "~" ^ s2 else s1 ^ s2
    )


(* Expressions *)

and untup_exp exp =
  match exp.it with
  | TupE exps -> exps
  | ParenE (exp1, _) -> [exp1]
  | _ -> [exp]

and render_exp env exp =
  match exp.it with
  | VarE id -> render_varid env id
  | AtomE atom -> render_expcase env atom [] exp.at
  | BoolE b -> render_atom env (Atom (string_of_bool b))
  | NatE n -> string_of_int n
  | TextE t -> "``" ^ t ^ "''"
  | UnE (unop, exp2) -> render_unop unop ^ render_exp env exp2
  | BinE (exp1, ExpOp, ({it = ParenE (exp2, _); _ } | exp2)) ->
    "{" ^ render_exp env exp1 ^ "^{" ^ render_exp env exp2 ^ "}}"
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
  | LenE exp1 -> "{|" ^ render_exp env exp1 ^ "|}"
  | ParenE (exp, _) -> "(" ^ render_exp env exp ^ ")"
  | TupE exps -> "(" ^ render_exps ",\\, " env exps ^ ")"
  | InfixE ({it = SeqE []; _}, atom, exp2) ->
    "{" ^ space (render_atom env) atom ^ "}\\;" ^ render_exp env exp2
  | InfixE (exp1, atom, exp2) ->
    render_exp env exp1 ^ space (render_atom env) atom ^ render_exp env exp2
  | BrackE (brack, exp) ->
    let l, r = render_brack brack in l ^ render_exp env exp ^ r
  | CallE (id, exp1) ->
    render_expand env env.show_def id (untup_exp exp1)
      (fun () ->
        if not (ends_sub id.it) then
          render_defid env id ^ render_exp env exp1
        else
          (* Handle subscripting *)
          "{" ^ render_defid env (chop_sub id.it $ id.at) ^
          let exp1', exp2' =
            match untup_exp exp1 with
            | [] -> SeqE [] $ exp1.at, SeqE [] $ exp1.at
            | [exp1'] -> exp1', SeqE [] $ exp1.at
            | exp1'::exps -> exp1', TupE exps $ exp1.at
          in
          "}_{" ^ render_exp env exp1' ^ "}" ^ render_exp env exp2'
      )
  | IterE (exp1, iter) -> "{" ^ render_exp env exp1 ^ render_iter env iter ^ "}"
  | FuseE (exp1, exp2) ->
    "{" ^ render_exp env exp1 ^ "}" ^ "{" ^ render_exp env exp2 ^ "}"
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
      match atom, exps with
      | Atom id, exp1::exps2 when ends_sub id ->
        (* Handle subscripting *)
        "{" ^ render_atomid env (chop_sub id) ^ "}_{" ^ render_exp env exp1 ^ "}" ^
          (if exps2 = [] then "" else "\\," ^ render_exps "~" env exps2)
      | _ ->
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
  | IfPr (exp, None) ->
    render_exp env exp
  | IfPr (exp, Some iter) ->
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

let desc_of_hint = function
  | {hintid = {it = "desc"; _}; hintexp = {it = TextE s; _}} -> Some s
  | {hintid = {it = "desc"; _}; hintexp = {at; _}} ->
    error at "malformed description hint"
  | _ -> None

let render_syndef env def =
  match def.it with
  | SynD (id1, _id2, deftyp, hints) ->
    (match env.deco_syn, List.find_map desc_of_hint hints with
    | true, Some s -> "\\mbox{(" ^ s ^ ")} & "
    | _ -> "& "
    ) ^
    render_synid env id1 ^ " &::=& " ^ render_deftyp env deftyp
  | _ -> assert false

let render_ruledef env def =
  match def.it with
  | RuleD (id1, id2, exp, prems) ->
    "\\frac{\n" ^
      (if has_nl prems then "\\begin{array}{@{}c@{}}\n" else "") ^
      altern_map_nl " \\qquad\n" " \\\\\n" (suffix "\n" (render_premise env)) prems ^
      (if has_nl prems then "\\end{array}\n" else "") ^
    "}{\n" ^
      render_exp {env with current_rel = id1.it} exp ^ "\n" ^
    "}" ^
    render_rule_deco env " \\, " id1 id2 ""
  | _ -> failwith "render_ruledef"

let render_conditions env = function
  | [] -> " & "
  | [Elem {it = ElsePr; _}] -> " &\\quad\n  " ^ word "otherwise"
  | prems ->
    " &\\quad\n  " ^ word "if" ^ "~" ^
    concat_map_nl " \\\\\n &&&\\quad {\\land}~" "" (render_premise env) prems

let render_reddef env def =
  match def.it with
  | RuleD (id1, id2, exp, prems) ->
    let exp1, exp2 =
      match exp.it with
      | InfixE (exp1, SqArrow, exp2) -> exp1, exp2
      | _ -> error exp.at "unrecognized format for reduction rule"
    in
    render_rule_deco env "" id1 id2 " \\quad " ^ "& " ^
      render_exp env exp1 ^ " &" ^ render_atom env SqArrow ^ "& " ^
        render_exp env exp2 ^ render_conditions env prems
  | _ -> failwith "render_reddef"

let render_funcdef env def =
  match def.it with
  | DefD (id1, exp1, exp2, prems) ->
    render_exp env (CallE (id1, exp1) $ def.at) ^ " &=& " ^
      render_exp env exp2 ^ render_conditions env prems
  | _ -> failwith "render_funcdef"

let rec render_sep_defs ?(sep = " \\\\\n") ?(br = " \\\\[0.8ex]\n") f = function
  | [] -> ""
  | {it = SepD; _}::defs -> "{} \\\\[-2ex]\n" ^ render_sep_defs ~sep ~br f defs
  | def::{it = SepD; _}::defs -> f def ^ br ^ render_sep_defs ~sep ~br f defs
  | def::defs -> f def ^ sep ^ render_sep_defs ~sep ~br f defs


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
      let defs' = merge_syndefs defs in
      let deco = if env.deco_syn then "l" else "l@{}" in
      "\\begin{array}{@{}" ^ deco ^ "rrl@{}}\n" ^
        render_sep_defs (render_syndef env) defs' ^
      "\\end{array}"
    | RelD (id, nottyp, _hints) ->
      "\\boxed{" ^
        render_nottyp {env with current_rel = id.it} nottyp ^
      "}" ^
      (if defs' = [] then "" else " \\; " ^ render_defs env defs')
    | RuleD (_, _, exp, _) ->
      (match classify_rel exp with
      | Some TypingRel ->
        "\\begin{array}{@{}c@{}}\\displaystyle\n" ^
          render_sep_defs ~sep:"\n\\qquad\n" ~br:"\n\\\\[3ex]\\displaystyle\n"
            (render_ruledef env) defs ^
        "\\end{array}"
      | Some ReductionRel ->
        "\\begin{array}{@{}l@{}lcl@{}l@{}}\n" ^
          render_sep_defs (render_reddef env) defs ^
        "\\end{array}"
      | None -> error def.at "unrecognized form of relation"
      )
    | DefD _ ->
      "\\begin{array}{@{}lcl@{}l@{}}\n" ^
        render_sep_defs (render_funcdef env) defs ^
      "\\end{array}"
    | SepD ->
      " \\\\\n" ^
      render_defs env defs'
    | VarD _ | DecD _ ->
      failwith "render_defs"

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
    | RuleD (id1, _, _, _) when id1.it = id ->
      split_reddefs id (def::reddefs) defs
    | _ -> List.rev reddefs, def::defs

let rec split_funcdefs id funcdefs = function
  | [] -> List.rev funcdefs, []
  | def::defs ->
    match def.it with
    | DefD (id1, _, _, _) when id1.it = id ->
      split_funcdefs id (def::funcdefs) defs
    | _ -> List.rev funcdefs, def::defs

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
      render_script env defs
    | DefD (id, _, _, _) ->
      let funcdefs, defs' = split_funcdefs id.it [def] defs in
      "$$\n" ^ render_defs env funcdefs ^ "\n$$\n\n" ^
      render_script env defs'
    | SepD ->
      "\\vspace{1ex}\n\n" ^
      render_script env defs
