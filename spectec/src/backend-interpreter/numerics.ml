open Reference_interpreter
open Construct
open Al
open Ast
open Al_util


(* Errors *)

let error fname msg = raise (Exception.InvalidArg (fname ^ ": " ^ msg))

let error_typ_value fname typ v =
  Printf.sprintf "invalid %s: %s" typ (Print.string_of_value v)
  |> error fname

let error_values fname vs =
  "[" ^ Print.string_of_values ", " vs ^ "]"
  |> error fname


(* Numerics *)

type numerics = { name : string; f : value list -> value }

let mask64 = Z.of_int64_unsigned (-1L)

let maskN n = Z.(pred (shift_left one (to_int n)))

let z_to_int64 z = Z.(to_int64_unsigned (logand mask64 z))

let i8_to_i32 i8 =
  (* NOTE: This operation extends the sign of i8 to i32 *)
  I32.shr_s (I32.shl i8 24l) 24l
let i16_to_i32 i16 =
  (* NOTE: This operation extends the sign of i8 to i32 *)
  I32.shr_s (I32.shl i16 16l) 16l

let catch_ixx_exception f = try f() |> singleton with
  | Ixx.DivideByZero
  | Ixx.Overflow
  | Ixx.InvalidConversion -> empty_list

let signed : numerics =
  {
    name = "signed";
    f =
      (function
      | [ NumV z; NumV n ] ->
        let z = Z.to_int z in
        (if Z.lt n (Z.shift_left Z.one (z - 1)) then n else Z.(sub n (shift_left one z))) |> al_of_z
      | vs -> error_values "signed" vs
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
      | vs -> error_values "inverse_of_signed" vs
      )
  }

let sat : numerics =
  {
    name = "sat";
    f =
      (function
      | [ NumV z; CaseV ("U", []); NumV i ] ->
        if Z.(gt i (shift_left one (Z.to_int z) |> pred)) then
          NumV Z.(shift_left one (Z.to_int z) |> pred)
        else if Z.(lt i zero) then
          NumV Z.zero
        else
          NumV i
      | [ NumV z; CaseV ("S", []); NumV i ] ->
        let n = Z.to_int z - 1 in
        if Z.(lt i (shift_left one n |> neg)) then
          inverse_of_signed.f [ NumV z; NumV Z.(shift_left one n |> neg) ]
        else if Z.(gt i (shift_left one n |> pred)) then
          inverse_of_signed.f [ NumV z; NumV Z.(shift_left one n |> pred) ]
        else
          NumV i
      | vs -> error_values "isat" vs
      );
  }

let iadd : numerics =
  {
    name = "iadd";
    f =
      (function
      | [ NumV z; NumV m; NumV n ] -> Z.(logand (add m n) (maskN z)) |> al_of_z
      | vs -> error_values "iadd" vs
      );
  }
let isub : numerics =
  {
    name = "isub";
    f =
      (function
      | [ NumV z; NumV m; NumV n ] -> Z.(logand (sub m n) (maskN z)) |> al_of_z
      | vs -> error_values "isub" vs
      );
  }
let imul : numerics =
  {
    name = "imul";
    f =
      (function
      | [ NumV z; NumV m; NumV n ] -> Z.(logand (mul m n) (maskN z)) |> al_of_z
      | vs -> error_values "imul" vs
      );
  }
let idiv : numerics =
  {
    name = "idiv";
    f =
      (function
      | [ NumV _; CaseV ("U", []); NumV m; NumV n ] ->
        if n = Z.zero then
          empty_list
        else
          Z.(div m n) |> al_of_z |> singleton
      | [ NumV z; CaseV ("S", []); NumV m; NumV n ] ->
        if n = Z.zero then
          empty_list
        else if m = Z.shift_left Z.one (Z.to_int z - 1) && n = maskN z then
          empty_list
        else
          let z = NumV z in
          let m = signed.f [ z; NumV m ] |> al_to_z in
          let n = signed.f [ z; NumV n ] |> al_to_z in
          inverse_of_signed.f [ z; NumV Z.(div m n) ] |> singleton
      | vs -> error_values "idiv" vs
      );
  }
let irem : numerics =
  {
    name = "irem";
    f =
      (function
      | [ NumV _; CaseV ("U", []); NumV m; NumV n ] ->
        if n = Z.zero then
          empty_list
        else
          Z.(rem m n) |> al_of_z |> singleton
      | [ NumV _ as z; CaseV ("S", []); NumV m; NumV n ] ->
        if n = Z.zero then
          empty_list
        else
          let m = signed.f [ z; NumV m ] |> al_to_z in
          let n = signed.f [ z; NumV n ] |> al_to_z in
          inverse_of_signed.f [ z; NumV Z.(rem m n) ] |> singleton
      | vs -> error_values "irem" vs
      );
  }
let inot : numerics =
  {
    name = "inot";
    f =
      (function
      | [ NumV z; NumV m ] -> Z.(logand (lognot m) (maskN z)) |> al_of_z
      | vs -> error_values "inot" vs
      );
  }
