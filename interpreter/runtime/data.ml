open Types
open Value

type field =
  | ValueField of value ref
  | PackedField of pack_size * int ref

type data =
  | Struct of sem_var * Rtt.t * field list
  | Array of sem_var * Rtt.t * field list
type t = data

type ref_ += DataRef of data


let gap sz = 32 - 8 * packed_size sz
let wrap sz i = Int32.(to_int (logand i (shift_right_logical (-1l) (gap sz))))
let extend_u sz i = Int32.of_int i
let extend_s sz i = Int32.(shift_right (shift_left (of_int i) (gap sz)) (gap sz))

let alloc_field ft v =
  let FieldType (st, _) = ft in
  match st, v with
  | ValueStorageType _, v -> ValueField (ref v)
  | PackedStorageType sz, Num (I32 i) -> PackedField (sz, ref (wrap sz i))
  | _, _ -> failwith "alloc_field"

let write_field fld v =
  match fld, v with
  | ValueField vr, v -> vr := v
  | PackedField (sz, ir), Num (I32 i) -> ir := wrap sz i
  | _, _ -> failwith "write_field"

let read_field fld exto =
  match fld, exto with
  | ValueField vr, None -> !vr
  | PackedField (sz, ir), Some ZX -> Num (I32 (extend_u sz !ir))
  | PackedField (sz, ir), Some SX -> Num (I32 (extend_s sz !ir))
  | _, _ -> failwith "read_field"


let alloc_struct x rtt vs =
  let StructType fts = as_struct_str_type (expand_ctx_type (def_of x)) in
  Struct (x, rtt, List.map2 alloc_field fts vs)

let alloc_array x rtt n v =
  let ArrayType ft = as_array_str_type (expand_ctx_type (def_of x)) in
  Array (x, rtt, List.init (Int32.to_int n) (fun _ -> alloc_field ft v))


let type_inst_of = function
  | Struct (x, _, _) -> x
  | Array (x, _, _) -> x

let struct_type_of d = as_struct_str_type (expand_ctx_type (def_of (type_inst_of d)))
let array_type_of d = as_array_str_type (expand_ctx_type (def_of (type_inst_of d)))

let read_rtt = function
  | Struct (_, rtt, _) -> rtt
  | Array (_, rtt, _) -> rtt


let () =
  let type_of_ref' = !Value.type_of_ref' in
  Value.type_of_ref' := function
    | DataRef d -> DefHeapType (SemVar (type_inst_of d))
    | r -> type_of_ref' r

let string_of_field = function
  | ValueField vr -> string_of_value !vr
  | PackedField (_, ir) -> string_of_int !ir

let string_of_fields fs =
  let fs', ell =
    if List.length fs > 5
    then Lib.List.take 5 fs, ["..."]
    else fs, []
  in String.concat " " (List.map string_of_field fs' @ ell)

let rec_for inner f x =
  inner := true;
  try let y = f x in inner := false; y
  with exn -> inner := false; raise exn

let () =
  let string_of_ref' = !Value.string_of_ref' in
  let inner = ref false in
  Value.string_of_ref' := function
    | DataRef _ when !inner -> "..."
    | DataRef (Struct (_, _, fs)) ->
      "(struct " ^ rec_for inner string_of_fields fs ^ ")"
    | DataRef (Array (_, _, fs)) ->
      "(array " ^ rec_for inner string_of_fields fs ^ ")"
    | r -> string_of_ref' r
