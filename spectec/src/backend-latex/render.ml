open Util
open Source
open El.Ast
open El.Convert
open Config

module Atom = Il.Atom


(* Errors *)

let error at msg = Error.error at "latex generation" msg


(* Environment *)

module Set = Set.Make(String)
module Map = Map.Make(String)

let map_cons x y map =
  map := Map.update x
    (function None -> Some [y] | Some ys' -> Some (y::ys')) !map

let map_append x ys map =
  map := Map.update x
    (function None -> Some ys | Some ys' -> Some (ys' @ ys)) !map


type rel_sort = TypingRel | ReductionRel

type env =
  { config : config;
    vars : Set.t ref;
    atoms : atom list Map.t ref;
    show_typ : exp list Map.t ref;
    show_gram : exp list Map.t ref;
    show_var : exp list Map.t ref;
    show_rel : exp list Map.t ref;
    show_def : exp list Map.t ref;
    show_atom : exp list Map.t ref;
    macro_typ : exp list Map.t ref;
    macro_gram : exp list Map.t ref;
    macro_var : exp list Map.t ref;
    macro_rel : exp list Map.t ref;
    macro_def : exp list Map.t ref;
    macro_atom : exp list Map.t ref;
    desc_typ : exp list Map.t ref;
    desc_gram : exp list Map.t ref;
    deco_typ : bool;
    deco_rule : bool;
    current_rel : string;
  }

let new_env config =
  { config;
    vars = ref Set.empty;
    atoms = ref Map.empty;
    show_typ = ref Map.empty;
    show_gram = ref Map.empty;
    show_var = ref Map.empty;
    show_rel = ref Map.empty;
    show_def = ref Map.empty;
    show_atom = ref Map.empty;
    macro_typ = ref Map.empty;
    macro_gram = ref Map.empty;
    macro_var = ref Map.empty;
    macro_rel = ref Map.empty;
    macro_def = ref Map.empty;
    macro_atom = ref Map.empty;
    desc_typ = ref Map.empty;
    desc_gram = ref Map.empty;
    deco_typ = false;
    deco_rule = false;
    current_rel = "";
  }

let config env : Config.t =
  env.config

let env_with_config env config : env =
  {env with config}

let with_syntax_decoration b env = {env with deco_typ = b}
let with_rule_decoration b env = {env with deco_rule = b}
let without_macros b env =
  if not b then env else
  env_with_config env {env.config with macros_for_ids = false}


let split_ticks id =
  let i = ref (String.length id) in
  while !i > 0 && id.[!i - 1] = '\'' do decr i done;
  String.sub id 0 !i, String.sub id !i (String.length id - !i)

let chop_ticks id = fst (split_ticks id)

let ends_sub id = id <> "" && id.[String.length id - 1] = '_'
let split_sub id =
  if ends_sub id then String.sub id 0 (String.length id - 1), "_" else id, ""
let chop_sub id = fst (split_sub id)

let rec ends_sub_exp e =
  match e.it with
  | VarE (id, []) -> ends_sub id.it
  | AtomE atom -> atom.it <> Atom.Atom "_" && ends_sub (Atom.string_of_atom atom)
  | FuseE (_e1, e2) -> ends_sub_exp e2
  | _ -> false


let typed_id' atom def = def ^ ":" ^ (Atom.name_of_atom atom)
let typed_id atom = typed_id' atom atom.note.Atom.def $ atom.at
let untyped_id' id' =
  let i = String.rindex id' ':' in
  String.sub id' (i + 1) (String.length id' - i - 1)
let untyped_id id = untyped_id' id.it $ id.at

let is_atom_typ t =
  match t.it with
  | AtomT _ -> true
  | _ -> false


let env_macro map id =
  map := Map.add id.it [TextE "%" $ id.at] !map

let env_hints name map id hints =
  List.iter (fun {hintid; hintexp} ->
    if hintid.it = name then map_cons id.it hintexp map
  ) hints

let env_hintdef env hd =
  match hd.it with
  | AtomH (id1, atom, hints) ->
    let id = typed_id {atom with note = {atom.note with def = id1.it}} in
    env_hints "macro" env.macro_atom id hints;
    env_hints "show" env.show_atom id hints
  | TypH (id1, id2, hints) ->
    let id = if id2.it = "" then id1 else (id1.it ^ "/" ^ id2.it) $ id2.at in
    env_hints "desc" env.desc_typ id hints;
    env_hints "macro" env.macro_typ id1 hints;
    env_hints "macro" env.macro_var id1 hints;
    env_hints "show" env.show_typ id1 hints;
    env_hints "show" env.show_var id1 hints
  | GramH (id1, id2, hints) ->
    let id = if id2.it = "" then id1 else (id1.it ^ "/" ^ id2.it) $ id2.at in
    env_hints "desc" env.desc_gram id hints;
    env_hints "macro" env.macro_gram id hints;
    env_hints "show" env.show_gram id1 hints
  | RelH (id, hints) ->
    env_hints "macro" env.macro_rel id hints;
    env_hints "show" env.show_rel id hints
  | VarH (id, hints) ->
    env_hints "macro" env.macro_var id hints;
    env_hints "show" env.show_var id hints
  | DecH (id, hints) ->
    env_hints "macro" env.macro_def id hints;
    env_hints "show" env.show_def id hints

let env_atom env tid atom hints =
  map_cons tid.it atom env.atoms;
