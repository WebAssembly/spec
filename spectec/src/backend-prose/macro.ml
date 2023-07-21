open Printf
open Util.Source

module Set = Set.Make(String)
module Map = Map.Make(String)

(* Environment *)

type env =
  { section: string Map.t ref;
    syn: string list Map.t ref;
    dec: Set.t ref;
  }

let get_section env = !(env.section)
let get_syn env = !(env.syn)
let get_dec env = !(env.dec)

let find_section env s = Map.mem s !(env.section)

let all_keywords env =
  let syn = !(env.syn) in
  let syn = Map.fold
    (fun _parent children acc -> 
      List.fold_left (fun acc child -> Set.add child acc) acc children)
    syn Set.empty
  in
  let dec = !(env.dec) in
  let dec = Set.fold
    (fun keyword acc -> Set.add keyword acc)
    dec Set.empty
  in
  Set.union syn dec

(* Parsing Sections from Splice Inputs and Outputs *)

let rec read_lines ic lines = match In_channel.input_line ic with
  | Some line -> read_lines ic (line :: lines)
  | None -> 
      In_channel.close ic; 
      List.rev lines

let parse_line line =
  let prefix = ".. _" in
  if String.starts_with ~prefix:prefix line then
    Some (String.sub line (String.length prefix) ((String.length line) - (String.length prefix) - 1))
  else
    None

let parse_file input output section2file =
  let ic = In_channel.open_text input in
  let lines = read_lines ic [] in
  List.fold_left 
    (fun acc line -> match parse_line line with
      | Some section -> Map.add section output acc
      | None -> acc)
    section2file lines

let parse_section pdsts odsts =
  List.fold_left2
    (fun acc input output -> 
      let suffix = ".rst" in
      assert (String.ends_with ~suffix:suffix output);
      let output = String.sub output 0 ((String.length output) - (String.length suffix)) in
      parse_file input output acc)
    Map.empty pdsts odsts

(* Extracting Macro from DSL *)

let extract_ids_keywords = function
  | El.Ast.Nl -> None
  | El.Ast.Elem elem -> Some elem.it 

let extract_typcases_keywords = function
  | El.Ast.Nl -> None
  | El.Ast.Elem (atom, _, _) -> (match atom with
    | El.Ast.Atom id -> Some id
    | _ -> None)

let extract_typfields_keywords = function
  | El.Ast.Nl -> None
  | El.Ast.Elem (atom, _, _) -> (match atom with
    | El.Ast.Atom id -> Some id
    | _ -> None)

let rec extract_typ_keywords typ =
  match typ with
  | El.Ast.AtomT atom -> (match atom with
    | El.Ast.Atom id -> [ id ]
    | _ -> [])
  | El.Ast.IterT (typ_inner, _) -> extract_typ_keywords typ_inner.it
  | El.Ast.StrT typfields -> List.filter_map extract_typfields_keywords typfields
  | El.Ast.CaseT (_, ids, typcases, _) ->
      let ids = List.filter_map extract_ids_keywords ids in
      let typcases = List.filter_map extract_typcases_keywords typcases in
      ids @ typcases
  | El.Ast.SeqT tl -> List.concat_map (fun t -> extract_typ_keywords t.it) tl
  | _ -> []

let extract_syn_keywords def =
  match def.it with
  | El.Ast.SynD (id, subid, typ, _) -> 
      let parent = if subid.it = "" then id.it else id.it ^ "-" ^ subid.it in
      let children = extract_typ_keywords typ.it in
      Some (parent, children)
  | _ -> None

let extract_dec_keywords def =
  match def.it with
  | El.Ast.DecD (id, _, _, _) -> [ id.it ]
  | _ -> []

(* Environment Construction *)

