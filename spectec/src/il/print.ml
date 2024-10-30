open Util
open Source
open Ast
open Xl


(* Helpers *)

let concat = String.concat
let prefix s f x = s ^ f x
let space f x = " " ^ f x ^ " "


(* Identifiers *)

let is_alphanum = function
  | '0'..'9'
  | 'A'..'Z'
  | 'a'..'z'
  | '_' | '.' | '\'' -> true
  | _ -> false

let string_of_id id =
  if String.for_all is_alphanum id.it
  then id.it
  else "`" ^ id.it ^ "`"


(* Operators *)

let string_of_unop = function
  | #Bool.unop as op -> Bool.string_of_unop op
  | #Num.unop as op -> Num.string_of_unop op
  | `PlusMinusOp -> "+-"
  | `MinusPlusOp -> "-+"

let string_of_binop = function
  | #Bool.binop as op -> Bool.string_of_binop op
  | #Num.binop as op -> Num.string_of_binop op

let string_of_cmpop = function
  | #Bool.cmpop as op -> Bool.string_of_cmpop op
  | #Num.cmpop as op -> Num.string_of_cmpop op

let string_of_atom = Atom.to_string
let string_of_mixop = Mixop.to_string


(* Types *)

let rec string_of_iter iter =
  match iter with
  | Opt -> "?"
  | List -> "*"
  | List1 -> "+"
  | ListN (e, None) -> "^" ^ string_of_exp e
  | ListN (e, Some id) ->
    "^(" ^ string_of_id id ^ "<" ^ string_of_exp e ^ ")"

and string_of_numtyp t =
  match t with
  | Num.NatT -> "nat"
  | Num.IntT -> "int"
  | Num.RatT -> "rat"
  | Num.RealT -> "real"

and string_of_typ t =
  match t.it with
  | VarT (id, as1) -> string_of_id id ^ string_of_args as1
  | BoolT -> "bool"
  | NumT t -> string_of_numtyp t
  | TextT -> "text"
  | TupT ets -> "(" ^ concat ", " (List.map string_of_typbind ets) ^ ")"
  | IterT (t1, iter) -> string_of_typ t1 ^ string_of_iter iter

and string_of_typ_name t =
  match t.it with
  | VarT (id, _) -> string_of_id id
  | _ -> assert false

and string_of_typ_args t =
  match t.it with
  | TupT [] -> ""
  | TupT _ -> string_of_typ t
  | _ -> "(" ^ string_of_typ t ^ ")"

and string_of_typbind (e, t) =
  match e.it with
  | VarE {it = "_"; _} -> string_of_typ t
  | _ -> string_of_exp e ^ " : " ^ string_of_typ t

and string_of_deftyp layout dt =
  match dt.it with
  | AliasT t -> string_of_typ t
  | StructT tfs when layout = `H ->
    "{" ^ concat ", " (List.map string_of_typfield tfs) ^ "}"
  | StructT tfs ->
    "\n{\n  " ^ concat ",\n  " (List.map string_of_typfield tfs) ^ "\n}"
  | VariantT tcs when layout = `H ->
    "| " ^ concat " | " (List.map string_of_typcase tcs)
  | VariantT tcs ->
    "\n  | " ^ concat "\n  | " (List.map string_of_typcase tcs)

and string_of_typfield (atom, (bs, t, prems), _hints) =
  string_of_mixop [[atom]] ^ string_of_binds bs ^ " " ^ string_of_typ t ^
    concat "" (List.map (prefix "\n    -- " string_of_prem) prems)

and string_of_typcase (op, (bs, t, prems), _hints) =
  string_of_mixop op ^ string_of_binds bs ^ string_of_typ_args t ^
    concat "" (List.map (prefix "\n    -- " string_of_prem) prems)


(* Expressions *)

