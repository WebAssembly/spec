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

let rec free_expr expr =
  match expr.it with
  | NumE _
  | GetCurLabelE
  | GetCurContextE
  | GetCurFrameE
  | YetE _ -> []
  | VarE n
  | SubE (n, _) -> [n]
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
  | CallE (_, es)
  | TupE es
  | ListE es
  | CaseE (_, es) -> List.concat_map free_expr es
  | StrE r -> Record.fold (fun _k e acc -> free_expr e @ acc) r []
  | AccE (e, p) -> free_expr e @ free_path p
  | ExtE (e1, ps, e2, _)
  | UpdE (e1, ps, e2) -> free_expr e1 @ List.concat_map free_path ps @ free_expr e2
  | OptE e_opt -> List.concat_map free_expr (Option.to_list e_opt)
  | IterE (e, _, i) -> free_expr e @ free_iter i
and free_iter = function
  | Opt
  | List
  | List1 -> []
  | ListN (e, id_opt) -> Option.to_list id_opt @ free_expr e
and free_path path =
  match path.it with 
  | IdxP e -> free_expr e
  | SliceP (e1, e2) -> free_expr e1 @ free_expr e2
  | DotP _ -> []

let rec free_cond cond =
  match cond.it with
  | UnC (_, c) -> free_cond c
  | BinC (_, c1, c2) -> free_cond c1 @ free_cond c2
  | CmpC (_, e1, e2) 
  | MatchC (e1, e2) -> free_expr e1 @ free_expr e2
  | TopLabelC
  | TopFrameC
  | TopValueC None
  | YetC _ -> []
  | ContextKindC (_, e)
  | IsDefinedC e
  | IsCaseOfC (e, _)
  | HasTypeC (e, _)
  | IsValidC e
  | TopValueC (Some e)
  | TopValuesC e -> free_expr e

let free_ns_iter (_, iter) = free_iter iter

let rec free_instr instr =
  match instr.it with
  | IfI (c, il1, il2) -> free_cond c @ List.concat_map free_instr il1 @ List.concat_map free_instr il2
  | OtherwiseI il -> List.concat_map free_instr il
  | EitherI (il1, il2) -> List.concat_map free_instr il1 @ List.concat_map free_instr il2
  (* empty *)
  | TrapI
  | NopI
  | ReturnI None
  | ExitI
  | YetI _ -> []
  (* One e *)
  | PushI e
  | PopI e
  | PopAllI e
  | ReturnI (Some e)
  | ExecuteI e
  | ExecuteSeqI e -> free_expr e
  (* Two e *)
  | LetI (e1, e2)
  | AppendI (e1, e2) -> free_expr e1 @ free_expr e2
  (* Others *)
  | EnterI (e1, e2, il) -> free_expr e1 @ free_expr e2 @ List.concat_map free_instr il
  | AssertI c -> free_cond c
  | PerformI (_, el) -> List.concat_map free_expr el
  | ReplaceI (e1, p, e2) -> free_expr e1 @ free_path p @ free_expr e2
