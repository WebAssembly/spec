open Reference_interpreter
open Construct
open Al
open Ast
open Al_util

type numerics = { name : string; f : value list -> value }

let mask32 = Z.of_int32_unsigned (-1l)
let mask64 = Z.of_int64_unsigned (-1L)

let maskN n = Z.(pred (shift_left one (Z.to_int n)))

let z_to_int32 z = Z.(to_int32_unsigned (logand mask32 z))
let z_to_int64 z = Z.(to_int64_unsigned (logand mask64 z))

let i8_to_i32 i8 =
  (* NOTE: This operation extends the sign of i8 to i32 *)
  I32.shr_s (I32.shl i8 24l) 24l
let i16_to_i32 i16 =
  (* NOTE: This operation extends the sign of i8 to i32 *)
  I32.shr_s (I32.shl i16 16l) 16l

let i32_to_i8 i32 = Int32.logand 0xffl i32
let i32_to_i16 i32 = Int32.logand 0xffffl i32

let signed : numerics =
  {
    name = "signed";
    f =
      (function
      | [ NumV z; NumV n ] ->
        let z = Z.to_int z in
        (if Z.lt n (Z.shift_left Z.one (z - 1)) then n else Z.(sub n (shift_left one z))) |> al_of_z
      | v -> fail_list "Invalid signed" v
      )
  }
let inverse_of_signed =
  {
    name = "inverse_of_signed";
    f =
      (function
      | [ NumV z; NumV n ] ->
        let z = Z.to_int z in
        (if Z.(geq n zero) then n else Z.(add n (shift_left one z))) |> al_of_z
      | v -> fail_list "Invalid inverse_of_signed" v
      )
  }

let iadd : numerics =
  {
    name = "iadd";
    f =
      (function
      | [ NumV z; NumV m; NumV n ] -> Z.(logand (add m n) (maskN z)) |> al_of_z
      | v -> fail_list "Invalid iadd" v
      );
  }
let isub : numerics =
  {
    name = "isub";
    f =
      (function
      | [ NumV z; NumV m; NumV n ] -> Z.(logand (sub m n) (maskN z)) |> al_of_z
      | v -> fail_list "Invalid isub" v
      );
  }
let imul : numerics =
  {
    name = "imul";
    f =
      (function
      | [ NumV z; NumV m; NumV n ] -> Z.(logand (mul m n) (maskN z)) |> al_of_z
      | v -> fail_list "Invalid imul" v
      );
  }
let idiv : numerics =
  {
    name = "idiv";
    f =
      (function
      | [ NumV _; CaseV ("U", []); NumV m; NumV n ] ->
        if n = Z.zero then
          raise Exception.Trap
        else
          Z.(div m n) |> al_of_z
      | [ NumV z; CaseV ("S", []); NumV m; NumV n ] ->
        if n = Z.zero then
          raise Exception.Trap
        else if m = Z.shift_left Z.one (Z.to_int z - 1) && n = maskN z then
          raise Exception.Trap
        else
          let z = NumV z in
          let m = signed.f [ z; NumV m ] |> al_to_z in
          let n = signed.f [ z; NumV n ] |> al_to_z in
          inverse_of_signed.f [ z; NumV Z.(div m n) ]
      | v -> fail_list "Invalid idiv" v
      );
  }
let irem: numerics =
  {
    name = "irem";
    f =
      (function
      | [ NumV _; CaseV ("U", []); NumV m; NumV n ] ->
        if n = Z.zero then
          raise Exception.Trap
        else
          Z.(rem m n) |> al_of_z
      | [ NumV z; CaseV ("S", []); NumV m; NumV n ] ->
        if n = Z.zero then
          raise Exception.Trap
        else
          let z = NumV z in
          let m = signed.f [ z; NumV m ] |> al_to_z in
          let n = signed.f [ z; NumV n ] |> al_to_z in
          inverse_of_signed.f [ z; NumV Z.(rem m n) ]
      | v -> fail_list "Invalid irem" v
      );
  }
let inot : numerics =
  {
    name = "inot";
    f =
      (function
      | [ NumV _; NumV m ] -> Z.(lognot m) |> al_of_z
      | v -> fail_list "Invalid inot" v
      );
  }
let iand : numerics =
  {
    name = "iand";
    f =
      (function
      | [ NumV _; NumV m; NumV n ] -> Z.(logand m n) |> al_of_z
      | v -> fail_list "Invalid imul" v
      );
  }
let iandnot : numerics =
  {
    name = "iandnot";
    f =
      (function
      | [ NumV _; NumV m; NumV n ] -> Z.(logand m n |> lognot) |> al_of_z
      | v -> fail_list "Invalid iandnot" v
      );
  }
let ior : numerics =
  {
    name = "ior";
    f =
      (function
      | [ NumV _; NumV m; NumV n ] -> Z.(logor m n) |> al_of_z
      | v -> fail_list "Invalid ior" v
      );
  }
let ixor : numerics =
  {
    name = "ixor";
    f =
      (function
      | [ NumV _; NumV m; NumV n ] -> Z.(logxor m n) |> al_of_z
      | v -> fail_list "Invalid ixor" v
      );
  }
let ishl : numerics =
  {
    name = "ishl";
    f =
      (function
      | [ NumV z; NumV m; NumV n ] -> Z.(logand (shift_left m (Z.to_int (rem n z))) (maskN z)) |> al_of_z
      | v -> fail_list "Invalid ishl" v
      );
  }
let ishr : numerics =
  {
    name = "ishr";
    f =
      (function
      | [ NumV z; CaseV ("U", []); NumV m; NumV n ] -> Z.(shift_right m (Z.to_int (rem n z))) |> al_of_z
      | [ NumV z; CaseV ("S", []); NumV m; NumV n ] ->
          let m = signed.f [ NumV z; NumV m ] |> al_to_z in
          let n = Z.rem n z |> Z.to_int in
          inverse_of_signed.f [ NumV z; NumV Z.(shift_right m n) ]
      | v -> fail_list "Invalid ishr" v
      );
  }
