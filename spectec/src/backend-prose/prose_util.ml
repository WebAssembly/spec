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
    func_prose_hints : hints ref;
    prose_allocxs_hints: hints ref; (* Hardcoded hint for allocX* in allocmodule *)
  }

let hintenv =
  {
    prose_hints = ref Map.empty;
    prosepp_hints = ref Map.empty;
    desc_hints = ref Map.empty;
    func_prose_hints = ref Map.empty;
    prose_allocxs_hints = ref Map.empty;
  }

(* Collect hints *)

let env_hints ?(partial = false) name map id hints =
  let open El.Ast in
  List.iter (fun {hintid; hintexp} ->
    if hintid.it = name then (
      (* print_endline (sprintf "prose hint for %s found: (%s %s)" id.it hintid.it (El.Print.string_of_exp hintexp)); *)
      map_update id.it hintexp map ~partial
    )
  ) hints

let env_hintdef ?(partial = false) hd =
  match hd.it with
  | El.Ast.VarH (id, hints) ->
    env_hints "desc" hintenv.desc_hints id hints ~partial;
    env_hints "prose_desc" hintenv.desc_hints id hints;
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
  | El.Ast.DecH (id, hints) ->
    env_hints "prose" hintenv.func_prose_hints id hints;
    env_hints "prose_allocxs" hintenv.prose_allocxs_hints id hints;
  | _ -> ()

let env_typ id t =
  let open El.Ast in
  match t.it with
  | El.Ast.StrT (_, _, l, _) ->
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
    else (
      env_hintdef (TypH (id1, id2, hints) $ d.at);
      env_hintdef (VarH (id1, hints) $ d.at) ~partial:true
    );
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
  (* "%n" -> n *)
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

let rec find_case_atom typ =
  let open El.Ast in
  match typ.it with
  | AtomT atom
  | BrackT (atom, _, _) -> Some atom
  | SeqT (typ1::_)
  | InfixT (typ1, _, _) -> find_case_atom typ1
  | _ -> None

let rec find_case_typ' s a: El.Ast.typ option =
  let open El.Ast in
  let find_typd = function
    | { it = TypD (id', _, _, typ, _); _ } when s = id'.it -> Some typ
    | _ -> None
  in
  let typds = List.filter_map find_typd !Langs.el in
  List.find_map (function
  | { it = CaseT (_, ts, tcs, _); _ } ->
    let find_typ = function
      | Nl -> None
      | Elem (_atom, (typ, _prems), _hints) ->
        match find_case_atom typ with
        | Some atom when Xl.Atom.eq a atom -> Some typ
        | _ -> None
    in
    (match List.find_map find_typ tcs with
    | Some t -> Some t
    | _ ->
      List.find_map (function
      | Nl -> None
      | Elem typ -> find_case_typ' (El.Print.string_of_typ typ) a
      ) ts
    )
  | _ -> None) typds

let find_case_typ s a: El.Ast.typ =
  match find_case_typ' s a with
  | Some t -> t
  | None ->
    let msg = sprintf "cannot find typcase of atom %s from typ %s"
      (Xl.Atom.to_string a) s in
    error no_region msg

let extract_case_hint t mixop =
  let id1 = Il.Print.string_of_typ t in
  let id2 = Xl.Mixop.name (List.nth mixop 0) in
  let id = id1 ^ "." ^ id2 in
  match Map.find_opt id !(hintenv.prose_hints) with
  | Some (Some e, _) -> Some e
  | _ -> None

let extract_call_hint fname =
  match Map.find_opt fname !(hintenv.func_prose_hints) with
  | Some (Some e, _) -> Some e
  | _ -> None

let is_allocxs fname =
  match Map.find_opt fname !(hintenv.prose_allocxs_hints) with
  | Some _ -> true
  | _ -> false

(* EL Helpers *)
open El.Ast

let rec walk_el_exp (f : El.Ast.exp -> El.Ast.exp) (e : El.Ast.exp) : El.Ast.exp =
  let we = walk_el_exp f in
  let it =
    match e.it with
    | VarE (id, args) -> VarE (id, args)
    | AtomE _ | BoolE _ | NumE _ | TextE _ | EpsE | SizeE _ | HoleE _ | LatexE _ -> e.it
    | CvtE (e1, t) -> CvtE (we e1, t)
    | UnE (op, e1) -> UnE (op, we e1)
    | BinE (e1, op, e2) -> BinE (we e1, op, we e2)
    | CmpE (e1, op, e2) -> CmpE (we e1, op, we e2)
    | SeqE es -> SeqE (List.map we es)
    | ListE es -> ListE (List.map we es)
    | IdxE (e1, e2) -> IdxE (we e1, we e2)
    | SliceE (e1, e2, e3) -> SliceE (we e1, we e2, we e3)
    | UpdE (e1, path, e2) -> UpdE (we e1, path, we e2)
    | ExtE (e1, path, e2) -> ExtE (we e1, path, we e2)
    | StrE fields -> StrE (El.Convert.map_nl_list (fun (a, e) -> (a, we e)) fields)
    | DotE (e1, a) -> DotE (we e1, a)
    | CommaE (e1, e2) -> CommaE (we e1, we e2)
    | CatE (e1, e2) -> CatE (we e1, we e2)
    | MemE (e1, e2) -> MemE (we e1, we e2)
    | LenE e1 -> LenE (we e1)
    | ParenE e1 -> ParenE (we e1)
    | TupE es -> TupE (List.map we es)
    | InfixE (e1, a, e2) -> InfixE (we e1, a, we e2)
    | BrackE (a1, e1, a2) -> BrackE (a1, we e1, a2)
    | CallE (id, args) -> CallE (id, List.map (walk_el_arg f) args)
    | IterE (e1, i) -> IterE (we e1, i)
    | TypE (e1, t) -> TypE (we e1, t)
    | ArithE e1 -> ArithE (we e1)
    | FuseE (e1, e2) -> FuseE (we e1, we e2)
    | UnparenE e1 -> UnparenE (we e1)
  in
  f {e with it}

and walk_el_arg f a =
  match !(a.it) with
  | ExpA e -> {a with it = ref @@ ExpA (walk_el_exp f e)}
  | _ -> a

let fill_hole args = walk_el_exp
  (fun e ->
    match e.it with
    | HoleE (`Num i) -> List.nth args (i-1)
    | _ -> e
  )
