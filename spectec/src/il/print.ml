open Util
open Source
open Ast


(* Helpers *)

let concat = String.concat
let prefix s f x = s ^ f x
let space f x = " " ^ f x ^ " "


(* Operators *)

let string_of_atom = function
  | Atom atomid -> atomid
  | Bot -> "_|_"
  | Dot -> "."
  | Dot2 -> ".."
  | Dot3 -> "..."
  | Semicolon -> ";"
  | Arrow -> "->"
  | Colon -> ":"
  | Sub -> "<:"
  | SqArrow -> "~>"
  | Tilesturn -> "-|"
  | Turnstile -> "|-"
  | LParen -> "("
  | LBrack -> "["
  | LBrace -> "{"
  | RParen -> ")"
  | RBrack -> "]"
  | RBrace -> "}"
  | Quest -> "?"
  | Star -> "*"

let string_of_unop = function
  | NotOp -> "~"
  | PlusOp -> "+"
  | MinusOp -> "-"

let string_of_binop = function
  | AndOp -> "/\\"
  | OrOp -> "\\/"
  | ImplOp -> "=>"
  | EquivOp -> "<=>"
  | AddOp -> "+"
  | SubOp -> "-"
  | MulOp -> "*"
  | DivOp -> "/"
  | ExpOp -> "^"

let string_of_cmpop = function
  | EqOp -> "="
  | NeOp -> "=/="
  | LtOp -> "<"
  | GtOp -> ">"
  | LeOp -> "<="
  | GeOp -> ">="

let string_of_mixop = function
  | [Atom a]::tail when List.for_all ((=) []) tail -> a
  | mixop ->
    let s =
      String.concat "%" (List.map (
        fun atoms -> String.concat "" (List.map string_of_atom atoms)) mixop
      )
    in
    "`" ^ s ^ "`"


(* Types *)

let rec string_of_iter iter =
  match iter with
  | Opt -> "?"
  | List -> "*"
  | List1 -> "+"
  | ListN e -> "^" ^ string_of_exp e
  | IndexedListN (id, e) ->
    "^(" ^ id.it ^ "<" ^ string_of_exp e ^ ")"

and string_of_typ t =
  match t.it with
  | VarT id -> id.it
  | BoolT -> "bool"
  | NatT -> "nat"
  | TextT -> "text"
  | TupT ts -> "(" ^ string_of_typs ", " ts ^ ")"
  | IterT (t1, iter) -> string_of_typ t1 ^ string_of_iter iter

and string_of_typ_args t =
  match t.it with
  | TupT [] -> ""
  | TupT _ -> string_of_typ t
  | _ -> "(" ^ string_of_typ t ^ ")"

and string_of_typs sep ts =
  concat sep (List.map string_of_typ ts)

and string_of_deftyp dt =
  match dt.it with
  | AliasT t -> string_of_typ t
  | NotationT (mixop, t) -> string_of_typ_mix mixop t
  | StructT tfs -> "{" ^ concat ", " (List.map string_of_typfield tfs) ^ "}"
  | VariantT tcs -> "\n  | " ^ concat "\n  | " (List.map string_of_typcase tcs)

and string_of_typ_mix mixop t =
  if mixop = [[]; []] then string_of_typ t else
  string_of_mixop mixop ^ string_of_typ_args t

and string_of_typfield (atom, t, _hints) =
  string_of_atom atom ^ " " ^ string_of_typ t

and string_of_typcase (atom, t, _hints) =
  string_of_atom atom ^ string_of_typ_args t


(* Expressions *)

