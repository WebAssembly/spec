open Ast
open Util

let get_name = function
  | RuleA ((name, _), _, _) -> name
  | FuncA (name, _, _) -> name

let get_param = function
  | RuleA (_, params, _) -> params
  | FuncA (_, params, _) -> params

let get_body = function
  | RuleA (_, _, body) -> body
  | FuncA (_, _, body) -> body



let listV a = ListV (ref a)

let listv_find f = function
  | ListV arr_ref -> Array.find_opt f !arr_ref |> Option.get
  | _ -> failwith "Not a list"

let listv_nth l n =
  match l with
  | ListV arr_ref -> Array.get !arr_ref n
  | _ -> failwith "Not a list"

let casev_nth_arg n = function
  | CaseV (_, l) -> List.nth l n
  | _ -> failwith "Not a case"

let strv_access field = function
  | StrV r -> Record.find field r
  | _ -> failwith "Not a record"

let map
  (destruct: value -> 'a)
  (construct: 'b -> value)
  (op: 'a -> 'b)
  (v: value): value =
    destruct v |> op |> construct
let map2
  (destruct: value -> 'a)
  (construct: 'b -> value)
  (op: 'a -> 'a -> 'b)
  (v1: value)
  (v2: value): value =
    op (destruct v1) (destruct v2) |> construct
