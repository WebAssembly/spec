(*
Lifts type aliases out of mutual groups.
*)

open Util
open Source
open Il.Ast
open Il.Walk

(* Errors *)

let error at msg = Error.error at "alias recursion lifting" msg

(* Environment *)

(* Global IL env*)
let env_ref = ref Il.Env.empty

module S = Set.Make(String)

type env = {
  aliases : S.t; (* Aliases to reduce *)
}

(* The main transformation case *)

let t_typ env x =
  match x.it with
  | VarT (id, []) when S.mem id.it env.aliases -> Il.Eval.reduce_typ !env_ref x
  | _ -> x

let alias_def_id def = 
  match def.it with
  | TypD(id, _, [{it = InstD (_, _, {it = AliasT _; _}); _}]) -> Some id.it
  | _ -> None

let is_alias_typ_def def = Option.is_some (alias_def_id def)

let rec t_def env def = 
  let t = { base_transformer with transform_typ = t_typ env } in 
  match def.it with
  | RecD defs ->
      let alias_defs, other_defs = List.partition is_alias_typ_def defs in
      let new_ids = List.filter_map alias_def_id alias_defs in
      let env' = { aliases = S.union env.aliases (S.of_list new_ids) } in
      let other_defs = List.concat_map (t_def env') other_defs in
      let alias_defs = List.concat_map (t_def env') alias_defs in
      if other_defs = [] then
        error (at def) "mutual group consists entirely of type aliases; at least one non-alias definition is required"
      else
        [ { def with it = RecD other_defs} ] @ alias_defs
  | _  -> [ transform_def t def ]

let transform (defs : script) =
  env_ref := Il.Env.env_of_script defs;
  let env = { aliases = S.empty } in
  List.concat_map (t_def env) defs
