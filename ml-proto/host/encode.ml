(* Version *)

let version = 0x0cl


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

    let gap () = let p = pos s in u32 0l; u8 0; p
    let patch_gap p n =
      assert (n <= 0x0fff_ffff); (* Strings cannot excess 2G anyway *)
      let lsb i = Char.chr (i land 0xff) in
      patch s p (lsb (n lor 0x80));
      patch s (p + 1) (lsb ((n lsr 7) lor 0x80));
      patch s (p + 2) (lsb ((n lsr 14) lor 0x80));
      patch s (p + 3) (lsb ((n lsr 21) lor 0x80));
      patch s (p + 4) (lsb (n lsr 28))

    (* Types *)

    open Types

    let value_type = function
      | Int32Type -> u8 0x01
      | Int64Type -> u8 0x02
      | Float32Type -> u8 0x03
      | Float64Type -> u8 0x04

    let elem_type = function
      | AnyFuncType -> u8 0x20

    let expr_type t = vec1 value_type t

    let func_type = function
      | {ins; out} -> u8 0x40; vec value_type ins; expr_type out

    let limits vu {min; max} =
      bool (max <> None); vu min; opt vu max

    let table_type = function
      | TableType (lim, t) -> elem_type t; limits vu32 lim

    let memory_type = function
      | MemoryType lim -> limits vu32 lim

    let mutability = function
      | Immutable -> u8 0
      | Mutable -> u8 1

    let global_type = function
      | GlobalType (t, mut) -> value_type t; mutability mut

    (* Expressions *)

    open Source
    open Kernel
    open Ast

    let op n = u8 n
    let arity xs = vu (List.length xs)
    let arity1 xo = bool (xo <> None)

    let memop off align = vu align; vu64 off  (*TODO: to be resolved*)

    let var x = vu x.it
    let var32 x = vu32 (Int32.of_int x.it)

    let rec expr e =
      match e.it with
      | Nop -> op 0x00
      | Block es -> op 0x01; list expr es; op 0x0f
      | Loop es -> op 0x02; list expr es; op 0x0f
      | If (e, es1, es2) ->
        expr e; op 0x03; list expr es1;
        if es2 <> [] then op 0x04; list expr es2; op 0x0f
      | Select (e1, e2, e3) -> expr e1; expr e2; expr e3; op 0x05
      | Br (x, eo) -> opt expr eo; op 0x06; arity1 eo; var x
      | Br_if (x, eo, e) -> opt expr eo; expr e; op 0x07; arity1 eo; var x
      | Br_table (xs, x, eo, e) ->
        opt expr eo; expr e; op 0x08; arity1 eo; vec var32 xs; var32 x
      | Ast.Return eo -> nary1 eo 0x09
      | Ast.Unreachable -> op 0x0a
      | Ast.Drop e -> unary e 0x0b

      | Ast.I32_const c -> op 0x10; vs32 c.it
      | Ast.I64_const c -> op 0x11; vs64 c.it
      | Ast.F32_const c -> op 0x12; f32 c.it
      | Ast.F64_const c -> op 0x13; f64 c.it

      | Ast.Get_local x -> op 0x14; var x
      | Ast.Set_local (x, e) -> unary e 0x15; var x
      | Ast.Tee_local (x, e) -> unary e 0x19; var x
      | Ast.Get_global x -> op 0xbb; var x
      | Ast.Set_global (x, e) -> unary e 0xbc; var x

      | Ast.Call (x, es) -> nary es 0x16; var x
      | Ast.Call_indirect (x, e, es) -> expr e; nary es 0x17; var x

      | I32_load8_s (o, a, e) -> unary e 0x20; memop o a
      | I32_load8_u (o, a, e) -> unary e 0x21; memop o a
      | I32_load16_s (o, a, e) -> unary e 0x22; memop o a
      | I32_load16_u (o, a, e) -> unary e 0x23; memop o a
      | I64_load8_s (o, a, e) -> unary e 0x24; memop o a
      | I64_load8_u (o, a, e) -> unary e 0x25; memop o a
      | I64_load16_s (o, a, e) -> unary e 0x26; memop o a
      | I64_load16_u (o, a, e) -> unary e 0x27; memop o a
      | I64_load32_s (o, a, e) -> unary e 0x28; memop o a
      | I64_load32_u (o, a, e) -> unary e 0x29; memop o a
      | I32_load (o, a, e) -> unary e 0x2a; memop o a
      | I64_load (o, a, e) -> unary e 0x2b; memop o a
      | F32_load (o, a, e) -> unary e 0x2c; memop o a
      | F64_load (o, a, e) -> unary e 0x2d; memop o a

      | I32_store8 (o, a, e1, e2) -> binary e1 e2 0x2e; memop o a
      | I32_store16 (o, a, e1, e2) -> binary e1 e2 0x2f; memop o a
      | I64_store8 (o, a, e1, e2) -> binary e1 e2 0x30; memop o a
      | I64_store16 (o, a, e1, e2) -> binary e1 e2 0x31; memop o a
      | I64_store32 (o, a, e1, e2) -> binary e1 e2 0x32; memop o a
      | I32_store (o, a, e1, e2) -> binary e1 e2 0x33; memop o a
      | I64_store (o, a, e1, e2) -> binary e1 e2 0x34; memop o a
      | F32_store (o, a, e1, e2) -> binary e1 e2 0x35; memop o a
      | F64_store (o, a, e1, e2) -> binary e1 e2 0x36; memop o a

      | Grow_memory e -> unary e 0x39
      | Current_memory -> op 0x3b

      | I32_add (e1, e2) -> binary e1 e2 0x40
      | I32_sub (e1, e2) -> binary e1 e2 0x41
      | I32_mul (e1, e2) -> binary e1 e2 0x42
      | I32_div_s (e1, e2) -> binary e1 e2 0x43
      | I32_div_u (e1, e2) -> binary e1 e2 0x44
      | I32_rem_s (e1, e2) -> binary e1 e2 0x45
      | I32_rem_u (e1, e2) -> binary e1 e2 0x46
      | I32_and (e1, e2) -> binary e1 e2 0x47
      | I32_or (e1, e2) -> binary e1 e2 0x48
      | I32_xor (e1, e2) -> binary e1 e2 0x49
      | I32_shl (e1, e2) -> binary e1 e2 0x4a
      | I32_shr_u (e1, e2) -> binary e1 e2 0x4b
      | I32_shr_s (e1, e2) -> binary e1 e2 0x4c
      | I32_rotl (e1, e2) -> binary e1 e2 0xb6
      | I32_rotr (e1, e2) -> binary e1 e2 0xb7
      | I32_eq (e1, e2) -> binary e1 e2 0x4d
      | I32_ne (e1, e2) -> binary e1 e2 0x4e
      | I32_lt_s (e1, e2) -> binary e1 e2 0x4f
      | I32_le_s (e1, e2) -> binary e1 e2 0x50
      | I32_lt_u (e1, e2) -> binary e1 e2 0x51
      | I32_le_u (e1, e2) -> binary e1 e2 0x52
      | I32_gt_s (e1, e2) -> binary e1 e2 0x53
      | I32_ge_s (e1, e2) -> binary e1 e2 0x54
      | I32_gt_u (e1, e2) -> binary e1 e2 0x55
      | I32_ge_u (e1, e2) -> binary e1 e2 0x56
      | I32_clz e -> unary e 0x57
      | I32_ctz e -> unary e 0x58
      | I32_popcnt e -> unary e 0x59
      | I32_eqz e -> unary e 0x5a

      | I64_add (e1, e2) -> binary e1 e2 0x5b
      | I64_sub (e1, e2) -> binary e1 e2 0x5c
      | I64_mul (e1, e2) -> binary e1 e2 0x5d
      | I64_div_s (e1, e2) -> binary e1 e2 0x5e
      | I64_div_u (e1, e2) -> binary e1 e2 0x5f
      | I64_rem_s (e1, e2) -> binary e1 e2 0x60
      | I64_rem_u (e1, e2) -> binary e1 e2 0x61
      | I64_and (e1, e2) -> binary e1 e2 0x62
      | I64_or (e1, e2) -> binary e1 e2 0x63
      | I64_xor (e1, e2) -> binary e1 e2 0x64
      | I64_shl (e1, e2) -> binary e1 e2 0x65
      | I64_shr_u (e1, e2) -> binary e1 e2 0x66
      | I64_shr_s (e1, e2) -> binary e1 e2 0x67
      | I64_rotl (e1, e2) -> binary e1 e2 0xb8
      | I64_rotr (e1, e2) -> binary e1 e2 0xb9
      | I64_eq (e1, e2) -> binary e1 e2 0x68
      | I64_ne (e1, e2) -> binary e1 e2 0x69
      | I64_lt_s (e1, e2) -> binary e1 e2 0x6a
      | I64_le_s (e1, e2) -> binary e1 e2 0x6b
      | I64_lt_u (e1, e2) -> binary e1 e2 0x6c
      | I64_le_u (e1, e2) -> binary e1 e2 0x6d
      | I64_gt_s (e1, e2) -> binary e1 e2 0x6e
      | I64_ge_s (e1, e2) -> binary e1 e2 0x6f
      | I64_gt_u (e1, e2) -> binary e1 e2 0x70
      | I64_ge_u (e1, e2) -> binary e1 e2 0x71
      | I64_clz e -> unary e 0x72
      | I64_ctz e -> unary e 0x73
      | I64_popcnt e -> unary e 0x74
      | I64_eqz e -> unary e 0xba

      | F32_add (e1, e2) -> binary e1 e2 0x75
      | F32_sub (e1, e2) -> binary e1 e2 0x76
      | F32_mul (e1, e2) -> binary e1 e2 0x77
      | F32_div (e1, e2) -> binary e1 e2 0x78
      | F32_min (e1, e2) -> binary e1 e2 0x79
      | F32_max (e1, e2) -> binary e1 e2 0x7a
      | F32_abs e -> unary e 0x7b
      | F32_neg e -> unary e 0x7c
      | F32_copysign (e1, e2) -> binary e1 e2 0x7d
      | F32_ceil e -> unary e 0x7e
      | F32_floor e -> unary e 0x7f
      | F32_trunc e -> unary e 0x80
      | F32_nearest e -> unary e 0x81
      | F32_sqrt e -> unary e 0x82
      | F32_eq (e1, e2) -> binary e1 e2 0x83
      | F32_ne (e1, e2) -> binary e1 e2 0x84
      | F32_lt (e1, e2) -> binary e1 e2 0x85
      | F32_le (e1, e2) -> binary e1 e2 0x86
      | F32_gt (e1, e2) -> binary e1 e2 0x87
      | F32_ge (e1, e2) -> binary e1 e2 0x88

      | F64_add (e1, e2) -> binary e1 e2 0x89
      | F64_sub (e1, e2) -> binary e1 e2 0x8a
      | F64_mul (e1, e2) -> binary e1 e2 0x8b
      | F64_div (e1, e2) -> binary e1 e2 0x8c
      | F64_min (e1, e2) -> binary e1 e2 0x8d
      | F64_max (e1, e2) -> binary e1 e2 0x8e
      | F64_abs e -> unary e 0x8f
      | F64_neg e -> unary e 0x90
      | F64_copysign (e1, e2) -> binary e1 e2 0x91
      | F64_ceil e -> unary e 0x92
      | F64_floor e -> unary e 0x93
      | F64_trunc e -> unary e 0x94
      | F64_nearest e -> unary e 0x95
      | F64_sqrt e -> unary e 0x96
      | F64_eq (e1, e2) -> binary e1 e2 0x97
      | F64_ne (e1, e2) -> binary e1 e2 0x98
      | F64_lt (e1, e2) -> binary e1 e2 0x99
      | F64_le (e1, e2) -> binary e1 e2 0x9a
      | F64_gt (e1, e2) -> binary e1 e2 0x9b
      | F64_ge (e1, e2) -> binary e1 e2 0x9c

      | I32_trunc_s_f32 e -> unary e 0x9d
      | I32_trunc_s_f64 e -> unary e 0x9e
      | I32_trunc_u_f32 e -> unary e 0x9f
      | I32_trunc_u_f64 e -> unary e 0xa0
      | I32_wrap_i64 e -> unary e 0xa1
      | I64_trunc_s_f32 e -> unary e 0xa2
      | I64_trunc_s_f64 e -> unary e 0xa3
      | I64_trunc_u_f32 e -> unary e 0xa4
      | I64_trunc_u_f64 e -> unary e 0xa5
      | I64_extend_s_i32 e -> unary e 0xa6
      | I64_extend_u_i32 e -> unary e 0xa7
      | F32_convert_s_i32 e -> unary e 0xa8
      | F32_convert_u_i32 e -> unary e 0xa9
      | F32_convert_s_i64 e -> unary e 0xaa
      | F32_convert_u_i64 e -> unary e 0xab
      | F32_demote_f64 e -> unary e 0xac
      | F32_reinterpret_i32 e -> unary e 0xad
      | F64_convert_s_i32 e -> unary e 0xae
      | F64_convert_u_i32 e -> unary e 0xaf
      | F64_convert_s_i64 e -> unary e 0xb0
      | F64_convert_u_i64 e -> unary e 0xb1
      | F64_promote_f32 e -> unary e 0xb2
      | F64_reinterpret_i64 e -> unary e 0xb3
      | I32_reinterpret_f32 e -> unary e 0xb4
      | I64_reinterpret_f64 e -> unary e 0xb5

    and unary e o = expr e; op o
    and binary e1 e2 o = expr e1; expr e2; op o
    and nary es o = list expr es; op o; arity es
    and nary1 eo o = opt expr eo; op o; arity1 eo

    let const e = expr e; op 0x0f

    (* Sections *)

    let section id f x needed =
      if needed then begin
        string id;
        let g = gap () in
        let p = pos s in
        f x;
        patch_gap g (pos s - p)
      end

    (* Type section *)
    let type_section ts =
      section "type" (vec func_type) ts (ts <> [])

    (* Import section *)
    let import_kind k =
      match k.it with
      | FuncImport x -> u8 0x00; var x
      | TableImport t -> u8 0x01; table_type t
      | MemoryImport t -> u8 0x02; memory_type t
      | GlobalImport t -> u8 0x03; global_type t

    let import imp =
      let {module_name; item_name; ikind} = imp.it in
      string module_name; string item_name; import_kind ikind

    let import_section imps =
      section "import" (vec import) imps (imps <> [])

    (* Function section *)
    let func f = var f.it.ftype

    let func_section fs =
      section "function" (vec func) fs (fs <> [])

    (* Table section *)
    let table tab =
      let {ttype} = tab.it in
      table_type ttype

    let table_section tabs =
      section "table" (vec table) tabs (tabs <> [])

    (* Memory section *)
    let memory mem =
      let {mtype} = mem.it in
      memory_type mtype

    let memory_section mems =
      section "memory" (vec memory) mems (mems <> [])

    (* Global section *)
    let global g =
      let {gtype; value} = g.it in
      global_type gtype; expr value; op 0x0f

    let global_section gs =
      section "global" (vec global) gs (gs <> [])

    (* Export section *)
    let export_kind k =
      match k.it with
      | FuncExport -> u8 0
      | TableExport -> u8 1
      | MemoryExport -> u8 2
      | GlobalExport -> u8 3

    let export exp =
      let {name; ekind; item} = exp.it in
      string name; export_kind ekind; var item

    let export_section exps =
      section "export" (vec export) exps (exps <> [])

    (* Start section *)
    let start_section xo =
      section "start" (opt var) xo (xo <> None)

    (* Code section *)
    let compress ts =
      let combine t = function
        | (t', n) :: ts when t = t' -> (t, n + 1) :: ts
        | ts -> (t, 1) :: ts
      in List.fold_right combine ts []

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

    (* Element section *)
    let segment dat seg =
      let {index; offset; init} = seg.it in
      var index; const offset; dat init

    let table_segment seg =
      segment (vec var) seg

    let elem_section elems =
      section "element" (vec table_segment) elems (elems <> [])

    (* Data section *)
    let memory_segment seg =
      segment string seg

    let data_section data =
      section "data" (vec memory_segment) data (data <> [])

    (* Module *)

    let module_ m =
      u32 0x6d736100l;
      u32 version;
      type_section m.it.types;
      import_section m.it.imports;
      func_section m.it.funcs;
      table_section m.it.tables;
      memory_section m.it.memories;
      global_section m.it.globals;
      export_section m.it.exports;
      start_section m.it.start;
      code_section m.it.funcs;
      elem_section m.it.elems;
      data_section m.it.data
  end
  in E.module_ m; to_string s
