open Printf
open Util.Source

module Set = Set.Make(String)
module Map = Map.Make(String)

(* Helpers *)

(* TODO a hack to remove . s in name, i.e., LOCAL.GET to LOCALGET,
   such that it is macro-compatible *)
let macroify ?(note = "") s = 
  let is_alphanumeric c = match c with
    | 'a' .. 'z' | 'A' .. 'Z' | '0' .. '9' -> true
    | _ -> false
  in
  let del acc c =
    if is_alphanumeric c then acc ^ (String.make 1 c)
    else acc 
  in
  String.fold_left del "" (s ^ note)

(* Environment *)

type env =
  { 
    legal: bool;
    sections: string Map.t ref;
    keywords: (Set.t * Set.t) Map.t ref;
    funcs: Set.t ref;
  }

let get_section env = !(env.sections)
let get_keyword env = !(env.keywords)
let get_func env = !(env.funcs)

let find_section env s = Map.mem s !(env.sections)

let rec find_keyword' env nonterminals variant = match nonterminals with
  | nonterminal :: rest -> (match find_keyword env nonterminal variant with
    | Some s -> Some s
    | None -> find_keyword' env rest variant)
  | _ -> None

and find_keyword env syntax variant = match Map.find_opt syntax !(env.keywords) with
  | Some (terminals, nonterminals) ->
      if Set.mem variant terminals then
        Some (macroify ~note:syntax variant)
      else
        find_keyword' env (Set.elements nonterminals) variant
  | _ -> None

let find_func env s = Option.map (fun s -> macroify s) (Set.find_opt s !(env.funcs))

let find_keyword env keyword = 
  let variant, syntax = keyword in
  find_keyword env syntax variant

let find_funcname env funcname = find_func env funcname

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

let extract_keyword_keywords def =
  match def.it with
  | El.Ast.SynD (id, subid, typ, _) -> 
      let topsyntax, syntax = 
        if subid.it = "" then (None, id.it) 
        else (Some id.it, id.it ^ "-" ^ subid.it) 
      in
      let variants = extract_typ_keywords typ.it in
      let variants = List.fold_left (fun acc child -> Set.add child acc) Set.empty variants in
      let (terminals, nonterminals) = Set.partition (fun word -> String.uppercase_ascii word = word) variants in
      Some (topsyntax, syntax, terminals, nonterminals)
  | _ -> None

let extract_func_keywords def =
  match def.it with
  | El.Ast.DecD (id, _, _, _) -> [ id.it ]
  | _ -> []

(* Environment Construction *)

let check_legal odsts =
  List.for_all (String.ends_with ~suffix:".rst") odsts

let env inputs outputs el =
  let legal = check_legal outputs in
  if legal then
    let sections = parse_section inputs outputs in
    let keywords = 
      List.fold_left
        (fun acc def -> match extract_keyword_keywords def with
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
    let funcs = List.concat_map extract_func_keywords el in
    let funcs = List.fold_left (fun s acc -> Set.add acc s) Set.empty funcs in
    let env = { legal; sections = ref sections; keywords = ref keywords; funcs = ref funcs; } in
    env
  else
    { legal; sections = ref Map.empty; keywords = ref Map.empty; funcs = ref Set.empty }

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

let gen_macro_word s = 
  let s = if String.uppercase_ascii s = s then String.lowercase_ascii s else s in
  let escape acc c =
    if c = '.' then acc ^ "{.}"
    else if c = '_' then acc ^ "\\_"
    else acc ^ (String.make 1 c)
  in
  String.fold_left escape "" s

let gen_macro_xref env header = match Map.find_opt header !(env.sections) with
  | Some path -> sprintf "\\xref{%s}{%s}" path header
  | None -> ""

let gen_macro_rule ?(note = "") env header font word =
  let xref = gen_macro_xref env header in
  sprintf ".. |%s| mathdef:: %s{\\%s{%s}}"
    (macroify ~note:note word) xref font (gen_macro_word word)

let gen_macro_keyword env syntax keyword =
  let header = "syntax-" ^ syntax in
  let font = "K" in
  gen_macro_rule ~note:syntax env header font keyword

let gen_macro_keywords env =
  let keyword = !(env.keywords) in
  Map.fold
    (fun syntax variants skeyword ->
      let terminals, _ = variants in
      let svariants = Set.fold
        (fun keyword svariants ->
          let svariant = gen_macro_keyword env syntax keyword in
          svariants ^ svariant ^ "\n")
        terminals "" 
      in
      skeyword
      ^ ".. " ^ (String.uppercase_ascii syntax) ^ "\n"
      ^ ".. " ^ (String.make (String.length syntax) '-') ^ "\n"
      ^ svariants
      ^ "\n")
    keyword "" 

let gen_macro_func env fname =
  let header = "def-" ^ fname in
  let font = "F" in
  gen_macro_rule env header font fname

let gen_macro_funcs env =
  let func = !(env.funcs) in
  Set.fold
    (fun fname sfunc -> 
      let sword = gen_macro_func env fname in
      sfunc ^ sword ^ "\n")
    func "" 

let gen_macro' env =
  let skeyword = gen_macro_keywords env in
  let sfunc = gen_macro_funcs env in
  macro_template
  ^ ".. syntax\n.. ------\n\n"
  ^ skeyword
  ^ ".. Functions\n.. ---------\n\n"
  ^ sfunc

let gen_macro env =
  if env.legal then
    let s = gen_macro' env in
    let oc = Out_channel.open_text "macros.def" in
    Fun.protect (fun () -> Out_channel.output_string oc s) 
      ~finally:(fun () -> Out_channel.close oc)
