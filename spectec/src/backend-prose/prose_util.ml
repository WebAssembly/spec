open Util.Source

let extract_desc_hint = List.find_map (function
  | El.Ast.{ hintid = id; hintexp = { it = TextE desc; _ } }
    when id.it = "desc" -> Some desc
  | _ -> None)

let rec extract_desc typ = match typ.it with
  | Il.Ast.IterT (typ, Opt) -> extract_desc typ
  | Il.Ast.IterT (typ, _) -> [extract_desc typ; "sequence"] |> String.concat " "
  | Il.Ast.VarT _ ->
    let name = Il.Print.string_of_typ typ in
    (match !Langs.el |> List.find_map (fun def ->
      match def.it with
      | El.Ast.TypD (id, subid, _, _, hints)
      | El.Ast.HintD {it = TypH (id, subid, hints); _}
        when id.it = name && (List.mem subid.it [""; "syn"]) ->
        extract_desc_hint hints
      | _ -> None)
    with
    | Some desc -> desc
    | None -> "")
  | _ -> ""

let rec alternate xs ys =
  match xs with
  | [] -> ys
  | x :: xs -> x :: alternate ys xs

(* TODO: improve this *)
let split_prose_hint input =
  let rec split_aux tokens substrings i =
    let len = String.length input in
    if i >= len then (List.rev tokens, List.rev substrings)
    else if input.[i] = '%' then
      let j = ref (i + 1) in
      while !j < len && Util.Lib.Char.is_digit_ascii input.[!j] do
        incr j
      done;
      let token = String.sub input i (!j - i) in
      split_aux (token :: tokens) substrings !j
    else
      let j = ref i in
      while !j < len && input.[!j] <> '%' do incr j done;
      let substring = String.sub input i (!j - i) in
      split_aux tokens (substring :: substrings) !j
  in
  split_aux [] [] 0

let hole_to_int hole =
  int_of_string (String.sub hole 1 (String.length hole - 1))

let apply_prose_hint hint args =
  let holes, template = split_prose_hint hint in
  let args = List.map (fun hole -> List.nth args (hole_to_int hole - 1)) holes in
  alternate template args |> String.concat ""
