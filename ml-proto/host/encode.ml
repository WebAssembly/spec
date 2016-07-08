(* Version *)

let version = 0x0b


(* Encoding stream *)

type stream =
{
  buf : Buffer.t;
  patches : (int * char) list ref
}

let stream () = {buf = Buffer.create 8192; patches = ref []}
let pos s = Buffer.length s.buf
let put s b = Buffer.add_char s.buf b
let put_string s bs = Buffer.add_string s.buf bs
let patch s pos b = s.patches := (pos, b) :: !(s.patches)

let to_string s =
  let bs = Buffer.to_bytes s.buf in
  List.iter (fun (pos, b) -> Bytes.set bs pos b) !(s.patches);
  Bytes.to_string bs


(* Encoding *)

let encode m =
  let s = stream () in

  let module E = struct
    (* Generic values *)

    let u8 i = put s (Char.chr (i land 0xff))
    let u16 i = u8 (i land 0xff); u8 (i lsr 8)
    let u32 i =
      Int32.(u16 (to_int (logand i 0xffffl));
             u16 (to_int (shift_right i 16)))
    let u64 i =
      Int64.(u32 (to_int32 (logand i 0xffffffffL));
             u32 (to_int32 (shift_right i 32)))

    let rec vu64 i =
      let b = Int64.(to_int (logand i 0x7fL)) in
      if i < 128L then u8 b
      else (u8 (b lor 0x80); vu64 (Int64.shift_right i 7))

    let rec vs64 i =
      let b = Int64.(to_int (logand i 0x7fL)) in
      if -64L <= i && i < 64L then u8 b
      else (u8 (b lor 0x80); vs64 (Int64.shift_right i 7))

    let vu32 i = vu64 (Int64.of_int32 i)
    let vs32 i = vs64 (Int64.of_int32 i)
    let vu i = vu64 (Int64.of_int i)
    let f32 x = u32 (F32.to_bits x)
    let f64 x = u64 (F64.to_bits x)

    let bool b = u8 (if b then 1 else 0)
    let string bs = vu (String.length bs); put_string s bs
    let list f xs = List.iter f xs
    let opt f xo = Lib.Option.app f xo
    let vec f xs = vu (List.length xs); list f xs
    let vec1 f xo = bool (xo <> None); opt f xo

    let gap () = let p = pos s in u32 0l; p
    let patch_gap p n =
      assert (n <= 0x0fff_ffff); (* Strings cannot excess 2G anyway *)
      let lsb i = Char.chr (i land 0xff) in
      patch s p (lsb (n lor 0x80));
      patch s (p + 1) (lsb ((n lsr 7) lor 0x80));
      patch s (p + 2) (lsb ((n lsr 14) lor 0x80));
      patch s (p + 3) (lsb (n lsr 21))

    (* Types *)

    open Types

    let value_type = function
      | Int32Type -> u8 0x01
      | Int64Type -> u8 0x02
      | Float32Type -> u8 0x03
      | Float64Type -> u8 0x04

    let expr_type t = vec1 value_type t

    let func_type = function
      | FuncType (ins, out) -> u8 0x05; vec value_type ins; vec value_type out

    (* Expressions *)

    open Source
    open Kernel
    open Ast

    let op n = u8 n
    let memop off align = vu align; vu64 off  (*TODO: to be resolved*)

    let var x = vu x.it
    let var32 x = vu32 (Int32.of_int x.it)

    let rec expr e =
      match e.it with
      | Nop -> op 0x00
      | Block es -> op 0x01; list expr es; op 0x0f
      | Loop es -> op 0x02; list expr es; op 0x0f
      | If (es1, es2) ->
        op 0x03; list expr es1;
        if es2 <> [] then op 0x04;
        list expr es2; op 0x0f
      | Select -> op 0x05
      | Br (n, x) -> op 0x06; vu n; var x
      | Br_if (n, x) -> op 0x07; vu n; var x
      | Br_table (n, xs, x) -> op 0x08; vu n; vec var32 xs; var32 x
      | Ast.Return n -> op 0x09; vu n
      | Ast.Unreachable -> op 0x0a
      | Ast.Drop -> op 0x0b

      | Ast.I32_const c -> op 0x10; vs32 c.it
      | Ast.I64_const c -> op 0x11; vs64 c.it
      | Ast.F32_const c -> op 0x12; f32 c.it
      | Ast.F64_const c -> op 0x13; f64 c.it

      | Ast.Get_local x -> op 0x14; var x
      | Ast.Set_local x -> op 0x15; var x
      | Ast.Tee_local x -> op 0x19; var x

      | Ast.Call (n, x) -> op 0x16; vu n; var x
      | Ast.Call_indirect (n, x) -> op 0x17; vu n; var x
      | Ast.Call_import (n, x) -> op 0x18; vu n; var x

      | I32_load8_s (o, a) -> op 0x20; memop o a
      | I32_load8_u (o, a) -> op 0x21; memop o a
      | I32_load16_s (o, a) -> op 0x22; memop o a
      | I32_load16_u (o, a) -> op 0x23; memop o a
      | I64_load8_s (o, a) -> op 0x24; memop o a
      | I64_load8_u (o, a) -> op 0x25; memop o a
      | I64_load16_s (o, a) -> op 0x26; memop o a
      | I64_load16_u (o, a) -> op 0x27; memop o a
      | I64_load32_s (o, a) -> op 0x28; memop o a
      | I64_load32_u (o, a) -> op 0x29; memop o a
      | I32_load (o, a) -> op 0x2a; memop o a
      | I64_load (o, a) -> op 0x2b; memop o a
      | F32_load (o, a) -> op 0x2c; memop o a
      | F64_load (o, a) -> op 0x2d; memop o a

      | I32_store8 (o, a) -> op 0x2e; memop o a
      | I32_store16 (o, a) -> op 0x2f; memop o a
      | I64_store8 (o, a) -> op 0x30; memop o a
      | I64_store16 (o, a) -> op 0x31; memop o a
      | I64_store32 (o, a) -> op 0x32; memop o a
      | I32_store (o, a) -> op 0x33; memop o a
      | I64_store (o, a) -> op 0x34; memop o a
      | F32_store (o, a) -> op 0x35; memop o a
      | F64_store (o, a) -> op 0x36; memop o a

      | Grow_memory -> op 0x39
      | Current_memory -> op 0x3b

      | I32_add -> op 0x40
      | I32_sub -> op 0x41
      | I32_mul -> op 0x42
      | I32_div_s -> op 0x43
      | I32_div_u -> op 0x44
      | I32_rem_s -> op 0x45
      | I32_rem_u -> op 0x46
      | I32_and -> op 0x47
      | I32_or -> op 0x48
      | I32_xor -> op 0x49
      | I32_shl -> op 0x4a
      | I32_shr_u -> op 0x4b
      | I32_shr_s -> op 0x4c
      | I32_rotl -> op 0xb6
      | I32_rotr -> op 0xb7
      | I32_eq -> op 0x4d
      | I32_ne -> op 0x4e
      | I32_lt_s -> op 0x4f
      | I32_le_s -> op 0x50
      | I32_lt_u -> op 0x51
      | I32_le_u -> op 0x52
      | I32_gt_s -> op 0x53
      | I32_ge_s -> op 0x54
      | I32_gt_u -> op 0x55
      | I32_ge_u -> op 0x56
      | I32_clz -> op 0x57
      | I32_ctz -> op 0x58
      | I32_popcnt -> op 0x59
      | I32_eqz -> op 0x5a

      | I64_add -> op 0x5b
      | I64_sub -> op 0x5c
      | I64_mul -> op 0x5d
      | I64_div_s -> op 0x5e
      | I64_div_u -> op 0x5f
      | I64_rem_s -> op 0x60
      | I64_rem_u -> op 0x61
      | I64_and -> op 0x62
      | I64_or -> op 0x63
      | I64_xor -> op 0x64
      | I64_shl -> op 0x65
      | I64_shr_u -> op 0x66
      | I64_shr_s -> op 0x67
      | I64_rotl -> op 0xb8
      | I64_rotr -> op 0xb9
      | I64_eq -> op 0x68
      | I64_ne -> op 0x69
      | I64_lt_s -> op 0x6a
      | I64_le_s -> op 0x6b
      | I64_lt_u -> op 0x6c
      | I64_le_u -> op 0x6d
      | I64_gt_s -> op 0x6e
      | I64_ge_s -> op 0x6f
      | I64_gt_u -> op 0x70
      | I64_ge_u -> op 0x71
      | I64_clz -> op 0x72
      | I64_ctz -> op 0x73
      | I64_popcnt -> op 0x74
      | I64_eqz -> op 0xba

      | F32_add -> op 0x75
      | F32_sub -> op 0x76
      | F32_mul -> op 0x77
      | F32_div -> op 0x78
      | F32_min -> op 0x79
      | F32_max -> op 0x7a
      | F32_abs -> op 0x7b
      | F32_neg -> op 0x7c
      | F32_copysign -> op 0x7d
      | F32_ceil -> op 0x7e
      | F32_floor -> op 0x7f
      | F32_trunc -> op 0x80
      | F32_nearest -> op 0x81
      | F32_sqrt -> op 0x82
      | F32_eq -> op 0x83
      | F32_ne -> op 0x84
      | F32_lt -> op 0x85
      | F32_le -> op 0x86
      | F32_gt -> op 0x87
      | F32_ge -> op 0x88

      | F64_add -> op 0x89
      | F64_sub -> op 0x8a
      | F64_mul -> op 0x8b
      | F64_div -> op 0x8c
      | F64_min -> op 0x8d
      | F64_max -> op 0x8e
      | F64_abs -> op 0x8f
      | F64_neg -> op 0x90
      | F64_copysign -> op 0x91
      | F64_ceil -> op 0x92
      | F64_floor -> op 0x93
      | F64_trunc -> op 0x94
      | F64_nearest -> op 0x95
      | F64_sqrt -> op 0x96
      | F64_eq -> op 0x97
      | F64_ne -> op 0x98
      | F64_lt -> op 0x99
      | F64_le -> op 0x9a
      | F64_gt -> op 0x9b
      | F64_ge -> op 0x9c

      | I32_trunc_s_f32 -> op 0x9d
      | I32_trunc_s_f64 -> op 0x9e
      | I32_trunc_u_f32 -> op 0x9f
      | I32_trunc_u_f64 -> op 0xa0
      | I32_wrap_i64 -> op 0xa1
      | I64_trunc_s_f32 -> op 0xa2
      | I64_trunc_s_f64 -> op 0xa3
      | I64_trunc_u_f32 -> op 0xa4
      | I64_trunc_u_f64 -> op 0xa5
      | I64_extend_s_i32 -> op 0xa6
      | I64_extend_u_i32 -> op 0xa7
      | F32_convert_s_i32 -> op 0xa8
      | F32_convert_u_i32 -> op 0xa9
      | F32_convert_s_i64 -> op 0xaa
      | F32_convert_u_i64 -> op 0xab
      | F32_demote_f64 -> op 0xac
      | F32_reinterpret_i32 -> op 0xad
      | F64_convert_s_i32 -> op 0xae
      | F64_convert_u_i32 -> op 0xaf
      | F64_convert_s_i64 -> op 0xb0
      | F64_convert_u_i64 -> op 0xb1
      | F64_promote_f32 -> op 0xb2
      | F64_reinterpret_i64 -> op 0xb3
      | I32_reinterpret_f32 -> op 0xb4
      | I64_reinterpret_f64 -> op 0xb5

    (* Sections *)

    let section id f x needed =
      if needed then begin
        let g = gap () in
        let p = pos s in
        string id;
        f x;
        patch_gap g (pos s - p)
      end

    (* Type section *)
    let type_section ts =
      section "type" (vec func_type) ts (ts <> [])

    (* Import section *)
    let import imp =
      let {itype; module_name; func_name} = imp.it in
      var itype; string module_name; string func_name

    let import_section imps =
      section "import" (vec import) imps (imps <> [])

    (* Function section *)
    let func f = var f.it.ftype

    let func_section fs =
      section "function" (vec func) fs (fs <> [])

    (* Table section *)
    let table_section tab =
      section "table" (vec var) tab (tab <> [])

    (* Memory section *)
    let memory mem =
      let {min; max; _} = mem.it in
      vu64 min; vu64 max; bool true (*TODO: pending change*)

    let memory_section memo =
      section "memory" (opt memory) memo (memo <> None)

    (* Export section *)
    let export exp =
      let {Kernel.name; kind} = exp.it in
      (match kind with
      | `Func x -> var x
      | `Memory -> () (*TODO: pending resolution*)
      ); string name

    let export_section exps =
      (*TODO: pending resolution*)
      let exps = List.filter (fun exp -> exp.it.kind <> `Memory) exps in
      section "export" (vec export) exps (exps <> [])

    (* Start section *)
    let start_section xo =
      section "start" (opt var) xo (xo <> None)

    (* Code section *)
    let compress locals =
      let combine t = function
        | (t', n) :: ts when t = t' -> (t, n + 1) :: ts
        | ts -> (t, 1) :: ts
      in List.fold_right combine locals []

    let local (t, n) = vu n; value_type t

    let code f =
      let {locals; body; _} = f.it in
      vec local (compress locals);
      let g = gap () in
      let p = pos s in
      list expr body;
      patch_gap g (pos s - p)

    let code_section fs =
      section "code" (vec code) fs (fs <> [])

    (* Data section *)
    let segment seg =
      let {Memory.addr; data} = seg.it in
      vu64 addr; string data

    let data_section segs =
      section "data" (opt (vec segment))
        segs (segs <> None && segs <> Some [])

    (* Module *)

    let module_ m =
      u32 0x6d736100l;
      u32 (Int32.of_int version);
      type_section m.it.types;
      import_section m.it.imports;
      func_section m.it.funcs;
      table_section m.it.table;
      memory_section m.it.memory;
      export_section m.it.exports;
      start_section m.it.start;
      code_section m.it.funcs;
      data_section (Lib.Option.map (fun mem -> mem.it.segments) m.it.memory)
  end
  in E.module_ m; to_string s
