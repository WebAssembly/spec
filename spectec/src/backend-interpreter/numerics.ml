open Reference_interpreter
open Construct
open Al
open Ast
open Al_util


(* Errors *)

let error fname msg = raise (Exception.ArgMismatch (fname ^ ": " ^ msg))

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

let catch_ixx_exception f = try f() |> someV with
  | Ixx.DivideByZero
  | Ixx.Overflow
  | Ixx.InvalidConversion -> noneV

let list_f f x = f x |> singleton
let unlist_f f x = f x |> listv_singleton


let profile name b : numerics =
  {
    name;
    f =
      (function
      | [] -> al_of_bool b
      | vs -> error_values name vs
      )
  }

let profile_nd = profile "ND" false


let relaxed name i : numerics =
  {
    name;
    f =
      (function
      | [] -> al_of_nat i
      | vs -> error_values name vs
      )
  }

let r_fmadd = relaxed "R_fmadd" 0
let r_fmin = relaxed "R_fmin" 0
let r_fmax = relaxed "R_fmax" 0
let r_idot = relaxed "R_idot" 0
let r_iq15mulr = relaxed "R_iq15mulr" 0
let r_trunc_u = relaxed "R_trunc_u" 0
let r_trunc_s = relaxed "R_trunc_s" 0
let r_swizzle = relaxed "R_swizzle" 0
let r_laneselect = relaxed "R_laneselect" 0


let signed : numerics =
  {
    name = "signed";
    f =
      (function
      | [ NumV (`Nat z); NumV (`Nat n) ] ->
        let z = Z.to_int z in
        (if Z.lt n (Z.shift_left Z.one (z - 1)) then n else Z.(sub n (shift_left one z))) |> al_of_z_int
      | vs -> error_values "signed" vs
      )
  }
let inverse_of_signed =
  {
    name = "inverse_of_signed";
    f =
      (function
      | [ NumV (`Nat z); NumV (`Int n) ] ->
        let z = Z.to_int z in
        (if Z.(geq n zero) then n else Z.(add n (shift_left one z))) |> al_of_z_nat
      | vs -> error_values "inverse_of_signed" vs
      )
  }

let sat : numerics =
  {
    name = "sat";
    f =
      (function
      | [ NumV (`Nat z); CaseV ("U", []); NumV (`Int i) ] ->
        if Z.(gt i (shift_left one (Z.to_int z) |> pred)) then
          NumV (`Nat Z.(shift_left one (Z.to_int z) |> pred))
        else if Z.(lt i zero) then
          NumV (`Nat Z.zero)
        else
          NumV (`Nat i)
      | [ NumV (`Nat z); CaseV ("S", []); NumV (`Int i) ] ->
        let n = Z.to_int z - 1 in
        let j =
          if Z.(lt i (shift_left one n |> neg)) then
            Z.(shift_left one n |> neg)
          else if Z.(gt i (shift_left one n |> pred)) then
            Z.(shift_left one n |> pred)
          else
            i
        in inverse_of_signed.f [ NumV (`Nat z); NumV (`Int j) ]
      | vs -> error_values "isat" vs
      );
  }

let iadd : numerics =
  {
    name = "iadd";
    f =
      (function
      | [ NumV (`Nat z); NumV (`Nat m); NumV (`Nat n) ] -> Z.(logand (add m n) (maskN z)) |> al_of_z_nat
      | vs -> error_values "iadd" vs
      );
  }
let isub : numerics =
  {
    name = "isub";
    f =
      (function
      | [ NumV (`Nat z); NumV (`Nat m); NumV (`Nat n) ] ->
        let z' = Z.to_int z in
        Z.(logand (sub (add Z.(shift_left one z') m) n) (maskN z)) |> al_of_z_nat
      | vs -> error_values "isub" vs
      );
  }
let imul : numerics =
  {
    name = "imul";
    f =
      (function
      | [ NumV (`Nat z); NumV (`Nat m); NumV (`Nat n) ] -> Z.(logand (mul m n) (maskN z)) |> al_of_z_nat
      | vs -> error_values "imul" vs
      );
  }
