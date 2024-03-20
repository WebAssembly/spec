open Util.Source

module Set = Set.Make(String)
module Map = Map.Make(String)

let to_set l = List.fold_left (fun s e -> Set.add e s) Set.empty l


(* Environment *)

type env =
  {
    atoms: (Set.t * Set.t) Map.t ref;
    funcs: Set.t ref;
  }


(* Extracting Macro from DSL *)

let extract_typ_atom = function
  | El.Ast.Nl -> None
  | El.Ast.Elem typ -> (match typ.it with
    | El.Ast.VarT (id, _) -> Some id.it
    | _ -> None)

let extract_typcase_atom = function
  | El.Ast.Nl -> None
  | El.Ast.Elem (atom, _, _) -> (match atom.it with
    | Il.Atom.Atom id -> Some id
    | _ -> None)

let extract_typfield_atom = function
  | El.Ast.Nl -> None
  | El.Ast.Elem (atom, _, _) -> (match atom.it with
    | Il.Atom.Atom id -> Some id
    | _ -> None)

let rec extract_typ_atoms typ =
  match typ.it with
  | El.Ast.AtomT atom -> (match atom.it with
    | Il.Atom.Atom id -> [ id ]
    | _ -> [])
  | El.Ast.IterT (typ_inner, _) -> extract_typ_atoms typ_inner
  | El.Ast.StrT typfields -> List.filter_map extract_typfield_atom typfields
  | El.Ast.CaseT (_, typs, typcases, _) ->
    let ids = List.filter_map extract_typ_atom typs in
    let typcases = List.filter_map extract_typcase_atom typcases in
    ids @ typcases
  | El.Ast.SeqT tl -> List.concat_map (fun t -> extract_typ_atoms t) tl
  | _ -> []

let extract_syntax_atoms' def =
  match def.it with
  | El.Ast.TypD (id, subid, _, typ, _) ->
    let topsyntax, syntax =
      if subid.it = "" then (None, id.it)
      else (Some id.it, id.it ^ "-" ^ subid.it)
    in
    let variants = extract_typ_atoms typ |> to_set in
    let (terminals, nonterminals) = Set.partition (fun word -> String.uppercase_ascii word = word) variants in
    Some (topsyntax, syntax, terminals, nonterminals)
  | _ -> None

let extract_syntax_atoms el =
  List.fold_left
    (fun acc def -> match extract_syntax_atoms' def with
      | Some (topsyntax, syntax, terminals, nonterminals) ->
          (* Update atom mapping from syntax to terminals and nonterminals *)
          let terminals', nonterminals' =
            (match Map.find_opt syntax acc with
            | Some (s_terminals, s_nonterminals) ->
              (Set.union terminals s_terminals, Set.union nonterminals s_nonterminals)
            | None -> (terminals, nonterminals))
          in
          let acc = Map.add syntax (terminals', nonterminals') acc in
          (* Add level of indirection for subid-ed grammer *)
          (match topsyntax with
          | Some topsyntax ->
            let terminals'', nonterminals'' =
              (match Map.find_opt topsyntax acc with
              | Some (t_terminals, t_nonterminals) -> (t_terminals, Set.add syntax t_nonterminals)
              | None -> (Set.empty, Set.singleton syntax))
            in
            Map.add topsyntax (terminals'', nonterminals'') acc
          | None -> acc)
      | _ -> acc)
    Map.empty el

let extract_func_atoms' def =
  match def.it with
  | El.Ast.DecD (id, _, _, _) -> [ id.it ]
  | _ -> []

let extract_func_atoms el =
  let funcs = List.concat_map extract_func_atoms' el in
  to_set funcs

(* Environment Construction *)

let env el =
  let atoms = extract_syntax_atoms el in
  let funcs = extract_func_atoms el in
  { atoms = ref atoms; funcs = ref funcs; }

(* Environment Getters *)

let atoms env = !(env.atoms)
let funcs env = !(env.funcs)

(* Environment Lookup *)

let rec narrow_atom' env nonterminals variant = match nonterminals with
  | nonterminal :: rest -> (match narrow_atom env nonterminal variant with
    | Some s -> Some s
    | None -> narrow_atom' env rest variant)
  | _ -> None

and narrow_atom env syntax variant =
  match Map.find_opt syntax !(env.atoms) with
  | Some (terminals, nonterminals) ->
      if Set.mem variant terminals then
        Some (variant, syntax)
      else
        narrow_atom' env (Set.elements nonterminals) variant
  | _ -> None

(* Narrows the given keyword if it exists in the grammar.
 * The returned keyword is a tuple of variant name, and its
 * shallowest nonterminal that defines the variant. *)
let narrow_atom env atom =
  let variant = Al.Print.string_of_atom atom in
  let _, syntax = atom in
  narrow_atom env syntax variant

let find_func env fname = Set.mem fname !(env.funcs)
