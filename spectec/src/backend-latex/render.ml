open Util
open Source
open El.Ast
open El.Convert
open Xl
open Config


(* Errors *)

let error at msg = Error.error at "latex generation" msg


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


let split_ticks id =
  let i = ref (String.length id) in
  while !i > 0 && id.[!i - 1] = '\'' do decr i done;
  String.sub id 0 !i, String.sub id !i (String.length id - !i)

let all_sub id = String.for_all ((=) '_') id
let ends_sub id = id <> "" && id.[String.length id - 1] = '_'
let count_sub id =
  let n = ref 0 in
  while !n < String.length id && id.[String.length id - !n - 1] = '_' do incr n done;
  !n
let split_sub id =
  let n = count_sub id in
  String.sub id 0 (String.length id - n), String.make n '_'
let chop_sub id = fst (split_sub id)

let rec ends_sub_exp e =
  match e.it with
  | VarE (id, []) -> ends_sub id.it
  | AtomE atom -> atom.it <> Atom.Atom "_" && ends_sub (Atom.to_string atom)
  | FuseE (_e1, e2) -> ends_sub_exp e2
  | _ -> false

let as_arith_exp e =
  match e.it with
  | ArithE e1 -> e1
  | _ -> e

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


(* Environment *)

module Set = Set.Make(String)
module Map = Map.Make(String)

let map_cons x y map =
  map := Map.update x
    (function None -> Some [y] | Some ys' -> Some (y::ys')) !map

let map_append x ys map =
  map := Map.update x
    (function None -> Some ys | Some ys' -> Some (ys' @ ys)) !map


type hints = exp list Map.t
type env =
  { config : config;
    vars : Set.t ref;
    atoms : atom list Map.t ref;
    show_typ : hints ref;
    show_gram : hints ref;
    show_var : hints ref;
    show_rel : hints ref;
    show_def : hints ref;
    show_atom : hints ref;
    macro_typ : hints ref;
    macro_gram : hints ref;
    macro_var : hints ref;
    macro_rel : hints ref;
    macro_def : hints ref;
    macro_atom : hints ref;
    desc_typ : hints ref;
    desc_gram : hints ref;
    deco_typ : bool;
    deco_gram : bool;
    deco_rule : bool;
    name_rel : hints ref;
    tab_rel : hints ref;
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
    deco_gram = false;
    deco_rule = false;
    name_rel = ref Map.empty;
    tab_rel = ref Map.empty;
  }

let config env : Config.t =
  env.config

let env_with_config env config : env =
  {env with config}

let with_syntax_decoration b env = {env with deco_typ = b}
let with_grammar_decoration b env = {env with deco_gram = b}
let with_rule_decoration b env = {env with deco_rule = b}

let without_macros b env =
  if not b then env else
  env_with_config env {env.config with macros_for_ids = false}

let local_env env =
  { env with
    macro_typ = ref !(env.macro_typ);
    macro_var = ref !(env.macro_var);
    macro_def = ref !(env.macro_def);
    macro_rel = ref !(env.macro_rel);
    macro_gram = ref !(env.macro_gram);
    macro_atom = ref !(env.macro_atom);
  }


let typed_id' atom def = def ^ ":" ^ (Atom.name atom)
let typed_id atom = typed_id' atom atom.note.Atom.def $ atom.at
let untyped_id' id' =
  let i = String.rindex id' ':' in
  String.sub id' (i + 1) (String.length id' - i - 1)
let untyped_id id = untyped_id' id.it $ id.at


(* Collecting hints to populate the environment *)

let is_atom_typ = function
  | {it = AtomT _; _} -> true
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
    env_hints "show" env.show_rel id hints;
    env_hints "name" env.name_rel id hints;
    env_hints "tabular" env.tab_rel id hints
  | VarH (id, hints) ->
    env_hints "macro" env.macro_var id hints;
    env_hints "show" env.show_var id hints
  | DecH (id, hints) ->
    env_hints "macro" env.macro_def id hints;
    env_hints "show" env.show_def id hints

let env_atom env tid atom hints =
  env_hintdef env (AtomH (tid, atom, hints) $ atom.at)

let env_atom_show env tid atom hints =
  env_atom env tid atom
    (List.filter (fun {hintid; _} -> hintid.it = "show") hints)

let env_typ env tid t hints =
  let hints' = List.filter (fun {hintid; _} -> hintid.it = "macro") hints in
  let module EnvIter =
    El.Iter.Make(
      struct
        include El.Iter.Skip
        let visit_atom atom =
          map_cons tid.it atom env.atoms;
          env_atom env tid atom hints'
      end
    )
  in EnvIter.typ t

let env_typfield env tid (atom, (t, _prems), hints) =
  map_cons tid.it atom env.atoms;
  env_atom env tid atom hints;
  env_typ env tid t hints

let env_typcase env tid (atom, (t, _prems), hints) = 
  env_atom_show env tid atom hints;
  env_typ env tid t hints

let env_typcon env tid ((t, _prems), hints) =
  env_typ env tid t hints;
  match t.it with
  | AtomT atom
  | InfixT (_, atom, _)
  | BrackT (atom, _, _) ->
    env_atom_show env tid atom hints
  | SeqT ts ->
    (match List.find_opt is_atom_typ ts with
    | Some {it = AtomT atom; _} -> env_atom_show env tid atom hints
    | _ -> ()
    )
  | _ -> ()

