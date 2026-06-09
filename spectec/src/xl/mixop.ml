open Util

type atom = Atom.atom

type 'a mixop =
  | Arg of 'a
  | Atom of atom
  | Brack of atom * 'a mixop * atom
  | Infix of 'a mixop * atom * 'a mixop
  | Seq of 'a mixop list


let rec map f mixop =
  match mixop with
  | Arg x -> Arg (f x)
  | Atom at -> Atom at
  | Brack (at1, mixop, at2) -> Brack (at1, map f mixop, at2)
  | Infix (mixop1, at, mixop2) ->
    let mixop1' = map f mixop1 in
    let mixop2' = map f mixop2 in
    Infix (mixop1', at, mixop2')
  | Seq mixops -> Seq (List.map (map f) mixops)

let rec fold f x mixop =
  match mixop with
  | Arg y -> f x y
  | Atom _ -> x
  | Brack (_, mixop, _) -> fold f x mixop
  | Infix (mixop1, _, mixop2) -> fold f (fold f x mixop1) mixop2
  | Seq mixops -> List.fold_left (fold f) x mixops

let rec map_atoms f mixop =
  match mixop with
  | Arg x -> Arg x
  | Atom at -> Atom (f at)
  | Brack (at1, mixop, at2) -> Brack (f at1, map_atoms f mixop, f at2)
  | Infix (mixop1, at, mixop2) ->
    Infix (map_atoms f mixop1, f at, map_atoms f mixop2)
  | Seq mixops -> Seq (List.map (map_atoms f) mixops)

let iter_atoms f mixop =
  ignore (map_atoms (fun at -> f at; at) mixop)

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
  | Atom atom | Brack (atom, _, _) | Infix (_, atom, _) -> Some atom
  | Seq (mixop::mixops) ->
    match head mixop with
    | None -> head (Seq mixops)
    | some -> some

let rec flatten = function
  | Arg _ -> [[]; []]
  | Atom atom -> [[atom]]
  | Brack (l, mixop, r) -> [[l]] ++ flatten mixop ++ [[r]]
  | Infix (mixop1, atom, mixop2) -> flatten mixop1 ++ [[atom]] ++ flatten mixop2
  | Seq mixops -> List.fold_left (++) [[]] (List.map flatten mixops)

let (>>) o1 o2 = if o1 = 0 then o2 else o1

let rec compare mixop1 mixop2 =
  match mixop1, mixop2 with
  | Arg x1, Arg x2 -> Stdlib.compare x1 x2
  | Atom a1, Atom a2 -> Atom.compare a1 a2
  | Brack (a11, op11, a12), Brack (a21, op21, a22) ->
    Atom.compare a11 a21 >> compare op11 op21 >> Atom.compare a12 a22
  | Infix (op11, a1, op12), Infix (op21, a2, op22) ->
    compare op11 op21 >> Atom.compare a1 a2 >> compare op12 op22
  | Seq (op1::ops1), Seq (op2::ops2) ->
    (match compare op1 op2 with 0 -> compare (Seq ops1) (Seq ops2) | o -> o)
  | _, _ -> Stdlib.compare mixop1 mixop2

let eq mixop1 mixop2 =
  compare mixop1 mixop2 = 0


let rec to_string_with f s = function
  | Arg x -> f x
  | Seq mixops -> String.concat s (List.map (to_string_with f s) mixops)
  | Atom atom -> Atom.to_string atom
  | Brack (l, mixop, r) ->
    Atom.to_string l ^ to_string_with f s mixop ^ Atom.to_string r
  | Infix (mixop1, atom, mixop2) ->
    to_string_with f s mixop1 ^ Atom.to_string atom ^ to_string_with f s mixop2

let is_arg = function Arg _ -> true | _ -> false
let to_string = function
  | Seq (Atom a :: tail) when List.for_all is_arg tail -> Atom.to_string a
  | mixop -> to_string_with (Fun.const "%") "" mixop
