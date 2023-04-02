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

let env_typ env t =
  match t.it with
  | StrT tfs -> List.iter (env_typfield env) tfs
  | CaseT (_, _, tcases, _) -> List.iter (env_typcase env) tcases
  | _ -> ()  (* TODO: this assumes that types structs & variants aren't nested *)

let env_def env d =
  match d.it with
  | SynD (id, _, t, hints) ->
    env.vars := Set.add id.it !(env.vars);
    env_hints env.show_syn id.it hints;
    env_hints env.show_var id.it hints;
    env_typ env t
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
  | ListN e -> ListN (expand_exp args e)

and expand_exp args e = expand_exp' args e.it $ e.at
and expand_exp' args e' =
  match e' with
  | VarE _ | AtomE _ | BoolE _ | NatE _ | TextE _ | EpsE -> e'
  | UnE (op, e) -> UnE (op, expand_exp args e)
  | BinE (e1, op, e2) ->
    let e1' = expand_exp args e1 in
    let e2' = expand_exp args e2 in
    BinE (e1', op, e2')
  | CmpE (e1, op, e2) ->
    let e1' = expand_exp args e1 in
    let e2' = expand_exp args e2 in
    CmpE (e1', op, e2')
  | SeqE es -> SeqE (List.map (expand_exp args) es)
  | IdxE (e1, e2) ->
    let e1' = expand_exp args e1 in
    let e2' = expand_exp args e2 in
    IdxE (e1', e2')
  | SliceE (e1, e2, e3) ->
    let e1' = expand_exp args e1 in
    let e2' = expand_exp args e2 in
    let e3' = expand_exp args e3 in
    SliceE (e1', e2', e3')
  | UpdE (e1, p, e2) ->
    let e1' = expand_exp args e1 in
    let p' = expand_path args p in
    let e2' = expand_exp args e2 in
    UpdE (e1', p', e2')
  | ExtE (e1, p, e2) ->
    let e1' = expand_exp args e1 in
    let p' = expand_path args p in
    let e2' = expand_exp args e2 in
    ExtE (e1', p', e2')
  | StrE efs -> StrE (map_nl_list (expand_expfield args) efs)
  | DotE (e, atom) -> DotE (expand_exp args e, atom)
  | CommaE (e1, e2) ->
    let e1' = expand_exp args e1 in
    let e2' = expand_exp args e2 in
    CommaE (e1', e2')
  | CompE (e1, e2) ->
    let e1' = expand_exp args e1 in
    let e2' = expand_exp args e2 in
    CompE (e1', e2')
  | LenE e -> LenE (expand_exp args e)
  | ParenE (e, b) -> ParenE (expand_exp args e, b)
  | TupE es -> TupE (List.map (expand_exp args) es)
  | InfixE (e1, atom, e2) ->
    let e1' = expand_exp args e1 in
    let e2' = expand_exp args e2 in
    InfixE (e1', atom, e2')
  | BrackE (brack, e) -> BrackE (brack, expand_exp args e)
  | CallE (id, e) -> CallE (id, expand_exp args e)
  | IterE (e1, iter) ->
    let e1' = expand_exp args e1 in
    let iter' = expand_iter args iter in
    IterE (e1', iter')
  | HoleE false ->
    (match !args with
    | [] -> raise Arity_mismatch
    | arg::args' -> args := args'; arg.it
    )
  | HoleE true -> let es = !args in args := []; SeqE es
  | FuseE (e1, e2) ->
    let e1' = expand_exp args e1 in
    let e2' = expand_exp args e2 in
    FuseE (e1', e2')

and expand_expfield args (atom, e) = (atom, expand_exp args e)

and expand_path args p = expand_path' args p.it $ p.at
and expand_path' args p' =
  match p' with
  | RootP -> RootP
  | IdxP (p1, e2) ->
    let p1' = expand_path args p1 in
    let e2' = expand_exp args e2 in
    IdxP (p1', e2')
  | DotP (p1, atom) -> DotP (expand_path args p1, atom)


and render_expand env show id args f =
  match Map.find_opt id.it !show with
  | None -> f ()
  | Some showexp ->
    try
      let rargs = ref args in
      let e = expand_exp rargs showexp in
      if !rargs <> [] then raise Arity_mismatch;
      (* Avoid cyclic expansion *)
      show := Map.remove id.it !show;
      Fun.protect (fun () -> render_exp env e)
        ~finally:(fun () -> show := Map.add id.it showexp !show)
    with Arity_mismatch -> f ()
      (* HACK: Ignore arity mismatches, such that overloading notation works,
       * e.g., using CONST for both instruction and relation. *)


(* Iteration *)

and render_iter env = function
  | Opt -> "^?"
  | List -> "^\\ast"
  | List1 -> "^{+}"
  | ListN {it = ParenE (e, _); _} | ListN e -> "^{" ^ render_exp env e ^ "}"


(* Types *)

and render_typ env t =
  match t.it with
  | VarT id -> render_synid env id
  | BoolT -> render_synid env ("bool" $ t.at)
  | NatT -> render_synid env ("nat" $ t.at)
  | TextT -> render_synid env ("text" $ t.at)
  | ParenT t -> "(" ^ render_typ env t ^ ")"
  | TupT ts -> "(" ^ render_typs ",\\; " env ts ^ ")"
  | IterT (t1, iter) -> "{" ^ render_typ env t1 ^ render_iter env iter ^ "}"
  | StrT tfs ->
    "\\{\\; " ^
    "\\begin{array}[t]{@{}l@{}}\n" ^
    concat_map_nl ",\\; " "\\\\\n  " (render_typfield env) tfs ^ " \\;\\}" ^
    "\\end{array}"
  | CaseT (dots1, ids, tcases, dots2) ->
    altern_map_nl " ~|~ " " \\\\ &&|&\n" Fun.id
      (render_dots dots1 @ map_nl_list (render_synid env) ids @
        map_nl_list (render_typcase env t.at) tcases @ render_dots dots2)
  | AtomT atom -> render_typcase env t.at (atom, [], [])
  | SeqT [] -> "\\epsilon"
  | SeqT ({it = AtomT atom; at}::ts) -> render_typcase env at (atom, ts, [])
  | SeqT ts -> render_typs "~" env ts
  | InfixT ({it = SeqT []; _}, atom, t2) ->
    "{" ^ space (render_atom env) atom ^ "}\\;" ^ render_typ env t2
  | InfixT (t1, atom, t2) ->
    render_typ env t1 ^ space (render_atom env) atom ^ render_typ env t2
  | BrackT (brack, t1) ->
    let l, r = render_brack brack in l ^ render_typ env t1 ^ r

and render_typs sep env ts =
  concat sep (List.filter ((<>) "") (List.map (render_typ env) ts))


and render_typfield env (atom, t, _hints) =
  render_fieldname env atom t.at  ^ "~" ^ render_typ env t

and render_typcase env at (atom, ts, _hints) =
  let ss = List.map (render_typ env) ts in
  (* Hack: turn rendered types into literal atoms *)
  let es = List.map2 (fun s t -> AtomE (Atom s) $ t.at) ss ts in
  render_expand env env.show_case (El.Print.string_of_atom atom $ at) es
    (fun () ->
      match atom, ts with
      | Atom id, t1::ts2 when ends_sub id ->
        (* Handle subscripting *)
        "{" ^ render_atomid env (chop_sub id) ^
          "}_{" ^ render_typ env t1 ^ "}\\," ^
          (if ts2 = [] then "" else "\\," ^ render_typs "~" env ts2)
      | _ ->
        let s1 = render_atom env atom in
        let s2 = render_typs "~" env ts in
        assert (s1 <> "" || s2 <> "");
        if s1 <> "" && s2 <> "" then s1 ^ "~" ^ s2 else s1 ^ s2
    )


(* Expressions *)

and untup_exp e =
  match e.it with
  | TupE es -> es
  | ParenE (e1, _) -> [e1]
  | _ -> [e]

and render_exp env e =
  match e.it with
  | VarE id -> render_varid env id
  | AtomE atom -> render_expcase env atom [] e.at
  | BoolE b -> render_atom env (Atom (string_of_bool b))
  | NatE n -> string_of_int n
  | TextE t -> "``" ^ t ^ "''"
  | UnE (op, e2) -> render_unop op ^ render_exp env e2
  | BinE (e1, ExpOp, ({it = ParenE (e2, _); _ } | e2)) ->
    "{" ^ render_exp env e1 ^ "^{" ^ render_exp env e2 ^ "}}"
  | BinE (e1, op, e2) ->
    render_exp env e1 ^ space render_binop op ^ render_exp env e2
  | CmpE (e1, op, e2) ->
    render_exp env e1 ^ space render_cmpop op ^ render_exp env e2
  | EpsE -> "\\epsilon"
  | SeqE ({it = AtomE atom; at}::es) -> render_expcase env atom es at
  | SeqE es -> render_exps "~" env es
  | IdxE (e1, e2) -> render_exp env e1 ^ "[" ^ render_exp env e2 ^ "]"
  | SliceE (e1, e2, e3) ->
    render_exp env e1 ^
      "[" ^ render_exp env e2 ^ " : " ^ render_exp env e3 ^ "]"
  | UpdE (e1, p, e2) ->
    render_exp env e1 ^
      "[" ^ render_path env p ^ " = " ^ render_exp env e2 ^ "]"
  | ExtE (e1, p, e2) ->
    render_exp env e1 ^
      "[" ^ render_path env p ^ " = .." ^ render_exp env e2 ^ "]"
  | StrE efs ->
    "\\{ " ^
    "\\begin{array}[t]{@{}l@{}}\n" ^
    concat_map_nl ",\\; " "\\\\\n  " (render_expfield env) efs ^ " \\}" ^
    "\\end{array}"
  | DotE (e1, atom) -> render_exp env e1 ^ "." ^ render_fieldname env atom e.at
  | CommaE (e1, e2) -> render_exp env e1 ^ ", " ^ render_exp env e2
  | CompE (e1, e2) -> render_exp env e1 ^ " \\oplus " ^ render_exp env e2
  | LenE e1 -> "{|" ^ render_exp env e1 ^ "|}"
  | ParenE (e, _) -> "(" ^ render_exp env e ^ ")"
  | TupE es -> "(" ^ render_exps ",\\, " env es ^ ")"
  | InfixE ({it = SeqE []; _}, atom, e2) ->
    "{" ^ space (render_atom env) atom ^ "}\\;" ^ render_exp env e2
  | InfixE (e1, atom, e2) ->
    render_exp env e1 ^ space (render_atom env) atom ^ render_exp env e2
  | BrackE (brack, e) ->
    let l, r = render_brack brack in l ^ render_exp env e ^ r
  | CallE (id, e1) ->
    render_expand env env.show_def id (untup_exp e1)
      (fun () ->
        if not (ends_sub id.it) then
          render_defid env id ^ render_exp env e1
        else
          (* Handle subscripting *)
          "{" ^ render_defid env (chop_sub id.it $ id.at) ^
          let e1', e2' =
            match untup_exp e1 with
            | [] -> SeqE [] $ e1.at, SeqE [] $ e1.at
            | [e1'] -> e1', SeqE [] $ e1.at
            | e1'::es -> e1', TupE es $ e1.at
          in
          "}_{" ^ render_exp env e1' ^ "}" ^ render_exp env e2'
      )
  | IterE (e1, iter) -> "{" ^ render_exp env e1 ^ render_iter env iter ^ "}"
  | FuseE (e1, e2) ->
    "{" ^ render_exp env e1 ^ "}" ^ "{" ^ render_exp env e2 ^ "}"
  | HoleE _ -> assert false

and render_exps sep env es =
  concat sep (List.filter ((<>) "") (List.map (render_exp env) es))

and render_expfield env (atom, e) =
  render_fieldname env atom e.at ^ "~" ^ render_exp env e

and render_path env p =
  match p.it with
  | RootP -> ""
  | IdxP (p1, e) -> render_path env p1 ^ "[" ^ render_exp env e ^ "]"
  | DotP ({it = RootP; _}, atom) -> render_fieldname env atom p.at
  | DotP (p1, atom) ->
    render_path env p1 ^ "." ^ render_fieldname env atom p.at

and render_fieldname env atom at =
  render_expand env env.show_field (El.Print.string_of_atom atom $ at) []
    (fun () -> render_atom env atom)

and render_expcase env atom es at =
  render_expand env env.show_case (El.Print.string_of_atom atom $ at) es
    (fun () ->
      match atom, es with
      | Atom id, e1::es2 when ends_sub id ->
        (* Handle subscripting *)
        "{" ^ render_atomid env (chop_sub id) ^ "}_{" ^ render_exp env e1 ^ "}" ^
          (if es2 = [] then "" else "\\," ^ render_exps "~" env es2)
      | _ ->
        let s1 = render_atom env atom in
        let s2 = render_exps "~" env es in
        assert (s1 <> "" || s2 <> "");
        if s1 <> "" && s2 <> "" then s1 ^ "~" ^ s2 else s1 ^ s2
    )


let () = render_expand_fwd := render_expand


(* Definitions *)

let word s = "\\mbox{" ^ s ^ "}"

let render_premise env prem =
  match prem.it with
  | RulePr (id, e, None) -> render_exp {env with current_rel = id.it} e
  | RulePr (id, e, Some iter) ->
    let env' = {env with current_rel = id.it} in
    "(" ^ render_exp env' e ^ ")" ^ render_iter env' iter
  | IfPr (e, None) -> render_exp env e
  | IfPr (e, Some iter) -> "(" ^ render_exp env e ^ ")" ^ render_iter env iter
  | ElsePr -> error prem.at "misplaced `otherwise` premise"


let merge_typ t1 t2 =
  match t1.it, t2.it with
  | CaseT (dots1, ids1, cases1, _), CaseT (_, ids2, cases2, dots2) ->
    CaseT( dots1, ids1 @ strip_nl ids2, cases1 @ strip_nl cases2, dots2) $ t1.at
  | _, _ -> assert false

let rec merge_syndefs = function
  | [] -> []
  | {it = SynD (id1, id', t1, _); at}::
    {it = SynD (id2, _, t2, _); _}::ds when id1.it = id2.it ->
    let d' = SynD (id1, id', merge_typ t1 t2, []) $ at in
    merge_syndefs (d'::ds)
  | d::ds ->
    d :: merge_syndefs ds

let desc_of_hint = function
  | {hintid = {it = "desc"; _}; hintexp = {it = TextE s; _}} -> Some s
  | {hintid = {it = "desc"; _}; hintexp = {at; _}} ->
    error at "malformed description hint"
  | _ -> None

let render_syndef env d =
  match d.it with
  | SynD (id1, _id2, t, hints) ->
    (match env.deco_syn, List.find_map desc_of_hint hints with
    | true, Some s -> "\\mbox{(" ^ s ^ ")} & "
    | _ -> "& "
    ) ^
    render_synid env id1 ^ " &::=& " ^ render_typ env t
  | _ -> assert false

let render_ruledef env d =
  match d.it with
  | RuleD (id1, id2, e, prems) ->
    "\\frac{\n" ^
      (if has_nl prems then "\\begin{array}{@{}c@{}}\n" else "") ^
      altern_map_nl " \\qquad\n" " \\\\\n" (suffix "\n" (render_premise env)) prems ^
      (if has_nl prems then "\\end{array}\n" else "") ^
    "}{\n" ^
      render_exp {env with current_rel = id1.it} e ^ "\n" ^
    "}" ^
    render_rule_deco env " \\, " id1 id2 ""
  | _ -> failwith "render_ruledef"

let render_conditions env = function
  | [] -> " & "
  | [Elem {it = ElsePr; _}] -> " &\\quad\n  " ^ word "otherwise"
  | prems ->
    " &\\quad\n  " ^ word "if" ^ "~" ^
    concat_map_nl " \\\\\n &&&\\quad {\\land}~" "" (render_premise env) prems

let render_reddef env d =
  match d.it with
  | RuleD (id1, id2, e, prems) ->
    let e1, e2 =
      match e.it with
      | InfixE (e1, SqArrow, e2) -> e1, e2
      | _ -> error e.at "unrecognized format for reduction rule"
    in
    render_rule_deco env "" id1 id2 " \\quad " ^ "& " ^
      render_exp env e1 ^ " &" ^ render_atom env SqArrow ^ "& " ^
        render_exp env e2 ^ render_conditions env prems
  | _ -> failwith "render_reddef"

let render_funcdef env d =
  match d.it with
  | DefD (id1, e1, e2, prems) ->
    render_exp env (CallE (id1, e1) $ d.at) ^ " &=& " ^
      render_exp env e2 ^ render_conditions env prems
  | _ -> failwith "render_funcdef"

let rec render_sep_defs ?(sep = " \\\\\n") ?(br = " \\\\[0.8ex]\n") f = function
  | [] -> ""
  | {it = SepD; _}::ds -> "{} \\\\[-2ex]\n" ^ render_sep_defs ~sep ~br f ds
  | d::{it = SepD; _}::ds -> f d ^ br ^ render_sep_defs ~sep ~br f ds
  | d::ds -> f d ^ sep ^ render_sep_defs ~sep ~br f ds


let rec classify_rel e : rel_sort option =
  match e.it with
  | InfixE (_, Turnstile, _) -> Some TypingRel
  | InfixE (_, SqArrow, _) -> Some ReductionRel
  | InfixE (e1, _, e2) ->
    (match classify_rel e1 with
    | None -> classify_rel e2
    | some -> some
    )
  | _ -> None


let rec render_defs env = function
  | [] -> ""
  | d::ds' as ds ->
    match d.it with
    | SynD _ ->
      let ds' = merge_syndefs ds in
      let deco = if env.deco_syn then "l" else "l@{}" in
      "\\begin{array}{@{}" ^ deco ^ "rrl@{}}\n" ^
        render_sep_defs (render_syndef env) ds' ^
      "\\end{array}"
    | RelD (id, t, _hints) ->
      "\\boxed{" ^
        render_typ {env with current_rel = id.it} t ^
      "}" ^
      (if ds' = [] then "" else " \\; " ^ render_defs env ds')
    | RuleD (_, _, e, _) ->
      (match classify_rel e with
      | Some TypingRel ->
        "\\begin{array}{@{}c@{}}\\displaystyle\n" ^
          render_sep_defs ~sep:"\n\\qquad\n" ~br:"\n\\\\[3ex]\\displaystyle\n"
            (render_ruledef env) ds ^
        "\\end{array}"
      | Some ReductionRel ->
        "\\begin{array}{@{}l@{}lcl@{}l@{}}\n" ^
          render_sep_defs (render_reddef env) ds ^
        "\\end{array}"
      | None -> error d.at "unrecognized form of relation"
      )
    | DefD _ ->
      "\\begin{array}{@{}lcl@{}l@{}}\n" ^
        render_sep_defs (render_funcdef env) ds ^
      "\\end{array}"
    | SepD ->
      " \\\\\n" ^
      render_defs env ds'
    | VarD _ | DecD _ ->
      failwith "render_defs"

let render_def env d = render_defs env [d]


(* Scripts *)

let rec split_syndefs syndefs = function
  | [] -> List.rev syndefs, []
  | d::ds ->
    match d.it with
    | SynD _ -> split_syndefs (d::syndefs) ds
    | _ -> List.rev syndefs, d::ds

let rec split_reddefs id reddefs = function
  | [] -> List.rev reddefs, []
  | d::ds ->
    match d.it with
    | RuleD (id1, _, _, _) when id1.it = id ->
      split_reddefs id (d::reddefs) ds
    | _ -> List.rev reddefs, d::ds

let rec split_funcdefs id funcdefs = function
  | [] -> List.rev funcdefs, []
  | d::ds ->
    match d.it with
    | DefD (id1, _, _, _) when id1.it = id -> split_funcdefs id (d::funcdefs) ds
    | _ -> List.rev funcdefs, d::ds

let rec render_script env = function
  | [] -> ""
  | d::ds ->
    match d.it with
    | SynD _ ->
      let syndefs, ds' = split_syndefs [d] ds in
      "$$\n" ^ render_defs env syndefs ^ "\n$$\n\n" ^
      render_script env ds'
    | RelD _ ->
      "$" ^ render_def env d ^ "$\n\n" ^
      render_script env ds
    | RuleD (id1, _, e, _) ->
      (match classify_rel e with
      | Some TypingRel ->
        "$$\n" ^ render_def env d ^ "\n$$\n\n" ^
        render_script env ds
      | Some ReductionRel ->
        let reddefs, ds' = split_reddefs id1.it [d] ds in
        "$$\n" ^ render_defs env reddefs ^ "\n$$\n\n" ^
        render_script env ds'
      | None -> error d.at "unrecognized form of relation"
      )
    | VarD _ ->
      render_script env ds
    | DecD _ ->
      render_script env ds
    | DefD (id, _, _, _) ->
      let funcdefs, ds' = split_funcdefs id.it [d] ds in
      "$$\n" ^ render_defs env funcdefs ^ "\n$$\n\n" ^
      render_script env ds'
    | SepD ->
      "\\vspace{1ex}\n\n" ^
      render_script env ds