and string_of_exp e =
  match e.it with
  | VarE id -> string_of_id id
  | BoolE b -> string_of_bool b
  | NumE n -> Num.to_string n
  | TextE t -> "\"" ^ String.escaped t ^ "\""
  | UnE (op, _, e2) -> string_of_unop op ^ " " ^ string_of_exp e2
  | BinE (op, _, e1, e2) ->
    "(" ^ string_of_exp e1 ^ space string_of_binop op ^ string_of_exp e2 ^ ")"
  | CmpE (op, _, e1, e2) ->
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
      "[" ^ string_of_path p ^ " =++ " ^ string_of_exp e2 ^ "]"
  | StrE efs -> "{" ^ concat ", " (List.map string_of_expfield efs) ^ "}"
  | DotE (e1, atom) ->
    string_of_exp e1 ^ "." ^ string_of_mixop [[atom]] ^ "_" ^ string_of_typ_name e1.note
  | CompE (e1, e2) -> string_of_exp e1 ^ " +++ " ^ string_of_exp e2
  | MemE (e1, e2) -> string_of_exp e1 ^ " <- " ^ string_of_exp e2
  | LenE e1 -> "|" ^ string_of_exp e1 ^ "|"
  | TupE es -> "(" ^ string_of_exps ", " es ^ ")"
  | CallE (id, as1) -> "$" ^ string_of_id id ^ string_of_args as1
  | IterE (e1, iter) -> string_of_exp e1 ^ string_of_iterexp iter
  | ProjE (e1, i) -> string_of_exp e1 ^ "." ^ string_of_int i
  | UncaseE (e1, op) ->
    string_of_exp e1 ^ "!" ^ string_of_mixop op ^ "_" ^ string_of_typ_name e1.note
  | OptE eo -> "?(" ^ string_of_exps "" (Option.to_list eo) ^ ")"
  | TheE e1 -> "!(" ^ string_of_exp e1 ^ ")"
  | ListE es -> "[" ^ string_of_exps " " es ^ "]"
  | CatE (e1, e2) -> string_of_exp e1 ^ " ++ " ^ string_of_exp e2
  | CaseE (op, e1) ->
    string_of_mixop op ^ "_" ^ string_of_typ_name e.note ^ string_of_exp_args e1
  | CvtE (e1, nt1, nt2) ->
    "(" ^ string_of_exp e1 ^ " : " ^ string_of_numtyp nt1 ^ " <:> " ^ string_of_numtyp nt2 ^ ")"
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
  string_of_mixop [[atom]] ^ " " ^ string_of_exp e

and string_of_path p =
  match p.it with
  | RootP -> ""
  | IdxP (p1, e) ->
    string_of_path p1 ^ "[" ^ string_of_exp e ^ "]"
  | SliceP (p1, e1, e2) ->
    string_of_path p1 ^ "[" ^ string_of_exp e1 ^ " : " ^ string_of_exp e2 ^ "]"
  | DotP ({it = RootP; note; _}, atom) ->
    string_of_mixop [[atom]] ^ "_" ^ string_of_typ_name note
  | DotP (p1, atom) ->
    string_of_path p1 ^ "." ^ string_of_mixop [[atom]] ^ "_" ^ string_of_typ_name p1.note

and string_of_iterexp (iter, xes) =
  string_of_iter iter ^ "{" ^ String.concat ", "
    (List.map (fun (id, e) -> string_of_id id ^ " <- " ^ string_of_exp e) xes) ^ "}"


(* Grammars *)

and string_of_sym g =
  match g.it with
  | VarG (id, args) -> string_of_id id ^ string_of_args args
  | NumG n -> Printf.sprintf "0x%02X" n
  | TextG t -> "\"" ^ String.escaped t ^ "\""
  | EpsG -> "eps"
  | SeqG gs -> "{" ^ concat " " (List.map string_of_sym gs) ^ "}"
  | AltG gs -> "(" ^ concat " | " (List.map string_of_sym gs) ^ ")"
  | RangeG (g1, g2) -> string_of_sym g1 ^ " | ... | " ^ string_of_sym g2
  | IterG (g1, iter) -> string_of_sym g1 ^ string_of_iterexp iter
  | AttrG (e, g1) -> string_of_exp e ^ ":" ^ string_of_sym g1


(* Premises *)

