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
  | Backslash -> "\\"
  | In -> "in"
  | Arrow -> "->"
  | Colon -> ":"
  | Sub -> "<:"
  | Assign -> ":="
  | Approx -> "~~"
  | SqArrow -> "~>"
  | SqArrowStar -> "~>*"
  | Prec -> "<<"
  | Succ -> ">>"
  | Tilesturn -> "-|"
  | Turnstile -> "|-"
  | Quest -> "?"
  | Star -> "*"

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
  | ListN (e, None) -> "^" ^ string_of_exp e
  | ListN (e, Some id) -> "^(" ^ id.it ^ "<" ^ string_of_exp e ^ ")"


(* Types *)

and string_of_typ t =
  match t.it with
  | VarT id -> id.it
  | BoolT -> "bool"
  | NatT -> "nat"
  | TextT -> "text"
  | ParenT t -> "(" ^ string_of_typ t ^ ")"
  | TupT ts -> "(" ^ string_of_typs ", " ts ^ ")"
  | IterT (t1, iter) -> string_of_typ t1 ^ string_of_iter iter
  | StrT tfs ->
    "{" ^ concat ", " (map_nl_list string_of_typfield tfs) ^ "}"
  | CaseT (dots1, ids, tcases, dots2) ->
    "\n  | " ^ concat "\n  | "
      (strings_of_dots dots1 @ map_nl_list it ids @
        map_nl_list string_of_typcase tcases @ strings_of_dots dots2)
  | AtomT atom -> string_of_atom atom
  | SeqT ts -> "{" ^ string_of_typs " " ts ^ "}"
  | InfixT (t1, atom, t2) ->
    string_of_typ t1 ^ space string_of_atom atom ^ string_of_typ t2
  | BrackT (brack, t1) ->
    let l, r = string_of_brack brack in
    "`" ^ l ^ string_of_typ t1 ^ r

and string_of_typs sep ts =
  concat sep (List.map string_of_typ ts)

and string_of_typfield (atom, t, _hints) =
  string_of_atom atom ^ " " ^ string_of_typ t

and string_of_typcase (atom, ts, _hints) =
  if ts = [] then
    string_of_atom atom
  else
    string_of_atom atom ^ " " ^ string_of_typs " " ts


(* Expressions *)

and string_of_exp e =
  match e.it with
  | VarE id -> id.it
  | AtomE atom -> string_of_atom atom
  | BoolE b -> string_of_bool b
  | NatE n -> string_of_int n
  | TextE t -> "\"" ^ String.escaped t ^ "\""
  | UnE (op, e2) -> string_of_unop op ^ " " ^ string_of_exp e2
  | BinE (e1, op, e2) ->
    string_of_exp e1 ^ space string_of_binop op ^ string_of_exp e2
  | CmpE (e1, op, e2) ->
    string_of_exp e1 ^ space string_of_cmpop op ^ string_of_exp e2
  | EpsE -> "epsilon"
  | SeqE es -> "{" ^ string_of_exps " " es ^ "}"
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
  | StrE efs -> "{" ^ concat ", " (map_nl_list string_of_expfield efs) ^ "}"
  | DotE (e1, atom) -> string_of_exp e1 ^ "." ^ string_of_atom atom
  | CommaE (e1, e2) -> string_of_exp e1 ^ ", " ^ string_of_exp e2
  | CompE (e1, e2) -> string_of_exp e1 ^ " ++ " ^ string_of_exp e2
  | LenE e1 -> "|" ^ string_of_exp e1 ^ "|"
  | ParenE (e, _necessary) -> "(" ^ string_of_exp e ^ ")"
  | TupE es -> "(" ^ string_of_exps ", " es ^ ")"
  | InfixE (e1, atom, e2) ->
    string_of_exp e1 ^ space string_of_atom atom ^ string_of_exp e2
  | BrackE (brack, e) ->
    let l, r = string_of_brack brack in
    "`" ^ l ^ string_of_exp e ^ r
  | CallE (id, {it = SeqE []; _}) -> "$" ^ id.it
  | CallE (id, e) -> "$" ^ id.it ^ string_of_exp e
  | IterE (e1, iter) -> string_of_exp e1 ^ string_of_iter iter
  | HoleE false -> "%"
  | HoleE true -> "%%"
  | FuseE (e1, e2) -> string_of_exp e1 ^ "#" ^ string_of_exp e2
  | ElementsOfE (e1, e2) -> string_of_exp e1 ^ "<-" ^ string_of_exp e2
  | ListBuilderE (e1, e2) ->
      "[" ^ string_of_exp e1 ^ "|" ^ string_of_exp e2 ^ "]"

and string_of_exps sep es =
  concat sep (List.map string_of_exp es)

and string_of_expfield (atom, e) =
  string_of_atom atom ^ " " ^ string_of_exp e

and string_of_path p =
  match p.it with
  | RootP -> ""
  | IdxP (p1, e) -> string_of_path p1 ^ "[" ^ string_of_exp e ^ "]"
  | SliceP (p1, e1, e2) ->
    string_of_path p1 ^ "[" ^ string_of_exp e1 ^ " : " ^ string_of_exp e2 ^ "]"
  | DotP ({it = RootP; _}, atom) -> string_of_atom atom
  | DotP (p1, atom) -> string_of_path p1 ^ "." ^ string_of_atom atom


(* Definitions *)

let rec string_of_prem prem =
  match prem.it with
  | RulePr (id, e) -> id.it ^ ": " ^ string_of_exp e
  | IfPr e -> "if " ^ string_of_exp e
  | ElsePr -> "otherwise"
  | IterPr ({it = IterPr _; _} as prem', iter) ->
    string_of_prem prem' ^ string_of_iter iter
  | IterPr (prem', iter) ->
    "(" ^ string_of_prem prem' ^ ")" ^ string_of_iter iter


let string_of_def d =
  match d.it with
  | SynD (id1, id2, t, _hints) ->
    let id2' = if id2.it = "" then "" else "/" ^ id2.it in
    "syntax " ^ id1.it ^ id2' ^ " = " ^ string_of_typ t
  | RelD (id, t, _hints) ->
    "relation " ^ id.it ^ ": " ^ string_of_typ t
  | RuleD (id1, id2, e, prems) ->
    let id2' = if id2.it = "" then "" else "/" ^ id2.it in
    "rule " ^ id1.it ^ id2' ^ ":\n  " ^ string_of_exp e ^
      concat "" (map_nl_list (prefix "\n  -- " string_of_prem) prems)
  | VarD (id, t, _hints) ->
    "var " ^ id.it ^ " : " ^ string_of_typ t
  | DecD (id, e1, t2, _hints) ->
    let s1 = match e1.it with SeqE [] -> "" | _ -> " " ^ string_of_exp e1 in
    "def " ^ id.it ^ s1 ^ " : " ^ string_of_typ t2
  | DefD (id, e1, e2, prems) ->
    let s1 = match e1.it with SeqE [] -> "" | _ -> " " ^ string_of_exp e1 in
    "def " ^ id.it ^ s1 ^ " = " ^ string_of_exp e2 ^
      concat "" (map_nl_list (prefix "\n  -- " string_of_prem) prems)
  | SepD ->
    "\n\n"
  | HintD _ -> ""


(* Scripts *)

let string_of_script ds =
  concat "" (List.map (suffix string_of_def "\n") ds)