let iand : numerics =
  {
    name = "iand";
    f =
      (function
      | [ NumV z; NumV m; NumV n ] -> Z.(logand (logand m n) (maskN z)) |> al_of_z
      | vs -> error_values "iand" vs
      );
  }
let iandnot : numerics =
  {
    name = "iandnot";
    f =
      (function
      | [ NumV z; NumV m; NumV n ] -> Z.(logand (logand m (lognot n)) (maskN z)) |> al_of_z
      | vs -> error_values "iandnot" vs
      );
  }
let ior : numerics =
  {
    name = "ior";
    f =
      (function
      | [ NumV z; NumV m; NumV n ] -> Z.(logand (logor m n) (maskN z)) |> al_of_z
      | vs -> error_values "ior" vs
      );
  }
let ixor : numerics =
  {
    name = "ixor";
    f =
      (function
      | [ NumV z; NumV m; NumV n ] -> Z.(logand (logxor m n) (maskN z)) |> al_of_z
      | vs -> error_values "ixor" vs
      );
  }
let ishl : numerics =
  {
    name = "ishl";
    f =
      (function
      | [ NumV z; NumV m; NumV n ] -> Z.(logand (shift_left m (Z.to_int (rem n z))) (maskN z)) |> al_of_z
      | vs -> error_values "ishl" vs
      );
  }
let ishr : numerics =
  {
    name = "ishr";
    f =
      (function
      | [ NumV z; CaseV ("U", []); NumV m; NumV n ] -> Z.(shift_right m (Z.to_int (rem n z))) |> al_of_z
      | [ NumV z; CaseV ("S", []); NumV m; NumV n ] ->
          let n = Z.(to_int (rem n z)) in
          let s = Z.to_int z in
          let d = s - n in
          let msb = Z.shift_right m (s - 1) in
          let pad = Z.(mul (shift_left one s - shift_left one d) msb) in
          NumV Z.(logor pad (shift_right m n))
      | vs -> error_values "ishr" vs
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
      | vs -> error_values "irotl" vs
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
      | vs -> error_values "irotr" vs
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
      | vs -> error_values "iclz" vs
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
      | vs -> error_values "ictz" vs
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
      | vs -> error_values "ipopcnt" vs
      );
  }
let ieqz : numerics =
  {
    name = "ieqz";
    f =
      (function
      | [ NumV _; NumV m ] -> m = Z.zero |> al_of_bool
      | vs -> error_values "ieqz" vs
      );
  }
let ieq : numerics =
  {
    name = "ieq";
    f =
      (function
      | [ NumV _; NumV m; NumV n ] -> Z.equal m n |> al_of_bool
      | vs -> error_values "ieq" vs
      );
  }
let ine : numerics =
  {
    name = "ine";
    f =
      (function
      | [ NumV _; NumV m; NumV n ] -> Z.equal m n |> not |> al_of_bool
      | vs -> error_values "ine" vs
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
      | vs -> error_values "ilt" vs
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
      | vs -> error_values "igt" vs
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
      | vs -> error_values "ile" vs
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
      | vs -> error_values "ige" vs
      );
  }
let ibitselect : numerics =
  {
    name = "ibitselect";
    f =
      (function
      | [ NumV _ as z; NumV _ as i1; NumV _ as i2; NumV _ as i3 ] ->
        ior.f [ z; iand.f [ z; i1; i3 ]; iand.f [ z; i2; inot.f [ z; i3 ]]]
      | vs -> error_values "ibitselect" vs
      );
  }
let iabs : numerics =
  {
    name = "iabs";
    f =
      (function
      | [ NumV _ as z; NumV _ as m ] -> signed.f [ z; m ] |> al_to_z |> Z.abs |> al_of_z
      | vs -> error_values "iabs" vs
      );
  }
let ineg : numerics =
  {
    name = "ineg";
    f =
      (function
      | [ NumV z; NumV m ] -> Z.(logand (shift_left one (to_int z) - m) (maskN z)) |> al_of_z
      | vs -> error_values "ineg" vs
      );
  }
let imin : numerics =
  {
    name = "imin";
    f =
      (function
      | [ NumV _ as z; CaseV (_, []) as sx; NumV _ as m; NumV _ as n ] ->
        (if al_to_int (ilt.f [ z; sx; m; n ]) = 1 then m else n)
      | vs -> error_values "imin" vs
      );
  }
let imax : numerics =
  {
    name = "imax";
    f =
      (function
      | [ NumV _ as z; CaseV (_, []) as sx; NumV _ as m; NumV _ as n ] ->
        (if al_to_int (igt.f [ z; sx; m; n ]) = 1 then m else n)
      | vs -> error_values "imax" vs
      );
  }