and string_of_prem prem =
  match prem.it with
  | RulePr (id, mixop, e) ->
    string_of_id id ^ ": " ^ string_of_mixop mixop ^ string_of_exp_args e
  | IfPr e -> "if " ^ string_of_exp e
  | LetPr (e1, e2, ids) ->
    let ids' = List.map (fun x -> x $ no_region) ids in
    "where " ^ string_of_exp e1 ^ " = " ^ string_of_exp e2 ^
    " {" ^ (String.concat ", " (List.map string_of_id ids')) ^ "}"
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
  | DefA id -> "def $" ^ string_of_id id
  | GramA g -> "grammar " ^ string_of_sym g

and string_of_args = function
  | [] -> ""
  | as_ -> "(" ^ concat ", " (List.map string_of_arg as_) ^ ")"

and string_of_bind bind =
  match bind.it with
  | ExpB (id, t) -> string_of_id id ^ " : " ^ string_of_typ t
  | TypB id -> "syntax " ^ string_of_id id
  | DefB (id, ps, t) ->
    "def $" ^ string_of_id id ^ string_of_params ps ^ " : " ^ string_of_typ t
  | GramB (id, ps, t) ->
    "grammar " ^ string_of_id id ^ string_of_params ps ^ " : " ^ string_of_typ t

and string_of_binds = function
  | [] -> ""
  | bs -> "{" ^ concat ", " (List.map string_of_bind bs) ^ "}"

and string_of_param p =
  match p.it with
  | ExpP (id, t) ->
    (if string_of_id id = "_" then "" else string_of_id id ^ " : ") ^ string_of_typ t
  | TypP id ->
    "syntax " ^ string_of_id id
  | DefP (id, ps, t) ->
    "def $" ^ string_of_id id ^ string_of_params ps ^ " : " ^ string_of_typ t
  | GramP (id, t) ->
    "grammar " ^ string_of_id id ^ " : " ^ string_of_typ t

and string_of_params = function
  | [] -> ""
  | ps -> "(" ^ concat ", " (List.map string_of_param ps) ^ ")"

let region_comment ?(suppress_pos = false) indent at =
  if at = no_region then "" else
  let s = if suppress_pos then at.left.file else string_of_region at in
  indent ^ ";; " ^ s ^ "\n"

let string_of_inst ?(suppress_pos = false) id inst =
  match inst.it with
  | InstD (bs, as_, dt) ->
    "\n" ^ region_comment ~suppress_pos "  " inst.at ^
    "  syntax " ^ string_of_id id ^ string_of_binds bs ^ string_of_args as_ ^ " = " ^
      string_of_deftyp `V dt ^ "\n"

let string_of_rule ?(suppress_pos = false) rule =
  match rule.it with
  | RuleD (id, bs, mixop, e, prems) ->
    let id' = if id.it = "" then "_" else string_of_id id in
    "\n" ^ region_comment ~suppress_pos "  " rule.at ^
    "  rule " ^ id' ^ string_of_binds bs ^ ":\n    " ^
      string_of_mixop mixop ^ string_of_exp_args e ^
      concat "" (List.map (prefix "\n    -- " string_of_prem) prems)

let string_of_clause ?(suppress_pos = false) id clause =
  match clause.it with
  | DefD (bs, as_, e, prems) ->
    "\n" ^ region_comment ~suppress_pos "  " clause.at ^
    "  def $" ^ string_of_id id ^ string_of_binds bs ^ string_of_args as_ ^ " = " ^
      string_of_exp e ^
      concat "" (List.map (prefix "\n    -- " string_of_prem) prems)

let string_of_prod ?(suppress_pos = false) prod =
  match prod.it with
  | ProdD (bs, g, e, prems) ->
    "\n" ^ region_comment ~suppress_pos "  " prod.at ^
    "  prod" ^ string_of_binds bs ^ " " ^ string_of_sym g ^ " => " ^
      string_of_exp e ^
      concat "" (List.map (prefix "\n    -- " string_of_prem) prems)

let rec string_of_def ?(suppress_pos = false) d =
  let pre = "\n" ^ region_comment ~suppress_pos "" d.at in
  match d.it with
  | TypD (id, _ps, [{it = InstD (bs, as_, dt); _}]) ->
    pre ^ "syntax " ^ string_of_id id ^ string_of_binds bs ^ string_of_args as_ ^ " = " ^
      string_of_deftyp `V dt ^ "\n"
  | TypD (id, ps, insts) ->
    pre ^ "syntax " ^ string_of_id id ^ string_of_params ps ^
     concat "\n" (List.map (string_of_inst ~suppress_pos id) insts) ^ "\n"
  | RelD (id, mixop, t, rules) ->
    pre ^ "relation " ^ string_of_id id ^ ": " ^
    string_of_mixop mixop ^ string_of_typ_args t ^
      concat "\n" (List.map (string_of_rule ~suppress_pos) rules) ^ "\n"
  | DecD (id, ps, t, clauses) ->
    pre ^ "def $" ^ string_of_id id ^ string_of_params ps ^ " : " ^ string_of_typ t ^
      concat "" (List.map (string_of_clause ~suppress_pos id) clauses) ^ "\n"
  | GramD (id, ps, t, prods) ->
    pre ^ "grammar " ^ string_of_id id ^ string_of_params ps ^ " : " ^ string_of_typ t ^
      concat "" (List.map (string_of_prod ~suppress_pos) prods) ^ "\n"
  | RecD ds ->
    pre ^ "rec {\n" ^ concat "" (List.map string_of_def ds) ^ "}" ^ "\n"
  | HintD _ ->
    ""


(* Scripts *)

let string_of_script ?(suppress_pos = false) ds =
  concat "" (List.map (string_of_def ~suppress_pos) ds)