let idiv : numerics =
  {
    name = "idiv";
    f =
      (function
      | [ NumV _; CaseV ("U", []); NumV (`Nat m); NumV (`Nat n) ] ->
        if n = Z.zero then
          noneV
        else
          Z.(div m n) |> al_of_z_nat |> someV
      | [ NumV (`Nat z); CaseV ("S", []); NumV (`Nat m); NumV (`Nat n) ] ->
        if n = Z.zero then
          noneV
        else if m = Z.shift_left Z.one (Z.to_int z - 1) && n = maskN z then
          noneV
        else
          let z = NumV (`Nat z) in
          let m = signed.f [ z; NumV (`Nat m) ] |> al_to_z_int in
          let n = signed.f [ z; NumV (`Nat n) ] |> al_to_z_int in
          inverse_of_signed.f [ z; NumV (`Int Z.(div m n)) ] |> someV
      | vs -> error_values "idiv" vs
      );
  }
let irem : numerics =
  {
    name = "irem";
    f =
      (function
      | [ NumV _; CaseV ("U", []); NumV (`Nat m); NumV (`Nat n) ] ->
        if n = Z.zero then
          noneV
        else
          Z.(rem m n) |> al_of_z_nat |> someV
      | [ NumV _ as z; CaseV ("S", []); NumV (`Nat m); NumV (`Nat n) ] ->
        if n = Z.zero then
          noneV
        else
          let m = signed.f [ z; NumV (`Nat m) ] |> al_to_z_int in
          let n = signed.f [ z; NumV (`Nat n) ] |> al_to_z_int in
          inverse_of_signed.f [ z; NumV (`Int Z.(rem m n)) ] |> someV
      | vs -> error_values "irem" vs
      );
  }
let inot : numerics =
  {
    name = "inot";
    f =
      (function
      | [ NumV (`Nat z); NumV (`Nat m) ] -> Z.(logand (lognot m) (maskN z)) |> al_of_z_nat
      | vs -> error_values "inot" vs
      );
  }
let irev : numerics =
  {
    name = "irev";
    f =
      (function
      | [ NumV (`Nat z); NumV (`Nat m) ] ->
        let rec loop z m n =
          if z = Z.zero then
            n
          else
            let n' = Z.(logor (shift_left n 1) (logand m one)) in
            loop Z.(sub z one) (Z.shift_right m 1) n'
        in loop z m Z.zero |> al_of_z_nat
      | vs -> error_values "irev" vs
      );
  }
let iand : numerics =
  {
    name = "iand";
    f =
      (function
      | [ NumV (`Nat z); NumV (`Nat m); NumV (`Nat n) ] -> Z.(logand (logand m n) (maskN z)) |> al_of_z_nat
      | vs -> error_values "iand" vs
      );
  }
let iandnot : numerics =
  {
    name = "iandnot";
    f =
      (function
      | [ NumV (`Nat z); NumV (`Nat m); NumV (`Nat n) ] -> Z.(logand (logand m (lognot n)) (maskN z)) |> al_of_z_nat
      | vs -> error_values "iandnot" vs
      );
  }
let ior : numerics =
  {
    name = "ior";
    f =
      (function
      | [ NumV (`Nat z); NumV (`Nat m); NumV (`Nat n) ] -> Z.(logand (logor m n) (maskN z)) |> al_of_z_nat
      | vs -> error_values "ior" vs
      );
  }
let ixor : numerics =
  {
    name = "ixor";
    f =
      (function
      | [ NumV (`Nat z); NumV (`Nat m); NumV (`Nat n) ] -> Z.(logand (logxor m n) (maskN z)) |> al_of_z_nat
      | vs -> error_values "ixor" vs
      );
  }
let ishl : numerics =
  {
    name = "ishl";
    f =
      (function
      | [ NumV (`Nat z); NumV (`Nat m); NumV (`Nat n) ] -> Z.(logand (shift_left m (Z.to_int (rem n z))) (maskN z)) |> al_of_z_nat
      | vs -> error_values "ishl" vs
      );
  }
let ishr : numerics =
  {
    name = "ishr";
    f =
      (function
      | [ NumV (`Nat z); CaseV ("U", []); NumV (`Nat m); NumV (`Nat n) ] -> Z.(shift_right m (Z.to_int (rem n z))) |> al_of_z_nat
      | [ NumV (`Nat z); CaseV ("S", []); NumV (`Nat m); NumV (`Nat n) ] ->
          let n = Z.(to_int (rem n z)) in
          let s = Z.to_int z in
          let d = s - n in
          let msb = Z.shift_right m (s - 1) in
          let pad = Z.(mul (shift_left one s - shift_left one d) msb) in
          NumV (`Nat Z.(logor pad (shift_right m n)))
      | vs -> error_values "ishr" vs
      );
  }
let irotl : numerics =
  {
    name = "irotl";
    f =
      (function
      | [ NumV (`Nat z); NumV (`Nat m); NumV (`Nat n) ] ->
        let n = Z.to_int (Z.rem n z) in
        (Z.logor (Z.logand (Z.shift_left m n) (maskN z)) (Z.shift_right m ((Z.to_int z - n)))) |> al_of_z_nat
      | vs -> error_values "irotl" vs
      );
  }
let irotr : numerics =
  {
    name = "irotr";
    f =
      (function
      | [ NumV (`Nat z); NumV (`Nat m); NumV (`Nat n) ] ->
        let n = Z.to_int (Z.rem n z) in
        (Z.logor (Z.shift_right m n) (Z.logand (Z.shift_left m ((Z.to_int z - n))) (maskN z))) |> al_of_z_nat
      | vs -> error_values "irotr" vs
      );
  }
let iclz : numerics =
  {
    name = "iclz";
    f =
      (function
      | [ NumV (`Nat z); NumV (`Nat m) ] ->
        if m = Z.zero then
          z |> al_of_z_nat
        else
          let z = Z.to_int z in
          let rec loop acc n =
            if Z.equal (Z.logand n (Z.shift_left Z.one (z - 1))) Z.zero then
              loop (1 + acc) (Z.shift_left n 1)
            else
              acc
          in al_of_nat (loop 0 m)
      | vs -> error_values "iclz" vs
      );
  }
let ictz : numerics =
  {
    name = "ictz";
    f =
      (function
      | [ NumV (`Nat z); NumV (`Nat m) ] ->
        if m = Z.zero then
          z |> al_of_z_nat
        else
          let rec loop acc n =
            if Z.(equal (logand n one) zero) then
              loop (1 + acc) (Z.shift_right n 1)
            else
              acc
          in al_of_nat (loop 0 m)
      | vs -> error_values "ictz" vs
      );
  }
let ipopcnt : numerics =
  {
    name = "ipopcnt";
    f =
      (function
      | [ NumV (`Nat z); NumV (`Nat m) ] ->
        let rec loop acc i n =
          if i = 0 then
            acc
          else
            let acc' = if Z.(equal (logand n one) one) then acc + 1 else acc in
            loop acc' (i - 1) (Z.shift_right n 1)
        in al_of_nat (loop 0 (Z.to_int z) m)
      | vs -> error_values "ipopcnt" vs
      );
  }
let ieqz : numerics =
  {
    name = "ieqz";
    f =
      (function
      | [ NumV _; NumV (`Nat m) ] -> m = Z.zero |> al_of_bool
      | vs -> error_values "ieqz" vs
      );
  }
let inez : numerics =
  {
    name = "inez";
    f =
      (function
      | [ NumV _; NumV (`Nat m) ] -> m <> Z.zero |> al_of_bool
      | vs -> error_values "inez" vs
      );
  }
let ieq : numerics =
  {
    name = "ieq";
    f =
      (function
      | [ NumV _; NumV (`Nat m); NumV (`Nat n) ] -> Z.equal m n |> al_of_bool
      | vs -> error_values "ieq" vs
      );
  }
let ine : numerics =
  {
    name = "ine";
    f =
      (function
      | [ NumV _; NumV (`Nat m); NumV (`Nat n) ] -> Z.equal m n |> not |> al_of_bool
      | vs -> error_values "ine" vs
      );
  }
let ilt : numerics =
  {
    name = "ilt";
    f =
      (function
      | [ NumV _; CaseV ("U", []); NumV (`Nat m); NumV (`Nat n) ] -> m < n |> al_of_bool
      | [ NumV _ as z; CaseV ("S", []); NumV _ as m; NumV _ as n ] ->
        let m = signed.f [ z; m ] |> al_to_z_int in
        let n = signed.f [ z; n ] |> al_to_z_int in
        m < n |> al_of_bool
      | vs -> error_values "ilt" vs
      );
  }
let igt : numerics =
  {
    name = "igt";
    f =
      (function
      | [ NumV _; CaseV ("U", []); NumV (`Nat m); NumV (`Nat n) ] -> m > n |> al_of_bool
      | [ NumV _ as z; CaseV ("S", []); NumV _ as m; NumV _ as n ] ->
        let m = signed.f [ z; m ] |> al_to_z_int in
        let n = signed.f [ z; n ] |> al_to_z_int in
        m > n |> al_of_bool
      | vs -> error_values "igt" vs
      );
  }
let ile : numerics =
  {
    name = "ile";
    f =
      (function
      | [ NumV _; CaseV ("U", []); NumV (`Nat m); NumV (`Nat n) ] -> m <= n |> al_of_bool
      | [ NumV _ as z; CaseV ("S", []); NumV _ as m; NumV _ as n ] ->
        let m = signed.f [ z; m ] |> al_to_z_int in
        let n = signed.f [ z; n ] |> al_to_z_int in
        m <= n |> al_of_bool
      | vs -> error_values "ile" vs
      );
  }
let ige : numerics =
  {
    name = "ige";
    f =
      (function
      | [ NumV _; CaseV ("U", []); NumV (`Nat m); NumV (`Nat n) ] -> m >= n |> al_of_bool
      | [ NumV _ as z; CaseV ("S", []); NumV _ as m; NumV _ as n ] ->
        let m = signed.f [ z; m ] |> al_to_z_int in
        let n = signed.f [ z; n ] |> al_to_z_int in
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
let irelaxed_laneselect : numerics =
  {
    name = "irelaxed_laneselect";
    f = list_f
      (function
      | [ NumV _ as z; NumV _ as n1; NumV _ as n2; NumV _ as n3 ] ->
        ibitselect.f [ z; n1; n2; n3 ]  (* use deterministic behaviour *)
      | vs -> error_values "irelaxed_laneselect" vs
      );
  }
let iabs : numerics =
  {
    name = "iabs";
    f =
      (function
      | [ NumV _ as z; NumV _ as m ] -> signed.f [ z; m ] |> al_to_z_int |> Z.abs |> al_of_z_nat
      | vs -> error_values "iabs" vs
      );
  }
let ineg : numerics =
  {
    name = "ineg";
    f =
      (function
      | [ NumV (`Nat z); NumV (`Nat m) ] -> Z.(logand (shift_left one (to_int z) - m) (maskN z)) |> al_of_z_nat
      | vs -> error_values "ineg" vs
      );
  }
let imin : numerics =
  {
    name = "imin";
    f =
      (function
      | [ NumV _ as z; CaseV (_, []) as sx; NumV _ as m; NumV _ as n ] ->
        (if al_to_nat (ilt.f [ z; sx; m; n ]) = 1 then m else n)
      | vs -> error_values "imin" vs
      );
  }
let imax : numerics =
  {
    name = "imax";
    f =
      (function
      | [ NumV _ as z; CaseV (_, []) as sx; NumV _ as m; NumV _ as n ] ->
        (if al_to_nat (igt.f [ z; sx; m; n ]) = 1 then m else n)
      | vs -> error_values "imax" vs
      );
  }
let iadd_sat : numerics =
  {
    name = "iadd_sat";
    f =
      (function
      | [ NumV _ as z; CaseV ("U", []); NumV (`Nat m); NumV (`Nat n) ] ->
        sat.f [ z; nullary "U"; NumV (`Int Z.(add m n))]
      | [ NumV _ as z; CaseV ("S", []); NumV (`Nat m); NumV (`Nat n) ] ->
        let m = signed.f [ z; NumV (`Nat m) ] |> al_to_z_int in
        let n = signed.f [ z; NumV (`Nat n) ] |> al_to_z_int in
        sat.f [ z; nullary "S"; NumV (`Int Z.(add m n))]
      | vs -> error_values "iadd_sat" vs
      );
  }
let isub_sat : numerics =
  {
    name = "isub_sat";
    f =
      (function
      | [ NumV _ as z; CaseV ("U", []); NumV (`Nat m); NumV (`Nat n) ] ->
        sat.f [ z; nullary "U"; NumV (`Int Z.(sub m n))]
      | [ NumV _ as z; CaseV ("S", []); NumV (`Nat m); NumV (`Nat n) ] ->
        let m = signed.f [ z; NumV (`Nat m) ] |> al_to_z_int in
        let n = signed.f [ z; NumV (`Nat n) ] |> al_to_z_int in
        sat.f [ z; nullary "S"; NumV (`Int Z.(sub m n))]
      | vs -> error_values "isub_sat" vs
      );
  }
let iavgr : numerics =
  {
    name = "iavgr";
    f =
      (function
      | [ NumV _ ; CaseV ("U", []); NumV (`Nat m); NumV (`Nat n) ] -> Z.((m + n + one) / of_int 2) |> al_of_z_nat
      | [ NumV _ as z; CaseV ("S", []); NumV (`Nat m); NumV (`Nat n) ] ->
        let m = signed.f [ z; NumV (`Nat m) ] |> al_to_z_int in
        let n = signed.f [ z; NumV (`Nat n) ] |> al_to_z_int in
        Z.((m + n + one) / Z.of_int 2) |> al_of_z_nat
      | vs -> error_values "iavgr" vs
      );
  }
let iq15mulr_sat : numerics =
  {
    name = "iq15mulr_sat";
    f =
      (function
      | [ NumV _ as z; sx; NumV _ as m; NumV _ as n ] ->
        let m = signed.f [ z; m ] |> al_to_z_int in
        let n = signed.f [ z; n ] |> al_to_z_int in
        sat.f [ z; sx; NumV (`Int Z.(shift_right (mul m n + of_int 0x4000) 15)) ]
      | vs -> error_values "iq15mulr_sat" vs
      );
  }
let irelaxed_q15mulr : numerics =
  {
    name = "irelaxed_q15mulr";
    f = list_f
      (function
      | [ NumV _ as z; sx; NumV _ as m; NumV _ as n ] ->
        iq15mulr_sat.f [z; sx; m; n]  (* use deterministic behaviour *)
      | vs -> error_values "irelaxed_q15mulr" vs
      );
  }

let fadd : numerics =
  {
    name = "fadd";
    f = list_f
      (function
      | [ NumV (`Nat z); CaseV _ as f1; CaseV _ as f2; ] when z = Z.of_int 32 ->
        F32.add (al_to_float32 f1) (al_to_float32 f2) |> al_of_float32
      | [ NumV (`Nat z); CaseV _ as f1; CaseV _ as f2; ] when z = Z.of_int 64 ->
        F64.add (al_to_float64 f1) (al_to_float64 f2) |> al_of_float64
      | vs -> error_values "fadd" vs
      );
  }
let fsub : numerics =
  {
    name = "fsub";
    f = list_f
      (function
      | [ NumV (`Nat z); CaseV _ as f1; CaseV _ as f2; ] when z = Z.of_int 32 ->
        F32.sub (al_to_float32 f1) (al_to_float32 f2) |> al_of_float32
      | [ NumV (`Nat z); CaseV _ as f1; CaseV _ as f2; ] when z = Z.of_int 64 ->
        F64.sub (al_to_float64 f1) (al_to_float64 f2) |> al_of_float64
      | vs -> error_values "fsub" vs
      );
  }
let fmul : numerics =
  {
    name = "fmul";
    f = list_f
      (function
      | [ NumV (`Nat z); CaseV _ as f1; CaseV _ as f2; ] when z = Z.of_int 32 ->
        F32.mul (al_to_float32 f1) (al_to_float32 f2) |> al_of_float32
      | [ NumV (`Nat z); CaseV _ as f1; CaseV _ as f2; ] when z = Z.of_int 64 ->
        F64.mul (al_to_float64 f1) (al_to_float64 f2) |> al_of_float64
      | vs -> error_values "fmul" vs
      );
  }
let fdiv : numerics =
  {
    name = "fdiv";
    f = list_f
      (function
      | [ NumV (`Nat z); CaseV _ as f1; CaseV _ as f2; ] when z = Z.of_int 32 ->
        F32.div (al_to_float32 f1) (al_to_float32 f2) |> al_of_float32
      | [ NumV (`Nat z); CaseV _ as f1; CaseV _ as f2; ] when z = Z.of_int 64 ->
        F64.div (al_to_float64 f1) (al_to_float64 f2) |> al_of_float64
      | vs -> error_values "fdiv" vs
      );
  }
let fmin : numerics =
  {
    name = "fmin";
    f = list_f
      (function
      | [ NumV (`Nat z); CaseV _ as f1; CaseV _ as f2; ] when z = Z.of_int 32 ->
        F32.min (al_to_float32 f1) (al_to_float32 f2) |> al_of_float32
      | [ NumV (`Nat z); CaseV _ as f1; CaseV _ as f2; ] when z = Z.of_int 64 ->
        F64.min (al_to_float64 f1) (al_to_float64 f2) |> al_of_float64
      | vs -> error_values "fmin" vs
      );
  }
let fmax : numerics =
  {
    name = "fmax";
    f = list_f
      (function
      | [ NumV (`Nat z); CaseV _ as f1; CaseV _ as f2; ] when z = Z.of_int 32 ->
        F32.max (al_to_float32 f1) (al_to_float32 f2) |> al_of_float32
      | [ NumV (`Nat z); CaseV _ as f1; CaseV _ as f2; ] when z = Z.of_int 64 ->
        F64.max (al_to_float64 f1) (al_to_float64 f2) |> al_of_float64
      | vs -> error_values "fmax" vs
      );
  }
let fcopysign : numerics =
  {
    name = "fcopysign";
    f = list_f
      (function
      | [ NumV (`Nat z); CaseV _ as f1; CaseV _ as f2; ] when z = Z.of_int 32 ->
        F32.copysign (al_to_float32 f1) (al_to_float32 f2) |> al_of_float32
      | [ NumV (`Nat z); CaseV _ as f1; CaseV _ as f2; ] when z = Z.of_int 64 ->
        F64.copysign (al_to_float64 f1) (al_to_float64 f2) |> al_of_float64
      | vs -> error_values "fcopysign" vs
      );
  }
let fabs : numerics =
  {
    name = "fabs";
    f = list_f
      (function
      | [ NumV (`Nat z); CaseV _ as f ] when z = Z.of_int 32 ->
        F32.abs (al_to_float32 f) |> al_of_float32
      | [ NumV (`Nat z); CaseV _ as f ] when z = Z.of_int 64 ->
        F64.abs (al_to_float64 f) |> al_of_float64
      | vs -> error_values "fabs" vs
      );
  }
let fneg : numerics =
  {
    name = "fneg";
    f = list_f
      (function
      | [ NumV (`Nat z); CaseV _ as f ] when z = Z.of_int 32 ->
        F32.neg (al_to_float32 f) |> al_of_float32
      | [ NumV (`Nat z); CaseV _ as f ] when z = Z.of_int 64 ->
        F64.neg (al_to_float64 f) |> al_of_float64
      | vs -> error_values "fneg" vs
      );
  }
let fsqrt : numerics =
  {
    name = "fsqrt";
    f = list_f
      (function
      | [ NumV (`Nat z); CaseV _ as f ] when z = Z.of_int 32 ->
        F32.sqrt (al_to_float32 f) |> al_of_float32
      | [ NumV (`Nat z); CaseV _ as f ] when z = Z.of_int 64 ->
        F64.sqrt (al_to_float64 f) |> al_of_float64
      | vs -> error_values "fsqrt" vs
      );
  }
let fceil : numerics =
  {
    name = "fceil";
    f = list_f
      (function
      | [ NumV (`Nat z); CaseV _ as f ] when z = Z.of_int 32 ->
        F32.ceil (al_to_float32 f) |> al_of_float32
      | [ NumV (`Nat z); CaseV _ as f ] when z = Z.of_int 64 ->
        F64.ceil (al_to_float64 f) |> al_of_float64
      | vs -> error_values "fceil" vs
      );
  }
let ffloor : numerics =
  {
    name = "ffloor";
    f = list_f
      (function
      | [ NumV (`Nat z); CaseV _ as f ] when z = Z.of_int 32 ->
        F32.floor (al_to_float32 f) |> al_of_float32
      | [ NumV (`Nat z); CaseV _ as f ] when z = Z.of_int 64 ->
        F64.floor (al_to_float64 f) |> al_of_float64
      | vs -> error_values "ffloor" vs
      );
  }
let ftrunc : numerics =
  {
    name = "ftrunc";
    f = list_f
      (function
      | [ NumV (`Nat z); CaseV _ as f ] when z = Z.of_int 32 ->
        F32.trunc (al_to_float32 f) |> al_of_float32
      | [ NumV (`Nat z); CaseV _ as f ] when z = Z.of_int 64 ->
        F64.trunc (al_to_float64 f) |> al_of_float64
      | vs -> error_values "ftrunc" vs
      );
  }
let fnearest : numerics =
  {
    name = "fnearest";
    f = list_f
      (function
      | [ NumV (`Nat z); CaseV _ as f ] when z = Z.of_int 32 ->
        F32.nearest (al_to_float32 f) |> al_of_float32
      | [ NumV (`Nat z); CaseV _ as f ] when z = Z.of_int 64 ->
        F64.nearest (al_to_float64 f) |> al_of_float64
      | vs -> error_values "fnearest" vs
      );
  }
let feq : numerics =
  {
    name = "feq";
    f =
      (function
      | [ NumV (`Nat z); CaseV _ as f1; CaseV _ as f2; ] when z = Z.of_int 32 ->
        F32.eq (al_to_float32 f1) (al_to_float32 f2) |> al_of_bool
      | [ NumV (`Nat z); CaseV _ as f1; CaseV _ as f2; ] when z = Z.of_int 64 ->
        F64.eq (al_to_float64 f1) (al_to_float64 f2) |> al_of_bool
      | vs -> error_values "feq" vs
      );
  }
let fne : numerics =
  {
    name = "fne";
    f =
      (function
      | [ NumV (`Nat z); CaseV _ as f1; CaseV _ as f2; ] when z = Z.of_int 32 ->
        F32.ne (al_to_float32 f1) (al_to_float32 f2) |> al_of_bool
      | [ NumV (`Nat z); CaseV _ as f1; CaseV _ as f2; ] when z = Z.of_int 64 ->
        F64.ne (al_to_float64 f1) (al_to_float64 f2) |> al_of_bool
      | vs -> error_values "fne" vs
      );
  }
let flt : numerics =
  {
    name = "flt";
    f =
      (function
      | [ NumV (`Nat z); CaseV _ as f1; CaseV _ as f2; ] when z = Z.of_int 32 ->
        F32.lt (al_to_float32 f1) (al_to_float32 f2) |> al_of_bool
      | [ NumV (`Nat z); CaseV _ as f1; CaseV _ as f2; ] when z = Z.of_int 64 ->
        F64.lt (al_to_float64 f1) (al_to_float64 f2) |> al_of_bool
      | vs -> error_values "flt" vs
      );
  }
let fgt : numerics =
  {
    name = "fgt";
    f =
      (function
      | [ NumV (`Nat z); CaseV _ as f1; CaseV _ as f2; ] when z = Z.of_int 32 ->
        F32.gt (al_to_float32 f1) (al_to_float32 f2) |> al_of_bool
      | [ NumV (`Nat z); CaseV _ as f1; CaseV _ as f2; ] when z = Z.of_int 64 ->
        F64.gt (al_to_float64 f1) (al_to_float64 f2) |> al_of_bool
      | vs -> error_values "fgt" vs
      );
  }
let fle : numerics =
  {
    name = "fle";
    f =
      (function
      | [ NumV (`Nat z); CaseV _ as f1; CaseV _ as f2; ] when z = Z.of_int 32 ->
        F32.le (al_to_float32 f1) (al_to_float32 f2) |> al_of_bool
      | [ NumV (`Nat z); CaseV _ as f1; CaseV _ as f2; ] when z = Z.of_int 64 ->
        F64.le (al_to_float64 f1) (al_to_float64 f2) |> al_of_bool
      | vs -> error_values "fle" vs
      );
  }
let fge : numerics =
  {
    name = "fge";
    f =
      (function
      | [ NumV (`Nat z); CaseV _ as f1; CaseV _ as f2; ] when z = Z.of_int 32 ->
        F32.ge (al_to_float32 f1) (al_to_float32 f2) |> al_of_bool
      | [ NumV (`Nat z); CaseV _ as f1; CaseV _ as f2; ] when z = Z.of_int 64 ->
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
        if (flt.f [ z; f2; f1 ] |> al_to_nat = 1) then f2 else f1
      | vs -> error_values "fpmin" vs
      );
  }
let fpmax : numerics =
  {
    name = "fpmax";
    f = list_f
      (function
      | [ NumV _ as z; CaseV _ as f1; CaseV _ as f2; ] ->
        if (flt.f [ z; f1; f2 ] |> al_to_nat = 1) then f2 else f1
      | vs -> error_values "fpmax" vs
      );
  }
let frelaxed_min : numerics =
  {
    name = "frelaxed_min";
    f =
      (function
      | [ NumV _ as z; CaseV _ as f1; CaseV _ as f2; ] ->
        fmin.f [ z; f1; f2 ]  (* use deterministic behaviour *)
      | vs -> error_values "frelaxed_min" vs
      );
  }
let frelaxed_max : numerics =
  {
    name = "frelaxed_max";
    f =
      (function
      | [ NumV _ as z; CaseV _ as f1; CaseV _ as f2; ] ->
        fmax.f [ z; f1; f2 ]  (* use deterministic behaviour *)
      | vs -> error_values "frelaxed_max" vs
      );
  }

let frelaxed_madd : numerics =
  {
    name = "frelaxed_madd";
    f =
      (function
      | [ NumV _ as z; CaseV _ as f1; CaseV _ as f2; CaseV _ as f3 ] ->
        fadd.f [ z; unlist_f fmul.f [ z; f1; f2 ]; f3 ]  (* use deterministic behaviour *)
      | vs -> error_values "frelaxed_madd" vs
      );
  }
let frelaxed_nmadd : numerics =
  {
    name = "frelaxed_nmadd";
    f =
      (function
      | [ NumV _ as z; CaseV _ as f1; CaseV _ as f2; CaseV _ as f3 ] ->
        frelaxed_madd.f [ z; unlist_f fneg.f [ z; f1 ]; f2; f3 ]  (* use deterministic behaviour *)
      | vs -> error_values "frelaxed_nmadd" vs
      );
  }

let extend : numerics =
  {
    name = "extend";
    f =
      (function
      | [ NumV (`Nat z); _; CaseV ("U", []); NumV (`Nat v) ] when z = Z.of_int 128 -> V128.I64x2.of_lanes [ z_to_int64 v; 0L ] |> al_of_vec128 (* HARDCODE *)
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
      | [ NumV (`Nat m); NumV (`Nat n); CaseV ("U", []); CaseV _ as i ] when m = Z.of_int 32 && n = Z.of_int 32 ->
        (fun _ -> i |> al_to_float32 |> I32_convert.trunc_f32_u |> al_of_nat32) |> catch_ixx_exception
      | [ NumV (`Nat m); NumV (`Nat n); CaseV ("U", []); CaseV _ as i ] when m = Z.of_int 64 && n = Z.of_int 32 ->
        (fun _ -> i |> al_to_float64 |> I32_convert.trunc_f64_u |> al_of_nat32) |> catch_ixx_exception
      | [ NumV (`Nat m); NumV (`Nat n); CaseV ("U", []); CaseV _ as i ] when m = Z.of_int 32 && n = Z.of_int 64 ->
        (fun _ -> i |> al_to_float32 |> I64_convert.trunc_f32_u |> al_of_nat64) |> catch_ixx_exception
      | [ NumV (`Nat m); NumV (`Nat n); CaseV ("U", []); CaseV _ as i ] when m = Z.of_int 64 && n = Z.of_int 64 ->
        (fun _ -> i |> al_to_float64 |> I64_convert.trunc_f64_u |> al_of_nat64) |> catch_ixx_exception
      | [ NumV (`Nat m); NumV (`Nat n); CaseV ("S", []); CaseV _ as i ] when m = Z.of_int 32 && n = Z.of_int 32 ->
        (fun _ -> i |> al_to_float32 |> I32_convert.trunc_f32_s |> al_of_nat32) |> catch_ixx_exception
      | [ NumV (`Nat m); NumV (`Nat n); CaseV ("S", []); CaseV _ as i ] when m = Z.of_int 64 && n = Z.of_int 32 ->
        (fun _ -> i |> al_to_float64 |> I32_convert.trunc_f64_s |> al_of_nat32) |> catch_ixx_exception
      | [ NumV (`Nat m); NumV (`Nat n); CaseV ("S", []); CaseV _ as i ] when m = Z.of_int 32 && n = Z.of_int 64 ->
        (fun _ -> i |> al_to_float32 |> I64_convert.trunc_f32_s |> al_of_nat64) |> catch_ixx_exception
      | [ NumV (`Nat m); NumV (`Nat n); CaseV ("S", []); CaseV _ as i ] when m = Z.of_int 64 && n = Z.of_int 64 ->
        (fun _ -> i |> al_to_float64 |> I64_convert.trunc_f64_s |> al_of_nat64) |> catch_ixx_exception
      | vs -> error_values "trunc" vs
      );
  }

let trunc_sat : numerics =
  {
    name = "trunc_sat";
    f =
      (function
      | [ NumV (`Nat m); NumV (`Nat n); CaseV ("U", []); CaseV _ as i ] when m = Z.of_int 32 && n = Z.of_int 32 ->
        (fun _ -> i |> al_to_float32 |> I32_convert.trunc_sat_f32_u |> al_of_nat32) |> catch_ixx_exception
      | [ NumV (`Nat m); NumV (`Nat n); CaseV ("U", []); CaseV _ as i ] when m = Z.of_int 64 && n = Z.of_int 32 ->
        (fun _ -> i |> al_to_float64 |> I32_convert.trunc_sat_f64_u |> al_of_nat32) |> catch_ixx_exception
      | [ NumV (`Nat m); NumV (`Nat n); CaseV ("U", []); CaseV _ as i ] when m = Z.of_int 32 && n = Z.of_int 64 ->
        (fun _ -> i |> al_to_float32 |> I64_convert.trunc_sat_f32_u |> al_of_nat64) |> catch_ixx_exception
      | [ NumV (`Nat m); NumV (`Nat n); CaseV ("U", []); CaseV _ as i ] when m = Z.of_int 64 && n = Z.of_int 64 ->
        (fun _ -> i |> al_to_float64 |> I64_convert.trunc_sat_f64_u |> al_of_nat64) |> catch_ixx_exception
      | [ NumV (`Nat m); NumV (`Nat n); CaseV ("S", []); CaseV _ as i ] when m = Z.of_int 32 && n = Z.of_int 32 ->
        (fun _ -> i |> al_to_float32 |> I32_convert.trunc_sat_f32_s |> al_of_nat32) |> catch_ixx_exception
      | [ NumV (`Nat m); NumV (`Nat n); CaseV ("S", []); CaseV _ as i ] when m = Z.of_int 64 && n = Z.of_int 32 ->
        (fun _ -> i |> al_to_float64 |> I32_convert.trunc_sat_f64_s |> al_of_nat32) |> catch_ixx_exception
      | [ NumV (`Nat m); NumV (`Nat n); CaseV ("S", []); CaseV _ as i ] when m = Z.of_int 32 && n = Z.of_int 64 ->
        (fun _ -> i |> al_to_float32 |> I64_convert.trunc_sat_f32_s |> al_of_nat64) |> catch_ixx_exception
      | [ NumV (`Nat m); NumV (`Nat n); CaseV ("S", []); CaseV _ as i ] when m = Z.of_int 64 && n = Z.of_int 64 ->
        (fun _ -> i |> al_to_float64 |> I64_convert.trunc_sat_f64_s |> al_of_nat64) |> catch_ixx_exception
      | vs -> error_values "trunc_sat" vs
      );
  }

let relaxed_trunc : numerics =
  {
    name = "relaxed_trunc";
    f =
      (function
      | [ NumV _ as m; NumV _ as n; sx; CaseV _ as i ] ->
        trunc_sat.f [m; n; sx; i]  (* use deterministic behaviour *)
      | vs -> error_values "relaxed_trunc" vs
      );
  }

let promote : numerics =
  {
    name = "promote";
    f = list_f
      (function
      | [ NumV (`Nat m); NumV (`Nat n); CaseV _ as i ] when m = Z.of_int 32 && n = Z.of_int 64 ->
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
      | [ NumV (`Nat m); NumV (`Nat n); CaseV _ as i ] when m = Z.of_int 64 && n = Z.of_int 32 ->
        i |> al_to_float64 |> F32_convert.demote_f64 |> al_of_float32
      | vs -> error_values "demote" vs
      );
  }

let convert : numerics =
  {
    name = "convert";
    f =
      (function
      | [ NumV (`Nat m); NumV (`Nat n); CaseV ("U", []); NumV _ as i ] when m = Z.of_int 32 && n = Z.of_int 32 ->
        i |> al_to_nat32 |> F32_convert.convert_i32_u |> al_of_float32
      | [ NumV (`Nat m); NumV (`Nat n); CaseV ("U", []); NumV _ as i ] when m = Z.of_int 64 && n = Z.of_int 32 ->
        i |> al_to_nat64 |> F32_convert.convert_i64_u |> al_of_float32
      | [ NumV (`Nat m); NumV (`Nat n); CaseV ("U", []); NumV _ as i ] when m = Z.of_int 32 && n = Z.of_int 64 ->
        i |> al_to_nat32 |> F64_convert.convert_i32_u |> al_of_float64
      | [ NumV (`Nat m); NumV (`Nat n); CaseV ("U", []); NumV _ as i ] when m = Z.of_int 64 && n = Z.of_int 64 ->
        i |> al_to_nat64 |> F64_convert.convert_i64_u |> al_of_float64
      | [ NumV (`Nat m); NumV (`Nat n); CaseV ("S", []); NumV _ as i ] when m = Z.of_int 32 && n = Z.of_int 32 ->
        i |> al_to_nat32 |> F32_convert.convert_i32_s |> al_of_float32
      | [ NumV (`Nat m); NumV (`Nat n); CaseV ("S", []); NumV _ as i ] when m = Z.of_int 64 && n = Z.of_int 32 ->
        i |> al_to_nat64 |> F32_convert.convert_i64_s |> al_of_float32
      | [ NumV (`Nat m); NumV (`Nat n); CaseV ("S", []); NumV _ as i ] when m = Z.of_int 32 && n = Z.of_int 64 ->
        i |> al_to_nat32 |> F64_convert.convert_i32_s |> al_of_float64
      | [ NumV (`Nat m); NumV (`Nat n); CaseV ("S", []); NumV _ as i ] when m = Z.of_int 64 && n = Z.of_int 64 ->
        i |> al_to_nat64 |> F64_convert.convert_i64_s |> al_of_float64
      | vs -> error_values "convert" vs
      );
  }

let reinterpret : numerics =
  {
    name = "reinterpret";
    f =
      (function
      | [ CaseV ("I32", []); CaseV ("F32", []); NumV _ as i ] ->
        i |> al_to_nat32 |> F32_convert.reinterpret_i32 |> al_of_float32
      | [ CaseV ("I64", []); CaseV ("F64", []); NumV _ as i ] ->
        i |> al_to_nat64 |> F64_convert.reinterpret_i64 |> al_of_float64
      | [ CaseV ("F32", []); CaseV ("I32", []); CaseV _ as i ] ->
        i |> al_to_float32 |> I32_convert.reinterpret_f32 |> al_of_nat32
      | [ CaseV ("F64", []); CaseV ("I64", []); CaseV _ as i ] ->
        i |> al_to_float64 |> I64_convert.reinterpret_f64 |> al_of_nat64
      | vs -> error_values "reinterpret" vs
      );
  }


let ibytes : numerics =
  {
    name = "ibytes";
    (* TODO: Handle the case where n > 16 (i.e. for v128 ) *)
    f =
      (function
      | [ NumV (`Nat n); NumV (`Nat i) ] ->
          let rec decompose n bits =
            if n = Z.zero then
              []
            else
              Z.(bits land of_int 0xff) :: decompose Z.(n - of_int 8) Z.(shift_right bits 8)
            in
          assert Z.(n >= Z.zero && rem n (of_int 8) = zero);
          decompose n i |> List.map natV |> listV_of_list
      | vs -> error_values "ibytes" vs
      );
  }
let inverse_of_ibytes : numerics =
  {
    name = "inverse_of_ibytes";
    f =
      (function
      | [ NumV (`Nat n); ListV bs ] ->
          assert (
            (* numtype *)
            n = Z.of_int (Array.length !bs * 8) ||
            (* packtype *)
            (n = Z.of_int 32 && Array.length !bs <= 2)
          );
          NumV (`Nat (Array.fold_right (fun b acc ->
            match b with
            | NumV (`Nat b) when Z.zero <= b && b < Z.of_int 256 -> Z.add b (Z.shift_left acc 8)
            | _ -> error_typ_value "inverse_of_ibytes" "byte" b
          ) !bs Z.zero))
      | vs -> error_values "inverse_of_ibytes" vs
      );
  }

let nbytes : numerics =
  {
    name = "nbytes";
    f =
      (function
      | [ CaseV ("I32", []); n ] -> ibytes.f [ NumV thirtytwo; n ]
      | [ CaseV ("I64", []); n ] -> ibytes.f [ NumV sixtyfour; n ]
      | [ CaseV ("F32", []); f ] -> ibytes.f [ NumV thirtytwo; al_to_float32 f |> F32.to_bits |> al_of_nat32 ]
      | [ CaseV ("F64", []); f ] -> ibytes.f [ NumV sixtyfour; al_to_float64 f |> F64.to_bits |> al_of_nat64 ]
      | vs -> error_values "nbytes" vs
      );
  }
let inverse_of_nbytes : numerics =
  {
    name = "inverse_of_nbytes";
    f =
      (function
      | [ CaseV ("I32", []); l ] -> inverse_of_ibytes.f [ NumV thirtytwo; l ]
      | [ CaseV ("I64", []); l ] -> inverse_of_ibytes.f [ NumV sixtyfour; l ]
      | [ CaseV ("F32", []); l ] -> inverse_of_ibytes.f [ NumV thirtytwo; l ] |> al_to_nat32 |> F32.of_bits |> al_of_float32
      | [ CaseV ("F64", []); l ] -> inverse_of_ibytes.f [ NumV sixtyfour; l ] |> al_to_nat64 |> F64.of_bits |> al_of_float64
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
        Array.init 16 (fun i -> s.[i] |> Char.code |> al_of_nat) |> listV
      | vs -> error_values "vbytes" vs
      );
  }
let inverse_of_vbytes : numerics =
  {
    name = "inverse_of_vbytes";
    f =
      (function
      | [ CaseV ("V128", []); ListV l ] ->
        let v1 = inverse_of_ibytes.f [ NumV sixtyfour; Array.sub !l 0 8 |> listV ] in
        let v2 = inverse_of_ibytes.f [ NumV sixtyfour; Array.sub !l 8 8 |> listV ] in

        (match v1, v2 with
        | NumV (`Nat n1), NumV (`Nat n2) -> al_of_vec128 (V128.I64x2.of_lanes [ z_to_int64 n1; z_to_int64 n2 ])
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
      | [ CaseV ("I8", []); l ] -> inverse_of_ibytes.f [ NumV eight; l ]
      | [ CaseV ("I16", []); l ] -> inverse_of_ibytes.f [ NumV sixteen; l ]
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
        | [ NumV _m; NumV (`Nat n); NumV (`Nat i) ] -> natV (Z.logand i (maskN n))
        | vs -> error_values "wrap" vs
      );
  }


let inverse_of_ibits : numerics =
  {
    name = "inverse_of_ibits";
    f =
      (function
      | [ NumV (`Nat n); ListV vs ] as vs' ->
        if Z.of_int (Array.length !vs) <> n then error_values "inverse_of_ibits" vs';
        let na = Array.map (function | NumV (`Nat e) when e = Z.zero || e = Z.one -> e | v -> error_typ_value "inverse_of_ibits" "bit" v) !vs in
        natV (Array.fold_left (fun acc e -> Z.logor e (Z.shift_left acc 1)) Z.zero na)
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
      | [ CaseV ("X", [ CaseV ("I8", []); NumV (`Nat z) ]); v ] when z = Z.of_int 16 ->
        v |> al_to_vec128 |> V128.I8x16.to_lanes |> List.map al_of_nat8 |> listV_of_list
      | [ CaseV ("X", [ CaseV ("I16", []); NumV (`Nat z) ]); v ] when z = Z.of_int 8 ->
        v |> al_to_vec128 |> V128.I16x8.to_lanes |> List.map al_of_nat16 |> listV_of_list
      | [ CaseV ("X", [ CaseV ("I32", []); NumV (`Nat z) ]); v ] when z = Z.of_int 4 ->
        v |> al_to_vec128 |> V128.I32x4.to_lanes |> List.map al_of_nat32 |> listV_of_list
      | [ CaseV ("X", [ CaseV ("I64", []); NumV (`Nat z) ]); v ] when z = Z.of_int 2 ->
        v |> al_to_vec128 |> V128.I64x2.to_lanes |> List.map al_of_nat64 |> listV_of_list
      | [ CaseV ("X", [ CaseV ("F32", []); NumV (`Nat z) ]); v ] when z = Z.of_int 4 ->
        v |> al_to_vec128 |> V128.F32x4.to_lanes |> List.map al_of_float32 |> listV_of_list
      | [ CaseV ("X", [ CaseV ("F64", []); NumV (`Nat z) ]); v ] when z = Z.of_int 2 ->
        v |> al_to_vec128 |> V128.F64x2.to_lanes |> List.map al_of_float64 |> listV_of_list
      | vs -> error_values "lanes" vs
      );
  }
let inverse_of_lanes : numerics =
  {
    name = "inverse_of_lanes";
    f =
      (function
      | [ CaseV ("X",[ CaseV ("I8", []); NumV (`Nat z) ]); ListV lanes; ] when z = Z.of_int 16 && Array.length !lanes = 16 ->
        List.map al_to_nat32 (!lanes |> Array.to_list) |> List.map i8_to_i32 |> V128.I8x16.of_lanes |> al_of_vec128
      | [ CaseV ("X",[ CaseV ("I16", []); NumV (`Nat z) ]); ListV lanes; ] when z = Z.of_int 8 && Array.length !lanes = 8 ->
        List.map al_to_nat32 (!lanes |> Array.to_list) |> List.map i16_to_i32 |> V128.I16x8.of_lanes |> al_of_vec128
      | [ CaseV ("X",[ CaseV ("I32", []); NumV (`Nat z) ]); ListV lanes; ] when z = Z.of_int 4 && Array.length !lanes = 4 ->
        List.map al_to_nat32 (!lanes |> Array.to_list) |> V128.I32x4.of_lanes |> al_of_vec128
      | [ CaseV ("X",[ CaseV ("I64", []); NumV (`Nat z) ]); ListV lanes; ] when z = Z.of_int 2 && Array.length !lanes = 2 ->
        List.map al_to_nat64 (!lanes |> Array.to_list) |> V128.I64x2.of_lanes |> al_of_vec128
      | [ CaseV ("X",[ CaseV ("F32", []); NumV (`Nat z) ]); ListV lanes; ] when z = Z.of_int 4 && Array.length !lanes = 4 ->
        List.map al_to_float32 (!lanes |> Array.to_list) |> V128.F32x4.of_lanes |> al_of_vec128
      | [ CaseV ("X",[ CaseV ("F64", []); NumV (`Nat z) ]); ListV lanes; ] when z = Z.of_int 2 && Array.length !lanes = 2 ->
        List.map al_to_float64 (!lanes |> Array.to_list) |> V128.F64x2.of_lanes |> al_of_vec128
        | vs -> error_values "inverse_of_lanes" vs
      );
  }

let inverse_of_isize : numerics =
  {
    name = "inverse_of_isize";
    f =
      (function
      | [ NumV (`Nat z) ] when z = Z.of_int 32 -> CaseV ("I32", [])
      | [ NumV (`Nat z) ] when z = Z.of_int 64 -> CaseV ("I64", [])
      | vs -> error_values "inverse_of_isize" vs
      );
  }
let inverse_of_lsize : numerics =
  {
    name = "inverse_of_lsize";
    f =
      (function
      | [ NumV (`Nat z) ] when z = Z.of_int 8 -> CaseV ("I8", [])
      | [ NumV (`Nat z) ] when z = Z.of_int 16 -> CaseV ("I16", [])
      | [ NumV (`Nat z) ] when z = Z.of_int 32 -> CaseV ("I32", [])
      | [ NumV (`Nat z) ] when z = Z.of_int 64 -> CaseV ("I64", [])
      | vs -> error_values "inverse_of_lsize" vs
      );
  }
let inverse_of_size : numerics =
  {
    name = "inverse_of_size";
    f = inverse_of_lsize.f;
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

  let rec inverse_of_concatn_helper n prev = function
  | a :: l ->
    let next = prev @ [a] in
    if List.length next = n then
      [listV_of_list (prev @ [a])] @ inverse_of_concatn_helper n [] l
    else
      inverse_of_concatn_helper n next l
  | [] -> []

let inverse_of_concatn : numerics =
  {
    name = "inverse_of_concatn";
    f =
      (function
      | [ NumV (`Nat len); ListV _ as lv] ->
        let n = Z.to_int len in
        let l =
          lv
          |> unwrap_listv_to_list
        in
        assert (List.length l mod n = 0);
        l
        |> inverse_of_concatn_helper n []
        |> listV_of_list
      | vs -> error_values "inverse_of_concatn" vs
      );
  }

let numerics_list : numerics list = [
  profile_nd;
  r_fmadd;
  r_fmin;
  r_fmax;
  r_idot;
  r_iq15mulr;
  r_trunc_u;
  r_trunc_s;
  r_swizzle;
  r_laneselect;
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
  inverse_of_concatn;
  signed;
  inverse_of_signed;
  sat;
  iadd;
  isub;
  imul;
  idiv;
  irem;
  inot;
  irev;
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
  inez;
  ieq;
  ine;
  ilt;
  igt;
  ile;
  ige;
  ibitselect;
  irelaxed_laneselect;
  iabs;
  ineg;
  imin;
  imax;
  iadd_sat;
  isub_sat;
  iavgr;
  iq15mulr_sat;
  irelaxed_q15mulr;
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
  frelaxed_min;
  frelaxed_max;
  frelaxed_madd;
  frelaxed_nmadd;
  extend;
  wrap;
  trunc;
  trunc_sat;
  relaxed_trunc;
  narrow;
  promote;
  demote;
  convert;
  reinterpret;
  lanes;
  inverse_of_lanes;
  inverse_of_size;
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
  | None -> raise (Exception.UnknownFunc ("Unknown numerics: " ^ name))

let mem name =
  let fname = strip_suffix name in
  List.exists (fun numerics -> numerics.name = fname) numerics_list