let iadd_sat : numerics =
  {
    name = "iadd_sat";
    f =
      (function
      | [ NumV _ as z; CaseV ("U", []); NumV m; NumV n ] -> sat.f [ z; nullary "U"; NumV Z.(add m n)]
      | [ NumV _ as z; CaseV ("S", []); NumV m; NumV n ] ->
        let m = signed.f [ z; NumV m ] |> al_to_z in
        let n = signed.f [ z; NumV n ] |> al_to_z in
        sat.f [ z; nullary "S"; NumV Z.(add m n)]
      | vs -> error_values "iadd_sat" vs
      );
  }
let isub_sat : numerics =
  {
    name = "isub_sat";
    f =
      (function
      | [ NumV _ as z; CaseV ("U", []); NumV m; NumV n ] -> sat.f [ z; nullary "U"; NumV Z.(sub m n)]
      | [ NumV _ as z; CaseV ("S", []); NumV m; NumV n ] ->
        let m = signed.f [ z; NumV m ] |> al_to_z in
        let n = signed.f [ z; NumV n ] |> al_to_z in
        sat.f [ z; nullary "S"; NumV Z.(sub m n)]
      | vs -> error_values "isub_sat" vs
      );
  }
let iavgr : numerics =
  {
    name = "iavgr";
    f =
      (function
      | [ NumV _ ; CaseV ("U", []); NumV m; NumV n ] -> Z.((m + n + one) / two) |> al_of_z
      | [ NumV _ as z; CaseV ("S", []); NumV m; NumV n ] ->
        let m = signed.f [ z; NumV m ] |> al_to_z in
        let n = signed.f [ z; NumV n ] |> al_to_z in
        Z.((m + n + one) / two) |> al_of_z
      | vs -> error_values "iavgr" vs
      );
  }
let iq15mulr_sat : numerics =
  {
    name = "iq15mulr_sat";
    f =
      (function
      | [ NumV _ as z; sx; NumV _ as m; NumV _ as n ] ->
        let m = signed.f [ z; m ] |> al_to_z in
        let n = signed.f [ z; n ] |> al_to_z in
        sat.f [ z; sx; NumV Z.(shift_right (mul m n + of_int 0x4000) 15) ]
      | vs -> error_values "iq15mulr_sat" vs
      );
  }

let list_f f x = f x |> singleton
let fadd : numerics =
  {
    name = "fadd";
    f = list_f
      (function
      | [ NumV z; CaseV _ as f1; CaseV _ as f2; ] when z = Z.of_int 32 ->
        F32.add (al_to_float32 f1) (al_to_float32 f2) |> al_of_float32
      | [ NumV z; CaseV _ as f1; CaseV _ as f2; ] when z = Z.of_int 64 ->
        F64.add (al_to_float64 f1) (al_to_float64 f2) |> al_of_float64
      | vs -> error_values "fadd" vs
      );
  }
let fsub : numerics =
  {
    name = "fsub";
    f = list_f
      (function
      | [ NumV z; CaseV _ as f1; CaseV _ as f2; ] when z = Z.of_int 32 ->
        F32.sub (al_to_float32 f1) (al_to_float32 f2) |> al_of_float32
      | [ NumV z; CaseV _ as f1; CaseV _ as f2; ] when z = Z.of_int 64 ->
        F64.sub (al_to_float64 f1) (al_to_float64 f2) |> al_of_float64
      | vs -> error_values "fsub" vs
      );
  }
let fmul : numerics =
  {
    name = "fmul";
    f = list_f
      (function
      | [ NumV z; CaseV _ as f1; CaseV _ as f2; ] when z = Z.of_int 32 ->
        F32.mul (al_to_float32 f1) (al_to_float32 f2) |> al_of_float32
      | [ NumV z; CaseV _ as f1; CaseV _ as f2; ] when z = Z.of_int 64 ->
        F64.mul (al_to_float64 f1) (al_to_float64 f2) |> al_of_float64
      | vs -> error_values "fmul" vs
      );
  }
let fdiv : numerics =
  {
    name = "fdiv";
    f = list_f
      (function
      | [ NumV z; CaseV _ as f1; CaseV _ as f2; ] when z = Z.of_int 32 ->
        F32.div (al_to_float32 f1) (al_to_float32 f2) |> al_of_float32
      | [ NumV z; CaseV _ as f1; CaseV _ as f2; ] when z = Z.of_int 64 ->
        F64.div (al_to_float64 f1) (al_to_float64 f2) |> al_of_float64
      | vs -> error_values "fdiv" vs
      );
  }
let fmin : numerics =
  {
    name = "fmin";
    f = list_f
      (function
      | [ NumV z; CaseV _ as f1; CaseV _ as f2; ] when z = Z.of_int 32 ->
        F32.min (al_to_float32 f1) (al_to_float32 f2) |> al_of_float32
      | [ NumV z; CaseV _ as f1; CaseV _ as f2; ] when z = Z.of_int 64 ->
        F64.min (al_to_float64 f1) (al_to_float64 f2) |> al_of_float64
      | vs -> error_values "fmin" vs
      );
  }
