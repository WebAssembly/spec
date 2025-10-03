open Util.Source

type atom = Atom.atom
type mixop = atom list list


let compare mixop1 mixop2 =
  List.compare (List.compare Atom.compare) mixop1 mixop2

let eq mixop1 mixop2 =
  compare mixop1 mixop2 = 0


let to_string = function
  | [{it = Atom.Atom a; _}]::tail when List.for_all ((=) []) tail -> a
  | mixop ->
    let s =
      String.concat "%" (List.map (
        fun atoms -> String.concat "" (List.map Atom.to_string atoms)) mixop
      )
    in
    "`" ^ s ^ "`"

let name mixop =
  String.concat "" (List.map Atom.name mixop)
