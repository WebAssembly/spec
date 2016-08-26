(*
 * Simple collection of functions useful for writing test cases.
 *)

open Types


let print vs =
  List.iter Print.print_value (List.map (fun v -> Some v) vs);
  None


open Instance

let lookup name t =
  match name, t with
  | "print", ExternalFuncType ({ins = _; out = None} as ft) ->
    ExternalFunc (HostFunc (ft, print))
  | _ -> raise Not_found
