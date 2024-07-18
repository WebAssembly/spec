open Al.Print
open Prose
open Printf
open Util.Source

(* Helpers *)

let string_of_opt prefix stringifier suffix = function
  | None -> ""
  | Some x -> prefix ^ stringifier x ^ suffix

let string_of_list stringifier left sep right = function
  | [] -> left ^ right
  | h :: t ->
      let limit = 16 in
      let is_long = List.length t > limit in
      left
      ^ List.fold_left
          (fun acc elem -> acc ^ sep ^ stringifier elem)
          (stringifier h) (List.filteri (fun i _ -> i <= limit) t)
      ^ (if is_long then (sep ^ "...") else "")
      ^ right

let indent_depth = ref 0
let indent () = ((List.init !indent_depth (fun _ -> "  ")) |> String.concat "") ^ "-"

let extract_desc_hint = List.find_map (function
  | El.Ast.{ hintid = id; hintexp = { it = TextE desc; _ } }
    when id.it = "desc" -> Some desc
  | _ -> None)
let extract_desc typ =
  let name = Il.Print.string_of_typ typ in
  match !Langs.el |> List.find_map (fun def ->
    match def.it with
    | El.Ast.FamD (id, _, hints) when id.it = name ->
      extract_desc_hint hints
    | El.Ast.TypD (id, subid, _, _, hints)
      when id.it = name && (subid.it = "" || (* HARDCODE *) subid.it = "syn") ->
      extract_desc_hint hints
    | _ -> None)
  with
  | Some desc -> desc
  | None -> name

let string_of_expr_with_type e = "the " ^ extract_desc e.note ^ " " ^ string_of_expr e

let string_of_cmpop = function
  | Eq -> "is"
  | Ne -> "is different with"
  | Lt -> "is less than"
  | Gt -> "is greater than"
  | Le -> "is less than or equal to"
  | Ge -> "is greater than or equal to"

let rec string_of_instr = function
  | LetI (e1, e2) ->
      sprintf "%s Let %s be %s." (indent ())
        (string_of_expr e1)
        (string_of_expr e2)
  | CmpI (e1, cmpop, e2) ->
      sprintf "%s %s %s %s." (indent ())
        (string_of_expr e1)
        (string_of_cmpop cmpop)
        (string_of_expr e2)
  | MemI (e1, e2) ->
      sprintf "%s %s is contained in %s." (indent ())
        (string_of_expr e1)
        (string_of_expr e2)
  | IsValidI (c_opt, e, e_opt) ->
      sprintf "%s %s%s is valid%s." (indent ())
        (string_of_opt "Under the context " string_of_expr ", " c_opt)
        (string_of_expr_with_type e)
        (string_of_opt " with type " string_of_expr "" e_opt)
  | MatchesI (e1, e2) ->
      sprintf "%s %s matches %s." (indent ())
        (string_of_expr_with_type e1)
        (string_of_expr_with_type e2)
  | IfI (c, is) ->
      sprintf "%s If %s, \n%s" (indent ())
        (string_of_expr c)
        (indented_string_of_instrs is)
  | ForallI (iters, is) ->
      let string_of_iter (e1, e2) = (string_of_expr e1) ^ " in " ^ (string_of_expr e2) in
      sprintf "%s For all %s,\n%s" (indent ())
        (string_of_list string_of_iter "" " and " "" iters)
        (indented_string_of_instrs is)
  | EquivI (e1, e2) ->
      sprintf "%s (%s) if and only if (%s)." (indent ())
        (string_of_expr e2)
        (string_of_expr e1)
  | EitherI iss -> 
      sprintf "%s Either:\n%s" (indent ())
        (string_of_list indented_string_of_instrs "" ("\n" ^ indent () ^ " Or:\n") "" iss)
  | YetI s -> indent () ^ " Yet: " ^ s

and indented_string_of_instr i =
  indent_depth := !indent_depth + 1;
  let result = string_of_instr i in
  indent_depth := !indent_depth - 1;
  result

and indented_string_of_instrs is =
  (string_of_list indented_string_of_instr "" "\n" "" is)

let string_of_def = function
| Iff (name, _e, concl, []) ->
    "validation_of_" ^ name
    (* ^ " " ^ string_of_expr e ^ "\n" *)
    ^ "\n"
    ^ string_of_instr concl ^ "\n"
| Iff (name, _e, concl, prems) ->
    let concl_str = string_of_instr concl in
    let drop_last x = String.sub x 0 (String.length x - 1) in
    "validation_of_" ^ name
    (* ^ " " ^ string_of_expr e ^ "\n" *)
    ^ "\n"
    ^ drop_last concl_str
    ^ " if and only if:\n"
    ^ string_of_list indented_string_of_instr "" "\n" "\n" prems
| Algo algo -> string_of_algorithm algo

let string_of_prose prose = List.map string_of_def prose |> String.concat "\n"
