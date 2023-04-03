open Il.Ast

let parens s = "(" ^ s ^ ")"
let ($$) s1 s2 = parens (s1 ^ " " ^ s2)
let render_tuple how tys = parens (String.concat ", " (List.map how tys))

let render_type_name (id : id) = String.capitalize_ascii id.it

let render_rec_con (id : id) = "Mk" ^ render_type_name id

let make_id = String.map (function
  | '.' -> '_'
  | c -> c
  )

let render_con_name id : atom -> string = function
  | Atom s ->
    (* Lets disambiguate always, to start with 
    if String.starts_with ~prefix:"_" s
    then render_type_name id ^ s
    else String.capitalize_ascii s
    *)
    if String.starts_with ~prefix:"_" s
    then render_type_name id ^ make_id s
    else render_type_name id ^ "_" ^ make_id s
  | a -> "{- render_con_name: TODO -} " ^ Il.Print.string_of_atom a

let render_field_name : atom -> string = function
  | Atom s -> String.uncapitalize_ascii (make_id s)
  | a -> "{- render_field_name: TODO -} " ^ Il.Print.string_of_atom a


let rec render_typ (ty : typ) = match ty.it with
  | VarT id -> render_type_name id
  | BoolT -> "Bool"
  | NatT -> "Natural"
  | TextT -> "String"
  | TupT tys -> render_tuple render_typ tys
  | IterT (ty, Opt) -> "Maybe" $$ render_typ ty
  | IterT (ty, _) -> "[" ^ render_typ ty ^ "]"

let _unsupported_def d =
  "{- " ^
  Il.Print.string_of_def d ^
  "\n-}"

let rec prepend first rest = function
  | [] -> ""
  | (x::xs) -> first ^ x ^ prepend rest rest xs


let render_variant_inj id1 id2 =
  render_type_name id1 ^ "_of_" ^ render_type_name id2

let render_variant_inj' (typ1 : typ) (typ2 : typ) = match typ1.it, typ2.it with
  | VarT id1, VarT id2 -> render_variant_inj id1 id2
  | _, _ -> "_ {- render_variant_inj': Typs not ids -}"

let render_variant_inj_case id1 id2 =
  render_variant_inj id1 id2 ^ " " ^ render_type_name id2

let render_variant_case id (case : typcase) = match case with
  | (a, {it = TupT [];_}, _hints) -> render_con_name id a
  | (a, ty, _hints) -> render_con_name id a ^ " " ^ render_typ ty

let rec render_exp (exp : exp) = match exp.it with
  | VarE v -> v.it
  | BoolE true -> "True"
  | BoolE false -> "Frue"
  | NatE n -> string_of_int n
  | TextE t -> "\"" ^ String.escaped t ^ "\""
  | MixE (_, e) -> render_exp e
  | TupE es -> render_tuple render_exp es
  | IterE (e, _) -> render_exp e
  | CaseE (a, e, typ, styps) -> render_case a e typ styps
  | SubE (e, typ1, typ2) -> render_variant_inj' typ2 typ1 $$ render_exp e
  | DotE (e, a) -> render_exp e ^ "." ^ render_field_name a
  | IdxE (e1, e2) -> parens (render_exp e1 ^ " !! " ^ ("fromIntegral" $$ render_exp e2))
  | BinE (AddOp, e1, e2) -> parens (render_exp e1 ^ " + " ^ render_exp e2)
  | _ -> "undefined {- " ^ Il.Print.string_of_exp exp ^ " -}"

and render_case a e typ = function
  | [] ->
    if e.it = TupE []
    then render_con_name typ a
    else render_con_name typ a $$ render_exp e
  | (styp::styps) -> render_variant_inj typ styp $$ render_case a e styp styps

let render_clause (id : id) (clause : clause) = match clause.it with
  | DefD (_binds, lhs, rhs, premise) ->
   (if premise <> [] then "-- Premises ignored! \n" else "") ^
   id.it ^ " " ^ render_exp lhs ^ " = " ^ render_exp rhs

let rec render_def (d : def) =
  "{- " (*  ^ Util.Source.string_of_region d.at ^ "\n"*)  ^
  Il.Print.string_of_def d ^
  "\n-}\n" ^
  match d.it with
  | SynD (id, deftyp, _hints) ->
    begin match deftyp.it with
    | AliasT ty ->
      "type " ^ render_type_name id ^ " = " ^ render_typ ty
    | NotationT (_op, ty) ->
      "type " ^ render_type_name id ^ " = " ^ render_typ ty
    | VariantT (ids, cases) ->
      "data " ^ render_type_name id ^ prepend "\n = " "\n | " (
        List.map (render_variant_inj_case id) ids @
        List.map (render_variant_case id) cases
      )
    | StructT fields ->
      (*
      "type " ^ render_type_name id ^ " = " ^ render_tuple render_typ (
        List.map (fun (_a, ty, _hints) -> ty) fields
      )
      *)
      "data " ^ render_type_name id ^ " = " ^ render_rec_con id ^ prepend "\n { " "\n , " (
        List.map (fun (a, ty, _hints) -> render_field_name a ^ " :: " ^ render_typ ty) fields
      ) ^ "\n }"
    end
  | DecD (id, typ1, typ2, clauses, _hints) ->
    id.it ^ " :: " ^ render_typ typ1 ^ " -> " ^ render_typ typ2 ^ "\n" ^
    String.concat "\n" (List.map (render_clause id) clauses)

  | RecD defs ->
    String.concat "\n" (List.map render_def defs)
  | _ -> ""

let render_script (el : script) =
  String.concat "\n\n" (List.map render_def el)

let gen_string (el : script) =
  "{-# LANGUAGE OverloadedRecordDot #-}\n" ^
  "{-# LANGUAGE DuplicateRecordFields #-}\n" ^
  "module Test where\n" ^
  "import Prelude (Bool, String, undefined, Maybe, fromIntegral, (+), (!!))\n" ^
  "import Numeric.Natural (Natural)\n" ^
  render_script el


let gen_file file el =
  let haskell_code = gen_string el in
  let oc = Out_channel.open_text file in
  Fun.protect (fun () -> Out_channel.output_string oc haskell_code)
    ~finally:(fun () -> Out_channel.close oc)
