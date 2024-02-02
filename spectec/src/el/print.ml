open Util.Source
open Ast
open Convert


(* Helpers *)

let concat = String.concat
let prefix s f x = s ^ f x
let suffix f s x = f x ^ s
let space f x = " " ^ f x ^ " "


(* Operators *)

let string_of_atom atom =
  match atom.it with
  | Atom atomid -> atomid
  | Infinity -> "infinity"
  | Bot -> "_|_"
  | Top -> "^|^"
  | Dot -> "."
  | Dot2 -> ".."
  | Dot3 -> "..."
  | Semicolon -> ";"
  | Backslash -> "\\"
  | In -> "<-"
  | Arrow -> "->"
  | Arrow2 -> "`=>"
  | Colon -> ":"
  | Sub -> "<:"
  | Sup -> ":>"
  | Assign -> ":="
  | Equiv -> "=="
  | Approx -> "~~"
  | SqArrow -> "~>"
  | SqArrowStar -> "~>*"
  | Prec -> "<<"
  | Succ -> ">>"
  | Tilesturn -> "-|"
  | Turnstile -> "|-"
  | Quest -> "`?"
  | Plus -> "`+"
  | Star -> "`*"
  | Comma -> "`,"
  | Bar -> "`|"
  | LParen -> "`("
  | RParen -> "`)"
  | LBrack -> "`["
  | RBrack -> "`]"
  | LBrace -> "`{"
  | RBrace -> "`}"

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

and string_of_numtyp = function
  | NatT -> "nat"
  | IntT -> "int"
  | RatT -> "rat"
  | RealT -> "real"

and string_of_typ t =
  match t.it with
  | VarT (id, args) -> id.it ^ string_of_args args
  | BoolT -> "bool"
  | NumT t -> string_of_numtyp t
  | TextT -> "text"
  | ParenT t -> "(" ^ string_of_typ t ^ ")"
  | TupT ts -> "(" ^ string_of_typs ", " ts ^ ")"
  | IterT (t1, iter) -> string_of_typ t1 ^ string_of_iter iter
  | StrT tfs ->
    "{" ^ concat ", " (map_filter_nl_list string_of_typfield tfs) ^ "}"
  | CaseT (dots1, ts, tcases, dots2) ->
    "| " ^ concat " | "
      (strings_of_dots dots1 @ map_filter_nl_list string_of_typ ts @
        map_filter_nl_list string_of_typcase tcases @ strings_of_dots dots2)
  | RangeT tes -> concat " | " (map_filter_nl_list string_of_typenum tes)
  | AtomT atom -> string_of_atom atom
  | SeqT ts -> "{" ^ string_of_typs " " ts ^ "}"
  | InfixT (t1, atom, t2) ->
    string_of_typ t1 ^ space string_of_atom atom ^ string_of_typ t2
  | BrackT (l, t1, r) ->
    "`" ^ string_of_atom l ^ string_of_typ t1 ^ string_of_atom r

and string_of_typs sep ts =
  concat sep (List.map string_of_typ ts)

and string_of_typfield (atom, (t, prems), _hints) =
  string_of_atom atom ^ " " ^ string_of_typ t ^
    concat "" (map_filter_nl_list (prefix "\n  -- " string_of_prem) prems)

and string_of_typcase (_atom, (t, prems), _hints) =
  string_of_typ t ^
    concat "" (map_filter_nl_list (prefix "\n  -- " string_of_prem) prems)

and string_of_typenum (e, eo) =
  string_of_exp e ^
  match eo with
  | None -> ""
  | Some e2 -> " | ... | " ^ string_of_exp e2


(* Expressions *)

and string_of_exp e =
  match e.it with
  | VarE (id, args) -> id.it ^ string_of_args args
  | AtomE atom -> string_of_atom atom
  | BoolE b -> string_of_bool b
  | NatE (DecOp, n) -> string_of_int n
  | NatE (HexOp, n) -> Printf.sprintf "0x%X" n
  | NatE (CharOp, n) -> Printf.sprintf "U+%X" n
  | TextE t -> "\"" ^ String.escaped t ^ "\""
  | UnE (op, e2) -> string_of_unop op ^ " " ^ string_of_exp e2
  | BinE (e1, op, e2) ->
    string_of_exp e1 ^ space string_of_binop op ^ string_of_exp e2
  | CmpE (e1, op, e2) ->
    string_of_exp e1 ^ space string_of_cmpop op ^ string_of_exp e2
  | EpsE -> "eps"
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
  | StrE efs -> "{" ^ concat ", " (map_filter_nl_list string_of_expfield efs) ^ "}"
  | DotE (e1, atom) -> string_of_exp e1 ^ "." ^ string_of_atom atom
  | CommaE (e1, e2) -> string_of_exp e1 ^ ", " ^ string_of_exp e2
  | CompE (e1, e2) -> string_of_exp e1 ^ " ++ " ^ string_of_exp e2
  | LenE e1 -> "|" ^ string_of_exp e1 ^ "|"
  | SizeE id -> "||" ^ id.it ^ "||"
  | ParenE (e, signif) -> "(" ^ string_of_exp e ^ ")" ^ (if signif then "!" else "")
  | TupE es -> "(" ^ string_of_exps ", " es ^ ")"
  | InfixE (e1, atom, e2) ->
    string_of_exp e1 ^ space string_of_atom atom ^ string_of_exp e2
  | BrackE (l, e1, r) ->
    "`" ^ string_of_atom l ^ string_of_exp e1 ^ string_of_atom r
  | CallE (id, args) -> "$" ^ id.it ^ string_of_args args
  | IterE (e1, iter) -> string_of_exp e1 ^ string_of_iter iter
  | TypE (e1, t) -> string_of_exp e1 ^ " : " ^ string_of_typ t
  | HoleE (`Use, `Num i) -> "%" ^ string_of_int i
  | HoleE (`Use, `Next) -> "%"
  | HoleE (`Use, `Rest) -> "%%"
  | HoleE (`Skip, `Num i) -> "!%" ^ string_of_int i
  | HoleE (`Skip, `Next) -> "!%"
  | HoleE (`Skip, `Rest) -> "!%%"
  | FuseE (e1, e2) -> string_of_exp e1 ^ "#" ^ string_of_exp e2

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