let irotl : numerics =
  {
    name = "irotl";
    f =
      (function
      | [ NumV z; NumV m; NumV n ] ->
        let n = Z.to_int (Z.rem n z) in
        (Z.logor (Z.logand (Z.shift_left m n) (maskN z)) (Z.shift_right m ((Z.to_int z - n)))) |> al_of_z
      | v -> fail_list "Invalid irotl" v
      );
  }
let irotr : numerics =
  {
    name = "irotr";
    f =
      (function
      | [ NumV z; NumV m; NumV n ] ->
        let n = Z.to_int (Z.rem n z) in
        (Z.logor (Z.shift_right m n) (Z.logand (Z.shift_left m ((Z.to_int z - n))) (maskN z))) |> al_of_z
      | v -> fail_list "Invalid irotr" v
      );
  }
let iclz : numerics =
  {
    name = "iclz";
    f =
      (function
      | [ NumV z; NumV m ] ->
        if m = Z.zero then
          z |> al_of_z
        else
          let z = Z.to_int z in
          let rec loop acc n =
            if Z.equal (Z.logand n (Z.shift_left Z.one (z - 1))) Z.zero then
              loop (1 + acc) (Z.shift_left n 1)
            else
              acc
          in al_of_int (loop 0 m)
      | v -> fail_list "Invalid iclz" v
      );
  }
let ictz : numerics =
  {
    name = "ictz";
    f =
      (function
      | [ NumV z; NumV m ] ->
        if m = Z.zero then
          z |> al_of_z
        else
          let rec loop acc n =
            if Z.(equal (logand n one) zero) then
              loop (1 + acc) (Z.shift_right n 1)
            else
              acc
          in al_of_int (loop 0 m)
      | v -> fail_list "Invalid ictz" v
      );
  }
let ipopcnt : numerics =
  {
    name = "ipopcnt";
    f =
      (function
      | [ NumV z; NumV m ] ->
        let rec loop acc i n =
          if i = 0 then
            acc
          else
            let acc' = if Z.(equal (logand n one) one) then acc + 1 else acc in
            loop acc' (i - 1) (Z.shift_right n 1)
        in al_of_int (loop 0 (Z.to_int z) m)
      | v -> fail_list "Invalid popcnt" v
      );
  }
let ieqz : numerics =
  {
    name = "ieqz";
    f =
      (function
      | [ NumV _; NumV m ] -> m = Z.zero |> al_of_bool
      | v -> fail_list "Invalid ieqz" v
      );
  }
let ieq : numerics =
  {
    name = "ieq";
    f =
      (function
      | [ NumV _; NumV m; NumV n ] -> Z.equal m n |> al_of_bool
      | v -> fail_list "Invalid ieq" v
      );
  }
let ine : numerics =
  {
    name = "ine";
    f =
      (function
      | [ NumV _; NumV m; NumV n ] -> Z.equal m n |> not |> al_of_bool
      | v -> fail_list "Invalid ine" v
      );
  }
let ilt : numerics =
  {
    name = "ilt";
    f =
      (function
      | [ NumV _; CaseV ("U", []); NumV m; NumV n ] -> m < n |> al_of_bool
      | [ NumV _ as z; CaseV ("S", []); NumV _ as m; NumV _ as n ] ->
        let m = signed.f [ z; m ] |> al_to_z in
        let n = signed.f [ z; n ] |> al_to_z in
        m < n |> al_of_bool
      | v -> fail_list "Invalid ilt" v
      );
  }
let igt : numerics =
  {
    name = "igt";
    f =
      (function
      | [ NumV _; CaseV ("U", []); NumV m; NumV n ] -> m > n |> al_of_bool
      | [ NumV _ as z; CaseV ("S", []); NumV _ as m; NumV _ as n ] ->
        let m = signed.f [ z; m ] |> al_to_z in
        let n = signed.f [ z; n ] |> al_to_z in
        m > n |> al_of_bool
      | v -> fail_list "Invalid igt" v
      );
  }
let ile : numerics =
  {
    name = "ile";
    f =
      (function
      | [ NumV _; CaseV ("U", []); NumV m; NumV n ] -> m <= n |> al_of_bool
      | [ NumV _ as z; CaseV ("S", []); NumV _ as m; NumV _ as n ] ->
        let m = signed.f [ z; m ] |> al_to_z in
        let n = signed.f [ z; n ] |> al_to_z in
        m <= n |> al_of_bool
      | v -> fail_list "Invalid ile" v
      );
  }
let ige : numerics =
  {
    name = "ige";
    f =
      (function
      | [ NumV _; CaseV ("U", []); NumV m; NumV n ] -> m >= n |> al_of_bool
      | [ NumV _ as z; CaseV ("S", []); NumV _ as m; NumV _ as n ] ->
        let m = signed.f [ z; m ] |> al_to_z in
        let n = signed.f [ z; n ] |> al_to_z in
        m >= n |> al_of_bool
      | v -> fail_list "Invalid ige" v
      );
  }
let iabs : numerics =
  {
    name = "iabs";
    f =
      (function
      | [ NumV _; NumV m ] -> Z.abs m |> al_of_z
      | v -> fail_list "Invalid iabs" v
      );
  }
let ineg : numerics =
  {
    name = "iabs";
    f =
      (function
      | [ NumV _; NumV m ] -> Z.neg m |> al_of_z
      | v -> fail_list "Invalid ineg" v
      );
  }
let imin : numerics =
  {
    name = "imin";
    f =
      (function
      | [ NumV _ as z; CaseV (_, []) as sx; NumV _ as m; NumV _ as n ] ->
        (if al_to_bool (ilt.f [ z; sx; m; n ]) then m else n)
      | v -> fail_list "Invalid imin" v
      );
  }
let imax : numerics =
  {
    name = "imax";
    f =
      (function
      | [ NumV _ as z; CaseV (_, []) as sx; NumV _ as m; NumV _ as n ] ->
        (if al_to_bool (igt.f [ z; sx; m; n ]) then m else n)
      | v -> fail_list "Invalid imax" v
      );
  }


