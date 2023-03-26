open Util
open Source
open El.Ast
open Config


(* Errors *)

let error at msg = Source.error at "latex generation" msg


(* Environment *)

type rel_sort = TypingRel | ReductionRel

type env = {config : config; current_rel : string}

let env config = {config; current_rel = ""}


(* Helpers *)

let concat = String.concat
let suffix s f x = f x ^ s
let space f x = " " ^ f x ^ " "

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


(* Identifiers *)

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


let is_digit c = '0' <= c && c <= '9'

let rec render_varid env id =
  render_varid_sub env (String.split_on_char '_' id.it)

and render_varid_sub env = function
  | [] -> ""
  | s::ss ->
    let rec find_primes i =
      if i > 0 && s.[i - 1] = '\'' then find_primes (i - 1) else i
    in
    let n = String.length s in
    let i = find_primes n in
    let s' = String.sub s 0 i in
    let s'' = if String.for_all is_digit s' then s' else render_id env `Var s' in
    (if i = n then s'' else "{" ^ s'' ^ String.sub s i (n - i) ^ "}") ^
    (if ss = [] then "" else "_{" ^ render_varid_sub env ss ^ "}")


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


(* Iteration *)

let rec render_iter env = function
  | Opt -> "^?"
  | List -> "^\\ast"
  | List1 -> "^{+}"
  | ListN {it = ParenE exp; _} | ListN exp -> "^{" ^ render_exp env exp ^ "}"


(* Types *)

and render_typ env typ =
  match typ.it with
  | VarT id -> render_varid env id
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
  | VariantT (ids, typcases) ->
    altern_map_nl " ~|~ " " \\\\ &&|&\n" Fun.id
      (map_nl_list it ids @ map_nl_list (render_typcase env) typcases)

and render_nottyp env nottyp =
  match nottyp.it with
  | TypT typ -> render_typ env typ
  | AtomT atom -> render_atom env atom
  | SeqT [] -> "\\epsilon"
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
  render_atom env atom ^ "~" ^ render_typ env typ

and render_typcase env (atom, nottyps, _hints) =
  if nottyps = [] then
    render_atom env atom
  else
    let s = render_atom env atom in
    (if s = "" then "" else s ^ "~") ^ render_nottyps "~" env nottyps


(* Expressions *)

and render_exp env exp =
  match exp.it with
  | VarE id -> render_varid env id
  | AtomE atom -> render_atom env atom
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
  | DotE (exp1, atom) -> render_exp env exp1 ^ "." ^ render_atom env atom
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
  | CallE (id, {it = SeqE []; _}) -> render_id env `Func id.it
  | CallE (id, exp) -> render_id env `Func id.it ^ render_exp env exp
  | IterE (exp1, iter) -> render_exp env exp1 ^ render_iter env iter
  | HoleE | FuseE _ -> assert false

and render_exps sep env exps =
  concat sep (List.filter ((<>) "") (List.map (render_exp env) exps))

and render_expfield env (atom, exp) =
  render_atom env atom ^ "~" ^ render_exp env exp

and render_path env path =
  match path.it with
  | RootP -> ""
  | IdxP (path1, exp) -> render_path env path1 ^ "[" ^ render_exp env exp ^ "]"
  | DotP ({it = RootP; _}, atom) -> render_atom env atom
  | DotP (path1, atom) -> render_path env path1 ^ "." ^ render_atom env atom


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


let render_syndef env def =
  match def.it with
  | SynD (id, deftyp, _hints) ->
    (* TODO: include grammar descriptions *)
    "& " ^ render_varid env id ^ " &::=& " ^ render_deftyp env deftyp
  | _ -> failwith "render_syndef"

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
    | [{it = ElsePr; _}] -> " &\n  " ^ word "otherwise"
    | _ ->
      " &\n  " ^ word "if" ^ "~" ^
      concat "\\\\\n &&& {\\land}~" (List.map (render_premise env) prems)
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
      "\\begin{array}{@{}l@{}rrl@{}}\n" ^
        concat "\\\\\n[0.5ex]\n" (List.map (render_syndef env) defs) ^ "\\\\\n" ^
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
          concat "\\qquad\n" (List.map (suffix "\n" (render_premise env)) prems) ^
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

let rec render_script_defs env = function
  | [] -> ""
  | def::defs ->
    match def.it with
    | SynD _ ->
      let syndefs, defs' = split_syndefs [def] defs in
      "$$\n" ^ render_defs env syndefs ^ "\n$$\n\n" ^
      render_script_defs env defs'

    | RelD _ ->
      "$" ^ render_def env def ^ "$\n\n" ^
      render_script_defs env defs

    | RuleD (id1, _, exp, _) ->
      (match classify_rel exp with
      | Some TypingRel ->
        "$$\n" ^ render_def env def ^ "\n$$\n\n" ^
        render_script_defs env defs
      | Some ReductionRel ->
        let reddefs, defs' = split_reddefs id1.it [def] defs in
        "$$\n" ^ render_defs env reddefs ^ "\n$$\n\n" ^
        render_script_defs env defs'
      | None -> error def.at "unrecognized form of relation"
      )

    | VarD _ ->
      render_script_defs env defs

    | DecD _ ->
      (* TODO: definitions *)
      render_script_defs env defs

    | DefD _ ->
      (* TODO: definitions *)
      render_script_defs env defs

    | SepD ->
      "\\vspace{1ex}\n\n" ^
      render_script_defs env defs


(* Entry points *)

let render_atom config atom = render_atom (env config) atom
let render_typ config typ = render_typ (env config) typ
let render_exp config exp = render_exp (env config) exp
let render_def config def = render_def (env config) def
let render_defs config defs = render_defs (env config) defs
let render_deftyp config deftyp = render_deftyp (env config) deftyp
let render_nottyp config nottyp = render_nottyp (env config) nottyp
let render_script config script = render_script_defs (env config) script
