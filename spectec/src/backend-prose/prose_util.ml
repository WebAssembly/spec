open Util.Source


let find_relation name =
  let open El.Ast in
  List.find_opt (fun def ->
  match def.it with
  | RelD (id, _, _) when id.it = name -> true
  | _ -> false
  ) !Langs.el