(* Premises *)

and string_of_prem prem =
  match prem.it with
  | RulePr (id, e) -> id.it ^ ": " ^ string_of_exp e
  | IfPr e -> "if " ^ string_of_exp e
  | ElsePr -> "otherwise"
  | IterPr ({it = IterPr _; _} as prem', iter) ->
    string_of_prem prem' ^ string_of_iter iter
  | IterPr (prem', iter) ->
    "(" ^ string_of_prem prem' ^ ")" ^ string_of_iter iter


(* Grammars *)

and string_of_sym g =
  match g.it with
  | VarG (id, args) -> id.it ^ string_of_args args
  | NatG (DecOp, n) -> string_of_int n
  | NatG (HexOp, n) -> Printf.sprintf "0x%X" n
  | NatG (CharOp, n) -> Printf.sprintf "U+%X" n
  | TextG t -> "\"" ^ String.escaped t ^ "\""
  | EpsG -> "eps"
  | SeqG gs -> "{" ^ concat " " (map_filter_nl_list string_of_sym gs) ^ "}"
  | AltG gs -> concat " | " (map_filter_nl_list string_of_sym gs)
  | RangeG (g1, g2) -> string_of_sym g1 ^ " | ... | " ^ string_of_sym g2
  | ParenG g -> "(" ^ string_of_sym g ^ ")"
  | TupG gs -> "(" ^ concat ", " (List.map string_of_sym gs) ^ ")"
  | IterG (g1, iter) -> string_of_sym g1 ^ string_of_iter iter
  | ArithG e -> string_of_exp e
  | AttrG (e, g1) -> string_of_exp e ^ ":" ^ string_of_sym g1
  | FuseG (g1, g2) -> string_of_sym g1 ^ "#" ^ string_of_sym g2

and string_of_prod prod =
  let (g, e, prems) = prod.it in
  string_of_sym g ^ " => " ^ string_of_exp e ^
    concat "" (map_filter_nl_list (prefix "\n  -- " string_of_prem) prems)

and string_of_gram gram =
  let (dots1, prods, dots2) = gram.it in
  "\n  | " ^ concat "\n  | "
    (strings_of_dots dots1 @ map_filter_nl_list string_of_prod prods @
      strings_of_dots dots2)


(* Definitions *)

and string_of_arg a =
  match !(a.it) with
  | ExpA e -> string_of_exp e
  | SynA t -> "syntax " ^ string_of_typ t
  | GramA g -> "grammar " ^ string_of_sym g

and string_of_args = function
  | [] -> ""
  | args -> "(" ^ concat ", " (List.map string_of_arg args) ^ ")"

let string_of_param p =
  match p.it with
  | ExpP (id, t) -> (if id.it = "" then "" else id.it ^ " : ") ^ string_of_typ t
  | SynP id -> "syntax " ^ id.it
  | GramP (id, t) -> "grammar " ^ id.it ^ " : " ^ string_of_typ t

let string_of_params = function
  | [] -> ""
  | ps -> "(" ^ concat ", " (List.map string_of_param ps) ^ ")"

let string_of_def d =
  match d.it with
  | FamD (id, ps, _hints) ->
    "syntax " ^ id.it ^ string_of_params ps
  | SynD (id1, id2, args, t, _hints) ->
    let id2' = if id2.it = "" then "" else "/" ^ id2.it in
    "syntax " ^ id1.it ^ id2' ^ string_of_args args ^ " = " ^ string_of_typ t
  | GramD (id1, id2, ps, t, gram, _hints) ->
    let id2' = if id2.it = "" then "" else "/" ^ id2.it in
    "grammar " ^ id1.it ^ id2' ^ string_of_params ps ^
      " : " ^ string_of_typ t ^ " = " ^ string_of_gram gram
  | RelD (id, t, _hints) ->
    "relation " ^ id.it ^ ": " ^ string_of_typ t
  | RuleD (id1, id2, e, prems) ->
    let id2' = if id2.it = "" then "" else "/" ^ id2.it in
    "rule " ^ id1.it ^ id2' ^ ":\n  " ^ string_of_exp e ^
      concat "" (map_filter_nl_list (prefix "\n  -- " string_of_prem) prems)
  | VarD (id, t, _hints) ->
    "var " ^ id.it ^ " : " ^ string_of_typ t
  | DecD (id, ps, t, _hints) ->
    "def " ^ id.it ^ string_of_params ps ^ " : " ^ string_of_typ t
  | DefD (id, args, e, prems) ->
    "def " ^ id.it ^ string_of_args args ^ " = " ^ string_of_exp e ^
      concat "" (map_filter_nl_list (prefix "\n  -- " string_of_prem) prems)
  | SepD ->
    "\n\n"
  | HintD _ -> ""


(* Scripts *)

let string_of_script ds =
  concat "" (List.map (suffix string_of_def "\n") ds)
