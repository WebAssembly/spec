open Ast

let rec eq_field f1 f2 =
  match f1, f2 with
  | (k1, a1), (k2, a2) -> k1 = k2 && eq_value !a1 !a2

and eq_value v1 v2 =
  match v1, v2 with
  | NumV i1, NumV i2 -> i1 = i2
  | StringV s1, StringV s2 -> s1 = s2
  | ListV a1, ListV a2 ->
    let l1 = Array.to_list !a1 in
    let l2 = Array.to_list !a2 in
    List.length l1 = List.length l2 &&
      List.for_all2 eq_value l1 l2
  | RecordV r1, RecordV r2 -> List.for_all2 eq_field r1 r2
  | ConstructV (tag1, vl1), ConstructV (tag2, vl2) ->
    tag1 = tag2 && List.for_all2 eq_value vl1 vl2
  | PairV (v1, v2), PairV (v3, v4)
  | LabelV (v1, v2), LabelV (v3, v4)
  | ArrowV (v1, v2), ArrowV (v3, v4) ->
    eq_value v1 v3 && eq_value v2 v4
  | FrameV (vo1, v1), FrameV (vo2, v2) ->
    eq_value (OptV vo1) (OptV vo2) && eq_value v1 v2
  | OptV (Some v1), OptV (Some v2) ->
    eq_value v1 v2
  | OptV None, OptV None
  | StoreV _, StoreV _ -> true
  | _ -> false