let fmax : numerics =
  {
    name = "fmax";
    f = list_f
      (function
      | [ NumV z; CaseV _ as f1; CaseV _ as f2; ] when z = Z.of_int 32 ->
        F32.max (al_to_float32 f1) (al_to_float32 f2) |> al_of_float32
      | [ NumV z; CaseV _ as f1; CaseV _ as f2; ] when z = Z.of_int 64 ->
        F64.max (al_to_float64 f1) (al_to_float64 f2) |> al_of_float64
      | vs -> error_values "fmax" vs
      );
  }
let fcopysign : numerics =
  {
    name = "fcopysign";
    f = list_f
      (function
      | [ NumV z; CaseV _ as f1; CaseV _ as f2; ] when z = Z.of_int 32 ->
        F32.copysign (al_to_float32 f1) (al_to_float32 f2) |> al_of_float32
      | [ NumV z; CaseV _ as f1; CaseV _ as f2; ] when z = Z.of_int 64 ->
        F64.copysign (al_to_float64 f1) (al_to_float64 f2) |> al_of_float64
      | vs -> error_values "fcopysign" vs
      );
  }
let fabs : numerics =
  {
    name = "fabs";
    f = list_f
      (function
      | [ NumV z; CaseV _ as f ] when z = Z.of_int 32 ->
        F32.abs (al_to_float32 f) |> al_of_float32
      | [ NumV z; CaseV _ as f ] when z = Z.of_int 64 ->
        F64.abs (al_to_float64 f) |> al_of_float64
      | vs -> error_values "fabs" vs
      );
  }
let fneg : numerics =
  {
    name = "fneg";
    f = list_f
      (function
      | [ NumV z; CaseV _ as f ] when z = Z.of_int 32 ->
        F32.neg (al_to_float32 f) |> al_of_float32
      | [ NumV z; CaseV _ as f ] when z = Z.of_int 64 ->
        F64.neg (al_to_float64 f) |> al_of_float64
      | vs -> error_values "fneg" vs
      );
  }
let fsqrt : numerics =
  {
    name = "fsqrt";
    f = list_f
      (function
      | [ NumV z; CaseV _ as f ] when z = Z.of_int 32 ->
        F32.sqrt (al_to_float32 f) |> al_of_float32
      | [ NumV z; CaseV _ as f ] when z = Z.of_int 64 ->
        F64.sqrt (al_to_float64 f) |> al_of_float64
      | vs -> error_values "fsqrt" vs
      );
  }
let fceil : numerics =
  {
    name = "fceil";
    f = list_f
      (function
      | [ NumV z; CaseV _ as f ] when z = Z.of_int 32 ->
        F32.ceil (al_to_float32 f) |> al_of_float32
      | [ NumV z; CaseV _ as f ] when z = Z.of_int 64 ->
        F64.ceil (al_to_float64 f) |> al_of_float64
      | vs -> error_values "fceil" vs
      );
  }
let ffloor : numerics =
  {
    name = "ffloor";
    f = list_f
      (function
      | [ NumV z; CaseV _ as f ] when z = Z.of_int 32 ->
        F32.floor (al_to_float32 f) |> al_of_float32
      | [ NumV z; CaseV _ as f ] when z = Z.of_int 64 ->
        F64.floor (al_to_float64 f) |> al_of_float64
      | vs -> error_values "ffloor" vs
      );
  }
let ftrunc : numerics =
  {
    name = "ftrunc";
    f = list_f
      (function
      | [ NumV z; CaseV _ as f ] when z = Z.of_int 32 ->
        F32.trunc (al_to_float32 f) |> al_of_float32
      | [ NumV z; CaseV _ as f ] when z = Z.of_int 64 ->
        F64.trunc (al_to_float64 f) |> al_of_float64
      | vs -> error_values "ftrunc" vs
      );
  }
let fnearest : numerics =
  {
    name = "fnearest";
    f = list_f
      (function
      | [ NumV z; CaseV _ as f ] when z = Z.of_int 32 ->
        F32.nearest (al_to_float32 f) |> al_of_float32
      | [ NumV z; CaseV _ as f ] when z = Z.of_int 64 ->
        F64.nearest (al_to_float64 f) |> al_of_float64
      | vs -> error_values "fnearest" vs
      );
  }
let feq : numerics =
  {
    name = "feq";
    f =
      (function
      | [ NumV z; CaseV _ as f1; CaseV _ as f2; ] when z = Z.of_int 32 ->
        F32.eq (al_to_float32 f1) (al_to_float32 f2) |> al_of_bool
      | [ NumV z; CaseV _ as f1; CaseV _ as f2; ] when z = Z.of_int 64 ->
        F64.eq (al_to_float64 f1) (al_to_float64 f2) |> al_of_bool
      | vs -> error_values "feq" vs
      );
  }
let fne : numerics =
  {
    name = "fne";
    f =
      (function
      | [ NumV z; CaseV _ as f1; CaseV _ as f2; ] when z = Z.of_int 32 ->
        F32.ne (al_to_float32 f1) (al_to_float32 f2) |> al_of_bool
      | [ NumV z; CaseV _ as f1; CaseV _ as f2; ] when z = Z.of_int 64 ->
        F64.ne (al_to_float64 f1) (al_to_float64 f2) |> al_of_bool
      | vs -> error_values "fne" vs
      );
  }
