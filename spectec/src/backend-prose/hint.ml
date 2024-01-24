open Util.Source

module KMap = Map.Make(struct
  type t = string * string
  let compare (a1, a2) (b1, b2) =
    let c1 = String.compare a1 b1 in
    let c2 = String.compare a2 b2 in
    if c1 = 0 then c2 else c1
end)
module FMap = Map.Make(String)

(* Environment *)

type env =
  {
    render_latex: Backend_latex.Render.env;
    show_kwds: El.Ast.exp KMap.t ref;
    show_funcs: El.Ast.exp FMap.t ref;
  }

(* Extracting Hint from DSL *)
(* Assume each syntax variant / function have at most one "show" hint. *)

let extract_show_hint (hint: El.Ast.hint) =
  if hint.hintid.it = "show" then [ hint.hintexp ] else []

let extract_typcase_hint = function
  | El.Ast.Nl -> None
  | El.Ast.Elem (atom, _, hints) -> (match atom with
    | El.Ast.Atom id ->
        let show_hints = List.concat_map extract_show_hint hints in
        (match show_hints with
        | hint :: _ -> Some (id, hint)
        | [] -> None)
    | _ -> None)

let extract_typ_hints typ =
  match typ.it with
  | El.Ast.CaseT (_, _, typcases, _) -> List.filter_map extract_typcase_hint typcases
  | _ -> []

let extract_syntax_hints show_kwds def =
  match def.it with
  | El.Ast.SynD (id, subid, _, typ, _) ->
      let id =
        if subid.it = "" then id.it
        else id.it ^ "-" ^ subid.it
      in
      let show_hints = extract_typ_hints typ in
      List.fold_left
        (fun acc (variant, hint) ->
          KMap.add (variant, id) hint acc)
        show_kwds show_hints
  | _ -> show_kwds

let extract_func_hints show_funcs def =
  match def.it with
  | El.Ast.DecD (id, _, _, hints) ->
      let show_hints = List.concat_map extract_show_hint hints in
      (match show_hints with
      | hint :: _ -> FMap.add id.it hint show_funcs
      | [] -> show_funcs)
  | _ -> show_funcs

(* Environment Construction *)

let env render_latex el =
  let show_kwds = List.fold_left extract_syntax_hints KMap.empty el in
  let show_funcs = List.fold_left extract_func_hints FMap.empty el in
  {
    render_latex;
    show_kwds = ref show_kwds;
    show_funcs = ref show_funcs
  }

(* Hint Application *)

let apply_hint env args hint =
  (* TODO Placeholder El args with "!!!", to be expanded into the El hint exp. *)
  let placeholder =
    let text = (El.Ast.TextE "!!!") $ no_region in
    let arg = El.Ast.ExpA text in
    (ref arg) $ no_region
  in
  let placeholders = List.init (List.length args) (fun _ -> placeholder) in
  (* Expand hint exp with placeholder args, then manipulate the rendered hint exp by string replacements. *)
  try
    let hint_expanded = Backend_latex.Render.expand_exp (ref placeholders) hint in
    let hint_rendered = Backend_latex.Render.render_exp env.render_latex hint_expanded in
    let hint_replaced =
      let placeholder = Str.regexp (Backend_latex.Render.render_arg env.render_latex placeholder) in
      List.fold_left
        (fun hint_rendered arg -> Str.replace_first placeholder arg hint_rendered)
        hint_rendered args
    in
    Some hint_replaced
  with _ -> None

let apply_kwd_hint env kwd args =
  let hint = KMap.find_opt kwd !(env.show_kwds) in
  Option.bind hint (apply_hint env args)

let apply_func_hint env fname args =
  let hint = FMap.find_opt fname !(env.show_funcs) in
  Option.bind hint (apply_hint env args)
