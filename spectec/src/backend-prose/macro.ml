open Printf

module Set = Set.Make(String)
module Map = Map.Make(String)

(* Helpers *)

(* TODO a hack to remove . s in name, i.e., LOCAL.GET to LOCALGET,
   such that it is macro-compatible *)
let macroify ?(note = "") s =
  let is_alphanumeric c = match c with
    | 'a' .. 'z' | 'A' .. 'Z' | '0' .. '9' | '-' -> true
    | _ -> false
  in
  let del acc c =
    if is_alphanumeric c then acc ^ (String.make 1 c)
    else acc
  in
  String.fold_left del "" (s ^ "-" ^ note)

let font_macro = function
  | "X" -> "mathit"
  | "F" -> "mathrm"
  | "K" -> "mathsf"
  | _ -> "mathtt"

(* Environment *)

type env =
  {
    sections: string Map.t ref;
  }

(* Macro Generation *)

let macro_template = {|
.. MATH MACROS


.. Generic Stuff
.. -------------

.. Type-setting of names
.. X - (multi-letter) variables / non-terminals
.. F - functions
.. K - kwds / terminals
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

let gen_macro_rhs env header font word =
  let xref = gen_macro_xref env header in
  sprintf "%s{\\%s{%s}}"
    xref font (gen_macro_word word)

let gen_macro_rule ?(note = "") env header font word =
  let lhs = macroify ~note:note word in
  let rhs = gen_macro_rhs env header font word in
  sprintf ".. |%s| mathdef:: %s" lhs rhs

let gen_macro_kwd env syntax kwd =
  let header = "syntax-" ^ syntax in
  let font = "K" in
  gen_macro_rule ~note:syntax env header font kwd

let gen_macro_kwds env kwds =
  Map.fold
    (fun syntax variants skwd ->
      let terminals, _ = variants in
      let svariants = Set.fold
        (fun kwd svariants ->
          let svariant = gen_macro_kwd env syntax kwd in
          svariants ^ svariant ^ "\n")
        terminals ""
      in
      skwd
      ^ ".. " ^ (String.uppercase_ascii syntax) ^ "\n"
      ^ ".. " ^ (String.make (String.length syntax) '-') ^ "\n"
      ^ svariants
      ^ "\n")
    kwds ""

let gen_macro_func env fname =
  let header = "def-" ^ fname in
  let font = "F" in
  gen_macro_rule env header font fname

let gen_macro_funcs env funcs =
  Set.fold
    (fun fname sfunc ->
      let sword = gen_macro_func env fname in
      sfunc ^ sword ^ "\n")
    funcs ""

let gen_macro' env (symbol: Symbol.env)  =
  let skwd = gen_macro_kwds env !(symbol.kwds) in
  let sfunc = gen_macro_funcs env !(symbol.funcs) in
  macro_template
  ^ ".. syntax\n.. ------\n\n"
  ^ skwd
  ^ ".. Functions\n.. ---------\n\n"
  ^ sfunc

let gen_macro env symbol =
  let s = gen_macro' env symbol in
  let oc = Out_channel.open_text "macros.def" in
  Fun.protect (fun () -> Out_channel.output_string oc s)
    ~finally:(fun () -> Out_channel.close oc)

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

(* Environment Construction *)

let check_rst outputs =
  List.for_all (String.ends_with ~suffix:".rst") outputs

let env inputs outputs =
  let sections = if check_rst outputs then parse_section inputs outputs else Map.empty in
  { sections = ref sections; }

(* Environment Lookup *)

let find_section env s = Map.mem s !(env.sections)

let macro_kwd env kwd =
  let variant, syntax = kwd in
  let header = "syntax-" ^ syntax in
  let font = font_macro "K" in
  let with_macro = "\\" ^ (macroify ~note:syntax variant) in
  let without_macro = gen_macro_rhs env header font variant in
  (with_macro, without_macro)

let macro_func env fname =
  let header = "def-" ^ fname in
  let font = font_macro "F" in
  let with_macro = "\\" ^ (macroify fname) in
  let without_macro = gen_macro_rhs env header font fname in
  (with_macro, without_macro)