let ext : numerics =
  {
    name = "ext";
    f =
      (function
      | [ NumV z; _; CaseV ("U", []); NumV v ] when z = Z.of_int 128 -> V128.I64x2.of_lanes [ z_to_int64 v; 0L ] |> al_of_vec128 (* HARDCODE *)
      | [ _; _; CaseV ("U", []); v ] -> v
      | [ NumV _ as n; NumV _ as m; CaseV ("S", []); NumV _ as i ] ->
        inverse_of_signed.f [ n; signed.f [ m; i] ]
      | _ -> failwith "Invalid argument fot ext"
      );
  }

let ibytes : numerics =
  {
    name = "ibytes";
    (* TODO: Handle the case where n > 16 (i.e. for v128 ) *)
    f =
      (function
      | [ NumV n; NumV i ] ->
          let rec decompose n bits =
            if n = Z.zero then
              []
            else
              Z.(bits land of_int 0xff) :: decompose Z.(n - of_int 8) Z.(shift_right bits 8)
            in
          assert Z.(n >= Z.zero && rem n (of_int 8) = zero);
          decompose n i |> List.map numV |> listV_of_list
      | vs -> failwith ("Invalid ibytes: " ^ Print.(string_of_list string_of_value " " vs))
      );
  }
let inverse_of_ibytes : numerics =
  {
    name = "inverse_of_ibytes";
    f =
      (function
      | [ NumV n; ListV bs ] ->
          assert (n = Z.of_int (Array.length !bs * 8));
          NumV (Array.fold_right (fun b acc ->
            match b with
            | NumV b when Z.zero <= b && b < Z.of_int 256 -> Z.add b (Z.shift_left acc 8)
            | _ -> failwith ("Invalid inverse_of_ibytes: " ^ Print.string_of_value b ^ " is not a valid byte.")
          ) !bs Z.zero)
      | _ -> failwith "Invalid argument for inverse_of_ibytes."
      );
  }

let nbytes : numerics =
  {
    name = "nbytes";
    f =
      (function
      | [ CaseV ("I32", []); n ] -> ibytes.f [ NumV (Z.of_int 32); n ]
      | [ CaseV ("I64", []); n ] -> ibytes.f [ NumV (Z.of_int 64); n ]
      | [ CaseV ("F32", []); f ] -> ibytes.f [ NumV (Z.of_int 32); al_to_float32 f |> F32.to_bits |> al_of_int32 ]
      | [ CaseV ("F64", []); f ] -> ibytes.f [ NumV (Z.of_int 64); al_to_float64 f |> F64.to_bits |> al_of_int64 ]
      | _ -> failwith "Invalid nbytes"
      );
  }
let inverse_of_nbytes : numerics =
  {
    name = "inverse_of_nbytes";
    f =
      (function
      | [ CaseV ("I32", []); l ] -> inverse_of_ibytes.f [ NumV (Z.of_int 32); l ]
      | [ CaseV ("I64", []); l ] -> inverse_of_ibytes.f [ NumV (Z.of_int 64); l ]
      | [ CaseV ("F32", []); l ] -> inverse_of_ibytes.f [ NumV (Z.of_int 32); l ] |> al_to_int32 |> F32.of_bits |> al_of_float32
      | [ CaseV ("F64", []); l ] -> inverse_of_ibytes.f [ NumV (Z.of_int 64); l ] |> al_to_int64 |> F64.of_bits |> al_of_float64
      | _ -> failwith "Invalid inverse_of_nbytes"
      );
  }

let vbytes : numerics =
  {
    name = "vbytes";
    f =
      (function
      | [ CaseV ("V128", []); v ] ->
        let s = v |> al_to_vec128 |> V128.to_bits in
        Array.init 16 (fun i -> s.[i] |> Char.code |> al_of_int) |> listV
      | _ -> failwith "Invalid vbytes"
      );
  }
let inverse_of_vbytes : numerics =
  {
    name = "inverse_of_vbytes";
    f =
      (function
      | [ CaseV ("V128", []); ListV l ] ->
        let v1 = inverse_of_ibytes.f [ NumV (Z.of_int 64); Array.sub !l 0 8 |> listV ] in
        let v2 = inverse_of_ibytes.f [ NumV (Z.of_int 64); Array.sub !l 8 8 |> listV ] in

        (match v1, v2 with
        | NumV n1, NumV n2 -> al_of_vec128 (V128.I64x2.of_lanes [ z_to_int64 n1; z_to_int64 n2 ])
        | _ -> failwith "Invalid inverse_of_vbytes")

      | _ -> failwith "Invalid inverse_of_vbytes"
      );
  }

let inverse_of_zbytes : numerics =
  {
    name = "inverse_of_zbytes";
    f =
      (function
      | [ CaseV ("I8", []); l ] -> inverse_of_ibytes.f [ NumV (Z.of_int 8); l ]
      | [ CaseV ("I16", []); l ] -> inverse_of_ibytes.f [ NumV (Z.of_int 16); l ]
      | args -> inverse_of_nbytes.f args
      );
  }

let bytes_ : numerics = { name = "bytes"; f = nbytes.f }
let inverse_of_bytes_ : numerics = { name = "inverse_of_bytes"; f = inverse_of_nbytes.f }

let wrap : numerics =
  {
    name = "wrap";
    f =
      (function
        | [ NumV _m; NumV n; NumV i ] -> NumV (Z.logand i (maskN n))
      | _ -> failwith "Invalid wrap"
      );
  }


let inverse_of_ibits : numerics =
  {
    name = "inverse_of_ibits";
    f =
      (function
      | [ NumV _; ListV l ] ->
        let na = Array.map (function | NumV e -> e | _ -> failwith "Invaild inverse_of_ibits") !l in
        NumV (Array.fold_right (fun e acc -> Z.logor e (Z.shift_left acc 1)) na Z.zero)
      | _ -> failwith "Invaild inverse_of_ibits"
      );
  }


let wrap_vunop = map al_to_vec128 al_of_vec128

let vvunop: numerics =
  {
    name = "vvunop";
    f =
      (function
      | [ CaseV ("V128", []); op; v ] -> (
        match op with
        | CaseV ("NOT", []) -> wrap_vunop V128.V1x128.lognot v
        | _ -> failwith ("Invalid vvunop: " ^ (Print.string_of_value op)))
      | _ -> failwith "Invalid vvunop")
  }

