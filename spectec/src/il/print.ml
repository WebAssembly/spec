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

let string_of_id x =
  if String.for_all is_alphanum x.it
  then x.it
  else "`" ^ x.it ^ "`"


(* Operators *)

let string_of_unop = function
  | #Bool.unop as op -> Bool.string_of_unop op
  | #Num.unop as op -> Num.string_of_unop op

let string_of_binop = function
  | #Bool.binop as op -> Bool.string_of_binop op
  | #Num.binop as op -> Num.string_of_binop op

let string_of_cmpop = function
  | #Bool.cmpop as op -> Bool.string_of_cmpop op
  | #Num.cmpop as op -> Num.string_of_cmpop op

let string_of_atom = Atom.to_string
let string_of_mixop mixop = "`" ^ Mixop.to_string mixop ^ "`"


(* Types *)

let rec string_of_iter iter =
  match iter with
  | Opt -> "?"
  | List -> "*"
  | List1 -> "+"
  | ListN (e, None) -> "^" ^ string_of_exp e
  | ListN (e, Some x) -> "^(" ^ string_of_id x ^ "<" ^ string_of_exp e ^ ")"

and string_of_numtyp = Num.string_of_typ

and string_of_typ t =
  match t.it with
  | VarT (x, as1) -> string_of_id x ^ string_of_args as1
  | BoolT -> "bool"
  | NumT t -> string_of_numtyp t
  | TextT -> "text"
  | TupT xts -> "(" ^ concat ", " (List.map string_of_typbind xts) ^ ")"
  | IterT (t1, iter) -> string_of_typ t1 ^ string_of_iter iter

and string_of_typ_name t =
  match t.it with
  | VarT (x, _) -> string_of_id x
  | _ -> assert false

and string_of_typ_args t =
  match t.it with
  | TupT [] -> ""
  | TupT _ -> string_of_typ t
  | _ -> "(" ^ string_of_typ t ^ ")"

and string_of_typbind (x, t) =
  match x.it with
  | "_" -> string_of_typ t
  | _ -> string_of_id x ^ " : " ^ string_of_typ t

and string_of_deftyp layout dt =
  match dt.it with
  | AliasT t -> string_of_typ t
  | StructT tfs when layout = `H ->
    "{" ^ concat ", " (List.map (string_of_typfield layout) tfs) ^ "}"
  | StructT tfs ->
    "\n{\n  " ^ concat ",\n  " (List.map (string_of_typfield layout) tfs) ^ "\n}"
  | VariantT tcs when layout = `H ->
    "| " ^ concat " | " (List.map (string_of_typcase layout) tcs)
  | VariantT tcs ->
    "\n  | " ^ concat "\n  | " (List.map (string_of_typcase layout) tcs)

and string_of_typfield layout (atom, (qs, t, prems), _hints) =
  string_of_mixop (Mixop.Atom atom) ^
  string_of_quants qs ^ " " ^ string_of_typ t ^
  if layout = `H && prems <> [] then " -- .." else
    concat "" (List.map (prefix "\n    -- " string_of_prem) prems)

and string_of_typcase layout (op, (qs, t, prems), _hints) =
  string_of_mixop op ^ string_of_quants qs ^ string_of_typ_args t ^
  if layout = `H && prems <> [] then " -- .." else
    concat "" (List.map (prefix "\n    -- " string_of_prem) prems)


(* Expressions *)

