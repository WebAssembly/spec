(*
 * Simple collection of functions useful for writing test cases.
 *)

open Types


let print vs =
  List.iter Print.print_result (List.map (fun v -> [v]) vs);
  []


let lookup name (FuncType (ins, out)) =
  match name, ins, out with
  | "print", _, [] -> print
  | _ -> raise Not_found
