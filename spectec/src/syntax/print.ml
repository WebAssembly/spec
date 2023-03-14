open Ast
open Source


(* Helpers *)

let concat = String.concat
let prefix s f x = s ^ f x
let suffix f s x = f x ^ s
let space f x = " " ^ f x ^ " "


(* Operators *)

let string_of_atom = function
  | Atom atomid -> atomid
  | Bot -> "_|_"

let string_of_unop = function
  | NotOp -> "~"
  | PlusOp -> "+"
  | MinusOp -> "-"

let string_of_binop = function
  | AndOp -> "/\\"
  | OrOp -> "\\/"
  | ImplOp -> "=>"
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

let string_of_relop = function
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

let string_of_brackop = function
  | Paren -> "(", ")"
  | Brack -> "[", "]"
  | Brace -> "{", "}"


(* Types *)

let rec string_of_iter iter =
  match iter with
  | Opt -> "?"
  | List -> "*"
  | List1 -> "+"
  | ListN exp -> "^" ^ string_of_exp exp

and string_of_typ typ =
  match typ.it with
  | VarT id -> id.it
  | AtomT atom -> string_of_atom atom
  | BoolT -> "bool"
  | NatT -> "nat"
  | TextT -> "text"
  | SeqT [] -> "epsilon"
  | SeqT typs -> "{" ^ string_of_typs " " typs ^ "}"
  | StrT typfields ->
    "{" ^ concat ", " (List.map string_of_typfield typfields) ^ "}"
  | TupT typs -> "(" ^ string_of_typs ", " typs ^ ")"
  | RelT (typ1, relop, typ2) ->
    string_of_typ typ1 ^ space string_of_relop relop ^ string_of_typ typ2
  | BrackT (brackop, typs) ->
    let l, r = string_of_brackop brackop in
    "`" ^ l ^ string_of_typs ", " typs ^ r
  | IterT (typ1, iter) -> string_of_typ typ1 ^ string_of_iter iter

and string_of_typs sep typs =
  concat sep (List.map string_of_typ typs)

and string_of_typfield (atom, typ, _hints) =
  string_of_atom atom ^ " " ^ string_of_typ typ

and string_of_typcase (atom, typs, _hints) =
  if typs = [] then
    string_of_atom atom
  else
    string_of_atom atom ^ " " ^ string_of_typs " " typs

and string_of_deftyp deftyp =
  match deftyp.it with
  | AliasT typ -> string_of_typ typ
  | StructT typfields ->
    "{" ^ concat ", " (List.map string_of_typfield typfields) ^ "}"
  | VariantT (ids, typcases) ->
    "| " ^ concat " | " (List.map it ids @ List.map string_of_typcase typcases)


(* Expressions *)

