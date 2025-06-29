open Types
open Value

type field =
  | ValField of value ref
  | PackField of packtype * int ref

type struct_ = Struct of deftype * field list
type array = Array of deftype * field list

type ref_ += StructRef of struct_
type ref_ += ArrayRef of array


let gap pt = 32 - 8 * pack_size pt
let wrap pt i = Int32.(to_int (logand i (shift_right_logical (-1l) (gap pt))))
let extend_u _pt i = Int32.of_int i
let extend_s pt i = Int32.(shift_right (shift_left (of_int i) (gap pt)) (gap pt))

let alloc_field ft v =
  let FieldT (_mut, st) = ft in
  match st, v with
  | ValStorageT _, v -> ValField (ref v)
  | PackStorageT sz, Num (I32 i) -> PackField (sz, ref (wrap sz i))
  | _, _ -> failwith "alloc_field"

let write_field fld v =
  match fld, v with
  | ValField vr, v -> vr := v
  | PackField (sz, ir), Num (I32 i) -> ir := wrap sz i
  | _, _ -> failwith "write_field"

let read_field fld exto =
  match fld, exto with
  | ValField vr, None -> !vr
  | PackField (sz, ir), Some Pack.U -> Num (I32 (extend_u sz !ir))
  | PackField (sz, ir), Some Pack.S -> Num (I32 (extend_s sz !ir))
  | _, _ -> failwith "read_field"

let array_length (Array (_, fs)) = Lib.List32.length fs


let alloc_struct dt vs =
  assert Free.((deftype dt).types = Set.empty);
  let StructT fts = structtype_of_comptype (expand_deftype dt) in
  Struct (dt, List.map2 alloc_field fts vs)

let alloc_array dt vs =
  assert Free.((deftype dt).types = Set.empty);
  let ArrayT ft = arraytype_of_comptype (expand_deftype dt) in
  Array (dt, List.map (alloc_field ft) vs)


let type_of_struct (Struct (dt, _)) = dt
let type_of_array (Array (dt, _)) = dt


let () =
  let type_of_ref' = !Value.type_of_ref' in
  Value.type_of_ref' := function
    | StructRef s -> UseHT (Def (type_of_struct s))
    | ArrayRef a -> UseHT (Def (type_of_array a))
    | r -> type_of_ref' r

let string_of_field = function
  | ValField vr -> string_of_value !vr
  | PackField (_, ir) -> string_of_int !ir

let string_of_fields nest fs =
  if fs = [] then "" else
  if !nest > 0 then " ..." else
  let fs', ell =
    if List.length fs > 5
    then Lib.List.take 5 fs, ["..."]
    else fs, []
  in " " ^ String.concat " " (List.map string_of_field fs' @ ell)

let string_of_aggr name nest fs =
  Fun.protect (fun () -> incr nest; "(" ^ name ^ string_of_fields nest fs ^ ")")
    ~finally:(fun () -> decr nest)

let () =
  let string_of_ref' = !Value.string_of_ref' in
  let nest = ref 0 in
  Value.string_of_ref' := function
    | StructRef (Struct (_, fs)) -> string_of_aggr "struct" nest fs
    | ArrayRef (Array (_, fs)) -> string_of_aggr "array" nest fs
    | r -> string_of_ref' r
