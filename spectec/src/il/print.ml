open Util
open Source
open Ast


(* Helpers *)

let concat = String.concat
let prefix s f x = s ^ f x
let suffix f s x = f x ^ s
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
  | NotationT (mixop, t) -> string_of_typmix (mixop, t)
  | StructT tfs -> "{" ^ concat ", " (List.map string_of_typfield tfs) ^ "}"
  | VariantT (ids, tcases) ->
    "\n  | " ^ concat "\n  | "
      (List.map it ids @ List.map string_of_typcase tcases)

and string_of_typmix (mixop, t) =
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
  | DotE (t, e1, atom) ->
    string_of_exp e1 ^ "." ^ string_of_atom atom ^ "_" ^ string_of_typ t
  | CompE (e1, e2) -> string_of_exp e1 ^ " ++ " ^ string_of_exp e2
  | LenE e1 -> "|" ^ string_of_exp e1 ^ "|"
  | TupE es -> "(" ^ string_of_exps ", " es ^ ")"
  | MixE (op, e1) -> string_of_mixop op ^ string_of_exp_args e1
  | CallE (id, e) -> "$" ^ id.it ^ string_of_exp_args e
  | IterE (e1, iter) -> string_of_exp e1 ^ string_of_iterexp iter
  | OptE eo -> "?(" ^ string_of_exps "" (Option.to_list eo) ^ ")"
  | ListE es -> "[" ^ string_of_exps " " es ^ "]"
  | CatE (e1, e2) -> string_of_exp e1 ^ " :: " ^ string_of_exp e2
  | CaseE (atom, e1, t) ->
    string_of_atom atom ^ "_" ^ string_of_typ t ^ string_of_exp_args e1
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
  | IdxP (p1, e) -> string_of_path p1 ^ "[" ^ string_of_exp e ^ "]"
  | DotP ({it = RootP; _}, atom) -> string_of_atom atom
  | DotP (p1, atom) -> string_of_path p1 ^ "." ^ string_of_atom atom

and string_of_iterexp (iter, ids) =
  string_of_iter iter ^ "{" ^ String.concat " " (List.map Source.it ids) ^ "}"


(* Definitions *)

let string_of_bind (id, t, iters) =
  let dim = String.concat "" (List.map string_of_iter iters) in
  id.it ^ dim ^ " : " ^ string_of_typ t ^ dim

let string_of_binds = function
  | [] -> ""
  | binds -> " {" ^ concat ", " (List.map string_of_bind binds) ^ "}"


let string_of_premise prem =
  match prem.it with
  | RulePr (id, op, e, []) ->
    id.it ^ ": " ^ string_of_exp (MixE (op, e) $ e.at)
  | RulePr (id, op, e, iters) ->
    "(" ^ id.it ^ ": " ^ string_of_exp (MixE (op, e) $ e.at) ^ ")" ^
      String.concat "" (List.map string_of_iterexp iters)
  | IfPr (e, []) -> "if " ^ string_of_exp e
  | IfPr (e, iters) ->
    "(" ^ "if " ^ string_of_exp e ^ ")" ^
      String.concat "" (List.map string_of_iterexp iters)
  | ElsePr -> "otherwise"

let string_of_rule rule =
  match rule.it with
  | RuleD (id, binds, mixop, e, prems) ->
    let id' = if id.it = "" then "_" else id.it in
    "\n  ;; " ^ string_of_region rule.at ^ "\n" ^
    "  rule " ^ id' ^ string_of_binds binds ^ ":\n    " ^
      string_of_exp (MixE (mixop, e) $ e.at) ^
      concat "" (List.map (prefix "\n    -- " string_of_premise) prems)

let string_of_clause id clause =
  match clause.it with
  | DefD (binds, e1, e2, prems) ->
    "\n  ;; " ^ string_of_region clause.at ^ "\n" ^
    "  def" ^ string_of_binds binds ^ " " ^ id.it ^ string_of_exp_args e1 ^ " = " ^
      string_of_exp e2 ^
      concat "" (List.map (prefix "\n    -- " string_of_premise) prems)

let rec string_of_def d =
  "\n;; " ^ string_of_region d.at ^ "\n" ^
  match d.it with
  | SynD (id, dt, _hints) ->
    "syntax " ^ id.it ^ " = " ^ string_of_deftyp dt
  | RelD (id, mixop, t, rules, _hints) ->
    "relation " ^ id.it ^ ": " ^ string_of_typmix (mixop, t) ^
      concat "\n" (List.map string_of_rule rules)
  | DecD (id, t1, t2, clauses, _hints) ->
    let s1 =
      match t1.it with
      | TupT [] -> ""
      | _ -> string_of_typ t1 ^ " -> "
    in
    "def " ^ id.it ^ " : " ^ s1 ^ string_of_typ t2 ^
      concat "" (List.map (string_of_clause id) clauses)
  | RecD ds ->
    "rec {\n" ^ concat "\n" (List.map string_of_def ds) ^ "\n}"


(* Scripts *)

let string_of_script ds =
  concat "" (List.map (suffix string_of_def "\n") ds)