and string_of_exp e =
  match e.it with
  | VarE id -> id.it
  | BoolE b -> string_of_bool b
  | NatE n -> string_of_int n
  | TextE t -> "\"" ^ String.escaped t ^ "\""
  | UnE (op, e2) -> string_of_unop op ^ " " ^ string_of_exp e2
  | BinE (op, e1, e2) ->
    "(" ^ string_of_exp e1 ^ space string_of_binop op ^ string_of_exp e2 ^ ")"
  | CmpE (op, e1, e2) ->
    "(" ^ string_of_exp e1 ^ space string_of_cmpop op ^ string_of_exp e2 ^ ")"
  | IdxE (e1, e2) -> string_of_exp e1 ^ "[" ^ string_of_exp e2 ^ "]"
  | SliceE (e1, e2, e3) ->
    string_of_exp e1 ^
      "[" ^ string_of_exp e2 ^ " : " ^ string_of_exp e3 ^ "]"
  | UpdE (e1, p, e2) ->
    string_of_exp e1 ^
      "[" ^ string_of_path p ^ " = " ^ string_of_exp e2 ^ "]"
  | ExtE (e1, p, e2) ->
    string_of_exp e1 ^
      "[" ^ string_of_path p ^ " =.. " ^ string_of_exp e2 ^ "]"
  | StrE efs -> "{" ^ concat ", " (List.map string_of_expfield efs) ^ "}"
  | DotE (e1, atom) ->
    string_of_exp e1 ^ "." ^ string_of_atom atom ^ "_" ^ string_of_typ e1.note
  | CompE (e1, e2) -> string_of_exp e1 ^ " ++ " ^ string_of_exp e2
  | LenE e1 -> "|" ^ string_of_exp e1 ^ "|"
  | TupE es -> "(" ^ string_of_exps ", " es ^ ")"
  | MixE (op, e1) -> string_of_mixop op ^ string_of_exp_args e1
  | CallE (id, e1) -> "$" ^ id.it ^ string_of_exp_args e1
  | IterE (e1, iter) -> string_of_exp e1 ^ string_of_iterexp iter
  | OptE eo -> "?(" ^ string_of_exps "" (Option.to_list eo) ^ ")"
  | TheE e1 -> "!(" ^ string_of_exp e1 ^ ")"
  | ListE es -> "[" ^ string_of_exps " " es ^ "]"
  | ElementsOfE (e1, e2) ->
    string_of_exp e1 ^ "<-" ^ string_of_exp e2
  | ListBuilderE (e1, e2) ->
    "[" ^ string_of_exp e1 ^ "|" ^ string_of_exp e2 ^ "]"
  | CatE (e1, e2) -> string_of_exp e1 ^ " :: " ^ string_of_exp e2
  | CaseE (atom, e1) ->
    string_of_atom atom ^ "_" ^ string_of_typ e.note ^ string_of_exp_args e1
  | SubE (e1, _t1, t2) ->
    "(" ^ string_of_exp e1 ^ " <: " ^ string_of_typ t2 ^ ")"

and string_of_exp_args e =
  match e.it with
  | TupE [] -> ""
  | TupE _ | SubE _ | BinE _ | CmpE _ -> string_of_exp e
  | _ -> "(" ^ string_of_exp e ^ ")"

and string_of_exps sep es =
  concat sep (List.map string_of_exp es)

and string_of_expfield (atom, e) =
  string_of_atom atom ^ " " ^ string_of_exp e

and string_of_path p =
  match p.it with
  | RootP -> ""
  | IdxP (p1, e) ->
    string_of_path p1 ^ "[" ^ string_of_exp e ^ "]"
  | SliceP (p1, e1, e2) ->
    string_of_path p1 ^ "[" ^ string_of_exp e1 ^ " : " ^ string_of_exp e2 ^ "]"
  | DotP ({it = RootP; note; _}, atom) ->
    string_of_atom atom ^ "_" ^ string_of_typ note
  | DotP (p1, atom) ->
    string_of_path p1 ^ "." ^ string_of_atom atom ^ "_" ^ string_of_typ p1.note

and string_of_iterexp (iter, ids) =
  string_of_iter iter ^ "{" ^ String.concat " " (List.map Source.it ids) ^ "}"


(* Definitions *)

let string_of_bind (id, t, iters) =
  let dim = String.concat "" (List.map string_of_iter iters) in
  id.it ^ dim ^ " : " ^ string_of_typ t ^ dim

let string_of_binds = function
  | [] -> ""
  | binds -> " {" ^ concat ", " (List.map string_of_bind binds) ^ "}"


