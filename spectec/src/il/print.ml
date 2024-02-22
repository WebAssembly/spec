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
  | Infinity -> "infinity"
  | Bot -> "_|_"
  | Top -> "^|^"
  | Dot -> "."
  | Dot2 -> ".."
  | Dot3 -> "..."
  | Semicolon -> ";"
  | Backslash -> "\\"
  | In -> "in"
  | Arrow -> "->"
  | Arrow2 -> "=>"
  | Colon -> ":"
  | Sub -> "<:"
  | Sup -> ":>"
  | Assign -> ":="
  | Equal -> "="
  | Equiv -> "=="
  | Approx -> "~~"
  | SqArrow -> "~>"
  | SqArrowStar -> "~>*"
  | Prec -> "<<"
  | Succ -> ">>"
  | Tilesturn -> "-|"
  | Turnstile -> "|-"
  | Quest -> "?"
  | Plus -> "+"
  | Star -> "*"
  | Comma -> ","
  | Comp -> "++"
  | Bar -> "|"
  | BigComp -> "(++)"
  | BigAnd -> "(/\\)"
  | BigOr -> "(\\/)"
  | LParen -> "("
  | LBrack -> "["
  | LBrace -> "{"
  | RParen -> ")"
  | RBrack -> "]"
  | RBrace -> "}"

let string_of_unop = function
  | NotOp -> "~"
  | PlusOp _ -> "+"
  | MinusOp _ -> "-"
  | PlusMinusOp _ -> "+-"
  | MinusPlusOp _ -> "-+"

let string_of_binop = function
  | AndOp -> "/\\"
  | OrOp -> "\\/"
  | ImplOp -> "=>"
  | EquivOp -> "<=>"
  | AddOp _ -> "+"
  | SubOp _ -> "-"
  | MulOp _ -> "*"
  | DivOp _ -> "/"
  | ExpOp _ -> "^"

let string_of_cmpop = function
  | EqOp -> "="
  | NeOp -> "=/="
  | LtOp _ -> "<"
  | GtOp _ -> ">"
  | LeOp _ -> "<="
  | GeOp _ -> ">="

let string_of_mixop = function
  | [Atom a]::tail when List.for_all ((=) []) tail -> a
  | mixop ->
    let s =
      String.concat "%" (List.map (
        fun atoms -> String.concat "_" (List.map string_of_atom atoms)) mixop
      )
    in
    "`" ^ s ^ "`"


(* Types *)

let rec string_of_iter iter =
  match iter with
  | Opt -> "?"
  | List -> "*"
  | List1 -> "+"
  | ListN (e, None) -> "^" ^ string_of_exp e
  | ListN (e, Some id) ->
    "^(" ^ id.it ^ "<" ^ string_of_exp e ^ ")"

and string_of_numtyp t =
  match t with
  | NatT -> "nat"
  | IntT -> "int"
  | RatT -> "rat"
  | RealT -> "real"

and string_of_typ t =
  match t.it with
  | VarT (id, as1) -> id.it ^ string_of_args as1
  | BoolT -> "bool"
  | NumT t -> string_of_numtyp t
  | TextT -> "text"
  | TupT xts -> "(" ^ concat ", " (List.map string_of_typbind xts) ^ ")"
  | IterT (t1, iter) -> string_of_typ t1 ^ string_of_iter iter

and string_of_typ_args t =
  match t.it with
  | TupT [] -> ""
  | TupT _ -> string_of_typ t
  | _ -> "(" ^ string_of_typ t ^ ")"

and string_of_typbind (id, t) =
  (if id.it = "_" then "" else id.it ^ " : ") ^ string_of_typ t

and string_of_deftyp layout dt =
  match dt.it with
  | AliasT t -> string_of_typ t
  | NotationT (mixop, t) -> string_of_typ_mix mixop t
  | StructT tfs when layout = `H ->
    "{" ^ concat ", " (List.map string_of_typfield tfs) ^ "}"
  | StructT tfs ->
    "\n{\n  " ^ concat ",\n  " (List.map string_of_typfield tfs) ^ "\n}"
  | VariantT tcs when layout = `H ->
    "| " ^ concat " | " (List.map string_of_typcase tcs)
  | VariantT tcs ->
    "\n  | " ^ concat "\n  | " (List.map string_of_typcase tcs)

and string_of_typ_mix mixop t =
  if mixop = [[]; []] then string_of_typ t else
  string_of_mixop mixop ^ string_of_typ_args t

and string_of_typfield (atom, (bs, t, prems), _hints) =
  string_of_atom atom ^ string_of_binds bs ^ " " ^ string_of_typ t ^
    concat "" (List.map (prefix "\n    -- " string_of_prem) prems)

and string_of_typcase (atom, (bs, t, prems), _hints) =
  string_of_atom atom ^ string_of_binds bs ^ string_of_typ_args t ^
    concat "" (List.map (prefix "\n    -- " string_of_prem) prems)


(* Expressions *)