(*
  env_macro env.macro_atom (typed_id' atom tid.it $ atom.at);
*)
  env_hintdef env (AtomH (tid, atom, hints) $ atom.at)

let env_typfield env tid (atom, _, hints) = env_atom env tid atom hints
let env_typcase env tid (atom, _, hints) = env_atom env tid atom hints

let env_typcon env tid ((t, _prems), hints) =
  match t.it with
  | AtomT atom
  | InfixT (_, atom, _)
  | BrackT (atom, _, _) ->
    env_atom env tid atom hints
  | SeqT ts ->
    (match List.find_opt is_atom_typ ts with
    | Some {it = AtomT atom; _} -> env_atom env tid atom hints
    | _ -> ()
    )
  | _ -> ()

let env_typ env tid t : (id * typ list) list =
  map_append tid.it [] env.atoms;
  match t.it with
  | StrT tfs ->
    iter_nl_list (env_typfield env tid) tfs; []
  | CaseT (_, ts, tcases, _) ->
    iter_nl_list (env_typcase env tid) tcases;
    iter_nl_list (fun t ->
      match t.it with
      | VarT (id, _) ->
        map_append tid.it (Map.find id.it !(env.atoms)) env.atoms
      | _ -> ()
    ) ts;
    [(tid, filter_nl ts)]
  | ConT tcon ->
    env_typcon env tid tcon; []
  | VarT (id, _) ->
    map_append tid.it (Map.find id.it !(env.atoms)) env.atoms;
    [(tid, [t])]
  | _ -> []

let env_def env d : (id * typ list) list =
  match d.it with
  | FamD (id, _ps, hints) ->
    env.vars := Set.add id.it !(env.vars);
    env_macro env.macro_typ id;
    env_macro env.macro_var id;
    env_hintdef env (TypH (id, "" $ id.at, hints) $ d.at);
    env_hintdef env (VarH (id, hints) $ d.at);
    []
  | TypD (id1, id2, _args, t, hints) ->
    env.vars := Set.add id1.it !(env.vars);
    env_macro env.macro_typ id1;
    env_macro env.macro_var id1;
    env_hintdef env (TypH (id1, id2, hints) $ d.at);
    env_hintdef env (VarH (id1, hints) $ d.at);
    env_typ env id1 t
  | GramD (id1, id2, _ps, _t, _gram, hints) ->
    env_macro env.macro_gram id1;
    env_hintdef env (GramH (id1, id2, hints) $ d.at);
    []
  | RelD (id, _t, hints) ->
    env_hintdef env (RelH (id, hints) $ d.at);
    []
  | VarD (id, _t, hints) ->
    env.vars := Set.add id.it !(env.vars);
    env_hintdef env (VarH (id, hints) $ d.at);
    []
  | DecD (id, _as, _e, hints) ->
    env_macro env.macro_def id;
    env_hintdef env (DecH (id, hints) $ d.at);
    []
  | HintD hd ->
    env_hintdef env hd;
    []
  | RuleD _ | DefD _ | SepD -> []

let env_hints_inherit env map tid tid' =
  List.iter (fun atom ->
    Option.iter (fun es ->
(*
Printf.printf "%s = %s => %s\n%!"
(typed_id' atom tid.it) (typed_id' atom tid'.it) (String.concat " | " (List.map El.Print.string_of_exp es));
*)
      map_append (typed_id' atom tid.it) es map
    ) (Map.find_opt (typed_id' atom tid'.it) !map)
  ) (Map.find tid'.it !(env.atoms))

let env config script : env =
  let env = new_env config in
  let inherits = List.concat_map (env_def env) script in
(*
Printf.printf "\n[env before inheritance]\n%s\n%!"
(String.concat "\n" (List.map (fun (id, atoms) -> id ^ ": " ^ String.concat " " (List.map El.Print.string_of_atom atoms)) (Map.bindings !(env.atoms))));
Printf.printf "\n[env show_atom]\n%s\n%!"
(String.concat "\n" (List.map (fun (id, exps) -> id ^ " => " ^ String.concat " | " (List.map El.Print.string_of_exp exps)) (Map.bindings !(env.show_atom))));
Printf.printf "\n[env macro_atom]\n%s\n%!"
(String.concat "\n" (List.map (fun (id, exps) -> id ^ " => " ^ String.concat " | " (List.map El.Print.string_of_exp exps)) (Map.bindings !(env.macro_atom))));
Printf.printf "\n[env inheritance]\n";
*)
  (* Stand-alone hints can occur in a different order than their associated
   * definitions, but to handle inherited type atoms correctly, they need to be
   * processed in order of their type definitions. Hence, inherited types are
   * recorded and processed in order. *)
  List.iter (fun (tid, ts) ->
    List.iter (fun t ->
      match t.it with
      | VarT (id, _) ->
        env_hints_inherit env env.macro_atom tid id;
        env_hints_inherit env env.show_atom tid id
      | _ -> ()
    ) ts;
    (* Add default atom hints last *)
    let e =
      match Map.find_opt tid.it !(env.macro_typ) with
      | Some ({it = SeqE (_::e::_); _}::_) -> e
      | _ -> TextE "%" $ no_region
    in
    List.iter (fun atom ->
      map_append (typed_id' atom tid.it) [e] env.macro_atom
    ) (Map.find tid.it !(env.atoms));
  ) inherits;
(*
  (* Add default atom hints last *)
  Map.iter (fun tid atoms ->
    let e =
      match Map.find_opt tid !(env.macro_typ) with
      | Some ({it = SeqE (_::e::_); _}::_) -> e
      | _ -> TextE "%" $ no_region
    in
    List.iter (fun atom ->
      map_append (typed_id' atom tid) [e] env.macro_atom
    ) atoms
  ) !(env.atoms);
*)
(*
Printf.printf "\n[env show_atom]\n%s\n%!"
(String.concat "\n" (List.map (fun (id, exps) -> id ^ " => " ^ String.concat " | " (List.map El.Print.string_of_exp exps)) (Map.bindings !(env.show_atom))));
Printf.printf "\n[env macro_atom]\n%s\n%!"
(String.concat "\n" (List.map (fun (id, exps) -> id ^ " => " ^ String.concat " | " (List.map El.Print.string_of_exp exps)) (Map.bindings !(env.macro_atom))));
*)
  env


(* Helpers *)

let concat = String.concat
let suffix s f x = f x ^ s
let space f x = " " ^ f x ^ " "

let rec has_nl = function
  | [] -> false
  | Nl::_ -> true
  | _::xs -> has_nl xs

let rec concat_map_nl sep br f = function
  | [] -> ""
  | [Elem x] -> f x
  | (Elem x)::xs -> f x ^ sep ^ concat_map_nl sep br f xs
  | Nl::xs -> br ^ concat_map_nl sep br f xs

let rec altern_map_nl sep br f = function
  | [] -> ""
  | [Elem x] -> f x
  | (Elem x)::Nl::xs -> f x ^ br ^ altern_map_nl sep br f xs
  | (Elem x)::xs -> f x ^ sep ^ altern_map_nl sep br f xs
  | Nl::xs -> br ^ altern_map_nl sep br f xs

let strip_nl = function
  | Nl::xs -> xs
  | xs -> xs


let as_paren_exp e =
  match e.it with
  | ParenE (e1, _) -> e1
  | _ -> e

let as_tup_exp e =
  match e.it with
  | TupE es -> es
  | ParenE (e1, _) -> [e1]
  | _ -> [e]

let as_seq_exp e =
  match e.it with
  | SeqE es -> es
  | _ -> [e]

let rec fuse_exp e deep =
  match e.it with
  | ParenE (e1, b) when deep -> ParenE (fuse_exp e1 false, b) $ e.at
  | IterE (e1, iter) -> IterE (fuse_exp e1 deep, iter) $ e.at
  | SeqE (e1::es) -> List.fold_left (fun e1 e2 -> FuseE (e1, e2) $ e.at) e1 es
  | _ -> e

let as_tup_arg a =
  match !(a.it) with
  | ExpA {it = TupE es; _} -> List.map (fun e -> ref (ExpA e) $ e.at) es
  | _ -> [a]


(* Show expansions *)

exception Arity_mismatch

let render_exp_fwd = ref (fun _ -> assert false)
let render_arg_fwd = ref (fun _ -> assert false)
let render_args_fwd = ref (fun _ -> assert false)

let macro_template env macro name =
  if not env.config.macros_for_ids then None else
  match Map.find_opt name !macro with
  | Some ({it = (TextE s | SeqE ({it = TextE s; _}::_)); _}::_) ->
    Some (String.split_on_char '%' s)
  | _ ->
(*
Printf.printf "[macro not found %s]\n%!" name;
Printf.printf "%s\n%!" (String.concat " " (List.map fst (Map.bindings !macro)));
*)
    None

let expand_name templ name =
  match templ with
  | Some m -> String.concat name m
  | _ -> name

let expand_atom map templ atom =
(*
Printf.eprintf "[expand_atom %s @ %s] def=%s templ=%s\n%!"
(Atom.string_of_atom atom) (Source.string_of_region atom.at) atom.note.Atom.def
(match templ with None -> "none" | Some xs -> String.concat "%" xs);
*)
  if atom.it = Atom.Atom "_" || templ = None then atom else
  let name, sub = split_sub (Atom.name_of_atom atom) in
  let name' = expand_name templ name ^ sub in
  let atom' = {atom with it = Atom.Atom name'} in
  if templ <> None && not (Map.mem name' !map) then
    env_macro map (typed_id atom');
  atom'

let expand_id map templ id =
  let name, sub = split_sub id.it in
  let id' = {id with it = expand_name templ name ^ sub} in
  if templ <> None && not (Map.mem id'.it !map) then env_macro map id';
  id'

let rec expand_iter env templ args i iter =
  match iter with
  | Opt | List | List1 -> iter
  | ListN (e, id_opt) -> ListN (expand_exp env templ args i e, id_opt)

and expand_exp env templ args i e =
  (match e.it with
  | AtomE atom -> AtomE (expand_atom env.macro_atom templ atom)
  | BoolE _ | NatE _ | TextE _ | EpsE -> e.it
  | VarE (id, args') ->
    VarE (expand_id env.macro_var templ id,
      List.map (expand_arg env templ args i) args')
  | UnE (op, e) -> UnE (op, expand_exp env templ args i e)
  | BinE (e1, op, e2) ->
    let e1' = expand_exp env templ args i e1 in
    let e2' = expand_exp env templ args i e2 in
    BinE (e1', op, e2')
  | CmpE (e1, op, e2) ->
    let e1' = expand_exp env templ args i e1 in
    let e2' = expand_exp env templ args i e2 in
    CmpE (e1', op, e2')
  | SeqE es -> SeqE (List.map (expand_exp env templ args i) es)
  | IdxE (e1, e2) ->
    let e1' = expand_exp env templ args i e1 in
    let e2' = expand_exp env templ args i e2 in
    IdxE (e1', e2')
  | SliceE (e1, e2, e3) ->
    let e1' = expand_exp env templ args i e1 in
    let e2' = expand_exp env templ args i e2 in
    let e3' = expand_exp env templ args i e3 in
    SliceE (e1', e2', e3')
  | UpdE (e1, p, e2) ->
    let e1' = expand_exp env templ args i e1 in
    let p' = expand_path env templ args i p in
    let e2' = expand_exp env templ args i e2 in
    UpdE (e1', p', e2')
  | ExtE (e1, p, e2) ->
    let e1' = expand_exp env templ args i e1 in
    let p' = expand_path env templ args i p in
    let e2' = expand_exp env templ args i e2 in
    ExtE (e1', p', e2')
  | StrE efs -> StrE (map_nl_list (expand_expfield env templ args i) efs)
  | DotE (e, atom) -> DotE (expand_exp env templ args i e, atom)
  | CommaE (e1, e2) ->
    let e1' = expand_exp env templ args i e1 in
    let e2' = expand_exp env templ args i e2 in
    CommaE (e1', e2')
  | CompE (e1, e2) ->
    let e1' = expand_exp env templ args i e1 in
    let e2' = expand_exp env templ args i e2 in
    CompE (e1', e2')
  | LenE e -> LenE (expand_exp env templ args i e)
  | SizeE id -> SizeE id
  | ParenE (e, b) -> ParenE (expand_exp env templ args i e, b)
  | TupE es -> TupE (List.map (expand_exp env templ args i) es)
  | InfixE (e1, atom, e2) ->
    let e1' = expand_exp env templ args i e1 in
    let e2' = expand_exp env templ args i e2 in
    InfixE (e1', atom, e2')
  | BrackE (l, e1, r) -> BrackE (l, expand_exp env templ args i e1, r)
  | CallE (id, args') ->
    CallE (expand_id env.macro_def templ id,
      List.map (expand_arg env templ args i) args')
  | IterE (e1, iter) ->
    let e1' = expand_exp env templ args i e1 in
    let iter' = expand_iter env templ args i iter in
    IterE (e1', iter')
  | TypE (e1, t) -> TypE (expand_exp env templ args i e1, t)
  | HoleE (`Num j) ->
    (match List.nth_opt args j with
    | None -> raise Arity_mismatch
    | Some arg -> i := j + 1;
      match !(arg.it) with
      | ExpA eJ -> eJ.it
      | _ -> CallE ("" $ e.at, [arg])
    )
  | HoleE `Next -> (expand_exp env templ args i (HoleE (`Num !i) $ e.at)).it
  | HoleE `Rest ->
    let args' = try Lib.List.drop !i args with Failure _ -> raise Arity_mismatch in
    i := List.length args;
    SeqE (List.map (function
      | {it = {contents = ExpA e}; _} -> e
      | a -> CallE ("" $ a.at, [a]) $ a.at
    ) args')
  | HoleE `None -> HoleE `None
  | FuseE (e1, e2) ->
    let e1' = expand_exp env templ args i e1 in
    let e2' = expand_exp env templ args i e2 in
    FuseE (e1', e2')
  ) $ e.at

and expand_expfield env templ args i (atom, e) =
  (expand_atom env.macro_atom templ atom, expand_exp env templ args i e)

and expand_path env templ args i p =
  (match p.it with
  | RootP -> RootP
  | IdxP (p1, e1) ->
    let p1' = expand_path env templ args i p1 in
    let e1' = expand_exp env templ args i e1 in
    IdxP (p1', e1')
  | SliceP (p1, e1, e2) ->
    let p1' = expand_path env templ args i p1 in
    let e1' = expand_exp env templ args i e1 in
    let e2' = expand_exp env templ args i e2 in
    SliceP (p1', e1', e2')
  | DotP (p1, atom) ->
    DotP (expand_path env templ args i p1,
      expand_atom env.macro_atom templ atom)
  ) $ p.at

and expand_arg env templ args i a =
  ref (match !(a.it) with
  | ExpA e -> ExpA (expand_exp env templ args i e)
  | a' -> a'
  ) $ a.at


(* Attempt to show-expand the application `id(args)`, using the hints `show`,
 * and the function `render` for rendering the resulting expression.
 * If no hint can be found, fall back to the default of rendering `f`.
 *)
let render_expand render env (show : exp list Map.t ref) macro id args f =
  match Map.find_opt id.it !show with
  | None ->
(*
(if env.config.macros_for_ids then (
Printf.printf "[expand not found %s]\n%!" id.it;
Printf.printf "%s\n%!" (String.concat " " (List.map fst (Map.bindings !show)))
));
*)
   f ()
  | Some showexps ->
    let templ = macro_template env macro id.it in
    let rec attempt = function
      | [] -> f ()
      | showexp::showexps' ->
        try
(*
(if env.config.macros_for_ids then
let m = match templ with None -> "-" | Some l -> String.concat "%" l in
Printf.printf "[expand attempt %s %s] %s\n%!" id.it m (El.Print.string_of_exp showexp)
);
*)
          let e = expand_exp env templ args (ref 1) showexp in
          (* Avoid cyclic expansion *)
          show := Map.remove id.it !show;
          Fun.protect (fun () -> render env e)
            ~finally:(fun () -> show := Map.add id.it showexps !show)
        with Arity_mismatch -> attempt showexps'
          (* HACK: Ignore arity mismatches, such that overloading notation works,
           * e.g., using CONST for both instruction and relation. *)
    in attempt showexps

(* Render the application `id(args)`, using the hints `show`,
 * and the function `render_id`, `render_exp` for rendering the id and
 * possible show expansion results, respectively.
 *)
let render_apply render_id render_exp env show macro id args =
  let atom = Atom.(Atom (" " ^ render_id env id) $$ id.at % info "") in
  let arg0 = arg_of_exp (AtomE atom $ id.at) in
  render_expand render_exp env show macro id (arg0::args)
    (fun () ->
      match args with
      | arg::args when ends_sub id.it ->
        (* Handle subscripting *)
        "{" ^ render_id env id ^
        "}_{" ^
          String.concat ", " (List.map (!render_arg_fwd env) (as_tup_arg arg)) ^
        "}" ^ !render_args_fwd env args
      | args -> render_id env id ^ !render_args_fwd env args
    )


(* Identifiers *)

let is_digit = Lib.Char.is_digit_ascii
let is_upper = Lib.Char.is_uppercase_ascii
let lower = String.lowercase_ascii

let dash_id = Str.(global_replace (regexp "-") "{-}")
let quote_id = Str.(global_replace (regexp "_+") "\\_")
let shrink_id = Str.(global_replace (regexp "[0-9]+") "{\\\\scriptstyle\\0}")
let macrofy_id = Str.(global_replace (regexp "_") "")

let id_style = function
  | `Var -> "\\mathit"
  | `Func -> "\\mathrm"
  | `Atom -> "\\mathsf"
  | `Token -> "\\mathtt"

let render_id' env style id templ =
  assert (templ = None || env.config.macros_for_ids);
  if templ <> None then "\\" ^ macrofy_id (expand_name templ id) else
(*
if env.config.macros_for_ids && String.length id > 2 && (style = `Var || style = `Func) then
Printf.eprintf "[id w/o macro] %s%s\n%!" (if style = `Func then "$" else "") id;
*)
  let id' = shrink_id (quote_id id) in
  if style = `Var && String.length id' = 1 && Lib.Char.is_letter_ascii id'.[0]
  then id'
  else id_style style ^ "{" ^ (if style = `Atom then lower id' else id') ^ "}"

let rec render_id_sub style show macro env first at = function
  | [] -> ""
  | ""::ss ->
    (* Ignore leading underscores *)
    render_id_sub style show macro env first at ss
  | s::ss when style = `Var &&
      not first && is_upper s.[0] && not (Set.mem (chop_ticks s) !(env.vars)) ->
    (* In vars, underscore renders subscripts; subscripts may be atoms *)
    render_id_sub `Atom show (ref Map.empty) env first at (lower s :: ss)
  | s1::""::[] ->
    (* Keep trailing underscores for macros (and chop later) *)
    render_id_sub style show macro env first at [s1 ^ "_"]
  | s1::""::s2::ss ->
    (* Record double underscores as regular underscore characters *)
    render_id_sub style show macro env first at ((s1 ^ "__" ^ s2)::ss)
  | s1::s2::ss when style = `Atom && is_upper s2.[0] ->
    (* Record single underscores in atoms as regular characters as well *)
    render_id_sub `Atom show (ref Map.empty) env first at ((s1 ^ "_" ^ lower s2)::ss)
  | s::ss ->
    (* All other underscores are rendered as subscripts *)
    let s1, sub = split_sub s in  (* previous steps might have appended underscore *)
    let s2, ticks = split_ticks s1 in
    let s3 = s2 ^ sub in
    let s4 =
      if String.for_all is_digit s3 then s3 else
      if not first then render_id' env style s2 None else
      render_expand !render_exp_fwd env show macro
        (s3 $ at) []
        (fun () -> render_id' env style s2 (macro_template env macro s3))
    in
    let s5 = s4 ^ ticks in
    (if String.length s5 = 1 then s5 else "{" ^ s5 ^ "}") ^
    match ss with
    | [] -> ""
    | [_] -> "_" ^ render_id_sub `Var env.show_var (ref Map.empty) env false at ss
    | _ -> "_{" ^ render_id_sub `Var env.show_var (ref Map.empty) env false at ss ^ "}"

and render_id style show macro env id =
  render_id_sub style show macro env true id.at (String.split_on_char '_' id.it)

let render_typid env id = render_id `Var env.show_typ env.macro_typ env id
let render_varid env id = render_id `Var env.show_var env.macro_var env id
let render_defid env id = render_id `Func env.show_def env.macro_def env id
let render_gramid env id = render_id `Token env.show_gram env.macro_gram env
  (* TODO: HACK for now: if first char is upper, remove *)
  (let len = String.length id.it in
  if len > 1 && is_upper id.it.[0] then String.sub id.it 1 (len - 1) $ id.at else id)

let render_ruleid env id1 id2 =
  let id1' =
    match Map.find_opt id1.it !(env.show_rel) with
    | None -> id1.it
    | Some [] -> assert false
    | Some ({it = TextE s; _}::_) -> s
    | Some ({at; _}::_) ->
      error at "malformed `show` hint for relation"
  in
  let id2' = if id2.it = "" then "" else "-" ^ id2.it in
  "\\textsc{\\scriptsize " ^ dash_id (quote_id (id1' ^ id2')) ^ "}"

let render_rule_deco env pre id1 id2 post =
  if not env.deco_rule then "" else
  pre ^ "{[" ^ render_ruleid env id1 id2 ^ "]}" ^ post


let render_atom env atom =
  let open Atom in
  let id = typed_id atom in
  let arg = arg_of_exp (AtomE atom $ atom.at) in
  render_expand !render_exp_fwd env env.show_atom env.macro_atom id [arg]
    (fun () ->
(*
if env.config.macros_for_ids then
Printf.eprintf "[render_atom %s @ %s] id=%s def=%s macros: %s (%s)\n%!"
(Atom.string_of_atom atom) (Source.string_of_region atom.at) id.it atom.note.Atom.def
(String.concat "%" (List.concat (Option.to_list (macro_template env env.macro_atom id.it))))
""(*(String.concat " " (List.map fst (Map.bindings !(env.macro_atom))))*);
*)
(*
      if env.config.macros_for_ids && atom.note.def = "" then
        error atom.at
          ("cannot infer type of notation `" ^ El.Print.string_of_atom atom ^ "`");
*)
      match atom.it with
      | Atom "_" -> render_id' env `Atom "_" None
      | Atom s when s.[0] = '_' -> ""
      (* HACK: inject literally, already rendered stuff *)
      | Atom s when s.[0] = ' ' -> String.sub s 1 (String.length s - 1)
      | _ when env.config.macros_for_ids && atom.note.def <> "" ->
        render_id' env `Atom (chop_sub (untyped_id id).it)
          (macro_template env env.macro_atom id.it)
      | Atom s -> render_id' env `Atom (chop_sub s) None
      | Dot -> "."  (* TODO: {.} *)
      | Dot2 -> ".."
      | Semicolon -> ";"
      | Colon -> ":"
      | Assign -> ":="
      | Equal -> "="
      | Quest -> "{}^?"
      | Plus -> "{}^+"
      | Star -> "{}^\\ast"
      | Comma -> ","
      | LParen -> "("
      | RParen -> ")"
      | LBrack -> "{}["
      | RBrack -> "]"
      | LBrace -> "\\{"
      | RBrace -> "\\}"
      | Arrow | ArrowSub -> "\\rightarrow"
      | Arrow2 | Arrow2Sub -> "\\Rightarrow"
      | Sub -> "\\leq"
      | Sup -> "\\geq"
      | SqArrow -> "\\hookrightarrow"
      | SqArrowStar -> "\\hookrightarrow^\\ast"
      | Comp -> "\\oplus"
      | Bar -> "\\mid"
      | BigComp -> "\\bigoplus"
      | _ -> "\\" ^ Atom.name_of_atom atom
    )


(* Operators *)

let render_unop = function
  | NotOp -> "\\neg"
  | PlusOp -> "+"
  | MinusOp -> "-"
  | PlusMinusOp -> "\\pm"
  | MinusPlusOp -> "\\mp"

let render_binop = function
  | AndOp -> "\\land"
  | OrOp -> "\\lor"
  | ImplOp -> "\\Rightarrow"
  | EquivOp -> "\\Leftrightarrow"
  | AddOp -> "+"
  | SubOp -> "-"
  | MulOp -> "\\cdot"
  | DivOp -> "/"
  | ExpOp -> assert false

let render_cmpop = function
  | EqOp -> "="
  | NeOp -> "\\neq"
  | LtOp -> "<"
  | GtOp -> ">"
  | LeOp -> "\\leq"
  | GeOp -> "\\geq"

let render_dots = function
  | Dots -> [Elem "\\dots"]
  | NoDots -> []


(* Iteration *)

let rec render_iter env = function
  | Opt -> "^?"
  | List -> "^\\ast"
  | List1 -> "^{+}"
  | ListN ({it = ParenE (e, _); _}, None) | ListN (e, None) ->
    "^{" ^ render_exp env e ^ "}"
  | ListN (e, Some id) ->
    "^{" ^ render_varid env id ^ "<" ^ render_exp env e ^ "}"


(* Types *)

and render_typ env t =
  (*
  Printf.eprintf "[render_typ %s] %s\n%!"
    (string_of_region t.at) (El.Print.string_of_typ t);
  *)
  match t.it with
  | StrT tfs ->
    "\\{ " ^
    "\\begin{array}[t]{@{}l@{}l@{}}\n" ^
    concat_map_nl ",\\; " "\\\\\n  " (render_typfield env) tfs ^ " \\}" ^
    "\\end{array}"
  | CaseT (dots1, ts, tcases, dots2) ->
    altern_map_nl " ~|~ " " \\\\ &&|&\n" Fun.id
      (render_dots dots1 @ map_nl_list (render_typ env) ts @
        map_nl_list (render_typcase env) tcases @ render_dots dots2)
  | ConT tcon ->
    render_typcon env tcon
  | RangeT tes ->
    altern_map_nl " ~|~ " "\\\\ &&|&\n" (render_typenum env) tes
  | _ ->
    render_exp env (exp_of_typ t)


and render_typfield env (atom, (t, prems), _hints) =
  render_fieldname env atom ^ "~" ^
    render_conditions env (render_typ env t) "&&&" prems

and render_typcase env (_atom, (t, prems), _hints) =
  render_conditions env (render_typ env t) "&&&" prems

and render_typcon env ((t, prems), _hints) =
  render_conditions env (render_typ env t) "&&&" prems

and render_typenum env (e, eo) =
  render_exp env e ^
  match eo with
  | None -> ""
  | Some e2 -> " ~|~ \\dots ~|~ " ^ render_exp env e2


(* Expressions *)

and is_atom_exp_with_show env e =
  match e.it with
  | AtomE atom when Map.mem (typed_id atom).it !(env.show_atom) -> true
| AtomE atom ->
if atom.it = Atom.Atom "X" && String.contains e.at.left.file 'A' then
Printf.eprintf "[is_atom_exp %s:X @ %s] false %s\n%!" (Source.string_of_region e.at) atom.note.Atom.def
(typed_id atom).it;
false
  | _ -> false

and render_exp env e =
  (*
  Printf.eprintf "[render_exp %s] %s\n%!"
    (string_of_region e.at) (El.Print.string_of_exp e);
  *)
  match e.it with
  | VarE (id, args) ->
    render_apply render_varid render_exp env env.show_typ env.macro_typ id args
  | BoolE b ->
    render_atom env (Atom.(Atom (string_of_bool b) $$ e.at % info "bool"))
  | NatE (DecOp, n) -> Z.to_string n
  | NatE (HexOp, n) ->
    let fmt =
      if n < Z.of_int 0x100 then "%02X" else
      if n < Z.of_int 0x10000 then "%04X" else
      "%X"
    in "\\mathtt{0x" ^ Z.format fmt n ^ "}"
  | NatE (CharOp, n) ->
    let fmt =
      if n < Z.of_int 0x100 then "%02X" else
      if n < Z.of_int 0x10000 then "%04X" else
      "%X"
    in "\\mathrm{U{+}" ^ Z.format fmt n ^ "}"
  | NatE (AtomOp, n) ->
    let atom = {it = Atom.Atom (Z.to_string n); at = e.at; note = Atom.info "nat"} in
    render_atom (without_macros true env) atom
  | TextE t -> "``" ^ t ^ "''"
  | UnE (op, e2) -> "{" ^ render_unop op ^ render_exp env e2 ^ "}"
  | BinE (e1, ExpOp, ({it = ParenE (e2, _); _ } | e2)) ->
    "{" ^ render_exp env e1 ^ "^{" ^ render_exp env e2 ^ "}}"
  | BinE (({it = NatE (DecOp, _); _} as e1), MulOp,
      ({it = VarE _ | CallE (_, []) | ParenE _; _ } as e2)) ->
    render_exp env e1 ^ " \\, " ^ render_exp env e2
  | BinE (e1, op, e2) ->
    render_exp env e1 ^ space render_binop op ^ render_exp env e2
  | CmpE (e1, op, e2) ->
    render_exp env e1 ^ space render_cmpop op ^ render_exp env e2
  | EpsE -> "\\epsilon"
  | AtomE atom -> render_atom env atom
  | SeqE es ->
    (match List.find_opt (is_atom_exp_with_show env) es with
    | Some {it = AtomE atom; _} ->
      let args = List.map arg_of_exp es in
(*
if atom.it = Atom.Atom "X" && String.contains e.at.left.file 'A' then
Printf.eprintf "[render %s:X @ %s] try expansion\n%!" (Source.string_of_region e.at) atom.note.Atom.def;
*)
      render_expand render_exp env env.show_atom env.macro_atom
        (typed_id atom) args (fun () -> render_exp_seq env es)
    | _ -> render_exp_seq env es
    )
  | IdxE (e1, e2) -> render_exp env e1 ^ "{}[" ^ render_exp env e2 ^ "]"
  | SliceE (e1, e2, e3) ->
    render_exp env e1 ^
      "{}[" ^ render_exp env e2 ^ " : " ^ render_exp env e3 ^ "]"
  | UpdE (e1, p, e2) ->
    render_exp env e1 ^
      "{}[" ^ render_path env p ^ " = " ^ render_exp env e2 ^ "]"
  | ExtE (e1, p, e2) ->
    render_exp env e1 ^
      "{}[" ^ render_path env p ^ " = .." ^ render_exp env e2 ^ "]"
  | StrE efs ->
    "\\{ " ^
    "\\begin{array}[t]{@{}l@{}}\n" ^
    concat_map_nl ",\\; " "\\\\\n  " (render_expfield env) efs ^ " \\}" ^
    "\\end{array}"
  | DotE (e1, atom) -> render_exp env e1 ^ "{.}" ^ render_fieldname env atom
  | CommaE (e1, e2) -> render_exp env e1 ^ ", " ^ render_exp env e2
  | CompE (e1, e2) -> render_exp env e1 ^ " \\oplus " ^ render_exp env e2
  | LenE e1 -> "{|" ^ render_exp env e1 ^ "|}"
  | SizeE id -> "||" ^ render_gramid env id ^ "||"
  | ParenE ({it = SeqE [{it = AtomE atom; _}; _]; _} as e1, _)
    when render_atom env atom = "" ->
    render_exp env e1
  | ParenE (e1, _) -> "(" ^ render_exp env e1 ^ ")"
  | TupE es -> "(" ^ render_exps ",\\, " env es ^ ")"
  | InfixE (e1, atom, e2) ->
    let id = typed_id atom in
    let e = AtomE atom $ atom.at in
    let args = List.map arg_of_exp (as_seq_exp e1 @ [e] @ as_seq_exp e2) in
    render_expand render_exp env env.show_atom env.macro_atom id args
      (fun () ->
        (match e1.it with
        | SeqE [] -> "{" ^ space (render_atom env) atom ^ "}\\;"
        | _ -> render_exp env e1 ^ space (render_atom env) atom
        ) ^ render_exp env e2
      )
  | BrackE (l, e1, r) ->
    let id = typed_id l in
    let el = AtomE l $ l.at in
    let er = AtomE r $ r.at in
    let args = List.map arg_of_exp ([el] @ as_seq_exp e1 @ [er]) in
    render_expand render_exp env env.show_atom env.macro_atom id args
      (fun () -> render_atom env l ^ render_exp env e1 ^ render_atom env r)
  | CallE (id, [arg]) when id.it = "" -> (* expansion result only *)
    render_arg env arg
  | CallE (id, args) when id.it = "" ->  (* expansion result only *)
    render_args env args
  | CallE (id, args) ->
    render_apply render_defid render_exp env env.show_def env.macro_def id args
  | IterE (e1, iter) -> "{" ^ render_exp env e1 ^ render_iter env iter ^ "}"
  | TypE ({it = VarE ({it = "_"; _}, []); _}, t) ->
    (* HACK for rendering shorthand parameters that have been turned into args
     * with arg_of_param, for use in render_apply. *)
    render_typ env t
  | TypE (e1, _) -> render_exp env e1
  | FuseE (e1, e2) ->
    (* Hack for printing t.LOADn_sx *)
    let e2' = as_paren_exp (fuse_exp e2 true) in
    "{" ^ render_exp env e1 ^ "}" ^ "{" ^ render_exp env e2' ^ "}"
  | HoleE `None -> ""
  | HoleE _ -> error e.at "misplaced hole"

and render_exps sep env es =
  concat sep (List.filter ((<>) "") (List.map (render_exp env) es))

and render_exp_seq env = function
  | [] -> ""
  | es when (List.hd es).at.left.line < (Lib.List.last es).at.right.line ->
    "\\begin{array}[t]{@{}l@{}} " ^ render_exp_seq' env es ^ " \\end{array}"
  | es -> render_exp_seq' env es

and render_exp_seq' env = function
  | [] -> ""
  | e1::e2::es when ends_sub_exp e1 ->
    (* Handle subscripting *)
    let s1 =
      "{" ^ render_exp env e1 ^ "}_{" ^
        render_exps "," env (as_tup_exp e2) ^ "}"
    in
    let s2 = render_exp_seq' env es in
    if s1 <> "" && s2 <> "" then s1 ^ "\\," ^ s2 else s1 ^ s2
  | e1::e2::es when e1.at.right.line < e2.at.left.line ->
    let s1 = render_exp env e1 in
    let s2 = render_exp_seq' env (e2::es) in
    s1 ^ " \\\\ " ^ s2
  | e1::es ->
    let s1 = render_exp env e1 in
    let s2 = render_exp_seq' env es in
    if s1 <> "" && s2 <> "" then s1 ^ "~" ^ s2 else s1 ^ s2

and render_expfield env (atom, e) =
  render_fieldname env atom ^ "~" ^ render_exp env e

and render_path env p =
  match p.it with
  | RootP -> ""
  | IdxP (p1, e) -> render_path env p1 ^ "{}[" ^ render_exp env e ^ "]"
  | SliceP (p1, e1, e2) ->
    render_path env p1 ^ "{}[" ^ render_exp env e1 ^ " : " ^ render_exp env e2 ^ "]"
  | DotP ({it = RootP; _}, atom) -> render_fieldname env atom
  | DotP (p1, atom) ->
    render_path env p1 ^ "{.}" ^ render_fieldname env atom

and render_fieldname env atom =
  El.Debug.(log "render.fieldname"
    (fun _ -> fmt "%s %s" (el_atom atom)
      (mapping (fun xs -> string_of_int (List.length xs)) !(env.show_atom)))
    (fun s -> s)
  ) @@ fun _ -> 
  render_atom env atom


(* Premises *)

and render_prem env prem =
  match prem.it with
  | VarPr _ -> assert false
  | RulePr (id, e) -> render_exp {env with current_rel = id.it} e
  | IfPr e -> render_exp env e
  | ElsePr -> error prem.at "misplaced `otherwise` premise"
  | IterPr ({it = IterPr _; _} as prem', iter) ->
    "{" ^ render_prem env prem' ^ "}" ^ render_iter env iter
  | IterPr (prem', iter) ->
    "(" ^ render_prem env prem' ^ ")" ^ render_iter env iter

and word s = "\\mbox{" ^ s ^ "}"

and render_conditions env rhs tabs prems =
  let prems' = filter_nl_list (function {it = VarPr _; _} -> false | _ -> true) prems in
  if prems' = [] then rhs else
  let rhs', prems'', tabs', begin_, end_ =
    match prems' with
    | Nl::Nl::prems'' ->
      (* If premises start with double empty line, break and align below LHS. *)
      let tabs' = String.sub tabs 0 (max 0 (String.length tabs - 2)) in
      let rhs' = if String.starts_with ~prefix:"\\\\" rhs then rhs else
        "\\multicolumn{2}{l@{}}{ " ^ rhs ^ " }" in
      rhs' ^ " \\\\\n  " ^ tabs',
      prems'', tabs', " \\multicolumn{4}{@{}l@{}}{\\qquad\\quad ", "}"
      (* If premises start with an empty line, break and align below RHS. *)
    | Nl::prems'' ->
      let rhs' = if String.starts_with ~prefix:"\\\\" rhs then rhs else
        "\\multicolumn{2}{l@{}}{ " ^ rhs ^ " }" in
      rhs' ^ " \\\\\n  " ^ tabs,
      prems'', tabs, " \\multicolumn{2}{l@{}}{\\quad ", "}"
    | _ -> rhs ^  "\n  &", prems', tabs ^ "&", "\\qquad ", ""
  in
  let prems''', first =
    match prems'' with
    | [Elem {it = ElsePr; _}] -> [], word "otherwise"
    | (Elem {it = ElsePr; _})::prems''' -> prems''', word "otherwise, if" ^ "~"
    | _ -> prems'', word "if" ^ "~"
  in
  rhs' ^
  begin_ ^ first ^
    concat_map_nl (end_ ^ " \\\\\n  " ^ tabs' ^ begin_ ^ "{\\land}~") ""
      (render_prem env) prems''' ^
  end_


(* Grammars *)

and render_exp_as_sym env e =
  render_sym env (sym_of_exp e)

and render_sym env g =
  match g.it with
  | VarG (id, args) ->
    render_apply render_gramid render_exp_as_sym
      env env.show_gram env.macro_def id args
  | NatG (DecOp, n) -> Z.to_string n
  | NatG (HexOp, n) ->
    let fmt =
      if n < Z.of_int 0x100 then "%02X" else
      if n < Z.of_int 0x10000 then "%04X" else
      "%X"
    in "\\mathtt{0x" ^ Z.format fmt n ^ "}"
  | NatG (CharOp, n) ->
    let fmt =
      if n < Z.of_int 0x100 then "%02X" else
      if n < Z.of_int 0x10000 then "%04X" else
      "%X"
    in "\\mathrm{U{+}" ^ Z.format fmt n ^ "}"
  | NatG (AtomOp, n) -> "\\mathtt{" ^ Z.to_string n ^ "}"
  | TextG t -> "`" ^ t ^ "'"
  | EpsG -> "\\epsilon"
  | SeqG gs -> render_syms "~" env gs
  | AltG gs -> render_syms " ~|~ " env gs
  | RangeG (g1, g2) ->
    render_sym env g1 ^ " ~|~ \\dots ~|~ " ^ render_sym env g2
  | ParenG g1 -> "(" ^ render_sym env g1 ^ ")"
  | TupG gs -> "(" ^ concat ", " (List.map (render_sym env) gs) ^ ")"
  | IterG (g1, iter) -> "{" ^ render_sym env g1 ^ render_iter env iter ^ "}"
  | ArithG e -> render_exp env e
  | AttrG (e, g1) -> render_exp env e ^ "{:}" ^ render_sym env g1
  | FuseG (g1, g2) ->
    "{" ^ render_sym env g1 ^ "}" ^ "{" ^ render_sym env g2 ^ "}"

and render_syms sep env gs =
  altern_map_nl sep " \\\\ &&&" (render_sym env) gs

and render_prod env prod =
  let (g, e, prems) = prod.it in
  render_sym env g ^ " &\\Rightarrow& " ^
    render_conditions env (render_exp env e) "&&&&&" prems

and render_gram env gram =
  let (dots1, prods, dots2) = gram.it in
  altern_map_nl " ~|~ " " \\\\ &&|&\n" Fun.id
    ( render_dots dots1 @
      map_nl_list (render_prod env) prods @
      render_dots dots2
    )


(* Definitions *)

and render_arg env arg =
  match !(arg.it) with
  | ExpA e -> render_exp env e
  | TypA t -> render_typ env t
  | GramA g -> render_sym env g

and render_args env args =
  match List.map (render_arg env) args with
  | [] -> ""
  | ss -> "(" ^ concat ", " ss ^ ")"

let render_param env p =
  match p.it with
  | ExpP (id, t) -> if id.it = "_" then render_typ env t else render_varid env id
  | TypP id -> render_typid env id
  | GramP (id, _t) -> render_gramid env id

let _render_params env = function
  | [] -> ""
  | ps -> "(" ^ concat ", " (List.map (render_param env) ps) ^ ")"

let () = render_exp_fwd := render_exp
let () = render_arg_fwd := render_arg
let () = render_args_fwd := render_args


let merge_typ t1 t2 =
  match t1.it, t2.it with
  | CaseT (dots1, ids1, cases1, _), CaseT (_, ids2, cases2, dots2) ->
    CaseT (dots1, ids1 @ strip_nl ids2, cases1 @ strip_nl cases2, dots2) $ t1.at
  | _, _ -> assert false

let merge_gram gram1 gram2 =
  match gram1.it, gram2.it with
  | (dots1, prods1, _), (_, prods2, dots2) ->
    (dots1, prods1 @ strip_nl prods2, dots2) $ gram1.at

let rec merge_typdefs = function
  | [] -> []
  | {it = TypD (id1, _, as1, t1, _); at; _}::
    {it = TypD (id2, _, as2, t2, _); _}::ds
    when id1.it = id2.it && El.Eq.(eq_list eq_arg as1 as2) ->
    let d' = TypD (id1, "" $ no_region, as1, merge_typ t1 t2, []) $ at in
    merge_typdefs (d'::ds)
  | d::ds ->
    d :: merge_typdefs ds

let rec merge_gramdefs = function
  | [] -> []
  | {it = GramD (id1, _, ps, t, gram1, _); at; _}::
    {it = GramD (id2, _, _ps, _t, gram2, _); _}::ds when id1.it = id2.it ->
    let d' = GramD (id1, "" $ no_region, ps, t, merge_gram gram1 gram2, []) $ at in
    merge_gramdefs (d'::ds)
  | d::ds ->
    d :: merge_gramdefs ds

let string_of_desc = function
  | Some ({it = TextE s; _}::_) -> Some s
  | Some ({at; _}::_) -> error at "malformed description hint"
  | _ -> None

let render_typdeco env id =
  match env.deco_typ, string_of_desc (Map.find_opt id.it !(env.desc_typ)) with
  | true, Some s -> "\\mbox{(" ^ s ^ ")} & "
  | _ -> "& "

let render_typdef env d =
  match d.it with
  | TypD (id1, _id2, args, t, _) ->
    render_typdeco env id1 ^
    render_apply render_typid render_exp env env.show_typ env.macro_typ id1 args ^
    " &::=& " ^ render_typ env t
  | _ -> assert false

let render_gramdef env d =
  match d.it with
  | GramD (id1, _id2, ps, _t, gram, _) ->
    let args = List.map arg_of_param ps in
    "& " ^ render_apply render_gramid render_exp_as_sym
      env env.show_gram env.macro_gram id1 args ^
      " &::=& " ^ render_gram env gram
  | _ -> assert false

let render_ruledef env d =
  match d.it with
  | RuleD (id1, id2, e, prems) ->
    let prems' = filter_nl_list (function {it = VarPr _; _} -> false | _ -> true) prems in
    "\\frac{\n" ^
      (if has_nl prems then "\\begin{array}{@{}c@{}}\n" else "") ^
      altern_map_nl " \\qquad\n" " \\\\\n" (suffix "\n" (render_prem env)) prems' ^
      (if has_nl prems then "\\end{array}\n" else "") ^
    "}{\n" ^
      render_exp {env with current_rel = id1.it} e ^ "\n" ^
    "}" ^
    render_rule_deco env " \\, " id1 id2 ""
  | _ -> failwith "render_ruledef"


let render_reddef env d =
  match d.it with
  | RuleD (id1, id2, e, prems) ->
    let e1, op, e2 =
      match e.it with
      | InfixE (e1, op, e2) -> e1, op, e2
      | _ -> error e.at "unrecognized format for reduction rule"
    in
    render_rule_deco env "" id1 id2 " \\quad " ^ "& " ^
      render_exp env e1 ^ " &" ^ render_atom env op ^ "& " ^
        if e1.at.right.line = e2.at.left.line then
          render_conditions env (render_exp env e2) "&&&" prems
        else
          render_conditions env ("\\\\\n  & \\multicolumn{3}{@{}l@{}}{\\qquad " ^
            render_exp env e2 ^ " }") "&&&" prems
  | _ -> failwith "render_reddef"

let render_funcdef env d =
  match d.it with
  | DefD (id1, args, e, prems) ->
    render_exp env (CallE (id1, args) $ d.at) ^ " &=& " ^
      render_conditions env (render_exp env e) "&&" prems
  | _ -> failwith "render_funcdef"

let rec render_sep_defs ?(sep = " \\\\\n") ?(br = " \\\\[0.8ex]\n") f = function
  | [] -> ""
  | {it = SepD; _}::ds -> "{} \\\\[-2ex]\n" ^ render_sep_defs ~sep ~br f ds
  | d::{it = SepD; _}::ds -> f d ^ br ^ render_sep_defs ~sep ~br f ds
  | d::ds -> f d ^ sep ^ render_sep_defs ~sep ~br f ds


let rec classify_rel e : rel_sort option =
  match e.it with
  | InfixE (_, {it = Turnstile; _}, _) -> Some TypingRel
  | InfixE (_, {it = SqArrow | SqArrowStar | Approx; _}, _) -> Some ReductionRel
  | InfixE (e1, _, e2) ->
    (match classify_rel e1 with
    | None -> classify_rel e2
    | some -> some
    )
  | _ -> None


let rec render_defs env = function
  | [] -> ""
  | d::ds' as ds ->
    let sp = if env.config.display then "" else "@{~}" in
    match d.it with
    | TypD _ ->
      let ds' = merge_typdefs ds in
      let deco = if env.deco_typ then "l" else "l@{}" in
      "\\begin{array}{@{}" ^ deco ^ "r" ^ sp ^ "r" ^ sp ^ "l@{}l@{}}\n" ^
        render_sep_defs (render_typdef env) ds' ^
      "\\end{array}"
    | GramD _ ->
      let ds' = merge_gramdefs ds in
      "\\begin{array}{@{}l@{}r" ^ sp ^ "r" ^ sp ^ "lll@{}l@{}}\n" ^
        render_sep_defs (render_gramdef env) ds' ^
      "\\end{array}"
    | RelD (id, t, _hints) ->
      "\\boxed{" ^
        render_typ {env with current_rel = id.it} t ^
      "}" ^
      (if ds' = [] then "" else " \\; " ^ render_defs env ds')
    | RuleD (_, _, e, _) ->
      (match classify_rel e with
      | Some TypingRel ->
        "\\begin{array}{@{}c@{}}\\displaystyle\n" ^
          render_sep_defs ~sep:"\n\\qquad\n" ~br:"\n\\\\[3ex]\\displaystyle\n"
            (render_ruledef env) ds ^
        "\\end{array}"
      | Some ReductionRel ->
        "\\begin{array}{@{}l@{}r" ^ sp ^ "c" ^ sp ^ "l@{}l@{}}\n" ^
          render_sep_defs (render_reddef env) ds ^
        "\\end{array}"
      | None -> error d.at "unrecognized form of relation"
      )
    | DefD _ ->
      "\\begin{array}{@{}l" ^ sp ^ "c" ^ sp ^ "l@{}l@{}}\n" ^
        render_sep_defs (render_funcdef env) ds ^
      "\\end{array}"
    | SepD ->
      " \\\\\n" ^
      render_defs env ds'
    | FamD _ | VarD _ | DecD _ | HintD _ ->
      failwith "render_defs"

let render_def env d = render_defs env [d]


(* Scripts *)

let rec split_typdefs typdefs = function
  | [] -> List.rev typdefs, []
  | d::ds ->
    match d.it with
    | TypD _ -> split_typdefs (d::typdefs) ds
    | _ -> List.rev typdefs, d::ds

let rec split_gramdefs gramdefs = function
  | [] -> List.rev gramdefs, []
  | d::ds ->
    match d.it with
    | GramD _ -> split_gramdefs (d::gramdefs) ds
    | _ -> List.rev gramdefs, d::ds

let rec split_reddefs id reddefs = function
  | [] -> List.rev reddefs, []
  | d::ds ->
    match d.it with
    | RuleD (id1, _, _, _) when id1.it = id ->
      split_reddefs id (d::reddefs) ds
    | _ -> List.rev reddefs, d::ds

let rec split_funcdefs id funcdefs = function
  | [] -> List.rev funcdefs, []
  | d::ds ->
    match d.it with
    | DefD (id1, _, _, _) when id1.it = id -> split_funcdefs id (d::funcdefs) ds
    | _ -> List.rev funcdefs, d::ds

let rec render_script env = function
  | [] -> ""
  | d::ds ->
    match d.it with
    | TypD _ ->
      let typdefs, ds' = split_typdefs [d] ds in
      "$$\n" ^ render_defs env typdefs ^ "\n$$\n\n" ^
      render_script env ds'
    | GramD _ ->
      let gramdefs, ds' = split_gramdefs [d] ds in
      "$$\n" ^ render_defs env gramdefs ^ "\n$$\n\n" ^
      render_script env ds'
    | RelD _ ->
      "$" ^ render_def env d ^ "$\n\n" ^
      render_script env ds
    | RuleD (id1, _, e, _) ->
      (match classify_rel e with
      | Some TypingRel ->
        "$$\n" ^ render_def env d ^ "\n$$\n\n" ^
        render_script env ds
      | Some ReductionRel ->
        let reddefs, ds' = split_reddefs id1.it [d] ds in
        "$$\n" ^ render_defs env reddefs ^ "\n$$\n\n" ^
        render_script env ds'
      | None -> error d.at "unrecognized form of relation"
      )
    | DefD (id, _, _, _) ->
      let funcdefs, ds' = split_funcdefs id.it [d] ds in
      "$$\n" ^ render_defs env funcdefs ^ "\n$$\n\n" ^
      render_script env ds'
    | SepD ->
      "\\vspace{1ex}\n\n" ^
      render_script env ds
    | FamD _ | VarD _ | DecD _ | HintD _ ->
      render_script env ds
