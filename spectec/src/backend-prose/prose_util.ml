open Util.Source

let extract_prose_hint' = List.find_map (function
  | El.Ast.{ hintid = id; hintexp = { it = TextE prose; _ } }
    when id.it = "prose" -> Some prose
  | _ -> None)

let extract_prose_hint name = 
  !Langs.el |> List.find_map (fun def ->
    match def.it with
    | El.Ast.RelD (id, _typ, hints) when id.it = name ->
      let h = extract_prose_hint' hints in
      if (Option.is_some h) then (
      );
      h
    | _ -> None
  )


let rec alternate xs ys =
  match xs with
  | [] -> ys
  | x :: xs -> x :: alternate ys xs

let split_prose_hint input =
  let rec split_aux tokens substrings i =
    if i >= String.length input then (List.rev tokens, List.rev substrings)
    else if input.[i] = '%' then
      let j = ref (i + 1) in
      while !j < String.length input && Char.code input.[!j] >= 48 && Char.code input.[!j] <= 57 do
        incr j
      done;
      let token = String.sub input i (!j - i) in
      split_aux (token :: tokens) substrings !j
    else
      let j = ref i in
      while !j < String.length input && input.[!j] <> '%' do
        incr j
      done;
      let substring = String.sub input i (!j - i) in
      split_aux tokens (substring :: substrings) !j
  in
  split_aux [] [] 0

let hole_to_int hole =
  int_of_string (String.sub hole 1 (String.length hole - 1))
  
let apply_prose_hint name hint args = 
  let typ = !Langs.el |> List.find_map (fun def ->
    match def.it with
    | El.Ast.RelD (id, typ, _hints) when id.it = name ->
      Some(typ)
    | _ -> None
  ) in
  let has_context =
    match (Option.get typ).it with
    | El.Ast.InfixT (t1, _atom, _t2) ->
      (match t1.it with
      | VarT _ -> true
      | _ -> false
      )
    | _ -> false
    in
  let holes, template = split_prose_hint hint in
  let args = List.map (fun hole ->
    if has_context then
      List.nth args (hole_to_int hole - 2)
    else List.nth args (hole_to_int hole - 1)
    ) holes in
  alternate template args |> String.concat ""