and string_of_exp e =
  match e.it with
  | VarE id -> id.it
  | BoolE b -> string_of_bool b
  | NatE n -> Z.to_string n
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
  | CallE (id, as1) -> "$" ^ id.it ^ string_of_args as1
  | IterE (e1, iter) -> string_of_exp e1 ^ string_of_iterexp iter
  | ProjE (e1, i) -> string_of_exp e1 ^ "." ^ string_of_int i
  | OptE eo -> "?(" ^ string_of_exps "" (Option.to_list eo) ^ ")"
  | TheE e1 -> "!(" ^ string_of_exp e1 ^ ")"
  | ListE es -> "[" ^ string_of_exps " " es ^ "]"
  | CatE (e1, e2) -> string_of_exp e1 ^ " :: " ^ string_of_exp e2
  | CaseE (atom, e1) ->
    string_of_atom atom ^ "_" ^ string_of_typ e.note ^ string_of_exp_args e1
  | SubE (e1, t1, t2) ->
    "(" ^ string_of_exp e1 ^ " : " ^ string_of_typ t1 ^ " <: " ^ string_of_typ t2 ^ ")"

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


(* Premises *)

and string_of_prem prem =
  match prem.it with
  | RulePr (id, op, e) -> id.it ^ ": " ^ string_of_exp {e with it = MixE (op, e)}
  | IfPr e -> "if " ^ string_of_exp e
  | LetPr (e1, e2, _ids) -> "where " ^ string_of_exp e1 ^ " = " ^ string_of_exp e2
  | ElsePr -> "otherwise"
  | IterPr ({it = IterPr _; _} as prem', iter) ->
    string_of_prem prem' ^ string_of_iterexp iter
  | IterPr (prem', iter) ->
    "(" ^ string_of_prem prem' ^ ")" ^ string_of_iterexp iter


(* Definitions *)

and string_of_arg a =
  match a.it with
  | ExpA e -> string_of_exp e
  | TypA t -> "syntax " ^ string_of_typ t

and string_of_args = function
  | [] -> ""
  | as_ -> "(" ^ concat ", " (List.map string_of_arg as_) ^ ")"

and string_of_bind bind =
  match bind.it with
  | ExpB (id, t, iters) ->
    let dim = String.concat "" (List.map string_of_iter iters) in
    id.it ^ dim ^ " : " ^ string_of_typ t ^ dim
  | TypB id -> "syntax " ^ id.it

and string_of_binds = function
  | [] -> ""
  | bs -> "{" ^ concat ", " (List.map string_of_bind bs) ^ "}"

let string_of_param p =
  match p.it with
  | ExpP (id, t) -> (if id.it = "_" then "" else id.it ^ " : ") ^ string_of_typ t
  | TypP id -> "syntax " ^ id.it

let string_of_params = function
  | [] -> ""
  | ps -> "(" ^ concat ", " (List.map string_of_param ps) ^ ")"

let region_comment indent at =
  if at = no_region then "" else
  indent ^ ";; " ^ string_of_region at ^ "\n"

let string_of_inst id inst =
  match inst.it with
  | InstD (bs, as_, dt) ->
    "\n" ^ region_comment "  " inst.at ^
    "  syntax " ^ id.it ^ string_of_binds bs ^ string_of_args as_ ^ " = " ^
      string_of_deftyp `V dt ^ "\n"

let string_of_rule rule =
  match rule.it with
  | RuleD (id, bs, mixop, e, prems) ->
    let id' = if id.it = "" then "_" else id.it in
    "\n" ^ region_comment "  " rule.at ^
    "  rule " ^ id' ^ string_of_binds bs ^ ":\n    " ^
      string_of_exp {e with it = MixE (mixop, e)} ^
      concat "" (List.map (prefix "\n    -- " string_of_prem) prems)

let string_of_clause id clause =
  match clause.it with
  | DefD (bs, as_, e, prems) ->
    "\n" ^ region_comment "  " clause.at ^
    "  def $" ^ id.it ^ string_of_binds bs ^ string_of_args as_ ^ " = " ^
      string_of_exp e ^
      concat "" (List.map (prefix "\n    -- " string_of_prem) prems)

let rec string_of_def d =
  let pre = "\n" ^ region_comment "" d.at in
  match d.it with
  | TypD (id, _ps, [{it = InstD (bs, as_, dt); _}]) ->
    pre ^ "syntax " ^ id.it ^ string_of_binds bs ^ string_of_args as_ ^ " = " ^
      string_of_deftyp `V dt ^ "\n"
  | TypD (id, ps, insts) ->
    pre ^ "syntax " ^ id.it ^ string_of_params ps ^
     concat "\n" (List.map (string_of_inst id) insts) ^ "\n"
  | RelD (id, mixop, t, rules) ->
    pre ^ "relation " ^ id.it ^ ": " ^ string_of_typ_mix mixop t ^
      concat "\n" (List.map string_of_rule rules) ^ "\n"
  | DecD (id, ps, t, clauses) ->
    pre ^ "def $" ^ id.it ^ string_of_params ps ^ " : " ^ string_of_typ t ^
      concat "" (List.map (string_of_clause id) clauses) ^ "\n"
  | RecD ds ->
    pre ^ "rec {\n" ^ concat "" (List.map string_of_def ds) ^ "}" ^ "\n"
  | HintD _ ->
    ""


(* Scripts *)

let string_of_script ds =
  concat "" (List.map string_of_def ds)