let vunop: numerics =
  {
    name = "vunop";
    f =
      (function
      | [ TupV [ CaseV (ls, []); NumV (ln) ]; op; v ] -> (
        match ls, ln with
        | "I8", z when z = Z.of_int 16 -> (
          match op with
          | CaseV ("ABS", []) -> wrap_vunop V128.I8x16.abs v
          | CaseV ("NEG", []) -> wrap_vunop V128.I8x16.neg v
          | CaseV ("POPCNT", []) -> wrap_vunop V128.I8x16.popcnt v
          | _ -> failwith ("Invalid viunop: " ^ (Print.string_of_value op)))
        | "I16", z when z = Z.of_int 8 -> (
          match op with
          | CaseV ("ABS", []) -> wrap_vunop V128.I16x8.abs v
          | CaseV ("NEG", []) -> wrap_vunop V128.I16x8.neg v
          | _ -> failwith ("Invalid viunop: " ^ (Print.string_of_value op)))
        | "I32", z when z = Z.of_int 4 -> (
          match op with
          | CaseV ("ABS", []) -> wrap_vunop V128.I32x4.abs v
          | CaseV ("NEG", []) -> wrap_vunop V128.I32x4.neg v
          | _ -> failwith ("Invalid viunop: " ^ (Print.string_of_value op)))
        | "I64", z when z = Z.of_int 2 -> (
          match op with
          | CaseV ("ABS", []) -> wrap_vunop V128.I64x2.abs v
          | CaseV ("NEG", []) -> wrap_vunop V128.I64x2.neg v
          | _ -> failwith ("Invalid viunop: " ^ (Print.string_of_value op)))
        | "F32", z when z = Z.of_int 4 -> (
          match op with
          | CaseV ("ABS", []) -> wrap_vunop V128.F32x4.abs v
          | CaseV ("NEG", []) -> wrap_vunop V128.F32x4.neg v
          | CaseV ("SQRT", []) -> wrap_vunop V128.F32x4.sqrt v
          | CaseV ("CEIL", []) -> wrap_vunop V128.F32x4.ceil v
          | CaseV ("FLOOR", []) -> wrap_vunop V128.F32x4.floor v
          | CaseV ("TRUNC", []) -> wrap_vunop V128.F32x4.trunc v
          | CaseV ("NEAREST", []) -> wrap_vunop V128.F32x4.nearest v
          | _ -> failwith ("Invalid vfunop: " ^ (Print.string_of_value op)))
        | "F64", z when z = Z.of_int 2 -> (
          match op with
          | CaseV ("ABS", []) -> wrap_vunop V128.F64x2.abs v
          | CaseV ("NEG", []) -> wrap_vunop V128.F64x2.neg v
          | CaseV ("SQRT", []) -> wrap_vunop V128.F64x2.sqrt v
          | CaseV ("CEIL", []) -> wrap_vunop V128.F64x2.ceil v
          | CaseV ("FLOOR", []) -> wrap_vunop V128.F64x2.floor v
          | CaseV ("TRUNC", []) -> wrap_vunop V128.F64x2.trunc v
          | CaseV ("NEAREST", []) -> wrap_vunop V128.F64x2.nearest v
          | _ -> failwith ("Invalid vfunop: " ^ (Print.string_of_value op)))
        | _ -> failwith "Invalid type for vunop")
      | _ -> failwith "Invalid vunop")
  }


let wrap_vvbinop = map2 al_to_vec128 al_of_vec128

let wrap_vbinop op v1 v2 =
  let v1 = al_to_vec128 v1 in
  let v2 = al_to_vec128 v2 in
  [ op v1 v2 |> al_of_vec128 ] |> listV_of_list

let vvbinop: numerics =
  {
    name = "vvbinop";
    f =
      (function
      | [ CaseV ("V128", []); op; v1; v2 ] -> (
        match op with
        | CaseV ("AND", []) -> wrap_vvbinop V128.V1x128.and_ v1 v2
        | CaseV ("ANDNOT", []) -> wrap_vvbinop V128.V1x128.andnot v1 v2
        | CaseV ("OR", []) -> wrap_vvbinop V128.V1x128.or_ v1 v2
        | CaseV ("XOR", []) -> wrap_vvbinop V128.V1x128.xor v1 v2
        | _ -> failwith ("Invalid vvbinop: " ^ (Print.string_of_value op)))
      | _ -> failwith "Invalid type for vvbinop")
  }

