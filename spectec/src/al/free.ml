open Ast
open Util.Record

let rec free_expr = function
  | NumE _
  | StringE _
  | GetCurLabelE
  | GetCurContextE
  | GetCurFrameE
  | YetE _ -> []
  | NameE n -> [n]
  | MinusE e
  | LengthE e
  | ArityE e
  | ContE e -> free_expr e
  | BinopE (_, e1, e2)
  | ListFillE (e1, e2)
  | ConcatE (e1, e2)
  | PairE (e1, e2)
  | ArrowE (e1, e2)
  | LabelE (e1, e2) -> free_expr e1 @ free_expr e2
  | FrameE (e_opt, e) ->
      Option.value (Option.map free_expr e_opt) ~default:[] @ free_expr e
  | AppE (_, es)
  | ListE es
  | ConstructE (_, es) -> List.concat_map free_expr es
  | RecordE r -> Record.fold (fun _k e acc -> free_expr e @ acc) r []
  | AccessE (e, p) -> free_expr e @ free_path p
  | ExtendE (e1, ps, e2, _)
  | ReplaceE (e1, ps, e2) -> free_expr e1 @ List.concat_map free_path ps @ free_expr e2
  | OptE e_opt -> List.concat_map free_expr (Option.to_list e_opt)
  | IterE (e, _, i) -> free_expr e @ free_iter i
and free_iter = function
  | Opt
  | List
  | List1 -> []
  | ListN (e, name_opt) -> Option.to_list name_opt @ free_expr e
and free_path = function
  | IndexP e -> free_expr e
  | SliceP (e1, e2) -> free_expr e1 @ free_expr e2
  | DotP _ -> []

let rec free_cond = function
  | NotC c -> free_cond c
  | BinopC (_, c1, c2) -> free_cond c1 @ free_cond c2
  | CompareC (_, e1, e2) -> free_expr e1 @ free_expr e2
  | TopLabelC
  | TopFrameC
  | TopValueC None
  | YetC _ -> []
  | ContextKindC (_, e)
  | IsDefinedC e
  | IsCaseOfC (e, _)
  | ValidC e
  | TopValueC (Some e)
  | TopValuesC e -> free_expr e

let free_ns_iter (_, iter) = free_iter iter

let rec free_instr = function
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
  | AppendI (e1, e2)
  | AppendListI (e1, e2) -> free_expr e1 @ free_expr e2
  (* Others *)
  | EnterI (e1, e2, il) -> free_expr e1 @ free_expr e2 @ List.concat_map free_instr il
  | AssertI c -> free_cond c
  | PerformI (_, el) -> List.concat_map free_expr el
  | ReplaceI (e1, p, e2) -> free_expr e1 @ free_path p @ free_expr e2