let env_typdef env tid t : typ list option =
  map_append tid.it [] env.atoms;
  match t.it with
  | VarT (id, _) ->
    map_append tid.it (Map.find id.it !(env.atoms)) env.atoms;
    Some [t]
  | StrT tfs ->
    iter_nl_list (env_typfield env tid) tfs;
    Some []
  | CaseT (dots1, ts, tcs, _) ->
    iter_nl_list (env_typcase env tid) tcs;
    iter_nl_list (fun t ->
      match t.it with
      | VarT (id, _) ->
        map_append tid.it (Map.find id.it !(env.atoms)) env.atoms
      | _ -> ()
    ) ts;
    if dots1 = Dots && ts = [] then None else Some (filter_nl ts)
  | ConT tc ->
    env_typcon env tid tc;
    Some []
  | _ ->
    Some []

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
    if not (Map.mem id1.it !(env.macro_typ)) then env_macro env.macro_typ id1;
    if not (Map.mem id1.it !(env.macro_var)) then env_macro env.macro_var id1;
    env_hintdef env (TypH (id1, id2, hints) $ d.at);
    env_hintdef env (VarH (id1, hints) $ d.at);
    (match env_typdef env id1 t with
    | None -> []
    | Some ts -> [(id1, ts)]
    )
  | GramD (id1, id2, _ps, _t, _gram, hints) ->
    env_macro env.macro_gram id1;
    env_hintdef env (GramH (id1, id2, hints) $ d.at);
    []
  | RelD (id, t, hints) ->
    env_hintdef env (RelH (id, hints) $ d.at);
    env_typcon env id ((t, []), hints);
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
if atom.it = Atom.Atom "REF.STRUCT_ADDR" && map == env.macro_atom then
Printf.printf "[inherit] %s = %s => %s\n%!"
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
    ) ts
  ) inherits;
  (* Add default atom hints last *)
  List.iter (fun (tid, _ts) ->
    let e =
      match Map.find_opt tid.it !(env.macro_typ) with
      | Some ({it = SeqE (_::e::_); _}::_) -> e
      | _ -> TextE "%" $ no_region
    in
    List.iter (fun atom ->
      let t_id = typed_id' atom tid.it in
      if not (Map.mem t_id !(env.macro_atom)) then
(*
if atom.it = Atom.Atom "REF.STRUCT_ADDR" then
begin
(Printf.printf "[default] %s => %s\n%!"
t_id (El.Print.string_of_exp e);
*)
        map_append t_id [e] env.macro_atom;
        (* TODO(4, rossberg): do something for having macros on untyped splices *)
(*      map_cons (typed_id' atom "") e env.macro_atom  (* for defaulting *) *)
    ) (Map.find tid.it !(env.atoms));
  ) inherits;
(*
Printf.printf "\n[env show_atom]\n%s\n%!"
(String.concat "\n" (List.map (fun (id, exps) -> id ^ " => " ^ String.concat " | " (List.map El.Print.string_of_exp exps)) (Map.bindings !(env.show_atom))));
Printf.printf "\n[env macro_atom]\n%s\n%!"
(String.concat "\n" (List.map (fun (id, exps) -> id ^ " => " ^ String.concat " | " (List.map El.Print.string_of_exp exps)) (Map.bindings !(env.macro_atom))));
*)
  env


(* Rendering tables *)

type col = Col of string | Br of [`Wide | `Narrow]
type row = Row of col list | Sep
type table = row list

let rec string_of_row sep br = function
  | [] -> ""
  | (Col s)::(Br _)::cols -> s ^ br ^ string_of_row sep br cols
  | (Col s)::cols -> s ^ sep ^ string_of_row sep br cols
  | (Br _)::cols -> br ^ string_of_row sep br cols

let rec string_of_table vsep vbr hsep hbr = function
  | [] -> ""
  | (Row cols)::Sep::rows -> string_of_row hsep hbr cols ^ vbr ^ string_of_table vsep vbr hsep hbr rows
  | (Row cols)::rows -> string_of_row hsep hbr cols ^ vsep ^ string_of_table vsep vbr hsep hbr rows
  | Sep::rows -> vbr ^ string_of_table vsep vbr hsep hbr rows

let rec map_cols f = function
  | [] -> []
  | (Br w)::cols -> Br w :: map_cols f cols
  | (Col s)::cols -> Col (f s) :: map_cols f cols

let rec map_rows f = function
  | [] -> []
  | Sep::rows -> Sep :: map_rows f rows
  | (Row cols)::rows -> Row (f cols) :: map_rows f rows

let prefix_row (pre : col list) = function
    | (Row cols)::rows -> (Row (pre @ cols))::rows
    | rows -> (Row pre)::rows

let rec prefix_rows (pre_hd : col list) (pre_tl : col list) = function
  | [] -> [Row pre_hd]
  | Sep::rows -> Sep :: prefix_rows pre_hd pre_tl rows
  | (Row cols)::rows -> Row (pre_hd @ cols) :: map_rows (fun row -> pre_tl @ row) rows

let prefix_rows_hd pre tab =
  let empty = map_cols (fun _ -> "") pre in
  prefix_rows pre empty tab

let rec merge_cols sep = function
  | [] -> []
  | (Col s1)::(Col s2)::cols -> merge_cols sep (Col (s1 ^ sep ^ s2) :: cols)
  | col::cols -> col :: merge_cols sep cols

let concat_cols sep s = function
  | (Col s')::cols -> Col (s ^ sep ^ s') :: cols
  | cols -> Col s :: cols

let concat_rows sep s = function
  | (Row cols)::rows -> Row (concat_cols sep s cols) :: rows
  | rows -> Row (concat_cols sep s []) :: rows

let rec concat_cols_table sep cols tab =
  match cols with
  | [] -> tab
  | [Col s] -> concat_rows sep s tab
  | col::cols' -> prefix_row [col] (concat_cols_table sep cols' tab)

let rec concat_table sep tab1 tab2 =
  match tab1 with
  | [] -> tab2
  | [Row cols] -> concat_cols_table sep cols tab2
  | row::tab1' -> row :: concat_table sep tab1' tab2

let rec render_cols env ((fmt, indent_wide, indent_narrow) as cfg) i = function
  | [] -> ""
  | (Br w)::cols ->
    let width = List.length fmt in
    let indent = if w = `Wide then indent_wide else indent_narrow in
    let fmt' = "l" :: List.map (fun _ -> "@{}l") (List.tl cols) in
    let n = width - i in
    (* Add spare &'s at the end of the current line to work around Latex
     * strangeness (it will calculate the formula's width incorrectly,
     * leading to bogus placement). *)
    String.make (max 0 (n - 1)) '&' ^ " \\\\\n" ^
    String.make indent '&' ^ " " ^
    "\\multicolumn{" ^ string_of_int (width - indent) ^ "}{@{}l@{}}{\\quad\n" ^
      (if n <= 1 then
        render_cols env (fmt', 0, 0) 0 cols
      else
        render_table env "" fmt' 0 0 [Row cols]
      ) ^
    "\n}"
  | (Col s)::[] -> s
  | (Col "")::cols -> "& " ^ render_cols env cfg (i + 1) cols
  | (Col s)::cols -> s ^ " & " ^ render_cols env cfg (i + 1) cols

and render_rows env cfg = function
  | [] -> ""
  | Sep::rows -> "{} \\\\[-2ex]\n" ^ render_rows env cfg rows
  | (Row r)::Sep::rows ->
    render_cols env cfg 0 r ^ " \\\\[0.8ex]\n" ^
    render_rows env cfg rows
  | (Row r)::rows ->
    render_cols env cfg 0 r ^ " \\\\\n" ^
    render_rows env cfg rows

and render_table env sp fmt indent_wide indent_narrow (tab : table) =
  let fmt' = List.hd fmt ::
    List.map (fun s -> if s.[0] = '@' then s else sp ^ s) (List.tl fmt) in
  "\\begin{array}[t]{@{}" ^ String.concat "" fmt' ^ "@{}}\n" ^
  render_rows env (fmt, indent_wide, indent_narrow) tab ^
  "\\end{array}"


let rec render_sep_defs f = function
  | [] -> []
  | {it = SepD; _}::ds -> Sep :: render_sep_defs f ds
  | d::ds -> f d @ render_sep_defs f ds

(*
 * TODO(4, rossberg): Reconcile this; perhaps get rid of NL lists altogether.
 * The NLs in different NL lists are currently interpreted differently:
 *  - comma nl list (str): comma-nl => NL instead of WS
 *  - bar nl list (alt): nl-bar => NL instead of WS
 *  - dash nl list (prem): dash-dash => Sep instead of NL
 *  - sym seq: nl-nl-nl => Sep instead of NL or WS
 *  - sym alt: nl-bar => NL instead of WS
 *)
let rec render_nl_list env (sep : [`V | `H] * string) (f : env -> 'a -> row list) :
  'a nl_list -> table =
  function
  | [] -> []
  | [Elem x] -> f env x
  | (Elem x)::Nl::xs when env.config.display ->
    f env x @ render_nl_list env sep f (Nl::xs)
  | (Elem x)::Nl::xs -> render_nl_list env sep f ((Elem x)::xs)
  | (Elem x)::xs ->
    let env' = {env with config = {env.config with display = false}} in
    let rows1 = f env' x in
    let rows2 = render_nl_list env sep f xs in
    if fst sep = `V then rows1 @ rows2
    else concat_table " " rows1 (concat_rows " " (snd sep) rows2)
  | Nl::xs when env.config.display ->
    let rows = render_nl_list env sep f xs in
    if fst sep = `V then Sep :: rows else rows
  | Nl::xs -> render_nl_list env sep f xs


(* Show expansions *)

exception Arity_mismatch

let render_exp_fwd = ref (fun _ -> assert false)
let render_arg_fwd = ref (fun _ -> assert false)
let render_args_fwd = ref (fun _ -> assert false)

(* Show hints are expressions, so expansion produces an expression that is
 * potentially converted to another syntactic class afterwards.
 *)
type ctxt =
  { macro : hints ref;           (* macro map for the target class of ids *)
    templ : string list option;  (* current macro template *)
    args : arg list;             (* epansion arguments *)
    next : int ref;              (* argument counter *)
    max : int ref;               (* highest used argument (to detect arity) *)
  }

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
  let name', sub = split_sub name in
  String.concat name' (Option.get templ) ^ sub

let nonmacro_atom atom =
  let open Atom in
  match atom.it with
  | Atom s -> s = "_"
  | Dot
  | Comma | Semicolon
  | Colon | Equal | Less | Greater
  | Quest | Plus | Star
  | LParen | RParen
  | LBrack | RBrack
  | LBrace | RBrace -> true
  | _ -> false

let expand_atom env (ctxt : ctxt) atom =
(*
Printf.eprintf "[expand_atom %s @ %s] def=%s templ=%s\n%!"
(Atom.to_string atom) (Source.string_of_region atom.at) atom.note.Atom.def
(match templ with None -> "none" | Some xs -> String.concat "%" xs);
*)
  (* When expanding with macro template, then pre-macrofy atom name,
   * since we will have lost the template context later on. *)
  if ctxt.templ = None || nonmacro_atom atom then atom else
  let name' = expand_name ctxt.templ (Atom.name atom) in
  let atom' = {atom with it = Atom.Atom name'} in
  (* Record result as identity expansion, HACK: unless it exists already *)
  if not (Map.mem name' !(env.macro_atom)) then env_macro env.macro_atom (typed_id atom');
  atom'

let expand_id _env (ctxt : ctxt) id =
  (* When expanding with macro template, then pre-macrofy id name,
   * since we will have lost the template context later on. *)
  if ctxt.templ = None || all_sub id.it then id else
  let id' = {id with it = expand_name ctxt.templ id.it} in
(*
Printf.eprintf "[expand_id %s] templ=%s macro=%b => %s macro=%b\n%!"
id.it
(match templ with None -> "none" | Some xs -> String.concat "%" xs)
(Map.mem id.it !(ctxt.macro)) id'.it (Map.mem id'.it !(ctxt.macro));
*)
  (* Record result as identity expansion, HACK: unless it exists already *)
  if not (Map.mem id'.it !(ctxt.macro)) then env_macro ctxt.macro id';
  id'

let rec expand_iter env ctxt iter =
  match iter with
  | Opt | List | List1 -> iter
  | ListN (e, id_opt) -> ListN (expand_exp env ctxt e, id_opt)

and expand_exp env ctxt e =
  (match e.it with
  | AtomE atom ->
    let atom' = expand_atom env ctxt atom in
    AtomE atom'
  | BoolE _ | NumE _ | TextE _ | EpsE ->
    e.it
  | VarE (id, args) ->
    let id' = expand_id env ctxt id in
    let args' = List.map (expand_arg env ctxt) args in
    VarE (id', args')
  | CvtE (e1, nt) ->
    let e1' = expand_exp env ctxt e1 in
    CvtE (e1', nt)
  | UnE (op, e1) ->
    let e1' = expand_exp env ctxt e1 in
    UnE (op, e1')
  | BinE (e1, op, e2) ->
    let e1' = expand_exp env ctxt e1 in
    let e2' = expand_exp env ctxt e2 in
    BinE (e1', op, e2')
  | CmpE (e1, op, e2) ->
    let e1' = expand_exp env ctxt e1 in
    let e2' = expand_exp env ctxt e2 in
    CmpE (e1', op, e2')
  | SeqE es ->
    let es' = List.map (expand_exp env ctxt) es in
    SeqE es'
  | IdxE (e1, e2) ->
    let e1' = expand_exp env ctxt e1 in
    let e2' = expand_exp env ctxt e2 in
    IdxE (e1', e2')
  | SliceE (e1, e2, e3) ->
    let e1' = expand_exp env ctxt e1 in
    let e2' = expand_exp env ctxt e2 in
    let e3' = expand_exp env ctxt e3 in
    SliceE (e1', e2', e3')
  | UpdE (e1, p, e2) ->
    let e1' = expand_exp env ctxt e1 in
    let p' = expand_path env ctxt p in
    let e2' = expand_exp env ctxt e2 in
    UpdE (e1', p', e2')
  | ExtE (e1, p, e2) ->
    let e1' = expand_exp env ctxt e1 in
    let p' = expand_path env ctxt p in
    let e2' = expand_exp env ctxt e2 in
    ExtE (e1', p', e2')
  | StrE efs ->
    let efs' = map_nl_list (expand_expfield env ctxt) efs in
    StrE efs'
  | DotE (e1, atom) ->
    let e1' = expand_exp env ctxt e1 in
    let atom' = expand_atom env ctxt atom in
    DotE (e1', atom')
  | CommaE (e1, e2) ->
    let e1' = expand_exp env ctxt e1 in
    let e2' = expand_exp env ctxt e2 in
    CommaE (e1', e2')
  | CatE (e1, e2) ->
    let e1' = expand_exp env ctxt e1 in
    let e2' = expand_exp env ctxt e2 in
    CatE (e1', e2')
  | MemE (e1, e2) ->
    let e1' = expand_exp env ctxt e1 in
    let e2' = expand_exp env ctxt e2 in
    MemE (e1', e2')
  | LenE e1 ->
    let e1' = expand_exp env ctxt e1 in
    LenE e1'
  | SizeE id ->
    SizeE id
  | ParenE (e1, b) ->
    let e1' = expand_exp env ctxt e1 in
    ParenE (e1', b)
  | TupE es ->
    let es' = List.map (expand_exp env ctxt) es in
    TupE es'
  | InfixE (e1, atom, e2) ->
    let e1' = expand_exp env ctxt e1 in
    let atom' = expand_atom env ctxt atom in
    let e2' = expand_exp env ctxt e2 in
    InfixE (e1', atom', e2')
  | BrackE (l, e1, r) ->
    let l' = expand_atom env ctxt l in
    let e1' = expand_exp env ctxt e1 in
    let r' = expand_atom env ctxt r in
    BrackE (l', e1', r')
  | CallE (id, args) ->
    let id' = expand_id env {ctxt with macro = env.macro_def} id in
    let args' = List.map (expand_arg env ctxt) args in
    CallE (id', args')
  | IterE (e1, iter) ->
    let e1' = expand_exp env ctxt e1 in
    let iter' = expand_iter env ctxt iter in
    IterE (e1', iter')
  | TypE (e1, t) ->
    let e1' = expand_exp env ctxt e1 in
    TypE (e1', t)
  | ArithE e1 ->
    let e1' = expand_exp env ctxt e1 in
    ArithE e1'
  | HoleE (`Num i) ->
    (match List.nth_opt ctxt.args i with
    | None -> raise Arity_mismatch
    | Some arg ->
      ctxt.next := i + 1;
      ctxt.max := max !(ctxt.max) i;
      match !(arg.it) with
      | ExpA eJ -> ArithE eJ
      | _ -> CallE ("" $ e.at, [arg])
    )
  | HoleE `Next ->
    (expand_exp env ctxt (HoleE (`Num !(ctxt.next)) $ e.at)).it
  | HoleE `Rest ->
    let args =
      try Lib.List.drop !(ctxt.next) ctxt.args
      with Failure _ -> raise Arity_mismatch
    in
    ctxt.next := List.length ctxt.args;
    ctxt.max := max !(ctxt.max) (!(ctxt.next) - 1);
    SeqE (List.map (function
      | {it = {contents = ExpA e}; _} ->
        (* Guard exp arguments against being reinterpreted as sym
         * when expanding a grammar id, by wrapping in ArithE. *)
        Source.(ArithE e $ e.at)
      | a -> CallE ("" $ a.at, [a]) $ a.at
    ) args)
  | HoleE `None ->
    HoleE `None
  | FuseE (e1, e2) ->
    let e1' = expand_exp env ctxt e1 in
    let e2' = expand_exp env ctxt e2 in
    FuseE (e1', e2')
  | UnparenE e1 ->
    let e1' = expand_exp env ctxt e1 in
    UnparenE e1'
  | LatexE s ->
    LatexE s
  ) $ e.at

and expand_expfield env ctxt (atom, e) =
  let atom' = expand_atom env ctxt atom in
  let e' = expand_exp env ctxt e in
  (atom', e')

and expand_path env ctxt p =
  (match p.it with
  | RootP -> RootP
  | IdxP (p1, e1) ->
    let p1' = expand_path env ctxt p1 in
    let e1' = expand_exp env ctxt e1 in
    IdxP (p1', e1')
  | SliceP (p1, e1, e2) ->
    let p1' = expand_path env ctxt p1 in
    let e1' = expand_exp env ctxt e1 in
    let e2' = expand_exp env ctxt e2 in
    SliceP (p1', e1', e2')
  | DotP (p1, atom) ->
    let p1' = expand_path env ctxt p1 in
    let atom' = expand_atom env ctxt atom in
    DotP (p1', atom')
  ) $ p.at

and expand_arg env ctxt a =
  ref (match !(a.it) with
  | ExpA e -> ExpA (expand_exp env ctxt e)
  | a' -> a'
  ) $ a.at


(* Attempt to expand the application `id(args)`, using the hints `show`,
 * and the function `render` for rendering the resulting expression.
 * If no hint can be found, fall back to the default of rendering `f`.
 *)
let render_expand render env (show : hints ref) macro id args f : string * arg list =
  match Map.find_opt id.it !show with
  | None ->
(*
(if env.config.macros_for_ids then (
Printf.printf "[expand not found %s]\n%!" id.it;
Printf.printf "%s\n%!" (String.concat " " (List.map fst (Map.bindings !show)))
));
*)
   f (), []
  | Some showexps ->
    let templ = macro_template env macro id.it in
    let rec attempt = function
      | [] -> f (), []
      | showexp::showexps' ->
        try
(*
(if env.config.macros_for_ids then
let m = match templ with None -> "-" | Some l -> String.concat "%" l in
Printf.printf "[expand attempt %s %s] %s\n%!" id.it m (El.Print.string_of_exp showexp)
);
*)
          let env' = local_env env in
          let ctxt = {macro; templ; args; next = ref 1; max = ref 0} in
          let e = expand_exp env' ctxt showexp in
          let args' = Lib.List.drop (!(ctxt.max) + 1) args in
          (* Avoid cyclic expansion *)
          show := Map.remove id.it !show;
          Fun.protect (fun () -> render env' e, args')
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
  (* Pre-render id here, since we cannot distinguish it from other id classes later. *)
  let arg0 = arg_of_exp (LatexE (render_id env id) $ id.at) in
  render_expand render_exp env show macro id (arg0::args)
    (fun () ->
      let n = count_sub id.it in
      if n > 0 && n <= List.length args then
        (* Handle subscripting *)
        let subs, args' = Lib.List.split n args in
        "{" ^ render_id env id ^
        "}_{" ^
          String.concat ", " (List.map (!render_arg_fwd env) (List.flatten (List.map as_tup_arg subs))) ^
        "}" ^ !render_args_fwd env args'
      else
        render_id env id ^ !render_args_fwd env args
    ) |> fst


(* Identifiers *)

let is_digit = Lib.Char.is_digit_ascii
let is_upper = Lib.Char.is_uppercase_ascii
let lower = String.lowercase_ascii

let dash_id = Str.(global_replace (regexp "-") "{-}")
let quote_id = Str.(global_replace (regexp "_+") "\\_")
let shrink_id = Str.(global_replace (regexp "[0-9]+") "{\\\\scriptstyle \\0}")
let rekerni_id = Str.(global_replace (regexp "[.]") "{.}")
let rekernl_id = Str.(global_replace (regexp "\\([a-z]\\)[{]") "\\1{\\kern-0.1em")
let rekernr_id = Str.(global_replace (regexp "[}]\\([a-z{]\\)") "\\kern-0.1em}\\1")
let macrofy_id = Str.(global_replace (regexp "[_.]") "")

let id_style = function
  | `Var -> "\\mathit"
  | `Func -> "\\mathrm"
  | `Atom -> "\\mathsf"
  | `Token -> "\\mathtt"

let render_id' env style id templ =
  El.Debug.(log "render.id"
    (fun _ -> fmt "%s %s" id
      ""(*mapping (fun xs -> string_of_int (List.length xs)) !(env.macro_atom)*))
    (fun s -> s)
  ) @@ fun _ ->
  assert (templ = None || env.config.macros_for_ids);
  if templ <> None && not (all_sub id) then
    "\\" ^ macrofy_id (expand_name templ id)
  else
(*
if env.config.macros_for_ids && String.length id > 2 && (style = `Var || style = `Func) then
Printf.eprintf "[id w/o macro] %s%s\n%!" (if style = `Func then "$" else "") id;
*)
  let id' = quote_id id in
  let id'' =
    (* TODO(3, rossberg): provide a way to selectively shrink uppercase vars, esp after # *)
    match style with
    | `Var | `Func -> rekernl_id (rekernr_id (shrink_id id'))
    | `Atom -> rekerni_id (shrink_id (lower id'))
    | `Token ->
      (* HACK for now: if first char is upper, remove *)
      if String.length id' > 1 && is_upper id'.[0]
      then String.sub id' 1 (String.length id' - 1)
      else id'
  in
  if style = `Var && String.length id'' = 1 && Lib.Char.is_letter_ascii id''.[0]
  then id''
  else id_style style ^ "{" ^ id'' ^ "}"

let rec render_id_sub style show macro env first at = function
  | [] -> ""
  | ""::ss ->
    (* Ignore leading underscores *)
    render_id_sub style show macro env first at ss
  | s::ss when style = `Var && not first && is_upper s.[0] ->
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
        (s3 $ at) [ref (ExpA (VarE (s3 $ at, []) $ at)) $ at]
        (fun () -> render_id' env style s2 (macro_template env macro s3)) |> fst
    in
    let s5 = s4 ^ ticks in
    (if String.length s5 = 1 then s5 else "{" ^ s5 ^ "}") ^
    match ss with
    | [] -> ""
    | [_] -> "_" ^ render_id_sub `Var env.show_var (ref Map.empty) env false at ss
    | _ -> "_{" ^ render_id_sub `Var env.show_var (ref Map.empty) env false at ss ^ "}"

and render_id style show macro env id =
  match id.it with
  | "bool" -> "\\mathbb{B}"
  | "nat" -> "\\mathbb{N}"
  | "int" -> "\\mathbb{Z}"
  | "rat" -> "\\mathbb{Q}"
  | "real" -> "\\mathbb{R}"
  | "text" -> "\\mathbb{T}"
  | _ ->
    render_id_sub style show macro env true id.at (String.split_on_char '_' id.it)

let render_typid env id = render_id `Var env.show_typ env.macro_typ env id
let render_varid env id = render_id `Var env.show_var env.macro_var env id
let render_defid env id = render_id `Func env.show_def env.macro_def env id
let render_gramid env id = render_id `Token env.show_gram env.macro_gram env id

let render_ruleid env id1 id2 =
  let id1' =
    match Map.find_opt id1.it !(env.name_rel) with
    | None -> id1.it
    | Some [] -> assert false
    | Some ({it = TextE s; _}::_) -> s
    | Some ({at; _}::_) ->
      error at "malformed `name` hint for relation"
  in
  let id2' = if id2.it = "" then "" else "-" ^ id2.it in
  "\\textsc{\\scriptsize " ^ dash_id (quote_id (id1' ^ id2')) ^ "}"

let render_rule_deco env pre id1 id2 post =
  if not env.deco_rule then "" else
  pre ^ "{[" ^ render_ruleid env id1 id2 ^ "]}" ^ post


let render_atom env atom =
  El.Debug.(log_if "render.atom" (atom.it = Atom.Atom "CALL_INDIRECT")
    (fun _ -> fmt "%s/%s %s" (el_atom atom) atom.note.def
      (string_of_int (List.length (List.flatten (Option.to_list (Map.find_opt (typed_id atom).it !(env.macro_atom))))))
      (*mapping (fun xs -> string_of_int (List.length xs)) !(env.macro_atom)*))
    (fun s -> s)
  ) @@ fun _ ->
  let open Atom in
  let id = typed_id atom in
  let arg = arg_of_exp (AtomE atom $ atom.at) in
  render_expand !render_exp_fwd env env.show_atom env.macro_atom id [arg]
    (fun () ->
(*
if env.config.macros_for_ids then
Printf.eprintf "[render_atom %s @ %s] id=%s def=%s macros: %s (%s)\n%!"
(Atom.to_string atom) (Source.string_of_region atom.at) id.it atom.note.Atom.def
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
      (* Always keep punctuation as non-macros *)
      | Dot -> "{.}"
      | Comma -> ","
      | Semicolon -> ";"
      | Colon -> ":"
      | Equal -> "="
      | Less -> "<"
      | Greater -> ">"
      | Quest -> "{}^?"
      | Plus -> "{}^+"
      | Star -> "{}^\\ast"
      | LParen -> "("
      | RParen -> ")"
      | LBrack -> "{}["
      | RBrack -> "]"
      | LBrace -> "\\{"
      | RBrace -> "\\}"
      | _ ->
        assert (not (nonmacro_atom atom));
        match macro_template env env.macro_atom id.it with
        | Some _ as templ when env.config.macros_for_ids (*&& atom.note.def <> ""*) ->
          render_id' env `Atom (chop_sub (untyped_id id).it) templ
        | _ ->
          match atom.it with
          | Atom s -> render_id' env `Atom (chop_sub s) None
          | Dot2 -> ".."
          | Dot3 -> "\\ldots"
          | Assign -> ":="
          | NotEqual -> "\\neq"
          | LessEqual-> "\\leq"
          | GreaterEqual -> "\\geq"
          | Arrow | ArrowSub -> "\\rightarrow"
          | Arrow2 | Arrow2Sub -> "\\Rightarrow"
          | Sub -> "\\leq"
          | Sup -> "\\geq"
          | SqArrow -> "\\hookrightarrow"
          | SqArrowStar -> "\\hookrightarrow^\\ast"
          | Cat -> "\\oplus"
          | Bar -> "\\mid"
          | BigAnd -> "\\bigwedge"
          | BigOr -> "\\bigvee"
          | BigAdd -> "\\Sigma"
          | BigMul -> "\\Pi"
          | BigCat -> "\\bigoplus"
          | _ -> "\\" ^ Atom.name atom
    ) |> fst


(* Operators *)

let render_unop = function
  | `NotOp -> "\\neg"
  | `PlusOp -> "+"
  | `MinusOp -> "-"
  | `PlusMinusOp -> "\\pm"
  | `MinusPlusOp -> "\\mp"

let render_binop = function
  | `AndOp -> "\\land"
  | `OrOp -> "\\lor"
  | `ImplOp -> "\\Rightarrow"
  | `EquivOp -> "\\Leftrightarrow"
  | `AddOp -> "+"
  | `SubOp -> "-"
  | `MulOp -> "\\cdot"
  | `DivOp -> "/"
  | `ModOp -> "\\mathbin{\\mathrm{mod}}"
  | `PowOp -> assert false

let render_cmpop = function
  | `EqOp -> "="
  | `NeOp -> "\\neq"
  | `LtOp -> "<"
  | `GtOp -> ">"
  | `LeOp -> "\\leq"
  | `GeOp -> "\\geq"

let render_dots = function
  | Dots -> [Row [Col "\\dots"]]
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

and render_typ env t : string =
  render_exp env (exp_of_typ t)

and render_nottyp env t : table =
  (*
  Printf.eprintf "[render_nottyp %s] %s\n%!"
    (string_of_region t.at) (El.Print.string_of_typ t);
  *)
  match t.it with
  | StrT tfs ->
    [Row [Col (
      "\\{ " ^
      render_table env "@{}" ["l"; "l"] 0 0
        (concat_table "" (render_nl_list env (`H, " ") render_typfield tfs) [Row [Col " \\}"]])
    )]]
  | CaseT (dots1, ts, tcs, dots2) ->
    let render env = function
      | `Dots -> render_dots Dots
      | `Typ t -> render_nottyp env t
      | `TypCase tc -> render_typcase env tc
    in
    let rhss =
      render_nl_list env (`H, "~|~") render (
        (match dots1 with Dots -> [Elem `Dots] | NoDots -> []) @
        map_nl_list (fun t -> `Typ t) ts @
        map_nl_list (fun tc -> `TypCase tc) tcs @
        (match dots2 with Dots -> [Elem `Dots] | NoDots -> [])
      )
    in
    if env.config.display then
      rhss
    else
      [Row [Col (string_of_table " ~|~ " " ~|~ " "" "" rhss)]]
  | ConT tcon ->
    render_typcon env tcon
  | RangeT tes ->
    render_nl_list env (`H, "~|~") render_typenum tes
  | NumT `NatT ->
    [Row [Col "0 ~|~ 1 ~|~ 2 ~|~ \\dots"]]
  | NumT `IntT ->
    [Row [Col "\\dots ~|~ {-2} ~|~ {-1} ~|~ 0 ~|~ 1 ~|~ 2 ~|~ \\dots"]]
  | _ ->
    [Row [Col (render_typ env t)]]


and render_typfield env (atom, (t, prems), _hints) =
  prefix_rows_hd 
    [Col (render_fieldname env atom ^ "~" ^ render_typ env t)]
    (render_conditions env prems)

and render_typcase env (_atom, (t, prems), _hints) : row list =
  prefix_rows_hd [Col (render_typ env t)] (render_conditions env prems)

and render_typcon env ((t, prems), _hints) : row list =
  prefix_rows_hd [Col (render_typ env t)] (render_conditions env prems)

and render_typenum env (e, eo) : row list =
  let r =
    match eo with
    | None -> ""
    | Some e2 -> " ~|~ \\ldots ~|~ " ^ render_exp env e2
  in
  [Row [Col (render_exp env e ^ r)]]


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

and flatten_fuse_exp_rev e =
  match e.it with
  | FuseE (e1, e2) -> e2 :: flatten_fuse_exp_rev e1
  | _ -> [e]

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
  | NumE (`DecOp, `Nat n) -> Z.to_string n
  | NumE (`HexOp, `Nat n) ->
    let fmt =
      if n < Z.of_int 0x100 then "%02X" else
      if n < Z.of_int 0x10000 then "%04X" else
      "%X"
    in "\\mathtt{0x" ^ Z.format fmt n ^ "}"
  | NumE (`CharOp, `Nat n) ->
    let fmt =
      if n < Z.of_int 0x100 then "%02X" else
      if n < Z.of_int 0x10000 then "%04X" else
      "%X"
    in "\\mathrm{U{+}" ^ Z.format fmt n ^ "}"
  | NumE (`AtomOp, `Nat n) ->
    let atom = {it = Atom.Atom (Z.to_string n); at = e.at; note = Atom.info "nat"} in
    render_atom (without_macros true env) atom
  | NumE _ -> assert false
  | TextE t -> "\\mbox{\\texttt{`" ^ t ^ "'}}"
  | CvtE (e1, _) -> render_exp env e1
  | UnE (op, e2) -> "{" ^ render_unop op ^ render_exp env e2 ^ "}"
  | BinE (e1, `PowOp, ({it = ParenE (e2, _); _ } | e2)) ->
    "{" ^ render_exp env e1 ^ "^{" ^ render_exp env e2 ^ "}}"
  | BinE (({it = NumE (`DecOp, `Nat _); _} as e1), `MulOp,
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
      (match render_expand render_exp env env.show_atom env.macro_atom
        (typed_id atom) args (fun () -> render_exp_seq env es)
      with
      | _, args' when List.length args' + 1 = List.length args ->
        (* HACK for nullary contructors *)
        (* TODO(4, rossberg): handle inner constructors more generally *)
        render_exp_seq env es
      | s, _ -> s
      )
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
      "{}[" ^ render_path env p ^ " \\mathrel{{=}{\\oplus}} " ^ render_exp env e2 ^ "]"
  | StrE efs ->
    "\\{ " ^
    "\\begin{array}[t]{@{}l@{}}\n" ^
    concat_map_nl ",\\; " "\\\\\n  " (render_expfield env) efs ^ " \\}" ^
    "\\end{array}"
  | DotE (e1, atom) -> render_exp env e1 ^ "{.}" ^ render_fieldname env atom
  | CommaE (e1, e2) -> render_exp env e1 ^ ", " ^ render_exp env e2
  | CatE (e1, e2) -> render_exp env e1 ^ " \\oplus " ^ render_exp env e2
  | MemE (e1, e2) -> render_exp env e1 ^ " \\in " ^ render_exp env e2
  | LenE e1 -> "{|" ^ render_exp env e1 ^ "|}"
  | SizeE id -> "||" ^ render_gramid env id ^ "||"
  | ParenE ({it = SeqE [{it = AtomE atom; _}; _]; _} as e1, _)
    when render_atom env atom = "" ->
    render_exp env e1
  | ParenE (e1, _) -> "(" ^ render_exp env e1 ^ ")"
  | TupE es -> "(" ^ render_exps ", " env es ^ ")"
  | InfixE (e1, atom, e2) ->
    let id = typed_id atom in
    let ea = AtomE atom $ atom.at in
    let args = List.map arg_of_exp ([e1; ea] @ as_seq_exp e2) in
    render_expand render_exp env env.show_atom env.macro_atom id args
      (fun () ->
        (* Handle subscripting and unary uses *)
        (match Atom.is_sub atom, (as_arith_exp e1).it with
        | false, SeqE [] -> "{" ^ render_atom env atom ^ "}\\, "
        | true, SeqE [] -> "{" ^ render_atom env atom ^ "}_"
        | false, _ -> render_exp env e1 ^ space (render_atom env) atom
        | true, _ -> render_exp env e1 ^ " " ^ render_atom env atom ^ "_"
        ) ^
        (match Atom.is_sub atom, e2.it with
        | true, SeqE (e21::e22::es2) ->
          "{" ^ render_exps "," env (as_tup_exp e21) ^ "} " ^ render_exp_seq env (e22::es2)
        | true, _ -> "{" ^ render_exps "," env (as_tup_exp e2) ^ "} {}"
        | false, _ -> render_exp env e2
        )
      ) |> fst
  | BrackE (l, e1, r) ->
    let id = typed_id l in
    let el = AtomE l $ l.at in
    let er = AtomE r $ r.at in
    let args = List.map arg_of_exp ([el] @ as_seq_exp e1 @ [er]) in
    render_expand render_exp env env.show_atom env.macro_atom id args
      (fun () -> render_atom env l ^ space (render_exp env) e1 ^ render_atom env r) |> fst
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
  | TypE (e1, _) | ArithE e1 -> render_exp env e1
  | FuseE (e1, e2) ->
    (* TODO(2, rossberg): HACK for printing t.LOADn_sx (replace with invisible parens) *)
    let e2' = as_paren_exp (fuse_exp e2 true) in
    let es = e2' :: flatten_fuse_exp_rev e1 in
    String.concat "" (List.map (fun e -> "{" ^ render_exp env e ^ "}") (List.rev es))
  | UnparenE {it = ArithE e1; _} -> render_exp env (UnparenE e1 $ e.at)
  | UnparenE ({it = ParenE (e1, _); _} | e1) -> render_exp env e1
  | HoleE `None -> ""
  | HoleE _ -> error e.at "misplaced hole"
  | LatexE s -> s

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
    s1 ^ " \\\\\n  " ^ s2
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
  | RulePr (_id, e) -> render_exp env e
  | IfPr e -> render_exp env e
  | ElsePr -> error prem.at "misplaced `otherwise` premise"
  | IterPr ({it = IterPr _; _} as prem', iter) ->
    "{" ^ render_prem env prem' ^ "}" ^ render_iter env iter
  | IterPr (prem', iter) ->
    "(" ^ render_prem env prem' ^ ")" ^ render_iter env iter

and word s = "\\mbox{" ^ s ^ "}"

and render_conditions env prems : row list =
  let prems' = filter_nl_list (function {it = VarPr _; _} -> false | _ -> true) prems in
  if prems' = [] then [] else
  let br, prems'' =
    match prems' with
    | Nl::Nl::prems'' ->
      (* If premises start with double empty line, break and align below LHS. *)
      [Br `Wide], prems''
    | Nl::prems'' ->
      (* If premises start with an empty line, break and align below RHS. *)
      [Br `Narrow], prems''
    | _ -> [], prems'
  in
  let prems''', pre =
    match prems'' with
    | [Elem {it = ElsePr; _}] -> [], word "otherwise"
    | (Elem {it = ElsePr; _})::prems''' -> prems''', word "otherwise, if"
    | _ -> prems'', word "if"
  in
  prefix_row br (
    match prems''' with
    | [] -> [Row [Col pre]]
    | [Elem prem] -> [Row [Col ("\\quad " ^ pre ^ "~ " ^ render_prem env prem)]]
    | _ ->
      [Row [Col
        ("\\quad\n" ^ render_table env "" ["l"] 0 0
          (map_rows (merge_cols "~ ")
            (prefix_rows [Col pre] [Col "{\\land}"]
              (render_nl_list env (`V, " \\and ") render_condition prems''')
            )
          )
        )
      ]]
  )

and render_condition env prem =
  [Row [Col (render_prem env prem)]]


(* Grammars *)

and render_exp_as_sym env e =
  render_sym env (sym_of_exp e)

and render_sym env g : string =
  (*
  Printf.eprintf "[render_sym %s] %s\n%!"
    (string_of_region g.at) (El.Print.string_of_sym g);
  *)
  match g.it with
  | VarG (id, args) ->
    render_apply render_gramid render_exp_as_sym
      env env.show_gram env.macro_gram id args
  | NumG (`DecOp, n) -> Z.to_string n
  | NumG (`HexOp, n) ->
    let fmt =
      if n < Z.of_int 0x100 then "%02X" else
      if n < Z.of_int 0x10000 then "%04X" else
      "%X"
    in "\\mathtt{0x" ^ Z.format fmt n ^ "}"
  | NumG (`CharOp, n) ->
    let fmt =
      if n < Z.of_int 0x100 then "%02X" else
      if n < Z.of_int 0x10000 then "%04X" else
      "%X"
    in "\\mathrm{U{+}" ^ Z.format fmt n ^ "}"
  | NumG (`AtomOp, n) -> "\\mathtt{" ^ Z.to_string n ^ "}"
  | TextG t -> "\\mbox{\\texttt{`" ^ t ^ "'}}"
  | EpsG -> "\\epsilon"
  | SeqG gs -> render_sym_seq env gs
  | AltG gs -> render_syms " ~|~ " env gs
  | RangeG (g1, g2) ->
    render_sym env g1 ^ " ~|~ \\ldots ~|~ " ^ render_sym env g2
  | ParenG g1 -> "(" ^ render_sym env g1 ^ ")"
  | TupG gs -> "(" ^ concat ", " (List.map (render_sym env) gs) ^ ")"
  | IterG (g1, iter) -> "{" ^ render_sym env g1 ^ render_iter env iter ^ "}"
  | ArithG e -> render_exp env e
  | AttrG (e, g1) -> render_exp env e ^ "{:}" ^ render_sym env g1
  | FuseG (g1, g2) ->
    "{" ^ render_sym env g1 ^ "}" ^ "{" ^ render_sym env g2 ^ "}"
  | UnparenG ({it = ParenG g1; _} | g1) -> render_sym env g1

(* TODO(3, rossberg): don't hard-code number of tabs *)
and render_syms sep env gs =
  let br = if env.config.display then " \\\\\n&&& " else " " in
  altern_map_nl sep br (render_sym env) gs

(* TODO(3, rossberg): don't hard-code number of tabs *)
and render_sym_seq env = function
  | [] -> ""
  | (Elem g1)::(Elem g2)::gs when g1.at.right.line < g2.at.left.line ->
    let s1 = render_sym env g1 in
    let s2 = render_sym_seq env (Elem g2::gs) in
    s1 ^ " \\\\\n  &&& " ^ s2
  | (Elem g1)::gs ->
    let s1 = render_sym env g1 in
    let s2 = render_sym_seq env gs in
    if s1 <> "" && s2 <> "" then s1 ^ "~~" ^ s2 else s1 ^ s2
  | Nl::gs ->
    let s = render_sym_seq env gs in
    " \\\\[0.8ex]\n  &&& " ^ s

and render_prod env prod : row list =
  let (g, e, prems) = prod.it in
  match e.it, prems with
  | (TupE [] | ParenE ({it = SeqE []; _}, _)), [] ->
    [Row [Col (render_sym env g)]]
  | _ when not env.config.display ->
    prefix_rows_hd
      [Col (render_sym env g ^ " ~\\Rightarrow~ " ^ render_exp env e)]
      (render_conditions env prems)
  | _ ->
    prefix_rows_hd
      ( Col (render_sym env g) ::
        Col "\\quad\\Rightarrow\\quad{}" ::
        if g.at.right.line = e.at.left.line then
          Col (render_exp env e) :: []
        else
          Br `Narrow :: Col (render_exp env e) :: []
      )
      (render_conditions env prems)

and render_gram env gram : table =
  let (dots1, prods, dots2) = gram.it in
  let render env = function
    | `Dots -> render_dots Dots
    | `Prod p -> render_prod env p
  in
  let rhss =
    render_nl_list env (`H, "~|~") render (
      (match dots1 with Dots -> [Elem `Dots] | NoDots -> []) @
      map_nl_list (fun p -> `Prod p) prods @
      (match dots2 with Dots -> [Elem `Dots] | NoDots -> [])
    )
  in
  if env.config.display then
    rhss
  else
    [Row [Col (string_of_table " ~|~ " " ~|~ " "" "" rhss)]]


(* Definitions *)

and render_arg env arg =
  match !(arg.it) with
  | ExpA e -> render_exp env e
  | TypA t -> render_typ env t
  | GramA g -> render_sym env g
  | DefA id -> render_defid env id

and render_args env args =
  match List.map (render_arg env) args with
  | [] -> ""
  | ss -> "(" ^ concat ", " ss ^ ")"

let render_param env p =
  match p.it with
  | ExpP (id, t) -> if id.it = "_" then render_typ env t else render_varid env id
  | TypP id -> render_typid env id
  | GramP (id, _t) -> render_gramid env id
  | DefP (id, _ps, _t) -> render_defid env id

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
  | true, Some s -> "\\mbox{(" ^ s ^ ")}"
  | _ -> ""

let render_typdef env d =
  match d.it with
  | TypD (id1, _id2, args, t, _hints) ->
    let lhs =
      Col (render_typdeco env id1) ::
      Col (render_apply render_typid render_exp
        env env.show_typ env.macro_typ id1 args) :: []
    in
    let rhss = render_nottyp env t in
    prefix_rows_hd lhs (prefix_rows [Col "::="] [Col "|"] rhss)
  | _ -> assert false

let render_gramdeco env id =
  match env.deco_gram, string_of_desc (Map.find_opt id.it !(env.desc_gram)) with
  | true, Some s -> "\\mbox{(" ^ s ^ ")}"
  | _ -> ""

let render_gramdef env d : row list =
  match d.it with
  | GramD (id1, _id2, ps, _t, gram, _hints) ->
    let args = List.map arg_of_param ps in
    let lhs =
      Col (render_gramdeco env id1) ::
      Col (render_apply render_gramid render_exp_as_sym
        env env.show_gram env.macro_gram id1 args) :: []
    in
    let rhss = render_gram env gram in
    prefix_rows_hd lhs (prefix_rows [Col "::="] [Col "|"] rhss)
  | _ -> assert false

let render_ruledef_infer env d =
  match d.it with
  | RuleD (id1, id2, e, prems) ->
    let prems' = filter_nl_list (function {it = VarPr _; _} -> false | _ -> true) prems in
    "\\frac{\n" ^
      (if has_nl prems then "\\begin{array}{@{}c@{}}\n" else "") ^
      altern_map_nl " \\qquad\n" " \\\\\n" (suffix "\n" (render_prem env)) prems' ^
      (if has_nl prems then "\\end{array}\n" else "") ^
    "}{\n" ^
      render_exp env e ^ "\n" ^
    "}" ^
    render_rule_deco env " \\, " id1 id2 ""
  | _ -> failwith "render_ruledef_infer"

let render_ruledef env d : row list =
  match d.it with
  | RuleD (id1, id2, e, prems) ->
    let e1, op, e2 =
      match e.it with
      | InfixE (e1, op, e2) -> e1, op, e2
      | _ -> error e.at "unrecognized format for tabular rule, infix operator expected"
    in
    prefix_rows_hd
      ( Col (render_rule_deco env "" id1 id2 " \\quad") ::
        Col (render_exp env e1) ::
        Col (render_atom env op) ::
        if e1.at.right.line = e2.at.left.line then
          Col (render_exp env e2) :: []
        else
          Br `Wide :: Col (render_exp env e2) :: []
      )
      (render_conditions env prems)
  | _ -> failwith "render_ruledef"

let render_funcdef env d : row list =
  match d.it with
  | DefD (id1, args, e, prems) ->
    prefix_rows_hd
      ( Col (render_exp env (CallE (id1, args) $ d.at)) ::
        Col "=" ::
        if id1.at.right.line = e.at.left.line then
          Col (render_exp env e) :: []
        else
          Br `Wide :: Col (render_exp env e) :: []
      )
      (render_conditions env prems)
  | _ -> failwith "render_funcdef"

let rec render_sep_defs' sep br f = function
  | [] -> ""
  | {it = SepD; _}::ds -> "{} \\\\[-2ex]\n" ^ render_sep_defs' sep br f ds
  | d::{it = SepD; _}::ds -> f d ^ br ^ render_sep_defs' sep br f ds
  | d::ds -> f d ^ sep ^ render_sep_defs' sep br f ds


let rec render_defs env = function
  | [] -> ""
  | d::ds' as ds ->
    let sp = if env.config.display then "" else "@{~}" in
    match d.it with
    | TypD _ ->
      (* Columns: decorator & lhs & ::=/| & rhs & premise *)
      let ds' = merge_typdefs ds in
      if List.length ds' > 1 && not env.config.display then
        error d.at "cannot render multiple syntax types in line";
      let sp_deco = if env.deco_typ then sp else "@{}" in
      render_table env sp ["l"; sp_deco ^ "r"; "r"; "l"; "@{}l"] 1 3
        (render_sep_defs (render_typdef env) ds')
    | GramD _ ->
      (* Columns: decorator & lhs & ::=/| & rhs & => & attr & premise *)
      let ds' = merge_gramdefs ds in
      if List.length ds' > 1 && not env.config.display then
        error d.at "cannot render multiple grammars in line";
      let sp_deco = if env.deco_gram then sp else "@{}" in
      render_table env sp ["l"; sp_deco ^ "r"; "r"; "l"; "@{}l"; "@{}l"; "@{}l"] 1 3
        (render_sep_defs (render_gramdef env) ds')
    | RelD (_, t, _) ->
      "\\boxed{" ^ render_typ env t ^ "}" ^
      (if ds' = [] then "" else " \\; " ^ render_defs env ds')
    | RuleD (id1, _, _, _) ->
      if Map.mem id1.it !(env.tab_rel) then
        (* Columns: decorator & lhs & op & rhs & premise *)
        let sp_deco = if env.deco_rule then sp else "@{}" in
        render_table env sp ["l"; sp_deco ^ "r"; "c"; "l"; "@{}l"] 1 3
          (render_sep_defs (render_ruledef env) ds)
      else
        "\\begin{array}{@{}c@{}}\\displaystyle\n" ^
          render_sep_defs' "\n\\qquad\n" "\n\\\\[3ex]\\displaystyle\n"
            (render_ruledef_infer env) ds ^
        "\\end{array}"
    | DefD _ ->
      (* Columns: lhs & = & rhs & premise *)
      render_table env sp ["l"; "c"; "l"; "@{}l"] 0 2
        (render_sep_defs (render_funcdef env) ds)
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

let rec split_tabdefs id tabdefs = function
  | [] -> List.rev tabdefs, []
  | d::ds ->
    match d.it with
    | RuleD (id1, _, _, _) when id1.it = id ->
      split_tabdefs id (d::tabdefs) ds
    | _ -> List.rev tabdefs, d::ds

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
    | RuleD (id1, _, _, _) ->
      if Map.mem id1.it !(env.tab_rel) then
        let tabdefs, ds' = split_tabdefs id1.it [d] ds in
        "$$\n" ^ render_defs env tabdefs ^ "\n$$\n\n" ^
        render_script env ds'
      else
        "$$\n" ^ render_def env d ^ "\n$$\n\n" ^
        render_script env ds
    | DefD (id, _, _, _) ->
      let funcdefs, ds' = split_funcdefs id.it [d] ds in
      "$$\n" ^ render_defs env funcdefs ^ "\n$$\n\n" ^
      render_script env ds'
    | SepD ->
      "\\vspace{1ex}\n\n" ^
      render_script env ds
    | FamD _ | VarD _ | DecD _ | HintD _ ->
      render_script env ds
