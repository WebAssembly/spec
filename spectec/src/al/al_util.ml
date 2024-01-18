open Ast
open Util.Record

let get_name = function
  | RuleA ((name, _), _, _) -> name
  | FuncA (name, _, _) -> name

let listV a = ListV (ref a)

(* TODO: move this function to Al_util *)
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