let flt : numerics =
  {
    name = "flt";
    f =
      (function
      | [ NumV z; CaseV _ as f1; CaseV _ as f2; ] when z = Z.of_int 32 ->
        F32.lt (al_to_float32 f1) (al_to_float32 f2) |> al_of_bool
      | [ NumV z; CaseV _ as f1; CaseV _ as f2; ] when z = Z.of_int 64 ->
        F64.lt (al_to_float64 f1) (al_to_float64 f2) |> al_of_bool
      | vs -> error_values "flt" vs
      );
  }
let fgt : numerics =
  {
    name = "fgt";
    f =
      (function
      | [ NumV z; CaseV _ as f1; CaseV _ as f2; ] when z = Z.of_int 32 ->
        F32.gt (al_to_float32 f1) (al_to_float32 f2) |> al_of_bool
      | [ NumV z; CaseV _ as f1; CaseV _ as f2; ] when z = Z.of_int 64 ->
        F64.gt (al_to_float64 f1) (al_to_float64 f2) |> al_of_bool
      | vs -> error_values "fgt" vs
      );
  }
let fle : numerics =
  {
    name = "fle";
    f =
      (function
      | [ NumV z; CaseV _ as f1; CaseV _ as f2; ] when z = Z.of_int 32 ->
        F32.le (al_to_float32 f1) (al_to_float32 f2) |> al_of_bool
      | [ NumV z; CaseV _ as f1; CaseV _ as f2; ] when z = Z.of_int 64 ->
        F64.le (al_to_float64 f1) (al_to_float64 f2) |> al_of_bool
      | vs -> error_values "fle" vs
      );
  }
let fge : numerics =
  {
    name = "fge";
    f =
      (function
      | [ NumV z; CaseV _ as f1; CaseV _ as f2; ] when z = Z.of_int 32 ->
        F32.ge (al_to_float32 f1) (al_to_float32 f2) |> al_of_bool
      | [ NumV z; CaseV _ as f1; CaseV _ as f2; ] when z = Z.of_int 64 ->
        F64.ge (al_to_float64 f1) (al_to_float64 f2) |> al_of_bool
      | vs -> error_values "fge" vs
      );
  }
let fpmin : numerics =
  {
    name = "fpmin";
    f = list_f
      (function
      | [ NumV _ as z; CaseV _ as f1; CaseV _ as f2; ] ->
        if (flt.f [ z; f2; f1 ] |> al_to_int = 1) then f2 else f1
      | vs -> error_values "fpmin" vs
      );
  }
let fpmax : numerics =
  {
    name = "fpmax";
    f = list_f
      (function
      | [ NumV _ as z; CaseV _ as f1; CaseV _ as f2; ] ->
        if (flt.f [ z; f1; f2 ] |> al_to_int = 1) then f2 else f1
      | vs -> error_values "fpmax" vs
      );
  }

let extend : numerics =
  {
    name = "extend";
    f =
      (function
      | [ NumV z; _; CaseV ("U", []); NumV v ] when z = Z.of_int 128 -> V128.I64x2.of_lanes [ z_to_int64 v; 0L ] |> al_of_vec128 (* HARDCODE *)
      | [ _; _; CaseV ("U", []); v ] -> v
      | [ NumV _ as m; NumV _ as n; CaseV ("S", []); NumV _ as i ] ->
        inverse_of_signed.f [ n; signed.f [ m; i ] ]
      | vs -> error_values "extend" vs
      );
  }

let trunc : numerics =
  {
    name = "trunc";
    f =
      (function
      | [ NumV m; NumV n; CaseV ("U", []); CaseV _ as i ] when m = Z.of_int 32 && n = Z.of_int 32 ->
        (fun _ -> i |> al_to_float32 |> I32_convert.trunc_f32_u |> al_of_int32) |> catch_ixx_exception
      | [ NumV m; NumV n; CaseV ("U", []); CaseV _ as i ] when m = Z.of_int 64 && n = Z.of_int 32 ->
        (fun _ -> i |> al_to_float64 |> I32_convert.trunc_f64_u |> al_of_int32) |> catch_ixx_exception
      | [ NumV m; NumV n; CaseV ("U", []); CaseV _ as i ] when m = Z.of_int 32 && n = Z.of_int 64 ->
        (fun _ -> i |> al_to_float32 |> I64_convert.trunc_f32_u |> al_of_int64) |> catch_ixx_exception
      | [ NumV m; NumV n; CaseV ("U", []); CaseV _ as i ] when m = Z.of_int 64 && n = Z.of_int 64 ->
        (fun _ -> i |> al_to_float64 |> I64_convert.trunc_f64_u |> al_of_int64) |> catch_ixx_exception
      | [ NumV m; NumV n; CaseV ("S", []); CaseV _ as i ] when m = Z.of_int 32 && n = Z.of_int 32 ->
        (fun _ -> i |> al_to_float32 |> I32_convert.trunc_f32_s |> al_of_int32) |> catch_ixx_exception
      | [ NumV m; NumV n; CaseV ("S", []); CaseV _ as i ] when m = Z.of_int 64 && n = Z.of_int 32 ->
        (fun _ -> i |> al_to_float64 |> I32_convert.trunc_f64_s |> al_of_int32) |> catch_ixx_exception
      | [ NumV m; NumV n; CaseV ("S", []); CaseV _ as i ] when m = Z.of_int 32 && n = Z.of_int 64 ->
        (fun _ -> i |> al_to_float32 |> I64_convert.trunc_f32_s |> al_of_int64) |> catch_ixx_exception
      | [ NumV m; NumV n; CaseV ("S", []); CaseV _ as i ] when m = Z.of_int 64 && n = Z.of_int 64 ->
        (fun _ -> i |> al_to_float64 |> I64_convert.trunc_f64_s |> al_of_int64) |> catch_ixx_exception
      | vs -> error_values "trunc" vs
      );
  }

