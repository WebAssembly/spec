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
    prosepp_hints : hints ref;
    desc_hints : hints ref;
  }

let hintenv =
  {
    prose_hints = ref Map.empty;
    prosepp_hints = ref Map.empty;
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
    env_hints "prosepp" hintenv.prosepp_hints id hints;
  | El.Ast.TypH (id1, id2, hints) ->
    let id = if id2.it = "" then id1 else (id1.it ^ "/" ^ id2.it) $ id2.at in
    env_hints "desc" hintenv.desc_hints id hints;
  | El.Ast.GramH (id1, id2, hints) ->
    let id = if id2.it = "" then id1 else (id1.it ^ "/" ^ id2.it) $ id2.at in
    env_hints "desc" hintenv.desc_hints id hints;
  | El.Ast.RelH (id, hints) ->
    env_hints "prose" hintenv.prose_hints id hints;
    env_hints "prosepp" hintenv.prosepp_hints id hints;
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
      env_hints "prosepp" hintenv.prosepp_hints id hints;
    ) l
  | El.Ast.CaseT (_, _, l, _) ->
    List.iter (function
    | Nl -> ()
    | Elem (atom, _, hints) ->
      let id = sprintf "%s.%s" id.it (Xl.Atom.to_string atom) $ no_region in
      env_hints "desc" hintenv.desc_hints id hints;
      env_hints "prose" hintenv.prose_hints id hints;
      env_hints "prosepp" hintenv.prosepp_hints id hints;
    ) l
  | El.Ast.ConT (_, hints) ->
    env_hints "desc" hintenv.desc_hints id hints;
    env_hints "prose" hintenv.prose_hints id hints;
    env_hints "prosepp" hintenv.prosepp_hints id hints;
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
  (* Assumption: desc hint is TextE *)
  match Map.find_opt name !(hintenv.desc_hints) with
  | Some (Some { it = TextE desc; _ }, _) -> Some desc
  | Some (None, l) ->
    let match_texte e = match e.it with
      | El.Ast.TextE desc -> Some desc
      | _ -> None
    in
    (match List.find_map match_texte l with
    | Some desc -> Some desc
    | None -> None)
  | _ -> None

let find_prose_hint name =
  match Map.find_opt name !(hintenv.prose_hints) with
  | Some (Some prose, _) | Some (None, [prose; _]) -> Some prose
  | _ -> None

let find_prosepp_hint name =
  match Map.find_opt name !(hintenv.prosepp_hints) with
  | Some (Some prose, _) | Some (None, [prose; _]) -> Some prose
  | _ -> None

let find_hint hintid name =
  match hintid with
  | "prose" -> find_prose_hint name
  | "prosepp" -> find_prosepp_hint name
  | _ -> None

let rec unwrap_itert typ = match typ.it with
| Il.Ast.IterT (typ, Opt) -> unwrap_itert typ
| Il.Ast.IterT (typ, _) ->
  let bt, iter = unwrap_itert typ in
  (bt, iter + 1)
| _ -> (typ, 0)

let extract_desc' typ =
  let bt, iter = unwrap_itert typ in
  match bt.it with
  | Il.Ast.VarT _ ->
    let name = Il.Print.string_of_typ bt in
    let* desc = find_desc_hint name in
    Some (desc, iter)
  | _ -> None