let vbinop: numerics =
  {
    name = "vbinop";
    f =
      (function
      | [ TupV [ CaseV (ls, []); NumV (ln) ]; op; v1; v2 ] -> (
        match ls, ln with
        | "I8", z when z = Z.of_int 16 -> (
          match op with
          | CaseV ("ADD", []) -> wrap_vbinop V128.I8x16.add v1 v2
          | CaseV ("SUB", []) -> wrap_vbinop V128.I8x16.sub v1 v2
          | CaseV ("ADD_SAT", [CaseV ("S", [])]) -> wrap_vbinop V128.I8x16.add_sat_s v1 v2
          | CaseV ("ADD_SAT", [CaseV ("U", [])]) -> wrap_vbinop V128.I8x16.add_sat_u v1 v2
          | CaseV ("SUB_SAT", [CaseV ("S", [])]) -> wrap_vbinop V128.I8x16.sub_sat_s v1 v2
          | CaseV ("SUB_SAT", [CaseV ("U", [])]) -> wrap_vbinop V128.I8x16.sub_sat_u v1 v2
          | CaseV ("MIN", [CaseV ("S", [])]) -> wrap_vbinop V128.I8x16.min_s v1 v2
          | CaseV ("MIN", [CaseV ("U", [])]) -> wrap_vbinop V128.I8x16.min_u v1 v2
          | CaseV ("MAX", [CaseV ("S", [])]) -> wrap_vbinop V128.I8x16.max_s v1 v2
          | CaseV ("MAX", [CaseV ("U", [])]) -> wrap_vbinop V128.I8x16.max_u v1 v2
          | CaseV ("AVGR_U", []) -> wrap_vbinop V128.I8x16.avgr_u v1 v2
          | _ -> failwith ("Invalid vibinop: " ^ (Print.string_of_value op)))
        | "I16", z when z = Z.of_int 8 -> (
          match op with
          | CaseV ("ADD", []) -> wrap_vbinop V128.I16x8.add v1 v2
          | CaseV ("SUB", []) -> wrap_vbinop V128.I16x8.sub v1 v2
          | CaseV ("ADD_SAT", [CaseV ("S", [])]) -> wrap_vbinop V128.I16x8.add_sat_s v1 v2
          | CaseV ("ADD_SAT", [CaseV ("U", [])]) -> wrap_vbinop V128.I16x8.add_sat_u v1 v2
          | CaseV ("SUB_SAT", [CaseV ("S", [])]) -> wrap_vbinop V128.I16x8.sub_sat_s v1 v2
          | CaseV ("SUB_SAT", [CaseV ("U", [])]) -> wrap_vbinop V128.I16x8.sub_sat_u v1 v2
          | CaseV ("MIN", [CaseV ("S", [])]) -> wrap_vbinop V128.I16x8.min_s v1 v2
          | CaseV ("MIN", [CaseV ("U", [])]) -> wrap_vbinop V128.I16x8.min_u v1 v2
          | CaseV ("MAX", [CaseV ("S", [])]) -> wrap_vbinop V128.I16x8.max_s v1 v2
          | CaseV ("MAX", [CaseV ("U", [])]) -> wrap_vbinop V128.I16x8.max_u v1 v2
          | CaseV ("MUL", []) -> wrap_vbinop V128.I16x8.mul v1 v2
          | CaseV ("AVGR_U", []) -> wrap_vbinop V128.I16x8.avgr_u v1 v2
          | CaseV ("Q15MULR_SAT_S", []) -> wrap_vbinop V128.I16x8.q15mulr_sat_s v1 v2
          | _ -> failwith ("Invalid vibinop: " ^ (Print.string_of_value op)))
        | "I32", z when z = Z.of_int 4 -> (
          match op with
          | CaseV ("ADD", []) -> wrap_vbinop V128.I32x4.add v1 v2
          | CaseV ("SUB", []) -> wrap_vbinop V128.I32x4.sub v1 v2
          | CaseV ("ADD_SAT", [CaseV ("S", [])]) -> wrap_vbinop V128.I32x4.add_sat_s v1 v2
          | CaseV ("ADD_SAT", [CaseV ("U", [])]) -> wrap_vbinop V128.I32x4.add_sat_u v1 v2
          | CaseV ("SUB_SAT", [CaseV ("S", [])]) -> wrap_vbinop V128.I32x4.sub_sat_s v1 v2
          | CaseV ("SUB_SAT", [CaseV ("U", [])]) -> wrap_vbinop V128.I32x4.sub_sat_u v1 v2
          | CaseV ("MIN", [CaseV ("S", [])]) -> wrap_vbinop V128.I32x4.min_s v1 v2
          | CaseV ("MIN", [CaseV ("U", [])]) -> wrap_vbinop V128.I32x4.min_u v1 v2
          | CaseV ("MAX", [CaseV ("S", [])]) -> wrap_vbinop V128.I32x4.max_s v1 v2
          | CaseV ("MAX", [CaseV ("U", [])]) -> wrap_vbinop V128.I32x4.max_u v1 v2
          | CaseV ("MUL", []) -> wrap_vbinop V128.I32x4.mul v1 v2
          | _ -> failwith ("Invalid vibinop: " ^ (Print.string_of_value op)))
        | "I64", z when z = Z.of_int 2 -> (
          match op with
          | CaseV ("ADD", []) -> wrap_vbinop V128.I64x2.add v1 v2
          | CaseV ("SUB", []) -> wrap_vbinop V128.I64x2.sub v1 v2
          | CaseV ("ADD_SAT", [CaseV ("S", [])]) -> wrap_vbinop V128.I64x2.add_sat_s v1 v2
          | CaseV ("ADD_SAT", [CaseV ("U", [])]) -> wrap_vbinop V128.I64x2.add_sat_u v1 v2
          | CaseV ("SUB_SAT", [CaseV ("S", [])]) -> wrap_vbinop V128.I64x2.sub_sat_s v1 v2
          | CaseV ("SUB_SAT", [CaseV ("U", [])]) -> wrap_vbinop V128.I64x2.sub_sat_u v1 v2
          | CaseV ("MIN", [CaseV ("S", [])]) -> wrap_vbinop V128.I64x2.min_s v1 v2
          | CaseV ("MIN", [CaseV ("U", [])]) -> wrap_vbinop V128.I64x2.min_u v1 v2
          | CaseV ("MAX", [CaseV ("S", [])]) -> wrap_vbinop V128.I64x2.max_s v1 v2
          | CaseV ("MAX", [CaseV ("U", [])]) -> wrap_vbinop V128.I64x2.max_u v1 v2
          | CaseV ("MUL", []) -> wrap_vbinop V128.I64x2.mul v1 v2
          | _ -> failwith ("Invalid vibinop: " ^ (Print.string_of_value op)))
        | "F32", z when z = Z.of_int 4 -> (
          match op with
          | CaseV ("ADD", []) -> wrap_vbinop V128.F32x4.add v1 v2
          | CaseV ("SUB", []) -> wrap_vbinop V128.F32x4.sub v1 v2
          | CaseV ("MUL", []) -> wrap_vbinop V128.F32x4.mul v1 v2
          | CaseV ("DIV", []) -> wrap_vbinop V128.F32x4.div v1 v2
          | CaseV ("MIN", []) -> wrap_vbinop V128.F32x4.min v1 v2
          | CaseV ("MAX", []) -> wrap_vbinop V128.F32x4.max v1 v2
          | CaseV ("PMIN", []) -> wrap_vbinop V128.F32x4.pmin v1 v2
          | CaseV ("PMAX", []) -> wrap_vbinop V128.F32x4.pmax v1 v2
          | _ -> failwith ("Invalid vfbinop: " ^ (Print.string_of_value op)))
        | "F64", z when z = Z.of_int 2 -> (
          match op with
          | CaseV ("ADD", []) -> wrap_vbinop V128.F64x2.add v1 v2
          | CaseV ("SUB", []) -> wrap_vbinop V128.F64x2.sub v1 v2
          | CaseV ("MUL", []) -> wrap_vbinop V128.F64x2.mul v1 v2
          | CaseV ("DIV", []) -> wrap_vbinop V128.F64x2.div v1 v2
          | CaseV ("MIN", []) -> wrap_vbinop V128.F64x2.min v1 v2
          | CaseV ("MAX", []) -> wrap_vbinop V128.F64x2.max v1 v2
          | CaseV ("PMIN", []) -> wrap_vbinop V128.F64x2.pmin v1 v2
          | CaseV ("PMAX", []) -> wrap_vbinop V128.F64x2.pmax v1 v2
          | _ -> failwith ("Invalid vfbinop: " ^ (Print.string_of_value op)))
        | _ -> failwith "Invalid type for vbinop")
      | _ -> failwith "Invalid vbinop")
  }

