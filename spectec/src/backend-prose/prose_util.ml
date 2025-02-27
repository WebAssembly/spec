open Util.Source
open Printf

(* Errors *)

let error at msg = Util.Error.error at "prose rendering" msg

(* Environment *)

module Map = Map.Make(String)
type hints = (El.Ast.exp option * El.Ast.exp list) Map.t   (* exact match and partial matches*)

let map_update ?(partial = false) x y map =
  if partial then
    map := Map.update x
      (function
      | None -> Some (None, [y])
      | Some (y', l) -> Some (y', y :: l)
      ) !map
  else
    map := Map.update x
      (function
      | None -> Some (Some y, [])
      | Some (None, l) -> Some (Some y, l)
      | Some (Some y', l) ->
        if El.Eq.eq_exp y y' then
          Some (Some y', l)
        else
          let msg = sprintf "multiple prose hints for %s: %s, %s"
            x (El.Print.string_of_exp y) (El.Print.string_of_exp y') in
          error no_region msg
      ) !map

type hintenv = 
  {
    prose_hints : hints ref;
    desc_hints : hints ref;
  }

let hintenv = 
  {
    prose_hints = ref Map.empty;
    desc_hints = ref Map.empty;
  }

(* Collect hints *)

let env_hints ?(partial = false) name map id hints =
  let open El.Ast in
  List.iter (fun {hintid; hintexp} ->
    if hintid.it = name then (
      (* print_endline (sprintf "prose hint for %s found: %s" id.it (El.Print.string_of_exp hintexp)); *)
      map_update id.it hintexp map ~partial
    )
  ) hints

let env_hintdef ?(partial = false) hd =
  match hd.it with
  | El.Ast.VarH (id, hints) ->
    env_hints "desc" hintenv.desc_hints id hints ~partial;
    env_hints "prose" hintenv.prose_hints id hints;
  | El.Ast.TypH (id1, id2, hints) ->
    let id = if id2.it = "" then id1 else (id1.it ^ "/" ^ id2.it) $ id2.at in
    env_hints "desc" hintenv.desc_hints id hints;
  | El.Ast.GramH (id1, id2, hints) ->
    let id = if id2.it = "" then id1 else (id1.it ^ "/" ^ id2.it) $ id2.at in
    env_hints "desc" hintenv.desc_hints id hints;
  | El.Ast.RelH (id, hints) ->
    env_hints "prose" hintenv.prose_hints id hints
  | _ -> ()

let env_typ id t =
  let open El.Ast in
  match t.it with
  | El.Ast.StrT l ->
    List.iter (function
    | Nl -> ()
    | Elem (atom, _, hints) ->
      let id = sprintf "%s.%s" id.it (Xl.Atom.to_string atom) $ no_region in
      env_hints "desc" hintenv.desc_hints id hints;
      env_hints "prose" hintenv.prose_hints id hints;
    ) l
  | El.Ast.CaseT (_, _, l, _) ->
    List.iter (function
    | Nl -> ()
    | Elem (atom, _, hints) ->
      let id = sprintf "%s.%s" id.it (Xl.Atom.to_string atom) $ no_region in
      env_hints "desc" hintenv.desc_hints id hints;
      env_hints "prose" hintenv.prose_hints id hints;
    ) l
  | El.Ast.ConT (_, hints) ->
    env_hints "desc" hintenv.desc_hints id hints;
    env_hints "prose" hintenv.prose_hints id hints;
  | _ -> ()

let env_def d =
  let open El.Ast in
  match d.it with
  | FamD (id, _ps, hints) ->
    env_hintdef (TypH (id, "" $ id.at, hints) $ d.at);
    env_hintdef (VarH (id, hints) $ d.at);
  | TypD (id1, id2, _args, t, hints) ->
    if id2.it = "" then
      env_hintdef (VarH (id1, hints) $ d.at)
    else
      env_hintdef (TypH (id1, id2, hints) $ d.at);
      env_hintdef (VarH (id1, hints) $ d.at) ~partial:true;
    env_typ id1 t;
  | GramD (id1, id2, _ps, t, _gram, hints) ->
    env_hintdef (GramH (id1, id2, hints) $ d.at);
    env_typ id1 t;
  | RelD (id, t, hints) ->
    env_hintdef (RelH (id, hints) $ d.at);
    env_typ id t;
  | VarD (id, t, hints) ->
    env_hintdef (VarH (id, hints) $ d.at);
    env_typ id t;
  | DecD (id, _as, _e, hints) ->
    env_hintdef (DecH (id, hints) $ d.at);
  | HintD hd ->
    env_hintdef hd;
  | RuleD _ | DefD _ | SepD -> ()

let init_hintenv script =
  List.iter env_def script

(* Helpers *)

let (let*) = Option.bind

let find_relation name =
  let open El.Ast in
  List.find_opt (fun def ->
  match def.it with
  | RelD (id, _, _) when id.it = name -> true
  | _ -> false
  ) !Langs.el

let find_desc_hint name =
  let rec extract_seq desc =
    if String.ends_with desc ~suffix:" sequence" then
      let desc', st = extract_seq (String.sub desc 0 (String.length desc - 9)) in
      desc', st+1
    else desc, 0
  in
  match Map.find_opt name !(hintenv.desc_hints) with
  | Some (Some { it = TextE desc; _ }, _) -> Some (extract_seq desc)
  | Some (None, l) ->
    let match_texte e = match e.it with
      | El.Ast.TextE desc -> Some desc
      | _ -> None
    in
    (match List.find_map match_texte l with
    | Some desc -> Some (extract_seq desc)
    | None -> None)
  | _ -> None

let rec repeat n s = if (n = 0) then "" else (repeat (n-1) s) ^ s

let rec extract_desc' typ = match typ.it with
  | Il.Ast.IterT (typ, Opt) -> (match extract_desc' typ with
    | Some (desc, seq) -> Some (desc, seq)
    | None -> None)
  | Il.Ast.IterT (typ, _) -> (match extract_desc' typ with
  | Some (desc, seq) -> Some (desc, seq ^ " sequence")
  | None -> None)
  | Il.Ast.VarT _ ->
    let name = Il.Print.string_of_typ typ in
    let* desc, st = find_desc_hint name in
    Some (desc, repeat st " sequence")
  | _ -> None

let extract_desc expr =
  let extract_context_desc expr =
    match expr.it with
    | Al.Ast.AccE (e', { it = IdxP _ ; _ }) ->
      (match e'.it with
      | Al.Ast.AccE (e'', { it = DotP atom; _ }) ->
        let name = Il.Print.string_of_typ e''.note ^ "." ^ Xl.Atom.to_string atom in
        let* desc, st = find_desc_hint name in
        Some (desc, repeat st " sequence")
      | _ -> None
      )
    | _ -> None
  in
  match extract_context_desc expr with
  | Some (desc, seq) -> Some (desc, seq)
  | None -> extract_desc' expr.note

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
  | _ when Il.Eq.eq_typ expr.note Al.Al_util.frameT -> "the :ref:`frame <syntax-frame>`"
  | CaseE (mixop, _) when Il.Eq.eq_typ expr.note Al.Al_util.evalctxT ->
    let evalctx_name = Xl.Mixop.name (List.nth mixop 0)
    |> fun s -> String.sub s 0 (String.length s - 1)
    |> String.lowercase_ascii in
    Printf.sprintf "the %s" evalctx_name
  | IterE _ -> "the values"
  | _ -> "the value"
