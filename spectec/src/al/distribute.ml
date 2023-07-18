open Ast
open Print

(* TODO: Refactor it to assign iter *)
let rec wrap_iter iters e =
  match iters with
  | [] -> e
  | h :: t -> IterE (e, h) |> wrap_iter t


let distribute_lhs_iter =

  let rec distribute_lhs_iter' iters = function
    | IterE (e, iter) -> distribute_lhs_iter' (iter :: iters) e
    | ConstructE (tag, el) -> ConstructE (tag, List.map (wrap_iter iters) el)
    | e ->
        string_of_expr e
        |> Printf.sprintf "Invalid association lhs: %s"
        |> failwith
  in

  distribute_lhs_iter' []

let rec get_empty_rhs = function
  | IterE (e, _) -> get_empty_rhs e
  | ConstructE (tag, el) ->
      let args = List.map (fun _ -> listV []) el in
      ConstructV (tag, args)
  | e -> 
      string_of_expr e
      |> Printf.sprintf "Invalid association lhs: %s"
      |> failwith

let distribute_construct_list constrs =
  let tag =
    match List.hd constrs with
    | ConstructV (tag, _) -> tag
    | _ -> failwith "Unreachable association"
  in

  let args_list =
    List.map
      (function
        | ConstructV (_, vl) -> vl
        | _ -> failwith "Unreachable association")
      constrs
  in

  let collect_nth_arg n =
    List.map (fun args -> List.nth args n) args_list |> listV in

  let length = List.hd args_list |> List.length in

  let rec distribute_list n acc =
    if n < 0 then acc
    else (
      collect_nth_arg n :: acc
      |> distribute_list (n-1)
    )
  in

  ConstructV (tag, distribute_list (length-1) [])

let rec distribute_rhs_list lhs = function
  | ListV arr when Array.length !arr = 0 ->
      get_empty_rhs lhs
  | ListV arr ->
      let l = Array.to_list !arr in
      begin match l with
      | [] -> ListV arr
      | ListV _ :: _ ->
          List.map (distribute_rhs_list lhs) l |> listV |> distribute_rhs_list lhs
      | ConstructV _ :: _ ->
          distribute_construct_list l
      | _ ->
          string_of_value (ListV arr)
          |> Printf.sprintf "Invalid association rhs: %s"
          |> failwith
      end
  | v ->
      string_of_value v
      |> Printf.sprintf "Invalid association rhs: %s"
      |> failwith
