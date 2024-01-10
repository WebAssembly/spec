open Ast
open Util.Source
open Util.Record

(* TODO: Change list to set *)
module IdSet = Set.Make (String)

(* intersection between id list *)
let intersection l1 l2 =
  let s1 = IdSet.of_list l1 in
  let s2 = IdSet.of_list l2 in
  IdSet.inter s1 s2 |> IdSet.elements


(* Expressions *)

let rec free_expr expr =
  match expr.it with
  | NumE _
  | BoolE _
  | GetCurLabelE
  | GetCurContextE
  | GetCurFrameE
  | YetE _ -> []
  | VarE id
  | SubE (id, _) -> [id]
  | UnE (_, e)
  | LenE e
  | ArityE e
  | ContE e -> free_expr e
  | BinE (_, e1, e2)
  | CatE (e1, e2)
  | ArrowE (e1, e2)
  | LabelE (e1, e2) -> free_expr e1 @ free_expr e2
  | FrameE (e_opt, e) ->
    Option.value (Option.map free_expr e_opt) ~default:[] @ free_expr e
  | CallE (_, el)
  | TupE el
  | ListE el
  | CaseE (_, el) -> List.concat_map free_expr el
  | StrE r -> Record.fold (fun _k e acc -> free_expr e @ acc) r []
  | AccE (e, p) -> free_expr e @ free_path p
  | ExtE (e1, ps, e2, _)
  | UpdE (e1, ps, e2) -> free_expr e1 @ List.concat_map free_path ps @ free_expr e2
  | OptE e_opt -> List.concat_map free_expr (Option.to_list e_opt)
  | IterE (e, _, i) -> free_expr e @ free_iter i
  | MatchE (e1, e2) -> free_expr e1 @ free_expr e2
  | TopLabelE
  | TopFrameE
  | TopValueE None -> []
  | ContextKindE (_, e)
  | IsDefinedE e
  | IsCaseOfE (e, _)
  | HasTypeE (e, _)
  | IsValidE e
  | TopValueE (Some e)
  | TopValuesE e -> free_expr e


(* Iters *)

and free_iter = function
  | Opt
  | List
  | List1 -> []
  | ListN (e, id_opt) -> Option.to_list id_opt @ free_expr e


(* Paths *)

and free_path path =
  match path.it with
  | IdxP e -> free_expr e
  | SliceP (e1, e2) -> free_expr e1 @ free_expr e2
  | DotP _ -> []


(* Instructions *)

let rec free_instr instr =
  match instr.it with
  | IfI (e, il1, il2) -> free_expr e @ List.concat_map free_instr il1 @ List.concat_map free_instr il2
  | OtherwiseI il -> List.concat_map free_instr il
  | EitherI (il1, il2) -> List.concat_map free_instr il1 @ List.concat_map free_instr il2
  | TrapI | NopI | ReturnI None | ExitI | YetI _ -> []
  | PushI e | PopI e | PopAllI e | ReturnI (Some e)
  | ExecuteI e | ExecuteSeqI e ->
    free_expr e
  | LetI (e1, e2) | AppendI (e1, e2) -> free_expr e1 @ free_expr e2
  | EnterI (e1, e2, il) -> free_expr e1 @ free_expr e2 @ List.concat_map free_instr il
  | AssertI e -> free_expr e
  | PerformI (_, el) -> List.concat_map free_expr el
  | ReplaceI (e1, p, e2) -> free_expr e1 @ free_path p @ free_expr e2
