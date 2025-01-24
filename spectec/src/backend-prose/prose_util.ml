open Util.Source


let find_relation name =
  let open El.Ast in
  List.find_opt (fun def ->
  match def.it with
  | RelD (id, _, _) when id.it = name -> true
  | _ -> false
  ) !Langs.el

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

(* TODO: improve prose hint implementation *)
(* Currently hint is hardcoded as text *)
let split_prose_hint input =
  let rec split_aux tokens i =
    let len = String.length input in
    if i >= len then List.rev tokens
    else if input.[i] = '%' then
      let j = ref (i + 1) in
      while !j < len && Util.Lib.Char.is_digit_ascii input.[!j] do
        incr j
      done;
      let token = String.sub input i (!j - i) in
      split_aux (token :: tokens) !j
    else
      let j = ref i in
      while !j < len && input.[!j] <> '%' do incr j done;
      let substring = String.sub input i (!j - i) in
      split_aux (substring :: tokens) !j
  in
  split_aux [] 0

let hole_to_int hole =
  int_of_string (String.sub hole 1 (String.length hole - 1))

let apply_prose_hint hint args =
  let template = split_prose_hint hint in
  List.map (fun token ->
    if String.starts_with ~prefix:"%" token then List.nth args (hole_to_int token - 1)
    else token
   ) template;
  |> String.concat ""

let string_of_stack_prefix expr =
  let open Al.Ast in
  match expr.it with
  | GetCurContextE _
  | VarE ("F" | "L") -> ""
  | _ when Il.Eq.eq_typ expr.note Al.Al_util.frameT -> "the :ref:`frame <syntax-frame>` "
  | CaseE (mixop, _) when Il.Eq.eq_typ expr.note Al.Al_util.evalctxT ->
    let evalctx_name = Xl.Mixop.name (List.nth mixop 0)
    |> fun s -> String.sub s 0 (String.length s - 1)
    |> String.lowercase_ascii in
    Printf.sprintf "the :ref:`%s <syntax-%s>` " evalctx_name evalctx_name
  | IterE _ -> "the values "
  | _ -> "the value "
