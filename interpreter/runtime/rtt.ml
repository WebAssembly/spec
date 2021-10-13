open Types
open Value

type rtt = Rtt of sem_var * rtt option
type t = rtt

type ref_ += RttRef of rtt


let alloc x ro = Rtt (x, ro)

let type_inst_of (Rtt (x, _)) = x
let def_type_of d = def_of (type_inst_of d)

let rec depth = function
  | Rtt (_, None) -> 0l
  | Rtt (_, Some rtt) -> Int32.add 1l (depth rtt)


let rec eq_rtt rtt1 rtt2 =
  match rtt1, rtt2 with
  | Rtt (x1, None), Rtt (x2, None) ->
    Match.eq_var_type [] [] (SemVar x1) (SemVar x2) 
  | Rtt (x1, Some rtt1'), Rtt (x2, Some rtt2') ->
    Match.eq_var_type [] [] (SemVar x1) (SemVar x2) && eq_rtt rtt1' rtt2'
  | _, _ -> false

let rec match_rtt rtt1 rtt2 =
  eq_rtt rtt1 rtt2 ||
  match rtt1 with
  | Rtt (_, None) -> false
  | Rtt (_, Some rtt1') -> match_rtt rtt1' rtt2

let rec string_of_rtt (Rtt (x, sup)) =
  string_of_var (SemVar x) ^
  (match sup with
  | None -> ""
  | Some rtt' -> " (sub " ^ string_of_rtt rtt' ^ ")"
  )


let () =
  let eq_ref' = !Value.eq_ref' in
  Value.eq_ref' := fun r1 r2 ->
    match r1, r2 with
    | RttRef rtt1, RttRef rtt2 -> eq_rtt rtt1 rtt2
    | _, _ -> eq_ref' r1 r2

let () =
  let type_of_ref' = !Value.type_of_ref' in
  Value.type_of_ref' := function
    | RttRef (Rtt (x, _) as rtt) -> RttHeapType (SemVar x, Some (depth rtt))
    | r -> type_of_ref' r

let () =
  let string_of_ref' = !Value.string_of_ref' in
  Value.string_of_ref' := function
    | RttRef (Rtt (x, rtto)) ->
      "(rtt " ^ string_of_var (SemVar x) ^
      (if rtto = None then "" else " <: ...") ^
      ")"
    | r -> string_of_ref' r