let extract_desc expr =
  let extract_context_desc expr =
    match expr.it with
    | Al.Ast.AccE (e', { it = IdxP _ ; _ }) ->
      (match e'.it with
      | Al.Ast.AccE (e'', { it = DotP atom; _ }) ->
        let name = Il.Print.string_of_typ e''.note ^ "." ^ Xl.Atom.to_string atom in
        let* desc = find_desc_hint name in
        Some (desc, "")
      | _ -> None
      )
    | _ -> None
  in
  match extract_context_desc expr with
  | Some (desc, seq) -> Some (desc, seq)
  | None ->
    let* desc, iter = extract_desc' expr.note in
    let rec repeat n s = if (n = 0) then "" else (repeat (n-1) s) ^ s in
    Some (desc, repeat iter " sequence")

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

let rec find_case_typ' s a: El.Ast.typ list option =
  let open El.Ast in
  let find_typd = function
    | { it = TypD (id', _, _, typ, _); _ } when s = id'.it -> Some typ
    | _ -> None
  in
  let typds = List.filter_map find_typd !Langs.el in
  List.find_map (function
  | { it = CaseT (_, ts, tcs, _); _ } ->
    let find_typ = function
      | Elem (atom, (typ, _prems), _hints) when Xl.Atom.eq atom a ->
        (match typ.it with
        | SeqT ts -> Some ts
        | _ -> None)
      | _ -> None
    in
    (match List.find_map find_typ tcs with
    | Some ts -> Some ts
    | _ ->
      List.find_map (function
      | Nl -> None
      | Elem typ -> find_case_typ' (El.Print.string_of_typ typ) a
      ) ts
    )
  | _ -> None) typds

let find_case_typ s a: El.Ast.typ list =
  match find_case_typ' s a with
  | Some ts -> ts
  | None ->
    let msg = sprintf "cannot find typcase of atom %s from typ %s"
      (Xl.Atom.to_string a) s in
    error no_region msg

open El.Ast
open El.Convert

(* If there is a hint of the form prose-xxx, temporarily consider as if it were the hint xxx *)
let replace_prose_hints hs =
  let phs, hs = List.partition (fun h -> String.starts_with ~prefix:"prose_" h.hintid.it) hs in
  let hs' = Util.Lib.List.filter_not (fun h ->
    List.exists (fun ph -> ph.hintid.it = "prose_" ^ h.hintid.it) phs
  ) hs in

  let phs' = List.map (fun ph ->
    let name = ph.hintid.it in
    let name' = String.sub name 6 (String.length name - 6) in
    let hintid' = {ph.hintid with it = name'} in
    {ph with hintid = hintid'}
  ) phs in

  phs' @ hs'

let rec replace_prose_hint_typ t =
  let it =
    match t.it with
    | VarT (id, args) -> VarT (id, args)
    | BoolT -> BoolT
    | NumT n -> NumT n
    | TextT -> TextT
    | ParenT t1 -> ParenT (replace_prose_hint_typ t1)
    | TupT ts -> TupT (List.map replace_prose_hint_typ ts)
    | IterT (t1, iter) -> IterT (replace_prose_hint_typ t1, iter)
    | StrT fields ->
        StrT (map_nl_list (fun (a, (t, prems), hints) ->
          (a, (replace_prose_hint_typ t, prems), replace_prose_hints hints)) fields)
    | CaseT (d1, tys, cases, d2) ->
        let tys' = map_nl_list replace_prose_hint_typ tys in
        let cases' = map_nl_list (fun (a, (t, prems), hints) ->
          (a, (replace_prose_hint_typ t, prems), replace_prose_hints hints)) cases
        in
        CaseT (d1, tys', cases', d2)
    | ConT ((t1, prems), hints) -> ConT ((replace_prose_hint_typ t1, prems), replace_prose_hints hints)
    | RangeT nums -> RangeT nums
    | AtomT a -> AtomT a
    | SeqT ts -> SeqT (List.map replace_prose_hint_typ ts)
    | InfixT (t1, a, t2) -> InfixT (replace_prose_hint_typ t1, a, replace_prose_hint_typ t2)
    | BrackT (a1, t1, a2) -> BrackT (a1, replace_prose_hint_typ t1, a2)
  in
  {t with it}

let replace_prose_hint_hintdef h =
  let it =
    match h.it with
    | AtomH (id, atom, hs) -> AtomH (id, atom, replace_prose_hints hs)
    | TypH (id1, id2, hs) -> TypH (id1, id2, replace_prose_hints hs)
    | GramH (id1, id2, hs) -> GramH (id1, id2, replace_prose_hints hs)
    | RelH (id, hs) -> RelH (id, replace_prose_hints hs)
    | VarH (id, hs) -> VarH (id, replace_prose_hints hs)
    | DecH (id, hs) -> DecH (id, replace_prose_hints hs)
  in
  {h with it}

let replace_prose_hint_def d =
  let it =
    match d.it with
    | FamD (id, params, hs) -> FamD (id, params, replace_prose_hints hs)
    | TypD (id, typid, args, typ, hs) -> TypD (id, typid, args, replace_prose_hint_typ typ, replace_prose_hints hs)
    | GramD (id, gramid, params, typ, gram, hs) -> GramD (id, gramid, params, replace_prose_hint_typ typ, gram, replace_prose_hints hs)
    | RelD (id, typ, hs) -> RelD (id, replace_prose_hint_typ typ, replace_prose_hints hs)
    | VarD (id, typ, hs) -> VarD (id, replace_prose_hint_typ typ, replace_prose_hints hs)
    | DecD (id, params, typ, hs) -> DecD (id, params, replace_prose_hint_typ typ, replace_prose_hints hs)
    | HintD hintdef -> HintD (replace_prose_hint_hintdef hintdef)
    | it -> it
  in
  {d with it}

let replace_prose_hint el =
  List.map replace_prose_hint_def el