and string_of_exp exp =
  match exp.it with
  | VarE id -> id.it
  | AtomE atom -> string_of_atom atom
  | BoolE b -> string_of_bool b
  | NatE n -> string_of_int n
  | TextE t -> "\"" ^ String.escaped t ^ "\""
  | UnE (unop, exp2) -> string_of_unop unop ^ " " ^ string_of_exp exp2
  | BinE (exp1, binop, exp2) ->
    string_of_exp exp1 ^ space string_of_binop binop ^ string_of_exp exp2
  | CmpE (exp1, cmpop, exp2) ->
    string_of_exp exp1 ^ space string_of_cmpop cmpop ^ string_of_exp exp2
  | SeqE [] -> "epsilon"
  | SeqE exps -> "{" ^ string_of_exps " " exps ^ "}"
  | IdxE (exp1, exp2) -> string_of_exp exp1 ^ "[" ^ string_of_exp exp2 ^ "]"
  | SliceE (exp1, exp2, exp3) ->
    string_of_exp exp1 ^
      "[" ^ string_of_exp exp2 ^ " : " ^ string_of_exp exp3 ^ "]"
  | UpdE (exp1, path, exp2) ->
    string_of_exp exp1 ^
      "[" ^ string_of_path path ^ " = " ^ string_of_exp exp2 ^ "]"
  | ExtE (exp1, path, exp2) ->
    string_of_exp exp1 ^
      "[" ^ string_of_path path ^ " =.. " ^ string_of_exp exp2 ^ "]"
  | StrE expfields ->
    "{" ^ concat ", " (List.map string_of_expfield expfields) ^ "}"
  | DotE (exp1, atom) -> string_of_exp exp1 ^ "." ^ string_of_atom atom
  | CommaE (exp1, exp2) -> string_of_exp exp1 ^ ", " ^ string_of_exp exp2
  | CompE (exp1, exp2) -> string_of_exp exp1 ^ " ++ " ^ string_of_exp exp2
  | LenE exp1 -> "|" ^ string_of_exp exp1 ^ "|"
  | TupE exps -> "(" ^ string_of_exps ", " exps ^ ")"
  | RelE (exp1, relop, exp2) ->
    string_of_exp exp1 ^ space string_of_relop relop ^ string_of_exp exp2
  | BrackE (brackop, exps) ->
    let l, r = string_of_brackop brackop in
    "`" ^ l ^ string_of_exps ", " exps ^ r
  | CallE (id, {it = SeqE []; _}) -> "$" ^ id.it
  | CallE (id, exp) -> "$" ^ id.it ^ string_of_exp exp
  | IterE (exp1, iter) -> string_of_exp exp1 ^ string_of_iter iter
  | OptE expo -> "?(" ^ string_of_exps "" (Option.to_list expo) ^ ")"
  | ListE exps -> "[" ^ string_of_exps " " exps ^ "]"
  | CatE (exp1, exp2) -> string_of_exp exp1 ^ " :: " ^ string_of_exp exp2
  | CaseE (atom, []) -> "@" ^ string_of_atom atom
  | CaseE (atom, exps) ->
    "(@" ^ string_of_atom atom ^ " " ^ string_of_exps " " exps ^ ")"
  | SubE (exp1, typ1, typ2) ->
    "((" ^ string_of_exp exp1 ^
      ") : " ^ string_of_typ typ1 ^ " <: " ^ string_of_typ typ2 ^ ")"
  | HoleE -> "%"
  | FuseE (exp1, exp2) -> string_of_exp exp1 ^ "#" ^ string_of_exp exp2

and string_of_exps sep exps =
  concat sep (List.map string_of_exp exps)

and string_of_expfield (atom, exp) =
  string_of_atom atom ^ " " ^ string_of_exp exp

and string_of_path path =
  match path.it with
  | RootP -> ""
  | IdxP (path1, exp) -> string_of_path path1 ^ "[" ^ string_of_exp exp ^ "]"
  | DotP ({it = RootP; _}, atom) -> string_of_atom atom
  | DotP (path1, atom) -> string_of_path path1 ^ "." ^ string_of_atom atom


(* Definitions *)

let string_of_premise prem =
  match prem.it with
  | RulePr (id, exp, None) -> id.it ^ ": " ^ string_of_exp exp
  | RulePr (id, exp, Some iter) ->
    "(" ^ id.it ^ ": " ^ string_of_exp exp ^ ")" ^ string_of_iter iter
  | IffPr (exp, None) -> "iff: " ^ string_of_exp exp
  | IffPr (exp, Some iter) ->
    "(" ^ "iff: " ^ string_of_exp exp ^ ")" ^ string_of_iter iter
  | ElsePr -> "otherwise"

let string_of_def def =
  match def.it with
  | SynD (id, deftyp, _hints) ->
    "syntax " ^ id.it ^ " = " ^ string_of_deftyp deftyp
  | RelD (id, typ, _hints) ->
    "relation " ^ id.it ^ ": " ^ string_of_typ typ
  | RuleD (id, ids, exp, prems) ->
    let ids' = if ids = [] then "" else "/" ^ concat "-" (List.map it ids) in
    "rule " ^ id.it ^ ids' ^ ":\n  " ^ string_of_exp exp ^
      concat "" (List.map (prefix "\n  --" string_of_premise) prems)
  | VarD (id, typ, _hints) ->
    "var " ^ id.it ^ " : " ^ string_of_typ typ
  | DecD (id, {it = SeqE []; _}, typ, _hints) ->
    "def " ^ id.it ^ " : " ^ string_of_typ typ
  | DecD (id, exp, typ, _hints) ->
    "def " ^ id.it ^ string_of_exp exp ^ " : " ^ string_of_typ typ
  | DefD (id, {it = SeqE []; _}, exp2) ->
    "def" ^ id.it ^ string_of_exp exp2 ^ " = " ^ string_of_exp exp2
  | DefD (id, exp1, exp2) ->
    "def" ^ id.it ^ string_of_exp exp1 ^ " = " ^ string_of_exp exp2


(* Scripts *)

let string_of_script defs =
  concat "" (List.map (suffix string_of_def "\n") defs)