let trunc_sat : numerics =
  {
    name = "trunc_sat";
    f =
      (function
      | [ NumV m; NumV n; CaseV ("U", []); CaseV _ as i ] when m = Z.of_int 32 && n = Z.of_int 32 ->
        (fun _ -> i |> al_to_float32 |> I32_convert.trunc_sat_f32_u |> al_of_int32) |> catch_ixx_exception
      | [ NumV m; NumV n; CaseV ("U", []); CaseV _ as i ] when m = Z.of_int 64 && n = Z.of_int 32 ->
        (fun _ -> i |> al_to_float64 |> I32_convert.trunc_sat_f64_u |> al_of_int32) |> catch_ixx_exception
      | [ NumV m; NumV n; CaseV ("U", []); CaseV _ as i ] when m = Z.of_int 32 && n = Z.of_int 64 ->
        (fun _ -> i |> al_to_float32 |> I64_convert.trunc_sat_f32_u |> al_of_int64) |> catch_ixx_exception
      | [ NumV m; NumV n; CaseV ("U", []); CaseV _ as i ] when m = Z.of_int 64 && n = Z.of_int 64 ->
        (fun _ -> i |> al_to_float64 |> I64_convert.trunc_sat_f64_u |> al_of_int64) |> catch_ixx_exception
      | [ NumV m; NumV n; CaseV ("S", []); CaseV _ as i ] when m = Z.of_int 32 && n = Z.of_int 32 ->
        (fun _ -> i |> al_to_float32 |> I32_convert.trunc_sat_f32_s |> al_of_int32) |> catch_ixx_exception
      | [ NumV m; NumV n; CaseV ("S", []); CaseV _ as i ] when m = Z.of_int 64 && n = Z.of_int 32 ->
        (fun _ -> i |> al_to_float64 |> I32_convert.trunc_sat_f64_s |> al_of_int32) |> catch_ixx_exception
      | [ NumV m; NumV n; CaseV ("S", []); CaseV _ as i ] when m = Z.of_int 32 && n = Z.of_int 64 ->
        (fun _ -> i |> al_to_float32 |> I64_convert.trunc_sat_f32_s |> al_of_int64) |> catch_ixx_exception
      | [ NumV m; NumV n; CaseV ("S", []); CaseV _ as i ] when m = Z.of_int 64 && n = Z.of_int 64 ->
        (fun _ -> i |> al_to_float64 |> I64_convert.trunc_sat_f64_s |> al_of_int64) |> catch_ixx_exception
      | vs -> error_values "trunc_sat" vs
      );
  }

let promote : numerics =
  {
    name = "promote";
    f = list_f
      (function
      | [ NumV m; NumV n; CaseV _ as i ] when m = Z.of_int 32 && n = Z.of_int 64 ->
        let ret = i |> al_to_float32 |> F64_convert.promote_f32 |> al_of_float64 in
        ret
      | vs -> error_values "promote" vs
      );
  }

let demote : numerics =
  {
    name = "demote";
    f = list_f
      (function
      | [ NumV m; NumV n; CaseV _ as i ] when m = Z.of_int 64 && n = Z.of_int 32 ->
        i |> al_to_float64 |> F32_convert.demote_f64 |> al_of_float32
      | vs -> error_values "demote" vs
      );
  }