let wrap_vrelop op v1 v2 =
  let v1 = al_to_vec128 v1 in
  let v2 = al_to_vec128 v2 in
  op v1 v2 |> al_of_vec128

let vrelop: numerics =
  {
    name = "vrelop";
    f =
      (function
      | [ TupV [ CaseV (ls, []); NumV (ln) ]; op; v1; v2 ] -> (
        match ls, ln with
        | "I8", z when z = Z.of_int 16 -> (
          match op with
          | CaseV ("EQ", []) -> wrap_vrelop V128.I8x16.eq v1 v2
          | CaseV ("NE", []) -> wrap_vrelop V128.I8x16.ne v1 v2
          | CaseV ("LT", [CaseV ("S", [])]) -> wrap_vrelop V128.I8x16.lt_s v1 v2
          | CaseV ("LT", [CaseV ("U", [])]) -> wrap_vrelop V128.I8x16.lt_u v1 v2
          | CaseV ("GT", [CaseV ("S", [])]) -> wrap_vrelop V128.I8x16.gt_s v1 v2
          | CaseV ("GT", [CaseV ("U", [])]) -> wrap_vrelop V128.I8x16.gt_u v1 v2
          | CaseV ("LE", [CaseV ("S", [])]) -> wrap_vrelop V128.I8x16.le_s v1 v2
          | CaseV ("LE", [CaseV ("U", [])]) -> wrap_vrelop V128.I8x16.le_u v1 v2
          | CaseV ("GE", [CaseV ("S", [])]) -> wrap_vrelop V128.I8x16.ge_s v1 v2
          | CaseV ("GE", [CaseV ("U", [])]) -> wrap_vrelop V128.I8x16.ge_u v1 v2
          | _ -> failwith ("Invalid virelop: " ^ (Print.string_of_value op)))
        | "I16", z when z = Z.of_int 8 -> (
          match op with
          | CaseV ("EQ", []) -> wrap_vrelop V128.I16x8.eq v1 v2
          | CaseV ("NE", []) -> wrap_vrelop V128.I16x8.ne v1 v2
          | CaseV ("LT", [CaseV ("S", [])]) -> wrap_vrelop V128.I16x8.lt_s v1 v2
          | CaseV ("LT", [CaseV ("U", [])]) -> wrap_vrelop V128.I16x8.lt_u v1 v2
          | CaseV ("GT", [CaseV ("S", [])]) -> wrap_vrelop V128.I16x8.gt_s v1 v2
          | CaseV ("GT", [CaseV ("U", [])]) -> wrap_vrelop V128.I16x8.gt_u v1 v2
          | CaseV ("LE", [CaseV ("S", [])]) -> wrap_vrelop V128.I16x8.le_s v1 v2
          | CaseV ("LE", [CaseV ("U", [])]) -> wrap_vrelop V128.I16x8.le_u v1 v2
          | CaseV ("GE", [CaseV ("S", [])]) -> wrap_vrelop V128.I16x8.ge_s v1 v2
          | CaseV ("GE", [CaseV ("U", [])]) -> wrap_vrelop V128.I16x8.ge_u v1 v2
          | _ -> failwith ("Invalid virelop: " ^ (Print.string_of_value op)))
        | "I32", z when z = Z.of_int 4 -> (
          match op with
          | CaseV ("EQ", []) -> wrap_vrelop V128.I32x4.eq v1 v2
          | CaseV ("NE", []) -> wrap_vrelop V128.I32x4.ne v1 v2
          | CaseV ("LT", [CaseV ("S", [])]) -> wrap_vrelop V128.I32x4.lt_s v1 v2
          | CaseV ("LT", [CaseV ("U", [])]) -> wrap_vrelop V128.I32x4.lt_u v1 v2
          | CaseV ("GT", [CaseV ("S", [])]) -> wrap_vrelop V128.I32x4.gt_s v1 v2
          | CaseV ("GT", [CaseV ("U", [])]) -> wrap_vrelop V128.I32x4.gt_u v1 v2
          | CaseV ("LE", [CaseV ("S", [])]) -> wrap_vrelop V128.I32x4.le_s v1 v2
          | CaseV ("LE", [CaseV ("U", [])]) -> wrap_vrelop V128.I32x4.le_u v1 v2
          | CaseV ("GE", [CaseV ("S", [])]) -> wrap_vrelop V128.I32x4.ge_s v1 v2
          | CaseV ("GE", [CaseV ("U", [])]) -> wrap_vrelop V128.I32x4.ge_u v1 v2
          | _ -> failwith ("Invalid virelop: " ^ (Print.string_of_value op)))
        | "I64", z when z = Z.of_int 2 -> (
          match op with
          | CaseV ("EQ", []) -> wrap_vrelop V128.I64x2.eq v1 v2
          | CaseV ("NE", []) -> wrap_vrelop V128.I64x2.ne v1 v2
          | CaseV ("LT", [CaseV ("S", [])]) -> wrap_vrelop V128.I64x2.lt_s v1 v2
          | CaseV ("LT", [CaseV ("U", [])]) -> wrap_vrelop V128.I64x2.lt_u v1 v2
          | CaseV ("GT", [CaseV ("S", [])]) -> wrap_vrelop V128.I64x2.gt_s v1 v2
          | CaseV ("GT", [CaseV ("U", [])]) -> wrap_vrelop V128.I64x2.gt_u v1 v2
          | CaseV ("LE", [CaseV ("S", [])]) -> wrap_vrelop V128.I64x2.le_s v1 v2
          | CaseV ("LE", [CaseV ("U", [])]) -> wrap_vrelop V128.I64x2.le_u v1 v2
          | CaseV ("GE", [CaseV ("S", [])]) -> wrap_vrelop V128.I64x2.ge_s v1 v2
          | CaseV ("GE", [CaseV ("U", [])]) -> wrap_vrelop V128.I64x2.ge_u v1 v2
          | _ -> failwith ("Invalid virelop: " ^ (Print.string_of_value op)))
        | "F32", z when z = Z.of_int 4 -> (
          match op with
          | CaseV ("EQ", []) -> wrap_vrelop V128.F32x4.eq v1 v2
          | CaseV ("NE", []) -> wrap_vrelop V128.F32x4.ne v1 v2
          | CaseV ("LT", []) -> wrap_vrelop V128.F32x4.lt v1 v2
          | CaseV ("GT", []) -> wrap_vrelop V128.F32x4.gt v1 v2
          | CaseV ("LE", []) -> wrap_vrelop V128.F32x4.le v1 v2
          | CaseV ("GE", []) -> wrap_vrelop V128.F32x4.ge v1 v2
          | _ -> failwith ("Invalid vfrelop: " ^ (Print.string_of_value op)))
        | "F64", z when z = Z.of_int 2 -> (
          match op with
          | CaseV ("EQ", []) -> wrap_vrelop V128.F64x2.eq v1 v2
          | CaseV ("NE", []) -> wrap_vrelop V128.F64x2.ne v1 v2
          | CaseV ("LT", []) -> wrap_vrelop V128.F64x2.lt v1 v2
          | CaseV ("GT", []) -> wrap_vrelop V128.F64x2.gt v1 v2
          | CaseV ("LE", []) -> wrap_vrelop V128.F64x2.le v1 v2
          | CaseV ("GE", []) -> wrap_vrelop V128.F64x2.ge v1 v2
          | _ -> failwith ("Invalid vfrelop: " ^ (Print.string_of_value op)))
        | _ -> failwith "Invalid type for vrelop")
      | _ -> failwith "Invalid vrelop")
  }