and string_of_exp e =
"(" ^ (
  match e.it with
  | VarE x -> string_of_id x
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
  | DotE (e1, atom, as_) ->
    string_of_exp e1 ^ "." ^
    string_of_mixop (Mixop.Atom atom) ^ "_" ^ string_of_typ_name e1.note ^
    string_of_quantargs as_
  | CompE (e1, e2) -> string_of_exp e1 ^ " +++ " ^ string_of_exp e2
  | MemE (e1, e2) -> "(" ^ string_of_exp e1 ^ " <- " ^ string_of_exp e2 ^ ")"
  | LenE e1 -> "|" ^ string_of_exp e1 ^ "|"
  | TupE es -> "(" ^ string_of_exps ", " es ^ ")"
  | CallE (x, as1) -> "$" ^ string_of_id x ^ string_of_args as1
  | IterE (e1, iter) -> string_of_exp e1 ^ string_of_iterexp iter
  | ProjE (e1, i) -> string_of_exp e1 ^ "." ^ string_of_int i
  | UncaseE (e1, op, as_) ->
    string_of_exp e1 ^ "!" ^
    string_of_mixop op ^ "_" ^ string_of_typ_name e1.note ^
    string_of_quantargs as_
  | OptE eo -> "?(" ^ string_of_exps "" (Option.to_list eo) ^ ")"
  | TheE e1 -> "!(" ^ string_of_exp e1 ^ ")"
  | ListE es -> "[" ^ string_of_exps " " es ^ "]"
  | LiftE e1 -> "lift(" ^ string_of_exp e1 ^ ")"
  | CatE (e1, e2) -> string_of_exp e1 ^ " ++ " ^ string_of_exp e2
  | CaseE (op, as_, e1) ->
    string_of_mixop op ^ "_" ^ string_of_typ_name e.note ^
    string_of_quantargs as_ ^
    string_of_exp_args e1
  | CvtE (e1, nt1, nt2) ->
    "(" ^ string_of_exp e1 ^ " : " ^ string_of_numtyp nt1 ^ " <:> " ^ string_of_numtyp nt2 ^ ")"
  | SubE (e1, t1, t2) ->
    "(" ^ string_of_exp e1 ^ " : " ^ string_of_typ t1 ^ " <: " ^ string_of_typ t2 ^ ")"
) ^ ")@[" ^ string_of_typ e.note ^ "]"

and string_of_exp_args e =
  match e.it with
  | TupE [] -> ""
  | TupE _ | SubE _ | BinE _ | CmpE _ -> string_of_exp e
  | _ -> "(" ^ string_of_exp e ^ ")"

and string_of_exps sep es =
  concat sep (List.map string_of_exp es)

and string_of_expfield (atom, as_, e) =
  string_of_mixop (Mixop.Atom atom) ^
  string_of_quantargs as_ ^
  " " ^ string_of_exp e

and string_of_path p =
  match p.it with
  | RootP -> ""
  | IdxP (p1, e) ->
    string_of_path p1 ^ "[" ^ string_of_exp e ^ "]"
  | SliceP (p1, e1, e2) ->
    string_of_path p1 ^ "[" ^ string_of_exp e1 ^ " : " ^ string_of_exp e2 ^ "]"
  | DotP ({it = RootP; note; _}, atom, as_) ->
    string_of_mixop (Mixop.Atom atom) ^ "_" ^ string_of_typ_name note ^
    string_of_quantargs as_
  | DotP (p1, atom, as_) ->
    string_of_path p1 ^ "." ^
    string_of_mixop (Mixop.Atom atom) ^ "_" ^ string_of_typ_name p1.note ^
    string_of_quantargs as_

and string_of_iterexp (iter, xes) =
  string_of_iter iter ^ "{" ^ String.concat ", "
    (List.map (fun (x, e) -> string_of_id x ^ " <- " ^ string_of_exp e) xes) ^ "}"


(* Grammars *)

and string_of_sym g =
  match g.it with
  | VarG (x, args) -> string_of_id x ^ string_of_args args
  | NumG n -> Printf.sprintf "0x%02X" n
  | TextG t -> "\"" ^ String.escaped t ^ "\""
  | EpsG -> "eps"
  | SeqG gs -> "{" ^ concat " " (List.map string_of_sym gs) ^ "}"
  | AltG gs -> "(" ^ concat " | " (List.map string_of_sym gs) ^ ")"
  | RangeG (g1, g2) -> "(" ^ string_of_sym g1 ^ " | ... | " ^ string_of_sym g2 ^ ")"
  | IterG (g1, iter) -> string_of_sym g1 ^ string_of_iterexp iter
  | AttrG (e, g1) -> string_of_exp e ^ ":" ^ string_of_sym g1


(* Premises *)