let convert : numerics =
  {
    name = "convert";
    f =
      (function
      | [ NumV m; NumV n; CaseV ("U", []); NumV _ as i ] when m = Z.of_int 32 && n = Z.of_int 32 ->
        i |> al_to_int32 |> F32_convert.convert_i32_u |> al_of_float32
      | [ NumV m; NumV n; CaseV ("U", []); NumV _ as i ] when m = Z.of_int 64 && n = Z.of_int 32 ->
        i |> al_to_int64 |> F32_convert.convert_i64_u |> al_of_float32
      | [ NumV m; NumV n; CaseV ("U", []); NumV _ as i ] when m = Z.of_int 32 && n = Z.of_int 64 ->
        i |> al_to_int32 |> F64_convert.convert_i32_u |> al_of_float64
      | [ NumV m; NumV n; CaseV ("U", []); NumV _ as i ] when m = Z.of_int 64 && n = Z.of_int 64 ->
        i |> al_to_int64 |> F64_convert.convert_i64_u |> al_of_float64
      | [ NumV m; NumV n; CaseV ("S", []); NumV _ as i ] when m = Z.of_int 32 && n = Z.of_int 32 ->
        i |> al_to_int32 |> F32_convert.convert_i32_s |> al_of_float32
      | [ NumV m; NumV n; CaseV ("S", []); NumV _ as i ] when m = Z.of_int 64 && n = Z.of_int 32 ->
        i |> al_to_int64 |> F32_convert.convert_i64_s |> al_of_float32
      | [ NumV m; NumV n; CaseV ("S", []); NumV _ as i ] when m = Z.of_int 32 && n = Z.of_int 64 ->
        i |> al_to_int32 |> F64_convert.convert_i32_s |> al_of_float64
      | [ NumV m; NumV n; CaseV ("S", []); NumV _ as i ] when m = Z.of_int 64 && n = Z.of_int 64 ->
        i |> al_to_int64 |> F64_convert.convert_i64_s |> al_of_float64
      | vs -> error_values "convert" vs
      );
  }

let reinterpret : numerics =
  {
    name = "reinterpret";
    f =
      (function
      | [ CaseV ("I32", []); CaseV ("F32", []); NumV _ as i ] ->
        i |> al_to_int32 |> F32_convert.reinterpret_i32 |> al_of_float32
      | [ CaseV ("I64", []); CaseV ("F64", []); NumV _ as i ] ->
        i |> al_to_int64 |> F64_convert.reinterpret_i64 |> al_of_float64
      | [ CaseV ("F32", []); CaseV ("I32", []); CaseV _ as i ] ->
        i |> al_to_float32 |> I32_convert.reinterpret_f32 |> al_of_int32
      | [ CaseV ("F64", []); CaseV ("I64", []); CaseV _ as i ] ->
        i |> al_to_float64 |> I64_convert.reinterpret_f64 |> al_of_int64
      | vs -> error_values "reinterpret" vs
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
      | vs -> error_values "ibytes" vs
      );
  }
let inverse_of_ibytes : numerics =
  {
    name = "inverse_of_ibytes";
    f =
      (function
      | [ NumV n; ListV bs ] ->
          assert (
            (* numtype *)
            n = Z.of_int (Array.length !bs * 8) ||
            (* packtype *)
            (n = Z.of_int 32 && Array.length !bs <= 2)
          );
          NumV (Array.fold_right (fun b acc ->
            match b with
            | NumV b when Z.zero <= b && b < Z.of_int 256 -> Z.add b (Z.shift_left acc 8)
            | _ -> error_typ_value "inverse_of_ibytes" "byte" b
          ) !bs Z.zero)
      | vs -> error_values "inverse_of_ibytes" vs
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
      | vs -> error_values "nbytes" vs
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
      | vs -> error_values "inverse_of_nbytes" vs
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
      | vs -> error_values "vbytes" vs
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
        | _ -> error_values "inverse_of_vbytes" [ v1; v2 ]
        )

      | vs -> error_values "inverse_of_vbytes" vs
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

let inverse_of_cbytes : numerics =
  {
    name = "inverse_of_cbytes";
    f = function
      | [ CaseV ("V128", []); _ ] as args -> inverse_of_vbytes.f args
      | args -> inverse_of_nbytes.f args
  }

let bytes : numerics = { name = "bytes"; f = nbytes.f }
let inverse_of_bytes : numerics = { name = "inverse_of_bytes"; f = inverse_of_nbytes.f }

let wrap : numerics =
  {
    name = "wrap";
    f =
      (function
        | [ NumV _m; NumV n; NumV i ] -> NumV (Z.logand i (maskN n))
        | vs -> error_values "wrap" vs
      );
  }


let inverse_of_ibits : numerics =
  {
    name = "inverse_of_ibits";
    f =
      (function
      | [ NumV _; ListV vs ] ->
        let na = Array.map (function | NumV e -> e | v -> error_typ_value "inverse_of_ibits" "bit" v) !vs in
        NumV (Array.fold_right (fun e acc -> Z.logor e (Z.shift_left acc 1)) na Z.zero)
      | vs -> error_values "inverse_of_ibits" vs
      );
  }

let narrow : numerics =
  {
    name = "narrow";
    f =
      (function
      | [ NumV _ as m; NumV _ as n; CaseV (_, []) as sx; NumV _ as i ] ->
        sat.f [ n; sx; signed.f [ m; i ]]
      | vs -> error_values "narrow" vs);
  }

let lanes : numerics =
  {
    name = "lanes";
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
      | vs -> error_values "lanes" vs
      );
  }