let rec string_of_prem prem =
  match prem.it with
  | RulePr (id, op, e) -> id.it ^ ": " ^ string_of_exp {e with it = MixE (op, e)}
  | IfPr e -> "if " ^ string_of_exp e
  | LetPr (e1, e2, _targets) -> "where " ^ string_of_exp e1 ^ " = " ^ string_of_exp e2
  | ElsePr -> "otherwise"
  | IterPr ({it = IterPr _; _} as prem', iter) ->
    string_of_prem prem' ^ string_of_iterexp iter
  | IterPr (prem', iter) ->
    "(" ^ string_of_prem prem' ^ ")" ^ string_of_iterexp iter

let region_comment indent at =
  if at = no_region then "" else
  indent ^ ";; " ^ string_of_region at ^ "\n"

let string_of_rule rule =
  match rule.it with
  | RuleD (id, binds, mixop, e, prems) ->
    let id' = if id.it = "" then "_" else id.it in
    "\n" ^ region_comment "  " rule.at ^
    "  rule " ^ id' ^ string_of_binds binds ^ ":\n    " ^
      string_of_exp {e with it = MixE (mixop, e)} ^
      concat "" (List.map (prefix "\n    -- " string_of_prem) prems)

let string_of_clause id clause =
  match clause.it with
  | DefD (binds, e1, e2, prems) ->
    "\n" ^ region_comment "  " clause.at ^
    "  def" ^ string_of_binds binds ^ " " ^ id.it ^ string_of_exp_args e1 ^ " = " ^
      string_of_exp e2 ^
      concat "" (List.map (prefix "\n    -- " string_of_prem) prems)

let rec string_of_def d =
  let pre = "\n" ^ region_comment "" d.at in
  match d.it with
  | SynD (id, dt) ->
    pre ^ "syntax " ^ id.it ^ " = " ^ string_of_deftyp dt ^ "\n"
  | RelD (id, mixop, t, rules) ->
    pre ^ "relation " ^ id.it ^ ": " ^ string_of_typ_mix mixop t ^
      concat "\n" (List.map string_of_rule rules) ^ "\n"
  | DecD (id, t1, t2, clauses) ->
    let s1 =
      match t1.it with
      | TupT [] -> ""
      | _ -> string_of_typ t1 ^ " -> "
    in
    pre ^ "def " ^ id.it ^ " : " ^ s1 ^ string_of_typ t2 ^
      concat "" (List.map (string_of_clause id) clauses) ^ "\n"
  | RecD ds ->
    pre ^ "rec {\n" ^ concat "" (List.map string_of_def ds) ^ "}" ^ "\n"
  | HintD _ ->
    ""


(* Scripts *)

let string_of_script ds =
  concat "" (List.map string_of_def ds)


let sprintf = Printf.sprintf

let structured_string_of_list stringifier = function
  | [] -> "[]"
  | h :: t ->
      "[" ^
        List.fold_left
          (fun acc elem -> acc ^ ", " ^ stringifier elem)
          (stringifier h) t ^ "]"


(* Structured string *)

let structured_string_of_hint hint =
  let identity x = x in
  sprintf "{hintid : \"%s\"; hintexp : %s}"
    (hint.hintid.it)
    (structured_string_of_list identity hint.hintexp)

let structured_string_of_hints hints =
    structured_string_of_list structured_string_of_hint hints

let structured_string_of_hintdef hintdef =
  match hintdef.it with
  | SynH (id, hints) -> sprintf "SynH (%s, %s)" id.it (structured_string_of_list structured_string_of_hint hints)
  | RelH (id, hints) -> sprintf "RelH (%s, %s)" id.it (structured_string_of_list structured_string_of_hint hints)
  | DecH (id, hints) -> sprintf "DecH (%s, %s)" id.it (structured_string_of_list structured_string_of_hint hints)

let structured_string_of_atom = function
  | Atom atomid -> sprintf "Atom \"%s\"" atomid
  | Bot -> "Bot"
  | Dot -> "Dot"
  | Dot2 -> "Dot2"
  | Dot3 -> "Dot3"
  | Semicolon -> "Semicolon"
  | Arrow -> "Arrow"
  | Colon -> "Colon"
  | Sub -> "Sub"
  | SqArrow -> "SqArrow"
  | Tilesturn -> "Tilesturn"
  | Turnstile -> "Turnstile"
  | LParen -> "LParen"
  | LBrack -> "LBrack"
  | LBrace -> "LBrace"
  | RParen -> "RParen"
  | RBrack -> "RBrack"
  | RBrace -> "RBrace"
  | Quest -> "Quest"
  | Star -> "Star"

let structured_string_of_unop = function
  | NotOp -> "NotOp"
  | PlusOp -> "PlusOp"
  | MinusOp -> "MinusOp"

let structured_string_of_binop = function
  | AndOp -> "AndOp"
  | OrOp -> "OrOp"
  | ImplOp -> "ImplOp"
  | EquivOp -> "EquivOp"
  | AddOp -> "AddOp"
  | SubOp -> "SubOp"
  | MulOp -> "MulOp"
  | DivOp -> "DivOp"
  | ExpOp -> "ExpOp"

let structured_string_of_cmpop = function
  | EqOp -> "EqOp"
  | NeOp -> "NeOp"
  | LtOp -> "LtOp"
  | GtOp -> "GtOp"
  | LeOp -> "LeOp"
  | GeOp -> "GeOp"

let structured_string_of_mixop mixop =
  structured_string_of_list
    (structured_string_of_list structured_string_of_atom)
    mixop


(* Types *)

let rec structured_string_of_iter iter =
  match iter with
  | Opt -> "Opt"
  | List -> "List"
  | List1 -> "List1"
  | ListN exp -> sprintf "ListN (%s)" (structured_string_of_exp exp)
  | IndexedListN (id, exp) ->
    sprintf "ListN (%s, %s)" id.it (structured_string_of_exp exp)

and structured_string_of_typ typ =
  match typ.it with
  | VarT id -> sprintf "VarT \"%s\"" id.it
  | BoolT -> "BoolT"
  | NatT -> "NatT"
  | TextT -> "TextT"
  | TupT typs -> sprintf "TupT (%s)" (structured_string_of_typs typs)
  | IterT (typ1, iter) ->
      sprintf "IterT (%s, %s)"
        (structured_string_of_typ typ1)
        (structured_string_of_iter iter)

and structured_string_of_typs typs =
  structured_string_of_list structured_string_of_typ typs

and structured_string_of_deftyp deftyp =
  match deftyp.it with
  | AliasT typ -> sprintf "AliasT (%s)" (structured_string_of_typ typ)
  | NotationT (mixop, typ) ->
      sprintf "NotationT (%s, %s)"
        (structured_string_of_mixop mixop)
        (structured_string_of_typ typ)
  | StructT typfields ->
      sprintf "StructT (%s)" (structured_string_of_typfields typfields)
  | VariantT (typcases) ->
      sprintf "VariantT (%s)"
        (structured_string_of_list structured_string_of_typcase typcases)

and structured_string_of_typfield (atom, typ, hints) =
  sprintf "(%s, %s, %s)"
    (structured_string_of_atom atom)
    (structured_string_of_typ typ)
    (structured_string_of_hints hints)

and structured_string_of_typfields typfields =
  structured_string_of_list structured_string_of_typfield typfields

and structured_string_of_typcase (atom, typ, hints) =
  sprintf "(%s, %s, %s)"
    (structured_string_of_atom atom)
    (structured_string_of_typ typ)
    (structured_string_of_hints hints)


(* Expressions *)

and structured_string_of_exp exp =
  match exp.it with
  | VarE id -> sprintf "VarE \"%s\"" id.it
  | BoolE b -> sprintf "BoolE %s" (string_of_bool b)
  | NatE n -> sprintf "NatE %s" (string_of_int n)
  | TextE t -> sprintf "TextE \"%s\"" (String.escaped t)
  | UnE (unop, exp2) ->
      sprintf "UnE (%s, %s)"
        (structured_string_of_unop unop)
        (structured_string_of_exp exp2)
  | BinE (binop, exp1, exp2) ->
      sprintf "BinE (%s, %s, %s)"
        (structured_string_of_exp exp1)
        (structured_string_of_binop binop)
        (structured_string_of_exp exp2)
  | CmpE (cmpop, exp1, exp2) ->
      sprintf "CmpE (%s, %s, %s)"
        (structured_string_of_exp exp1)
        (structured_string_of_cmpop cmpop)
        (structured_string_of_exp exp2)
  | IdxE (exp1, exp2) ->
      sprintf "IdxE (%s, %s)"
        (structured_string_of_exp exp1)
        (structured_string_of_exp exp2)
  | SliceE (exp1, exp2, exp3) ->
      sprintf "SliceE (%s, %s, %s)"
        (structured_string_of_exp exp1)
        (structured_string_of_exp exp2)
        (structured_string_of_exp exp3)
  | UpdE (exp1, path, exp2) ->
      sprintf "UpdE (%s, %s, %s)"
        (structured_string_of_exp exp1)
        (structured_string_of_path path)
        (structured_string_of_exp exp2)
  | ExtE (exp1, path, exp2) ->
      sprintf "ExtE (%s, %s, %s)"
        (structured_string_of_exp exp1)
        (structured_string_of_path path)
        (structured_string_of_exp exp2)
  | StrE expfields ->
      sprintf "StrE (%s)"
        (structured_string_of_list structured_string_of_expfield expfields)
  | DotE (exp1, atom) ->
      sprintf "DotE (%s, %s)"
        (structured_string_of_exp exp1)
        (structured_string_of_atom atom)
  | CompE (exp1, exp2) ->
      sprintf "CompE (%s, %s)"
        (structured_string_of_exp exp1)
        (structured_string_of_exp exp2)
  | LenE exp1 -> sprintf "LenE (%s)" (structured_string_of_exp exp1)
  | TupE exps -> sprintf "TupE (%s)" (structured_string_of_exps exps)
  | MixE (mixop, exp1) ->
      sprintf "MixE (%s, %s)"
        (structured_string_of_mixop mixop)
        (structured_string_of_exp exp1)
  | CallE (id, exp) ->
      sprintf "CallE (\"%s\", %s)"
        id.it
        (structured_string_of_exp exp)
  | IterE (exp1, iterexp) ->
      sprintf "IterE (%s, %s)"
        (structured_string_of_exp exp1)
        (structured_string_of_iterexp iterexp)
  | OptE None -> "OptE ()"
  | OptE Some exp -> sprintf "OptE (%s)" (structured_string_of_exp exp)
  | TheE exp -> sprintf "TheE (%s)" (structured_string_of_exp exp)
  | ListE exps -> sprintf "ListE (%s)" (structured_string_of_exps exps)
  | CatE (exp1, exp2) ->
      sprintf "CatE (%s, %s)"
        (structured_string_of_exp exp1)
        (structured_string_of_exp exp2)
  | CaseE (atom, exp1) ->
      sprintf "CaseE (%s, %s)"
        (structured_string_of_atom atom)
        (structured_string_of_exp exp1)
  | SubE (exp1, typ1, typ2) ->
      sprintf "SubE (%s, %s, %s)"
        (structured_string_of_exp exp1)
        (structured_string_of_typ typ1)
        (structured_string_of_typ typ2)
  | ElementsOfE (exp1, exp2) ->
      sprintf "ElementsOfE (%s, %s)"
        (structured_string_of_exp exp1)
        (structured_string_of_exp exp2)
  | ListBuilderE (exp1, exp2) ->
      sprintf "ListBuilderE (%s, %s)"
        (structured_string_of_exp exp1)
        (structured_string_of_exp exp2)

and structured_string_of_exps exps =
  structured_string_of_list structured_string_of_exp exps

and structured_string_of_iterexp (iter, ids) =
  sprintf "(%s, %s)"
    (structured_string_of_iter iter)
    (structured_string_of_list (fun id -> sprintf "\"%s\"" id.it) ids)


and structured_string_of_expfield (atom, exp) =
  sprintf "(%s, %s)" (structured_string_of_atom atom) (structured_string_of_exp exp)

and structured_string_of_path path =
  match path.it with
  | RootP -> "RootP"
  | IdxP (path1, exp) ->
      sprintf "IdxP (%s, %s)"
        (structured_string_of_path path1)
        (structured_string_of_exp exp)
  | SliceP (path1, exp1, exp2) ->
      sprintf "SliceP (%s, %s, %s)"
        (structured_string_of_path path1)
        (structured_string_of_exp exp1)
        (structured_string_of_exp exp2)
  | DotP (path1, atom) ->
      sprintf "DotP (%s, %s)"
        (structured_string_of_path path1)
        (structured_string_of_atom atom)


(* Definitions *)

let structured_string_of_bind (id, typ, iters) =
  sprintf "(\"%s\", %s, %s)"
    id.it
    (structured_string_of_typ typ)
    (structured_string_of_list structured_string_of_iter iters)

let structured_string_of_binds binds =
  structured_string_of_list structured_string_of_bind binds


let rec structured_string_of_premise prem =
  match prem.it with
  | RulePr (id, mixop, exp) ->
      sprintf "RulePr (\"%s\", %s, %s)"
        id.it
        (structured_string_of_mixop mixop)
        (structured_string_of_exp exp)
  | IfPr (exp) -> sprintf "IfPr (%s)" (structured_string_of_exp exp)
  | LetPr (exp1, exp2, targets) ->
      sprintf "LetPr (%s, %s, %s)"
        (structured_string_of_exp exp1)
        (structured_string_of_exp exp2)
        ("[" ^ String.concat ";" targets ^ "]")
  | ElsePr -> "ElsePr"
  | IterPr (prem, iterexp) ->
      sprintf "IterPr (%s, %s)"
        (structured_string_of_premise prem)
        (structured_string_of_iterexp iterexp)

let structured_string_of_rule rule =
  match rule.it with
  | RuleD (id, binds, mixop, exp, prems) ->
      sprintf "RuleD (\"%s\", %s, %s, %s, %s)"
        id.it
        (structured_string_of_binds binds)
        (structured_string_of_mixop mixop)
        (structured_string_of_exp exp)
        (structured_string_of_list structured_string_of_premise prems)

let structured_string_of_clause clause =
  match clause.it with
  | DefD (binds, exp1, exp2, prems) ->
      sprintf "DefD (%s, %s, %s, %s)"
        (structured_string_of_binds binds)
        (structured_string_of_exp exp1)
        (structured_string_of_exp exp2)
        (structured_string_of_list structured_string_of_premise prems)

let rec structured_string_of_def def =
  match def.it with
  | SynD (id, deftyp) ->
      sprintf "SynD (\n   \"%s\",\n   %s\n)\n"
        id.it
        (structured_string_of_deftyp deftyp)
  | RelD (id, mixop, typ, rules) ->
      sprintf "RelD (\n   \"%s\",\n   %s,\n   %s,\n   %s\n)\n"
        id.it
        (structured_string_of_mixop mixop)
        (structured_string_of_typ typ)
        (structured_string_of_list structured_string_of_rule rules)
  | DecD (id, typ1, typ2, clauses) ->
      sprintf "DecD (\n   \"%s\",\n   %s,\n   %s,\n   %s\n)\n"
        id.it
        (structured_string_of_typ typ1)
        (structured_string_of_typ typ2)
        (structured_string_of_list structured_string_of_clause clauses)
  | RecD defs ->
      sprintf "RecD (%s)\n" (structured_string_of_list structured_string_of_def defs)
  | HintD hintdef ->
      sprintf "HintD (%s)\n" (structured_string_of_hintdef hintdef)


(* Scripts *)

let structured_string_of_script defs =
  concat "" (List.map structured_string_of_def defs)