let wrap_vternop op v1 v2 v3 =
  let v1 = al_to_vec128 v1 in
  let v2 = al_to_vec128 v2 in
  let v3 = al_to_vec128 v3 in
  op v1 v2 v3 |> al_of_vec128

let vvternop: numerics =
  {
    name = "vvternop";
    f =
      (function
      | [ CaseV ("V128", []); op; v1; v2; v3] -> (
        match op with
        | CaseV ("BITSELECT", []) -> wrap_vternop V128.V1x128.bitselect v1 v2 v3
        | _ -> failwith ("Invalid vvternop: " ^ (Print.string_of_value op)))
      | _ -> failwith "Invalid type for vvternop")
  }


let narrow : numerics =
  {
    name = "narrow";
    f =
      (function
      | [ NumV _; NumV n; CaseV ("S", []); NumV i ] -> (
        match z_to_int64 n with
        | 8L -> NumV (i |> z_to_int32 |> i16_to_i32 |> I8.saturate_s |> i32_to_i8 |> Z.of_int32)
        | 16L -> NumV (i |> z_to_int32 |> I16.saturate_s |> i32_to_i16 |> Z.of_int32)
        | _ -> failwith "Invalid narrow"
        )
      | [ NumV _; NumV n; CaseV ("U", []); NumV i ] -> (
        match z_to_int64 n with
        | 8L -> NumV (i |> z_to_int32 |> i16_to_i32 |> I8.saturate_u |> Z.of_int32)
        | 16L -> NumV (i |> z_to_int32 |> I16.saturate_u |> i32_to_i16 |> Z.of_int32)
        | _ -> failwith "Invalid narrow"
        )
      | _ -> failwith "Invalid narrow");
  }

let lanes : numerics =
  {
    name = "lanes_";
    f =
      (function
      | [ TupV [ CaseV ("I8", []); NumV z ]; v ] when z = Z.of_int 16 ->
        v |> al_to_vec128 |> V128.I8x16.to_lanes |> List.map al_of_int8 |> listV_of_list
      | [ TupV [ CaseV ("I16", []); NumV z ]; v ] when z = Z.of_int 8 ->
        v |> al_to_vec128 |> V128.I16x8.to_lanes |> List.map al_of_int16 |> listV_of_list
      | [ TupV [ CaseV ("I32", []); NumV z ]; v ] when z = Z.of_int 4 ->
        v |> al_to_vec128 |> V128.I32x4.to_lanes |> List.map al_of_int32 |> listV_of_list
      | [ TupV [ CaseV ("I64", []); NumV z ]; v ] when z = Z.of_int 2 ->
        v |> al_to_vec128 |> V128.I64x2.to_lanes |> List.map al_of_int64 |> listV_of_list
      | [ TupV [ CaseV ("F32", []); NumV z ]; v ] when z = Z.of_int 4 ->
        v |> al_to_vec128 |> V128.F32x4.to_lanes |> List.map al_of_float32 |> listV_of_list
      | [ TupV [ CaseV ("F64", []); NumV z ]; v ] when z = Z.of_int 2 ->
        v |> al_to_vec128 |> V128.F64x2.to_lanes |> List.map al_of_float64 |> listV_of_list
      | vs -> failwith ("Invalid lanes_: " ^ Print.(string_of_list string_of_value " " vs))
      );
  }