let inverse_of_lanes : numerics =
  {
    name = "inverse_of_lanes";
    f =
      (function
      | [ TupV [ CaseV ("I8", []); NumV z ]; ListV lanes; ] when z = Z.of_int 16 && Array.length !lanes = 16 ->
        List.map al_to_int32 (!lanes |> Array.to_list) |> List.map i8_to_i32 |> V128.I8x16.of_lanes |> al_of_vec128
      | [ TupV [ CaseV ("I16", []); NumV z ]; ListV lanes; ] when z = Z.of_int 8 && Array.length !lanes = 8 ->
        List.map al_to_int32 (!lanes |> Array.to_list) |> List.map i16_to_i32 |> V128.I16x8.of_lanes |> al_of_vec128
      | [ TupV [ CaseV ("I32", []); NumV z ]; ListV lanes; ] when z = Z.of_int 4 && Array.length !lanes = 4 ->
        List.map al_to_int32 (!lanes |> Array.to_list) |> V128.I32x4.of_lanes |> al_of_vec128
      | [ TupV [ CaseV ("I64", []); NumV z ]; ListV lanes; ] when z = Z.of_int 2 && Array.length !lanes = 2 ->
        List.map al_to_int64 (!lanes |> Array.to_list) |> V128.I64x2.of_lanes |> al_of_vec128
      | [ TupV [ CaseV ("F32", []); NumV z ]; ListV lanes; ] when z = Z.of_int 4 && Array.length !lanes = 4 ->
        List.map al_to_float32 (!lanes |> Array.to_list) |> V128.F32x4.of_lanes |> al_of_vec128
      | [ TupV [ CaseV ("F64", []); NumV z ]; ListV lanes; ] when z = Z.of_int 2 && Array.length !lanes = 2 ->
        List.map al_to_float64 (!lanes |> Array.to_list) |> V128.F64x2.of_lanes |> al_of_vec128
      | vs -> error_values "inverse_of_lanes" vs
      );
  }

let inverse_of_isize : numerics =
  {
    name = "inverse_of_isize";
    f =
      (function
      | [ NumV z ] when z = Z.of_int 32 -> CaseV ("I32", [])
      | [ NumV z ] when z = Z.of_int 64 -> CaseV ("I64", [])
      | vs -> error_values "inverse_of_isize" vs
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
      | vs -> error_values "inverse_of_lsize" vs
      );
  }
let inverse_of_lsizenn : numerics =
  {
    name = "inverse_of_lsizenn";
    f = inverse_of_lsize.f;
  }
let inverse_of_sizenn : numerics =
  {
    name = "inverse_of_sizenn";
    f = inverse_of_lsize.f;
  }

let rec inverse_of_concat_helper = function
  | a :: b :: l ->
    [listV_of_list [a; b]] @ inverse_of_concat_helper l
  | [] -> []
  | vs -> error_values "inverse_of_concat_helper" vs

let inverse_of_concat : numerics =
  {
    name = "inverse_of_concat";
    f =
      (function
      | [ ListV _ as lv ] ->
        lv
        |> unwrap_listv_to_list
        |> inverse_of_concat_helper
        |> listV_of_list
      | vs -> error_values "inverse_of_concat" vs
      );
  }

let numerics_list : numerics list = [
  ibytes;
  inverse_of_ibytes;
  nbytes;
  vbytes;
  inverse_of_nbytes;
  inverse_of_vbytes;
  inverse_of_zbytes;
  inverse_of_cbytes;
  bytes;
  inverse_of_bytes;
  inverse_of_concat;
  signed;
  inverse_of_signed;
  sat;
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
  ibitselect;
  iabs;
  ineg;
  imin;
  imax;
  iadd_sat;
  isub_sat;
  iavgr;
  iq15mulr_sat;
  fadd;
  fsub;
  fmul;
  fdiv;
  fmin;
  fmax;
  fcopysign;
  fabs;
  fneg;
  fsqrt;
  fceil;
  ffloor;
  ftrunc;
  fnearest;
  feq;
  fne;
  flt;
  fgt;
  fle;
  fge;
  fpmin;
  fpmax;
  extend;
  wrap;
  trunc;
  trunc_sat;
  narrow;
  promote;
  demote;
  convert;
  reinterpret;
  lanes;
  inverse_of_lanes;
  inverse_of_isize;
  inverse_of_lsize;
  inverse_of_lsizenn;
  inverse_of_sizenn;
  inverse_of_ibits;
]

let rec strip_suffix name =
  let last = String.length name - 1 in
  if name <> "" && name.[last] = '_' then
    strip_suffix (String.sub name 0 last)
  else
    name

let call_numerics name args =
  let fname = strip_suffix name in
  match List.find_opt (fun numerics -> numerics.name = fname) numerics_list with
  | Some numerics -> numerics.f args
  | None -> raise (Exception.InvalidFunc ("Invalid numerics: " ^ name))

let mem name =
  let fname = strip_suffix name in
  List.exists (fun numerics -> numerics.name = fname) numerics_list
