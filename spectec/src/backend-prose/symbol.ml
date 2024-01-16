open Util.Source

module Set = Set.Make(String)
module Map = Map.Make(String)

(* Environment *)

type env =
  {
    kwds: (Set.t * Set.t) Map.t ref;
    funcs: Set.t ref;
  }

(* Extracting Macro from DSL *)

let extract_id_kwd = function
  | El.Ast.Nl -> None
  | El.Ast.Elem elem -> Some elem.it

let extract_typcase_kwd = function
  | El.Ast.Nl -> None
  | El.Ast.Elem (atom, _, _) -> (match atom with
    | El.Ast.Atom id -> Some id
    | _ -> None)

let extract_typfield_kwd = function
  | El.Ast.Nl -> None
  | El.Ast.Elem (atom, _, _) -> (match atom with
    | El.Ast.Atom id -> Some id
    | _ -> None)

let rec extract_typ_kwds typ =
  match typ with
  | El.Ast.AtomT atom -> (match atom with
    | El.Ast.Atom id -> [ id ]
    | _ -> [])
  | El.Ast.IterT (typ_inner, _) -> extract_typ_kwds typ_inner.it
  | El.Ast.StrT typfields -> List.filter_map extract_typfield_kwd typfields
  | El.Ast.CaseT (_, ids, typcases, _) ->
      let ids = List.filter_map extract_id_kwd ids in
      let typcases = List.filter_map extract_typcase_kwd typcases in
      ids @ typcases
  | El.Ast.SeqT tl -> List.concat_map (fun t -> extract_typ_kwds t.it) tl
  | _ -> []

let extract_syntax_kwds def =
  match def.it with
  | El.Ast.SynD (id, subid, _, typ, _) ->
      let topsyntax, syntax =
        if subid.it = "" then (None, id.it)
        else (Some id.it, id.it ^ "-" ^ subid.it)
      in
      let variants = extract_typ_kwds typ.it in
      let variants = List.fold_left (fun acc child -> Set.add child acc) Set.empty variants in
      let (terminals, nonterminals) = Set.partition (fun word -> String.uppercase_ascii word = word) variants in
      Some (topsyntax, syntax, terminals, nonterminals)
  | _ -> None

let extract_func_kwds def =
  match def.it with
  | El.Ast.DecD (id, _, _, _) -> [ id.it ]
  | _ -> []

(* Environment Construction *)

let env el =
  let kwds =
    List.fold_left
      (fun acc def -> match extract_syntax_kwds def with
        | Some (topsyntax, syntax, terminals, nonterminals) ->
            let acc = Map.add syntax (terminals, nonterminals) acc in
            (match topsyntax with
            | Some topsyntax ->
                let terminals, nonterminals =
                  (match Map.find_opt topsyntax acc with
                  | Some (terminals, nonterminals) -> (terminals, Set.add syntax nonterminals)
                  | None -> (Set.empty, Set.singleton syntax))
                in
                Map.add topsyntax (terminals, nonterminals) acc
            | None -> acc)
        | _ -> acc)
      Map.empty el
  in
  let funcs = List.concat_map extract_func_kwds el in
  let funcs = List.fold_left (fun s acc -> Set.add acc s) Set.empty funcs in
  { kwds = ref kwds; funcs = ref funcs; }

(* Environment Lookup *)

let rec find_kwd' env nonterminals variant = match nonterminals with
  | nonterminal :: rest -> (match find_kwd env nonterminal variant with
    | Some s -> Some s
    | None -> find_kwd' env rest variant)
  | _ -> None

and find_kwd env syntax variant =
  match Map.find_opt syntax !(env.kwds) with
  | Some (terminals, nonterminals) ->
      if Set.mem variant terminals then
        Some (variant, syntax)
      else
        find_kwd' env (Set.elements nonterminals) variant
  | _ -> None

let find_func env fname = Set.find_opt fname !(env.funcs)

let find_kwd env kwd =
  let variant, syntax = kwd in
  find_kwd env syntax variant

let find_funcname env funcname = find_func env funcname
