open Util.Source
open Ast


(* Helpers *)

let concat = String.concat
let prefix s f x = s ^ f x
let suffix f s x = f x ^ s
let space f x = " " ^ f x ^ " "

let filter_nl xs = List.filter_map (function Nl -> None | Elem x -> Some x) xs
let map_nl_list f xs = List.map f (filter_nl xs)


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

let string_of_brack = function
  | Paren -> "(", ")"
  | Brack -> "[", "]"
  | Brace -> "{", "}"

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

let strings_of_dots = function
  | Dots -> ["..."]
  | NoDots -> []


(* Iteration *)

let rec string_of_iter iter =
  match iter with
  | Opt -> "?"
  | List -> "*"
  | List1 -> "+"
  | ListN exp -> "^" ^ string_of_exp exp


(* Types *)

and string_of_typ typ =
  match typ.it with
  | VarT id -> id.it
  | BoolT -> "bool"
  | NatT -> "nat"
  | TextT -> "text"
  | ParenT typ -> "(" ^ string_of_typ typ ^ ")"
  | TupT typs -> "(" ^ string_of_typs ", " typs ^ ")"
  | IterT (typ1, iter) -> string_of_typ typ1 ^ string_of_iter iter
  | StrT typfields ->
    "{" ^ concat ", " (map_nl_list string_of_typfield typfields) ^ "}"
  | CaseT (dots1, ids, typcases, dots2) ->
    "\n  | " ^ concat "\n  | "
      (strings_of_dots dots1 @ map_nl_list it ids @
        map_nl_list string_of_typcase typcases @ strings_of_dots dots2)
  | AtomT atom -> string_of_atom atom
  | SeqT typs -> "{" ^ string_of_typs " " typs ^ "}"
  | InfixT (typ1, atom, typ2) ->
    string_of_typ typ1 ^ space string_of_atom atom ^ string_of_typ typ2
  | BrackT (brack, typ1) ->
    let l, r = string_of_brack brack in
    "`" ^ l ^ string_of_typ typ1 ^ r

and string_of_typs sep typs =
  concat sep (List.map string_of_typ typs)

and string_of_typfield (atom, typ, _hints) =
  string_of_atom atom ^ " " ^ string_of_typ typ

and string_of_typcase (atom, typs, _hints) =
  if typs = [] then
    string_of_atom atom
  else
    string_of_atom atom ^ " " ^ string_of_typs " " typs


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
  | EpsE -> "epsilon"
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
    "{" ^ concat ", " (map_nl_list string_of_expfield expfields) ^ "}"
  | DotE (exp1, atom) -> string_of_exp exp1 ^ "." ^ string_of_atom atom
  | CommaE (exp1, exp2) -> string_of_exp exp1 ^ ", " ^ string_of_exp exp2
  | CompE (exp1, exp2) -> string_of_exp exp1 ^ " ++ " ^ string_of_exp exp2
  | LenE exp1 -> "|" ^ string_of_exp exp1 ^ "|"
  | ParenE (exp, _necessary) -> "(" ^ string_of_exp exp ^ ")"
  | TupE exps -> "(" ^ string_of_exps ", " exps ^ ")"
  | InfixE (exp1, atom, exp2) ->
    string_of_exp exp1 ^ space string_of_atom atom ^ string_of_exp exp2
  | BrackE (brack, exp) ->
    let l, r = string_of_brack brack in
    "`" ^ l ^ string_of_exp exp ^ r
  | CallE (id, {it = SeqE []; _}) -> "$" ^ id.it
  | CallE (id, exp) -> "$" ^ id.it ^ string_of_exp exp
  | IterE (exp1, iter) -> string_of_exp exp1 ^ string_of_iter iter
  | HoleE false -> "%"
  | HoleE true -> "%%"
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
  | IfPr (exp, None) -> "if " ^ string_of_exp exp
  | IfPr (exp, Some iter) ->
    "(" ^ "if " ^ string_of_exp exp ^ ")" ^ string_of_iter iter
  | ElsePr -> "otherwise"

let string_of_def def =
  match def.it with
  | SynD (id1, id2, typ, _hints) ->
    let id2' = if id2.it = "" then "" else "/" ^ id2.it in
    "syntax " ^ id1.it ^ id2' ^ " = " ^ string_of_typ typ
  | RelD (id, typ, _hints) ->
    "relation " ^ id.it ^ ": " ^ string_of_typ typ
  | RuleD (id1, id2, exp, prems) ->
    let id2' = if id2.it = "" then "" else "/" ^ id2.it in
    "rule " ^ id1.it ^ id2' ^ ":\n  " ^ string_of_exp exp ^
      concat "" (map_nl_list (prefix "\n  -- " string_of_premise) prems)
  | VarD (id, typ, _hints) ->
    "var " ^ id.it ^ " : " ^ string_of_typ typ
  | DecD (id, exp1, typ2, _hints) ->
    let s1 = match exp1.it with SeqE [] -> "" | _ -> " " ^ string_of_exp exp1 in
    "def " ^ id.it ^ s1 ^ " : " ^ string_of_typ typ2
  | DefD (id, exp1, exp2, prems) ->
    let s1 = match exp1.it with SeqE [] -> "" | _ -> " " ^ string_of_exp exp1 in
    "def " ^ id.it ^ s1 ^ " = " ^ string_of_exp exp2 ^
      concat "" (map_nl_list (prefix "\n  -- " string_of_premise) prems)
  | SepD ->
    "\n\n"


(* Scripts *)

let string_of_script defs =
  concat "" (List.map (suffix string_of_def "\n") defs)
