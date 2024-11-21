open Util.Source

let concat = String.concat
let prefix s f x = s ^ f x

let string_of_rule_clause rc =
  let e1, e2, prems = rc in
  Printf.sprintf "%s --> %s\n%s"
    (Il.Print.string_of_exp e1)
    (Il.Print.string_of_exp e2)
    (concat "" (List.map (prefix "\n    -- " Il.Print.string_of_prem) prems))
let string_of_rule_def rd =
  let instr_name, rel_id, rcs = rd.it in
  instr_name ^ "/" ^ rel_id.it ^ "\n" ^
  (concat "\n" (List.map string_of_rule_clause rcs))
