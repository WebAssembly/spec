open Util.Source
open Printf

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
  | El.Ast.SynD (syntax, _, _, typ, _) -> 
      let show_hints = extract_typ_hints typ in
      List.fold_left
        (fun acc (variant, hint) -> 
          KMap.add (variant, syntax.it) hint acc)
        show_kwds show_hints
  | _ -> show_kwds

let extract_func_hints show_funcs def =
  match def.it with
  | El.Ast.DecD (func, _, _, hints) ->
      let show_hints = List.concat_map extract_show_hint hints in
      (match show_hints with
      | hint :: _ -> FMap.add func.it hint show_funcs
      | [] -> show_funcs)
  | _ -> show_funcs

(* Environment Construction *)

let env el =
  let show_kwds = List.fold_left extract_syntax_hints KMap.empty el in
  (*
  print_endline "show_kwds";
  KMap.iter (fun (a, b) v -> sprintf "\t(%s,%s) => %s" a b (El.Print.string_of_exp v) |> print_endline) show_kwds;
  *)
  let show_funcs = List.fold_left extract_func_hints FMap.empty el in
  (*
  print_endline "show_funcs";
  FMap.iter (fun k v -> sprintf "\t%s => %s" k (El.Print.string_of_exp v) |> print_endline) show_funcs;
  *)
  { show_kwds = ref show_kwds; show_funcs = ref show_funcs }

(* Environment Lookup *)

let find_kwd_hint env kwd =
  let variant, syntax = kwd in
  sprintf "Request keyword (%s, %s): " variant syntax |> print_endline;
  (match KMap.find_opt kwd !(env.show_kwds) with
  | Some hint -> El.Print.string_of_exp hint 
  | None -> "not found")
  |> print_endline 

let find_func_hint env funcname = 
  sprintf "Request function %s: " funcname |> print_endline;
  (match FMap.find_opt funcname !(env.show_funcs) with
  | Some hint -> El.Print.string_of_exp hint 
  | None -> "not found")
  |> print_endline
