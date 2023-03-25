open Util
open Source
open El.Ast


(* Flags *)

let flag_macros_for_ids = ref false
let flag_macros_for_vdash = ref false
let flag_include_grammar_desc = ref true


(* Errors *)

let error at msg = Source.error at "latex generation" msg


(* Environment *)

module Env = Map.Make(String)

type rel_sort = TypingRel | ReductionRel

type env = {mutable rels : rel_sort Env.t; current_rel : string}

let empty_env = {rels = Env.empty; current_rel = ""}


(* Helpers *)

let concat = String.concat
let suffix s f x = f x ^ s
let space f x = " " ^ f x ^ " "


(* Identifiers *)

let id_style = function
  | `Var -> "\\mathit"
  | `Func -> "\\mathrm"
  | `Atom -> "\\mathsf"
  | `Token -> "\\mathtt"

let gen_id style id =
  if !flag_macros_for_ids then
    "\\" ^ id
  else
    id_style style ^ "{" ^ id ^ "}"


(* TODO: handle more complicated subscripts and ticks correctly *)

let is_digit c = '0' <= c && c <= '9'

let rec gen_varid id = gen_varid_sub (String.split_on_char '_' id.it)
and gen_varid_sub = function
  | [] -> ""
  | s::ss ->
    let rec find_primes i =
      if i > 0 && s.[i - 1] = '\'' then find_primes (i - 1) else i
    in
    let n = String.length s in
    let i = find_primes n in
    let s' = String.sub s 0 i in
    let s'' = if String.for_all is_digit s' then s' else gen_id `Var s' in
    (if i = n then s'' else "{" ^ s'' ^ String.sub s i (n - i) ^ "}") ^
    (if ss = [] then "" else "_{" ^ gen_varid_sub ss ^ "}")


(* Operators *)

let gen_atom env = function
  | Atom atomid when atomid.[0] = '_' -> ""
  | Atom atomid ->
    let atomid' = Str.(global_replace (regexp "_") "\\_" atomid) in
    gen_id `Atom (String.lowercase_ascii atomid')
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
    if !flag_macros_for_vdash then
      "\\vdash" ^ env.current_rel
    else
      "\\vdash"

let gen_brack = function
  | Paren -> "(", ")"
  | Brack -> "[", "]"
  | Brace -> "\\{", "\\}"

let gen_unop = function
  | NotOp -> "\\neg"
  | PlusOp -> "+"
  | MinusOp -> "-"

let gen_binop = function
  | AndOp -> "\\land"
  | OrOp -> "\\lor"
  | ImplOp -> "Rightarrow"
  | AddOp -> "+"
  | SubOp -> "-"
  | MulOp -> "\\cdot"
  | DivOp -> "/"
  | ExpOp -> assert false

let gen_cmpop = function
  | EqOp -> "="
  | NeOp -> "\\neq"
  | LtOp -> "<"
  | GtOp -> ">"
  | LeOp -> "\\leq"
  | GeOp -> "\\geq"


(* Iteration *)

let rec gen_iter env = function
  | Opt -> "^?"
  | List -> "^\\ast"
  | List1 -> "^{+}"
  | ListN {it = ParenE exp; _} | ListN exp -> "^{" ^ gen_exp env exp ^ "}"


(* Types *)

and gen_typ env typ =
  match typ.it with
  | VarT id -> gen_varid id
  | BoolT -> gen_id `Var "bool"
  | NatT -> gen_id `Var "nat"
  | TextT -> gen_id `Var "text"
  | ParenT typ -> "("^ gen_typ env typ ^")"
  | TupT typs -> "("^ gen_typs ",\\; " env typs ^")"
  | IterT (typ1, iter) -> gen_typ env typ1 ^ gen_iter env iter

and gen_typs sep env typs =
  concat sep (List.filter ((<>) "") (List.map (gen_typ env) typs))


and gen_deftyp env deftyp =
  match deftyp.it with
  | NotationT nottyp -> gen_nottyp env nottyp
  | StructT typfields ->
    "\\{" ^ concat ",\\; " (List.map (gen_typfield env) typfields) ^ "\\}"
  | VariantT (ids, typcases) ->
    let ss = List.map it ids @ List.map (gen_typcase env) typcases in
    let is_short_typecase (_atom, nottyps, _hints) = nottyps = [] in
    (* TODO: heuristic *)
    if List.length typcases <= 6 && List.for_all is_short_typecase typcases then
      concat " ~|~ " ss
    else
      concat " \\\\ &&|&\n" ss

and gen_nottyp env nottyp =
  match nottyp.it with
  | TypT typ -> gen_typ env typ
  | AtomT atom -> gen_atom env atom
  | SeqT [] -> "\\epsilon"
  | SeqT nottyps -> gen_nottyps "~" env nottyps
  | InfixT ({it = SeqT []; _}, atom, nottyp2) ->
    "{" ^ space (gen_atom env) atom ^ "}\\;" ^ gen_nottyp env nottyp2
  | InfixT (nottyp1, atom, nottyp2) ->
    gen_nottyp env nottyp1 ^ space (gen_atom env) atom ^ gen_nottyp env nottyp2
  | BrackT (brack, nottyp1) ->
    let l, r = gen_brack brack in l ^ gen_nottyp env nottyp1 ^ r
  | ParenNT nottyp1 -> "(" ^ gen_nottyp env nottyp1 ^ ")"
  | IterNT (nottyp1, iter) -> gen_nottyp env nottyp1 ^ gen_iter env iter

and gen_nottyps sep env nottyps =
  concat sep (List.filter ((<>) "") (List.map (gen_nottyp env) nottyps))


and gen_typfield env (atom, typ, _hints) =
  gen_atom env atom ^ "~" ^ gen_typ env typ

and gen_typcase env (atom, nottyps, _hints) =
  if nottyps = [] then
    gen_atom env atom
  else
    let s = gen_atom env atom in
    (if s = "" then "" else s ^ "~") ^ gen_nottyps "~" env nottyps


(* Expressions *)

and gen_exp env exp =
  match exp.it with
  | VarE id -> gen_varid id
  | AtomE atom -> gen_atom env atom
  | BoolE b -> gen_id `Atom (string_of_bool b)
  | NatE n -> string_of_int n
  | TextE t -> "``" ^ t ^ "''"
  | UnE (unop, exp2) -> gen_unop unop ^ gen_exp env exp2
  | BinE (exp1, ExpOp, ({it = ParenE exp2; _ } | exp2)) ->
    gen_exp env exp1 ^ "^{" ^ gen_exp env exp2 ^ "}"
  | BinE (exp1, binop, exp2) ->
    gen_exp env exp1 ^ space gen_binop binop ^ gen_exp env exp2
  | CmpE (exp1, cmpop, exp2) ->
    gen_exp env exp1 ^ space gen_cmpop cmpop ^ gen_exp env exp2
  | EpsE -> "\\epsilon"
  | SeqE exps -> gen_exps "~" env exps
  | IdxE (exp1, exp2) -> gen_exp env exp1 ^ "[" ^ gen_exp env exp2 ^ "]"
  | SliceE (exp1, exp2, exp3) ->
    gen_exp env exp1 ^ "[" ^ gen_exp env exp2 ^ " : " ^ gen_exp env exp3 ^ "]"
  | UpdE (exp1, path, exp2) ->
    gen_exp env exp1 ^ "[" ^ gen_path env path ^ " = " ^ gen_exp env exp2 ^ "]"
  | ExtE (exp1, path, exp2) ->
    gen_exp env exp1 ^ "[" ^ gen_path env path ^ " = .." ^ gen_exp env exp2 ^ "]"
  | StrE expfields ->
    "\\{" ^ concat ",\\; " (List.map (gen_expfield env) expfields) ^ "\\}"
  | DotE (exp1, atom) -> gen_exp env exp1 ^ "." ^ gen_atom env atom
  | CommaE (exp1, exp2) -> gen_exp env exp1 ^ ", " ^ gen_exp env exp2
  | CompE (exp1, exp2) -> gen_exp env exp1 ^ " \\oplus " ^ gen_exp env exp2
  | LenE exp1 -> "|" ^ gen_exp env exp1 ^ "|"
  | ParenE exp -> "(" ^ gen_exp env exp ^ ")"
  | TupE exps -> "(" ^ gen_exps ",\\, " env exps ^ ")"
  | InfixE ({it = SeqE []; _}, atom, exp2) ->
    "{" ^ space (gen_atom env) atom ^ "}\\;" ^ gen_exp env exp2
  | InfixE (exp1, atom, exp2) ->
    gen_exp env exp1 ^ space (gen_atom env) atom ^ gen_exp env exp2
  | BrackE (brack, exp) ->
    let l, r = gen_brack brack in l ^ gen_exp env exp ^ r
  | CallE (id, {it = SeqE []; _}) -> gen_id `Func id.it
  | CallE (id, exp) -> gen_id `Func id.it ^ gen_exp env exp
  | IterE (exp1, iter) -> gen_exp env exp1 ^ gen_iter env iter
  | HoleE | FuseE _ -> assert false

and gen_exps sep env exps =
  concat sep (List.filter ((<>) "") (List.map (gen_exp env) exps))

and gen_expfield env (atom, exp) =
  gen_atom env atom ^ "~" ^ gen_exp env exp

and gen_path env path =
  match path.it with
  | RootP -> ""
  | IdxP (path1, exp) -> gen_path env path1 ^ "[" ^ gen_exp env exp ^ "]"
  | DotP ({it = RootP; _}, atom) -> gen_atom env atom
  | DotP (path1, atom) -> gen_path env path1 ^ "." ^ gen_atom env atom


(* Definitions *)

let word s = "\\mbox{" ^ s ^ "}"

let gen_premise env prem =
  match prem.it with
  | RulePr (id, exp, None) ->
    gen_exp {env with current_rel = id.it} exp
  | RulePr (id, exp, Some iter) ->
    let env' = {env with current_rel = id.it} in
    "(" ^ gen_exp env' exp ^ ")" ^ gen_iter env' iter
  | IffPr (exp, None) ->
    gen_exp env exp
  | IffPr (exp, Some iter) ->
    "(" ^ gen_exp env exp ^ ")" ^ gen_iter env iter
  | ElsePr ->
    error prem.at "misplaced `otherwise` premise"


let gen_syndef env def =
  match def.it with
  | SynD (id, deftyp, _hints) ->
    (* TODO: include grammar descriptions *)
    "& " ^ gen_varid id ^ " &::=& " ^ gen_deftyp env deftyp
  | _ -> assert false

let split_redexp exp =
  match exp.it with
  | InfixE (exp1, SqArrow, exp2) -> exp1, exp2
  | _ -> error exp.at "unrecognized format for reduction rule"

let gen_reddef env def =
  match def.it with
  | RuleD (_id1, _id2, exp, prems) ->
    let exp1, exp2 = split_redexp exp in
    gen_exp env exp1 ^ " &" ^ gen_atom env SqArrow ^ "& " ^ gen_exp env exp2 ^
    (match prems with
    | [] -> ""
    | [{it = ElsePr; _}] -> " &\n  " ^ word "otherwise"
    | _ ->
      " &\n  " ^ word "if" ^ "~" ^
      concat "\\\\\n &&& {\\land}~" (List.map (gen_premise env) prems)
    )
  | _ -> assert false


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

let rec classify_rel nottyp : rel_sort option =
  match nottyp.it with
  | InfixT (_, Turnstile, _) -> Some TypingRel
  | InfixT (_, SqArrow, _) -> Some ReductionRel
  | InfixT (nottyp1, _, nottyp2) ->
    (match classify_rel nottyp1 with None -> classify_rel nottyp2 | some -> some)
  | _ -> None

let rec gen_defs env = function
  | [] -> ""
  | def::defs ->
    match def.it with
    | SynD _ ->
      let syndefs, defs' = split_syndefs [def] defs in
      "$$\n" ^
      "\\begin{array}{@{}l@{}rcl@{}}\n" ^
      concat "\\\\\n[1ex]\n" (List.map (gen_syndef env) syndefs) ^ "\\\\\n" ^
      "\\end{array}\n" ^
      "$$\n\n" ^
      gen_defs env defs'

    | RelD (id, nottyp, _hints) ->
      let sort =
        match classify_rel nottyp with
        | Some sort -> sort
        | None -> error def.at "unrecognized form of relation"
      in
      env.rels <- Env.add id.it sort env.rels;
      "$\n" ^
      "\\boxed{" ^ gen_nottyp {env with current_rel = id.it} nottyp ^ "}\n" ^
      "$\n\n" ^
      gen_defs env defs

    | RuleD (id1, _id2, exp, prems) ->
      (* TODO: include rule name *)
      (match Env.find id1.it env.rels with
      | TypingRel ->
        "$$\n" ^
        "\\frac{\n" ^
          concat "\\qquad\n" (List.map (suffix "\n" (gen_premise env)) prems) ^
        "}{\n" ^
          gen_exp {env with current_rel = id1.it} exp ^ "\n" ^
        "}\n" ^
        "$$\n\n" ^
        gen_defs env defs

      | ReductionRel ->
        let reddefs, defs' = split_reddefs id1.it [def] defs in
        "$$\n" ^
        "\\begin{array}{@{}lcll@{}}\n" ^
        concat "\\\\\n" (List.map (gen_reddef env) reddefs) ^ "\\\\\n" ^
        "\\end{array}\n" ^
        "$$\n\n" ^
        gen_defs env defs'
      )

    | VarD _ ->
      gen_defs env defs

    | DecD _ ->
      (* TODO: definitions *)
      gen_defs env defs

    | DefD _ ->
      (* TODO: definitions *)
      gen_defs env defs

let gen_def env def = gen_defs env [def]


(* Scripts *)

let gen_script defs =
  gen_defs empty_env defs
