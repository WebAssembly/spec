open Ast
open Util
open Source

module IdSet = Set.Make (String)

(* Expressions *)

let (@) = IdSet.union
let (-) = IdSet.diff
let free_opt free_x xo = Option.(value (map free_x xo) ~default:IdSet.empty)
let free_list free_x xs = List.(fold_left IdSet.union IdSet.empty (map free_x xs))


let free_id = IdSet.singleton

let rec free_expr expr =
  match expr.it with
  | NumE _
  | BoolE _
  | GetCurStateE
  | GetCurContextE _
  | ContextKindE _
  | YetE _ -> IdSet.empty
  | VarE id
  | SubE (id, _) -> free_id id
  | CvtE (e, _, _)
  | UnE (_, e)
  | LiftE e
  | LenE e
  | ChooseE e -> free_expr e
  | BinE (_, e1, e2)
  | CompE (e1, e2)
  | CatE (e1, e2)
  | MemE (e1, e2) -> free_expr e1 @ free_expr e2
  | CallE (_, al)
  | InvCallE (_, _, al) ->  free_list free_arg al
  | TupE el
  | ListE el
  | CaseE (_, el) -> free_list free_expr el
  | StrE r -> free_list (fun (_, e) -> free_expr !e) r
  | AccE (e, p) -> free_expr e @ free_path p
  | ExtE (e1, ps, e2, _)
  | UpdE (e1, ps, e2) -> free_expr e1 @ free_list free_path ps @ free_expr e2
  | OptE e_opt -> free_opt free_expr e_opt
  | IterE (e, ie) ->
    (* We look for semantic free variables, not the syntactic free variables. *)
    (* Therefore, in the expression `x*{x <- xs}`, xs is free, but x is not. *)
    let free1 = free_expr e in
    let bound, free2 = free_iterexp ie in
    (free1 - bound) @ free2
  | MatchE (e1, e2) -> free_expr e1 @ free_expr e2
  | TopValueE None -> IdSet.empty
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
  | List1 -> IdSet.empty
  | ListN (e, id_opt) -> free_opt IdSet.singleton id_opt @ free_expr e


(* Paths *)

and free_path path =
  match path.it with
  | IdxP e -> free_expr e
  | SliceP (e1, e2) -> free_expr e1 @ free_expr e2
  | DotP _ -> IdSet.empty


(* Args *)

and free_arg arg =
  match arg.it with
  | ExpA e -> free_expr e
  | TypA _
  | DefA _ -> IdSet.empty


(* Iter exps *)

and free_xes xes =
  let xs, es = List.split xes in
  free_list free_id xs, free_list free_expr es


and free_iterexp (iter, xes) =
  let bound, free = free_xes xes in
  bound, free_iter iter @ free


(* Instructions *)

let rec free_instr instr =
  match instr.it with
  | IfI (e, il1, il2) -> free_expr e @ free_list free_instr il1 @ free_list free_instr il2
  | OtherwiseI il -> free_list free_instr il
  | EitherI (il1, il2) -> free_list free_instr il1 @ free_list free_instr il2
  | TrapI | FailI | NopI | ReturnI None | ExitI _ | YetI _ -> IdSet.empty
  | ThrowI e | PushI e | PopI e | PopAllI e | ReturnI (Some e)
  | ExecuteI e | ExecuteSeqI e ->
    free_expr e
  | LetI (e1, e2) | AppendI (e1, e2) -> free_expr e1 @ free_expr e2
  | EnterI (e1, e2, il) -> free_expr e1 @ free_expr e2 @ free_list free_instr il
  | AssertI e -> free_expr e
  | PerformI (_, al) -> free_list free_arg al
  | ReplaceI (e1, p, e2) -> free_expr e1 @ free_path p @ free_expr e2
  | ForEachI (xes, il) ->
    let free1 = free_list free_instr il in
    let bound, free2 = free_xes xes in
    (free1 - bound) @ free2

(* Algorithms *)
let free_algo algo =
  match algo.it with
  | RuleA (_, _, args, instrs)
  | FuncA (_, args, instrs) -> free_list free_arg args @ free_list free_instr instrs
