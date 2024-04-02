module Set = Set.Make(String)
module Map = Map.Make(String)

(* Environment *)

type env =
  {
    sections: string Map.t ref;
  }

(* Environment Lookup *)

let find_section env s = Map.mem s !(env.sections)

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
