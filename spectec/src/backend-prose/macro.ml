open Util.Source

module Map = Map.Make(String)

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
