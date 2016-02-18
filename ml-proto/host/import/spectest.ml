open Types


let print vs =
  List.iter Print.print_value (List.map (fun v -> Some v) vs);
  None


let lookup name ty =
  match name, ty.ins, ty.out with
  | "print", _, None -> print
  | _ -> raise Not_found
