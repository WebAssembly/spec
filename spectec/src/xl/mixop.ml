open Util
open Util.Source

type atom = Atom.atom

type 'a mixop =
  | Arg of 'a
  | Seq of 'a mixop list
  | Atom of atom
  | Brack of atom * 'a mixop * atom
  | Infix of 'a mixop * atom * 'a mixop


let rec map f mixop =
  match mixop with
  | Arg x -> Arg (f x)
  | Seq mixops -> Seq (List.map (map f) mixops)
  | Atom at -> Atom at
  | Brack (at1, mixop, at2) -> Brack (at1, map f mixop, at2)
  | Infix (mixop1, at, mixop2) -> Infix (map f mixop1, at, map f mixop2)

let rec fold f x mixop =
  match mixop with
  | Arg y -> f x y
  | Seq mixops -> List.fold_left (fold f) x mixops
  | Atom _ -> x
  | Brack (_, mixop, _) -> fold f x mixop
  | Infix (mixop1, _, mixop2) -> fold f (fold f x mixop1) mixop2

let rec map_atoms f mixop =
  match mixop with
  | Arg x -> Arg x
  | Seq mixops -> Seq (List.map (map_atoms f) mixops)
  | Atom at -> Atom (f at)
  | Brack (at1, mixop, at2) -> Brack (f at1, map_atoms f mixop, f at2)
  | Infix (mixop1, at, mixop2) ->
    Infix (map_atoms f mixop1, f at, map_atoms f mixop2)


let arity mixop = fold (fun n _ -> n + 1) 0 mixop

let apply mixop xs =
  let rxs = ref xs in
  let mixop' =
    map (fun _ -> let xs = !rxs in rxs := List.tl xs; List.hd xs) mixop in
  assert (!rxs = []);
  mixop'


let (++) atomss1 atomss2 =
  let atomss1', atoms1 = Lib.List.split_last atomss1 in
  let atoms2, atomss2' = Lib.List.split_hd atomss2 in
  atomss1' @ [atoms1 @ atoms2] @ atomss2'

let rec head = function
  | Arg _ | Seq [] -> None
  | Seq (mixop::_) -> head mixop
  | Atom atom | Brack (atom, _, _) | Infix (_, atom, _) -> Some atom

let rec flatten = function
  | Arg _ -> [[]; []]
  | Seq mixops -> List.fold_left (++) [[]] (List.map flatten mixops)
  | Atom atom -> [[atom]]
  | Brack (l, mixop, r) -> [[l]] ++ flatten mixop ++ [[r]]
  | Infix (mixop1, atom, mixop2) -> flatten mixop1 ++ [[atom]] ++ flatten mixop2

let compare mixop1 mixop2 =
  List.compare (List.compare Atom.compare) (flatten mixop1) (flatten mixop2)

let eq mixop1 mixop2 =
  compare mixop1 mixop2 = 0


let to_string' = function
  | [{it = Atom.Atom a; _}]::tail when List.for_all ((=) []) tail -> a
  | mixop ->
    String.concat "%" (List.map (
      fun atoms -> String.concat "" (List.map Atom.to_string atoms)) mixop
    )

let to_string mixop = to_string' (flatten mixop)