let env inputs outputs el =
  let section = parse_section inputs outputs in
  let syn = 
    List.fold_left
      (fun acc def -> match extract_syn_keywords def with
        | Some (parent, children) -> Map.add parent ([ parent ] @ children) acc
        | _ -> acc)
      Map.empty el
  in
  let dec = List.concat_map extract_dec_keywords el in
  let dec = List.fold_left (fun s acc -> Set.add acc s) Set.empty dec in
  let env = { section = ref section; syn = ref syn; dec = ref dec; } in
  env

(* Macro Generation *)

let macro_template = {|
.. MATH MACROS


.. Generic Stuff
.. -------------

.. Type-setting of names
.. X - (multi-letter) variables / non-terminals
.. F - functions
.. K - keywords / terminals
.. B - binary grammar non-terminals
.. T - textual grammar non-terminals

.. |X| mathdef:: \mathit
.. |F| mathdef:: \mathrm
.. |K| mathdef:: \mathsf
.. |B| mathdef:: \mathtt
.. |T| mathdef:: \mathtt

|}

(* TODO a hack to remove . s in name, i.e., LOCAL.GET to LOCALGET,
   such that it is macro-compatible *)
let macroify s = 
  let del acc c =
    if c = '.' || c = '_' then acc
    else acc ^ (String.make 1 c) 
  in
  String.fold_left del "" s

let gen_macro_keyword s = 
  let s = if String.uppercase_ascii s = s then String.lowercase_ascii s else s in
  let escape acc c =
    if c = '.' then acc ^ "{.}"
    else if c = '_' then acc ^ "\\_"
    else acc ^ (String.make 1 c)
  in
  String.fold_left escape "" s

let gen_macro_def env ref s =
  (* TODO hardcoded to avoid duplicate macros *)
  if s = "_F" then ""
  else if s = "LABEL_" then ".. |label| mathdef:: {\\X{label}}"
  else
    let xref = match Map.find_opt ref !(env.section) with
      | Some path -> sprintf "\\xref{%s}{%s}" path ref
      | None -> ""
    in
    let typ = if s = (String.uppercase_ascii s) then "K" else "X" in
    sprintf ".. |%s| mathdef:: %s{\\%s{%s}}"
      (macroify s) xref typ (gen_macro_keyword s)

let gen_macro_syn env seen =
  let syn = !(env.syn) in
  Map.fold
    (fun parent children acc ->
      let ssyn, seen = acc in
      let schildren, seen = List.fold_left
        (fun acc keyword ->
          let schildren, seen = acc in
          let (skeyword, seen) = 
            if Set.mem keyword seen then (".. (duplicate) " ^ keyword, seen)
            else (gen_macro_def env ("syntax-" ^ parent) keyword, Set.add keyword seen)
          in
          (schildren ^ skeyword ^ "\n", seen))
        ("", seen) children
      in
      let ssyn = ssyn
        ^ ".. " ^ (String.uppercase_ascii parent) ^ "\n"
        ^ ".. " ^ (String.make (String.length parent) '-') ^ "\n"
        ^ schildren
        ^ "\n"
      in
      (ssyn, seen)
    )
    syn ("", seen)

let gen_macro_dec env seen =
  let dec = !(env.dec) in
  Set.fold
    (fun keyword acc -> 
      let sdec, seen = acc in
      let skeyword, seen =
        if Set.mem keyword seen then (".. (duplicate) " ^ keyword, seen)
        else (gen_macro_def env ("exec-" ^ keyword) keyword, Set.add keyword seen)
      in
      (sdec ^ skeyword ^ "\n", seen))
    dec ("", seen)

let gen_macro' env =
  let (ssyn, seen) = gen_macro_syn env Set.empty in
  let (sdec, _seen) = gen_macro_dec env seen in
  macro_template
  ^ ".. Syntax\n.. ------\n\n"
  ^ ssyn
  ^ ".. Functions\n.. ---------\n\n"
  ^ sdec

let gen_macro env =
  let s = gen_macro' env in
  let oc = Out_channel.open_text "macros.def" in
  Fun.protect (fun () -> Out_channel.output_string oc s) 
    ~finally:(fun () -> Out_channel.close oc)