and string_of_prem prem =
  match prem.it with
  | RulePr (x, mixop, e) ->
    string_of_id x ^ ": " ^ string_of_mixop mixop ^ string_of_exp_args e
  | IfPr e -> "if " ^ string_of_exp e
  | LetPr (e1, e2, xs) ->
    let xs' = List.map (fun x -> x $ no_region) xs in
    "where " ^ string_of_exp e1 ^ " = " ^ string_of_exp e2 ^
    " {" ^ (String.concat ", " (List.map string_of_id xs')) ^ "}"
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
  | DefA x -> "def $" ^ string_of_id x
  | GramA g -> "grammar " ^ string_of_sym g

and string_of_args = function
  | [] -> ""
  | as_ -> "(" ^ concat ", " (List.map string_of_arg as_) ^ ")"

and string_of_quantargs = function
  | [] -> ""
  | as_ -> "{" ^ concat ", " (List.map string_of_arg as_) ^ "}"

and string_of_param p =
  match p.it with
  | ExpP (x, t) ->
    (if string_of_id x = "_" then "" else string_of_id x ^ " : ") ^ string_of_typ t
  | TypP x ->
    "syntax " ^ string_of_id x
  | DefP (x, ps, t) ->
    "def $" ^ string_of_id x ^ string_of_params ps ^ " : " ^ string_of_typ t
  | GramP (x, ps, t) ->
    "grammar " ^ string_of_id x ^ string_of_params ps ^ " : " ^ string_of_typ t

and string_of_params = function
  | [] -> ""
  | ps -> "(" ^ concat ", " (List.map string_of_param ps) ^ ")"

and string_of_quants = function
  | [] -> ""
  | ps -> "{" ^ concat ", " (List.map string_of_param ps) ^ "}"


let region_comment ?(suppress_pos = false) indent at =
  if at = no_region then "" else
  let s = if suppress_pos then at.left.file else string_of_region at in
  indent ^ ";; " ^ s ^ "\n"

let string_of_inst ?(suppress_pos = false) x inst =
  match inst.it with
  | InstD (qs, as_, dt) ->
    "\n" ^ region_comment ~suppress_pos "  " inst.at ^
    "  syntax " ^ string_of_id x ^ string_of_quants qs ^ string_of_args as_ ^ " = " ^
      string_of_deftyp `V dt ^ "\n"

let string_of_rule ?(suppress_pos = false) rule =
  match rule.it with
  | RuleD (x, qs, mixop, e, prems) ->
    let x' = if x.it = "" then "_" else string_of_id x in
    "\n" ^ region_comment ~suppress_pos "  " rule.at ^
    "  rule " ^ x' ^ string_of_quants qs ^ ":\n    " ^
      string_of_mixop mixop ^ string_of_exp_args e ^
      concat "" (List.map (prefix "\n    -- " string_of_prem) prems)

let string_of_clause ?(suppress_pos = false) x clause =
  match clause.it with
  | DefD (qs, as_, e, prems) ->
    "\n" ^ region_comment ~suppress_pos "  " clause.at ^
    "  def $" ^ string_of_id x ^ string_of_quants qs ^ string_of_args as_ ^ " = " ^
      string_of_exp e ^
      concat "" (List.map (prefix "\n    -- " string_of_prem) prems)

let string_of_prod ?(suppress_pos = false) prod =
  match prod.it with
  | ProdD (qs, g, e, prems) ->
    "\n" ^ region_comment ~suppress_pos "  " prod.at ^
    "  prod" ^ string_of_quants qs ^ " " ^ string_of_sym g ^ " => " ^
      string_of_exp e ^
      concat "" (List.map (prefix "\n    -- " string_of_prem) prems)

let rec string_of_def ?(suppress_pos = false) d =
  let pre = "\n" ^ region_comment ~suppress_pos "" d.at in
  match d.it with
  | TypD (x, _ps, [{it = InstD (ps, as_, dt); _}]) ->
    pre ^ "syntax " ^ string_of_id x ^ string_of_params ps ^ string_of_args as_ ^ " = " ^
      string_of_deftyp `V dt ^ "\n"
  | TypD (x, ps, insts) ->
    pre ^ "syntax " ^ string_of_id x ^ string_of_params ps ^
     concat "\n" (List.map (string_of_inst ~suppress_pos x) insts) ^ "\n"
  | RelD (x, mixop, t, rules) ->
    pre ^ "relation " ^ string_of_id x ^ ": " ^
    string_of_mixop mixop ^ string_of_typ_args t ^
      concat "\n" (List.map (string_of_rule ~suppress_pos) rules) ^ "\n"
  | DecD (x, ps, t, clauses) ->
    pre ^ "def $" ^ string_of_id x ^ string_of_params ps ^ " : " ^ string_of_typ t ^
      concat "" (List.map (string_of_clause ~suppress_pos x) clauses) ^ "\n"
  | GramD (x, ps, t, prods) ->
    pre ^ "grammar " ^ string_of_id x ^ string_of_params ps ^ " : " ^ string_of_typ t ^
      concat "" (List.map (string_of_prod ~suppress_pos) prods) ^ "\n"
  | RecD ds ->
    pre ^ "rec {\n" ^ concat "" (List.map string_of_def ds) ^ "}" ^ "\n"
  | HintD _ ->
    ""


(* Scripts *)

let string_of_script ?(suppress_pos = false) ds =
  concat "" (List.map (string_of_def ~suppress_pos) ds)