let inverse_of_lanes : numerics =
  {
    name = "inverse_of_lanes_";
    f =
      (function
      | [ TupV [ CaseV ("I8", []); NumV z ]; ListV lanes; ] when z = Z.of_int 16 -> List.map al_to_int32 (!lanes |> Array.to_list) |> List.map i8_to_i32 |> V128.I8x16.of_lanes |> al_of_vec128
      | [ TupV [ CaseV ("I16", []); NumV z ]; ListV lanes; ] when z = Z.of_int 8 -> List.map al_to_int32 (!lanes |> Array.to_list) |> List.map i16_to_i32 |> V128.I16x8.of_lanes |> al_of_vec128
      | [ TupV [ CaseV ("I32", []); NumV z ]; ListV lanes; ] when z = Z.of_int 4 -> List.map al_to_int32 (!lanes |> Array.to_list) |> V128.I32x4.of_lanes |> al_of_vec128
      | [ TupV [ CaseV ("I64", []); NumV z ]; ListV lanes; ] when z = Z.of_int 2 -> List.map al_to_int64 (!lanes |> Array.to_list) |> V128.I64x2.of_lanes |> al_of_vec128
      | [ TupV [ CaseV ("F32", []); NumV z ]; ListV lanes; ] when z = Z.of_int 4 -> List.map al_to_float32 (!lanes |> Array.to_list) |> V128.F32x4.of_lanes |> al_of_vec128
      | [ TupV [ CaseV ("F64", []); NumV z ]; ListV lanes; ] when z = Z.of_int 2 -> List.map al_to_float64 (!lanes |> Array.to_list) |> V128.F64x2.of_lanes |> al_of_vec128
      | _ -> failwith "Invalid inverse_of_lanes_"
      );
  }

let inverse_of_lsize : numerics =
  {
    name = "inverse_of_lsize";
    f =
      (function
      | [ NumV z ] when z = Z.of_int 8 -> CaseV ("I8", [])
      | [ NumV z ] when z = Z.of_int 16 -> CaseV ("I16", [])
      | [ NumV z ] when z = Z.of_int 32 -> CaseV ("I32", [])
      | [ NumV z ] when z = Z.of_int 64 -> CaseV ("I64", [])
      | _ -> failwith "Invalid inverse_of_lsize"
      );
  }

let rec inverse_of_concat_helper = function
  | a :: b :: l ->
    [listV_of_list [a; b]] @ inverse_of_concat_helper l
  | [] -> []
  | _ -> failwith "Invalid inverse_of_concat_bytes_helper"

let inverse_of_concat : numerics =
  {
    name = "inverse_of_concat";
    f =
      (function
      | [ ListV l ] -> listV_of_list (inverse_of_concat_helper (Array.to_list !l))
      | _ -> failwith "Invalid inverse_of_concat"
      );
  }

let vishiftop: numerics =
  {
    name = "vishiftop";
    f =
      (function
      | [ TupV [ CaseV (ls, []); _ ]; op; NumV v1; NumV v2] -> (
        match ls with
        | "I8" -> (
          let v1p = v1 |> z_to_int32 |> i8_to_i32 in
          let v2p = Z.rem v2 (Z.of_int 8) |> z_to_int32 in

          match op with
          | CaseV ("SHL", []) -> I8.shl v1p v2p |> al_of_int32
          | CaseV ("SHR", [CaseV ("S", [])]) -> I8.shr_s v1p v2p |> al_of_int32
          | CaseV ("SHR", [CaseV ("U", [])]) -> I8.shr_u v1p v2p |> al_of_int32
          | _ -> failwith ("Invalid vishiftop: " ^ (Print.string_of_value op))
        )
        | "I16" -> (
          let v1p = v1 |> z_to_int32 |> i16_to_i32 in
          let v2p = Z.rem v2 (Z.of_int 16) |> z_to_int32 in

          match op with
          | CaseV ("SHL", []) -> I16.shl v1p v2p |> al_of_int32
          | CaseV ("SHR", [CaseV ("S", [])]) -> I16.shr_s v1p v2p |> al_of_int32
          | CaseV ("SHR", [CaseV ("U", [])]) -> I16.shr_u v1p v2p |> al_of_int32
          | _ -> failwith ("Invalid vishiftop: " ^ (Print.string_of_value op))
        )
        | "I32" -> (
          let v1p = v1 |> z_to_int32 in
          let v2p = Z.rem v2 (Z.of_int 32) |> z_to_int32 in

          match op with
          | CaseV ("SHL", []) -> I32.shl v1p v2p |> al_of_int32
          | CaseV ("SHR", [CaseV ("S", [])]) -> I32.shr_s v1p v2p |> al_of_int32
          | CaseV ("SHR", [CaseV ("U", [])]) -> I32.shr_u v1p v2p |> al_of_int32
          | _ -> failwith ("Invalid vishiftop: " ^ (Print.string_of_value op))
        )
        | "I64" -> (
          let v1p = v1 |> z_to_int64 in
          let v2p = Z.rem v2 (Z.of_int 64) |> z_to_int64 in

          match op with
          | CaseV ("SHL", []) -> I64.shl v1p v2p |> al_of_int64
          | CaseV ("SHR", [CaseV ("S", [])]) -> I64.shr_s v1p v2p |> al_of_int64
          | CaseV ("SHR", [CaseV ("U", [])]) -> I64.shr_u v1p v2p |> al_of_int64
          | _ -> failwith ("Invalid vishiftop: " ^ (Print.string_of_value op))
        )
        | _ -> failwith "Invalid type for vishiftop"
        )
      | _ -> failwith "Invalid vishiftop")
  }

let numerics_list : numerics list = [
  ibytes;
  inverse_of_ibytes;
  nbytes;
  vbytes;
  inverse_of_nbytes;
  inverse_of_vbytes;
  inverse_of_zbytes;
  bytes_;
  inverse_of_bytes_;
  vvunop;
  vvbinop;
  vvternop;
  vunop;
  vbinop;
  inverse_of_concat;
  signed;
  inverse_of_signed;
  iadd;
  isub;
  imul;
  idiv;
  irem;
  inot;
  iand;
  iandnot;
  ior;
  ixor;
  ishl;
  ishr;
  irotl;
  irotr;
  iclz;
  ictz;
  ipopcnt;
  ieqz;
  ieq;
  ine;
  ilt;
  igt;
  ile;
  ige;
  iabs;
  ineg;
  imin;
  imax;
  ext;
  wrap;
  vrelop;
  vishiftop;
  narrow;
  lanes;
  inverse_of_lanes;
  inverse_of_lsize;
  inverse_of_ibits;
]

let call_numerics fname args =
  let numerics =
    List.find (fun numerics -> numerics.name = fname) numerics_list
  in
  numerics.f args

let mem name = List.exists (fun numerics -> numerics.name = name) numerics_list
