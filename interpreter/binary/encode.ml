(* Version *)

let version = 1l


(* Errors *)

module Code = Error.Make ()
exception Code = Code.Error


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
      if 0L <= i && i < 128L then u8 b
      else (u8 (b lor 0x80); vu64 (Int64.shift_right_logical i 7))

    let rec vs64 i =
      let b = Int64.(to_int (logand i 0x7fL)) in
      if -64L <= i && i < 64L then u8 b
      else (u8 (b lor 0x80); vs64 (Int64.shift_right i 7))

    let vu1 i = vu64 Int64.(logand (of_int i) 1L)
    let vu32 i = vu64 Int64.(logand (of_int32 i) 0xffffffffL)
    let vs7 i = vs64 (Int64.of_int i)
    let vs32 i = vs64 (Int64.of_int32 i)
    let vs33 i = vs64 (I64_convert.extend_i32_s i)
    let f32 x = u32 (F32.to_bits x)
    let f64 x = u64 (F64.to_bits x)
    let v128 v = String.iter (put s) (V128.to_bits v)

    let len i =
      if Int32.to_int (Int32.of_int i) <> i then
        Code.error Source.no_region
          "cannot encode length with more than 32 bit";
      vu32 (Int32.of_int i)

    let bool b = vu1 (if b then 1 else 0)
    let string bs = len (String.length bs); put_string s bs
    let name n = string (Utf8.encode n)
    let list f xs = List.iter f xs
    let opt f xo = Lib.Option.app f xo
    let vec f xs = len (List.length xs); list f xs

    let gap32 () = let p = pos s in u32 0l; u8 0; p
    let patch_gap32 p n =
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
      | I32Type -> vs7 (-0x01)
      | I64Type -> vs7 (-0x02)
      | F32Type -> vs7 (-0x03)
      | F64Type -> vs7 (-0x04)
      | V128Type -> vs7 (-0x05)

    let elem_type = function
      | FuncRefType -> vs7 (-0x10)

    let stack_type = vec value_type
    let func_type = function
      | FuncType (ins, out) -> vs7 (-0x20); stack_type ins; stack_type out

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
    open Ast
    open Values

    let op n = u8 n
    let simd_op n = op 0xfd; vu32 n
    let end_ () = op 0x0b

    let memop {align; offset; _} = vu32 (Int32.of_int align); vu32 offset

    let var x = vu32 x.it

    let block_type = function
      | VarBlockType x -> vs33 x.it
      | ValBlockType None -> vs7 (-0x40)
      | ValBlockType (Some t) -> value_type t

    let rec instr e =
      match e.it with
      | Unreachable -> op 0x00
      | Nop -> op 0x01

      | Block (bt, es) -> op 0x02; block_type bt; list instr es; end_ ()
      | Loop (bt, es) -> op 0x03; block_type bt; list instr es; end_ ()
      | If (bt, es1, es2) ->
        op 0x04; block_type bt; list instr es1;
        if es2 <> [] then op 0x05;
        list instr es2; end_ ()

      | Br x -> op 0x0c; var x
      | BrIf x -> op 0x0d; var x
      | BrTable (xs, x) -> op 0x0e; vec var xs; var x
      | Return -> op 0x0f
      | Call x -> op 0x10; var x
      | CallIndirect x -> op 0x11; var x; u8 0x00

      | Drop -> op 0x1a
      | Select -> op 0x1b

      | LocalGet x -> op 0x20; var x
      | LocalSet x -> op 0x21; var x
      | LocalTee x -> op 0x22; var x
      | GlobalGet x -> op 0x23; var x
      | GlobalSet x -> op 0x24; var x

      | Load ({ty = I32Type; sz = None; _} as mo) -> op 0x28; memop mo
      | Load ({ty = I64Type; sz = None; _} as mo) -> op 0x29; memop mo
      | Load ({ty = F32Type; sz = None; _} as mo) -> op 0x2a; memop mo
      | Load ({ty = F64Type; sz = None; _} as mo) -> op 0x2b; memop mo
      | Load ({ty = I32Type; sz = Some (Pack8, SX); _} as mo) ->
        op 0x2c; memop mo
      | Load ({ty = I32Type; sz = Some (Pack8, ZX); _} as mo) ->
        op 0x2d; memop mo
      | Load ({ty = I32Type; sz = Some (Pack16, SX); _} as mo) ->
        op 0x2e; memop mo
      | Load ({ty = I32Type; sz = Some (Pack16, ZX); _} as mo) ->
        op 0x2f; memop mo
      | Load {ty = I32Type; sz = Some (Pack32, _); _} ->
        assert false
      | Load ({ty = I64Type; sz = Some (Pack8, SX); _} as mo) ->
        op 0x30; memop mo
      | Load ({ty = I64Type; sz = Some (Pack8, ZX); _} as mo) ->
        op 0x31; memop mo
      | Load ({ty = I64Type; sz = Some (Pack16, SX); _} as mo) ->
        op 0x32; memop mo
      | Load ({ty = I64Type; sz = Some (Pack16, ZX); _} as mo) ->
        op 0x33; memop mo
      | Load ({ty = I64Type; sz = Some (Pack32, SX); _} as mo) ->
        op 0x34; memop mo
      | Load ({ty = I64Type; sz = Some (Pack32, ZX); _} as mo) ->
        op 0x35; memop mo
      | Load {ty = F32Type | F64Type; sz = Some _; _} ->
        assert false

      | SimdLoad ({ty = V128Type; sz = None; _} as mo) ->
        simd_op 0x00l; memop mo
      | SimdLoad ({ty = V128Type; sz = Some (Pack64, Pack8x8 SX); _} as mo) ->
        simd_op 0x01l; memop mo
      | SimdLoad ({ty = V128Type; sz = Some (Pack64, Pack8x8 ZX); _} as mo) ->
        simd_op 0x02l; memop mo
      | SimdLoad ({ty = V128Type; sz = Some (Pack64, Pack16x4 SX); _} as mo) ->
        simd_op 0x03l; memop mo
      | SimdLoad ({ty = V128Type; sz = Some (Pack64, Pack16x4 ZX); _} as mo) ->
        simd_op 0x04l; memop mo
      | SimdLoad ({ty = V128Type; sz = Some (Pack64, Pack32x2 SX); _} as mo) ->
        simd_op 0x05l; memop mo
      | SimdLoad ({ty = V128Type; sz = Some (Pack64, Pack32x2 ZX); _} as mo) ->
        simd_op 0x06l; memop mo
      | SimdLoad ({ty= V128Type; sz = Some (Pack8, PackSplat); _} as mo) ->
        simd_op 0x07l; memop mo
      | SimdLoad ({ty= V128Type; sz = Some (Pack16, PackSplat); _} as mo) ->
        simd_op 0x08l; memop mo
      | SimdLoad ({ty= V128Type; sz = Some (Pack32, PackSplat); _} as mo) ->
        simd_op 0x09l; memop mo
      | SimdLoad ({ty= V128Type; sz = Some (Pack64, PackSplat); _} as mo) ->
        simd_op 0x0al; memop mo
      | SimdLoad ({ty= V128Type; sz = Some (Pack32, PackZero); _} as mo) ->
        simd_op 0xfcl; memop mo
      | SimdLoad ({ty= V128Type; sz = Some (Pack64, PackZero); _} as mo) ->
        simd_op 0xfdl; memop mo

      | Store ({ty = I32Type; sz = None; _} as mo) -> op 0x36; memop mo
      | Store ({ty = I64Type; sz = None; _} as mo) -> op 0x37; memop mo
      | Store ({ty = F32Type; sz = None; _} as mo) -> op 0x38; memop mo
      | Store ({ty = F64Type; sz = None; _} as mo) -> op 0x39; memop mo
      | Store ({ty = I32Type; sz = Some Pack8; _} as mo) -> op 0x3a; memop mo
      | Store ({ty = I32Type; sz = Some Pack16; _} as mo) -> op 0x3b; memop mo
      | Store {ty = I32Type; sz = Some Pack32; _} -> assert false
      | Store ({ty = I64Type; sz = Some Pack8; _} as mo) -> op 0x3c; memop mo
      | Store ({ty = I64Type; sz = Some Pack16; _} as mo) -> op 0x3d; memop mo
      | Store ({ty = I64Type; sz = Some Pack32; _} as mo) -> op 0x3e; memop mo
      | Store {ty = F32Type | F64Type; sz = Some _; _} -> assert false

      | SimdStore ({ty = V128Type; _} as mo) -> simd_op 0x0bl; memop mo

      | MemorySize -> op 0x3f; u8 0x00
      | MemoryGrow -> op 0x40; u8 0x00

      | Const {it = I32 c; _} -> op 0x41; vs32 c
      | Const {it = I64 c; _} -> op 0x42; vs64 c
      | Const {it = F32 c; _} -> op 0x43; f32 c
      | Const {it = F64 c; _} -> op 0x44; f64 c
      | Const {it = V128 c; _} -> simd_op 0x0cl; v128 c

      | Test (I32 I32Op.Eqz) -> op 0x45
      | Test (I64 I64Op.Eqz) -> op 0x50
      | Test (F32 _) -> assert false
      | Test (F64 _) -> assert false
      | Test (V128 V128Op.(I8x16 AnyTrue)) -> simd_op 0x62l
      | Test (V128 V128Op.(I8x16 AllTrue)) -> simd_op 0x63l
      | Test (V128 V128Op.(I16x8 AnyTrue)) -> simd_op 0x82l
      | Test (V128 V128Op.(I16x8 AllTrue)) -> simd_op 0x83l
      | Test (V128 V128Op.(I32x4 AnyTrue)) -> simd_op 0xa2l
      | Test (V128 V128Op.(I32x4 AllTrue)) -> simd_op 0xa3l
      | Test (V128 _) -> assert false

      | Compare (I32 I32Op.Eq) -> op 0x46
      | Compare (I32 I32Op.Ne) -> op 0x47
      | Compare (I32 I32Op.LtS) -> op 0x48
      | Compare (I32 I32Op.LtU) -> op 0x49
      | Compare (I32 I32Op.GtS) -> op 0x4a
      | Compare (I32 I32Op.GtU) -> op 0x4b
      | Compare (I32 I32Op.LeS) -> op 0x4c
      | Compare (I32 I32Op.LeU) -> op 0x4d
      | Compare (I32 I32Op.GeS) -> op 0x4e
      | Compare (I32 I32Op.GeU) -> op 0x4f

      | Compare (I64 I64Op.Eq) -> op 0x51
      | Compare (I64 I64Op.Ne) -> op 0x52
      | Compare (I64 I64Op.LtS) -> op 0x53
      | Compare (I64 I64Op.LtU) -> op 0x54
      | Compare (I64 I64Op.GtS) -> op 0x55
      | Compare (I64 I64Op.GtU) -> op 0x56
      | Compare (I64 I64Op.LeS) -> op 0x57
      | Compare (I64 I64Op.LeU) -> op 0x58
      | Compare (I64 I64Op.GeS) -> op 0x59
      | Compare (I64 I64Op.GeU) -> op 0x5a

      | Compare (F32 F32Op.Eq) -> op 0x5b
      | Compare (F32 F32Op.Ne) -> op 0x5c
      | Compare (F32 F32Op.Lt) -> op 0x5d
      | Compare (F32 F32Op.Gt) -> op 0x5e
      | Compare (F32 F32Op.Le) -> op 0x5f
      | Compare (F32 F32Op.Ge) -> op 0x60

      | Compare (F64 F64Op.Eq) -> op 0x61
      | Compare (F64 F64Op.Ne) -> op 0x62
      | Compare (F64 F64Op.Lt) -> op 0x63
      | Compare (F64 F64Op.Gt) -> op 0x64
      | Compare (F64 F64Op.Le) -> op 0x65
      | Compare (F64 F64Op.Ge) -> op 0x66
      | Compare (V128 _) -> assert false

      | Unary (I32 I32Op.Clz) -> op 0x67
      | Unary (I32 I32Op.Ctz) -> op 0x68
      | Unary (I32 I32Op.Popcnt) -> op 0x69
      | Unary (I32 (I32Op.ExtendS Pack8)) -> op 0xc0
      | Unary (I32 (I32Op.ExtendS Pack16)) -> op 0xc1
      | Unary (I32 (I32Op.ExtendS Pack32)) -> assert false

      | Unary (I64 I64Op.Clz) -> op 0x79
      | Unary (I64 I64Op.Ctz) -> op 0x7a
      | Unary (I64 I64Op.Popcnt) -> op 0x7b
      | Unary (I64 (I64Op.ExtendS Pack8)) -> op 0xc2
      | Unary (I64 (I64Op.ExtendS Pack16)) -> op 0xc3
      | Unary (I64 (I64Op.ExtendS Pack32)) -> op 0xc4

      | Unary (F32 F32Op.Abs) -> op 0x8b
      | Unary (F32 F32Op.Neg) -> op 0x8c
      | Unary (F32 F32Op.Ceil) -> op 0x8d
      | Unary (F32 F32Op.Floor) -> op 0x8e
      | Unary (F32 F32Op.Trunc) -> op 0x8f
      | Unary (F32 F32Op.Nearest) -> op 0x90
      | Unary (F32 F32Op.Sqrt) -> op 0x91

      | Unary (F64 F64Op.Abs) -> op 0x99
      | Unary (F64 F64Op.Neg) -> op 0x9a
      | Unary (F64 F64Op.Ceil) -> op 0x9b
      | Unary (F64 F64Op.Floor) -> op 0x9c
      | Unary (F64 F64Op.Trunc) -> op 0x9d
      | Unary (F64 F64Op.Nearest) -> op 0x9e
      | Unary (F64 F64Op.Sqrt) -> op 0x9f

      | Unary (V128 V128Op.(V128 Not)) -> simd_op 0x4dl
      | Unary (V128 V128Op.(I8x16 Abs)) -> simd_op 0x60l
      | Unary (V128 V128Op.(I8x16 Neg)) -> simd_op 0x61l
      | Unary (V128 V128Op.(I16x8 Abs)) -> simd_op 0x80l
      | Unary (V128 V128Op.(I16x8 Neg)) -> simd_op 0x81l
      | Unary (V128 V128Op.(I16x8 WidenLowS)) -> simd_op 0x87l
      | Unary (V128 V128Op.(I16x8 WidenHighS)) -> simd_op 0x88l
      | Unary (V128 V128Op.(I16x8 WidenLowU)) -> simd_op 0x89l
      | Unary (V128 V128Op.(I16x8 WidenHighU)) -> simd_op 0x8al
      | Unary (V128 V128Op.(I32x4 Abs)) -> simd_op 0xa0l
      | Unary (V128 V128Op.(I32x4 Neg)) -> simd_op 0xa1l
      | Unary (V128 V128Op.(I32x4 WidenLowS)) -> simd_op 0xa7l
      | Unary (V128 V128Op.(I32x4 WidenHighS)) -> simd_op 0xa8l
      | Unary (V128 V128Op.(I32x4 WidenLowU)) -> simd_op 0xa9l
      | Unary (V128 V128Op.(I32x4 WidenHighU)) -> simd_op 0xaal
      | Unary (V128 V128Op.(I64x2 Neg)) -> simd_op 0xc1l
      | Unary (V128 V128Op.(F32x4 Ceil)) -> simd_op 0xd8l
      | Unary (V128 V128Op.(F32x4 Floor)) -> simd_op 0xd9l
      | Unary (V128 V128Op.(F32x4 Trunc)) -> simd_op 0xdal
      | Unary (V128 V128Op.(F32x4 Nearest)) -> simd_op 0xdbl
      | Unary (V128 V128Op.(F64x2 Ceil)) -> simd_op 0xdcl
      | Unary (V128 V128Op.(F64x2 Floor)) -> simd_op 0xddl
      | Unary (V128 V128Op.(F64x2 Trunc)) -> simd_op 0xdel
      | Unary (V128 V128Op.(F64x2 Nearest)) -> simd_op 0xdfl
      | Unary (V128 V128Op.(F32x4 Abs)) -> simd_op 0xe0l
      | Unary (V128 V128Op.(F32x4 Neg)) -> simd_op 0xe1l
      | Unary (V128 V128Op.(F32x4 Sqrt)) -> simd_op 0xe3l
      | Unary (V128 V128Op.(F64x2 Abs)) -> simd_op 0xecl
      | Unary (V128 V128Op.(F64x2 Neg)) -> simd_op 0xedl
      | Unary (V128 V128Op.(F64x2 Sqrt)) -> simd_op 0xefl
      | Unary (V128 V128Op.(I32x4 TruncSatF32x4S)) -> simd_op 0xf8l
      | Unary (V128 V128Op.(I32x4 TruncSatF32x4U)) -> simd_op 0xf9l
      | Unary (V128 V128Op.(F32x4 ConvertI32x4S)) -> simd_op 0xfal
      | Unary (V128 V128Op.(F32x4 ConvertI32x4U)) -> simd_op 0xfbl
      | Unary (V128 _) -> failwith "unimplemented V128 Unary op"

      | Binary (I32 I32Op.Add) -> op 0x6a
      | Binary (I32 I32Op.Sub) -> op 0x6b
      | Binary (I32 I32Op.Mul) -> op 0x6c
      | Binary (I32 I32Op.DivS) -> op 0x6d
      | Binary (I32 I32Op.DivU) -> op 0x6e
      | Binary (I32 I32Op.RemS) -> op 0x6f
      | Binary (I32 I32Op.RemU) -> op 0x70
      | Binary (I32 I32Op.And) -> op 0x71
      | Binary (I32 I32Op.Or) -> op 0x72
      | Binary (I32 I32Op.Xor) -> op 0x73
      | Binary (I32 I32Op.Shl) -> op 0x74
      | Binary (I32 I32Op.ShrS) -> op 0x75
      | Binary (I32 I32Op.ShrU) -> op 0x76
      | Binary (I32 I32Op.Rotl) -> op 0x77
      | Binary (I32 I32Op.Rotr) -> op 0x78

      | Binary (I64 I64Op.Add) -> op 0x7c
      | Binary (I64 I64Op.Sub) -> op 0x7d
      | Binary (I64 I64Op.Mul) -> op 0x7e
      | Binary (I64 I64Op.DivS) -> op 0x7f
      | Binary (I64 I64Op.DivU) -> op 0x80
      | Binary (I64 I64Op.RemS) -> op 0x81
      | Binary (I64 I64Op.RemU) -> op 0x82
      | Binary (I64 I64Op.And) -> op 0x83
      | Binary (I64 I64Op.Or) -> op 0x84
      | Binary (I64 I64Op.Xor) -> op 0x85
      | Binary (I64 I64Op.Shl) -> op 0x86
      | Binary (I64 I64Op.ShrS) -> op 0x87
      | Binary (I64 I64Op.ShrU) -> op 0x88
      | Binary (I64 I64Op.Rotl) -> op 0x89
      | Binary (I64 I64Op.Rotr) -> op 0x8a

      | Binary (F32 F32Op.Add) -> op 0x92
      | Binary (F32 F32Op.Sub) -> op 0x93
      | Binary (F32 F32Op.Mul) -> op 0x94
      | Binary (F32 F32Op.Div) -> op 0x95
      | Binary (F32 F32Op.Min) -> op 0x96
      | Binary (F32 F32Op.Max) -> op 0x97
      | Binary (F32 F32Op.CopySign) -> op 0x98

      | Binary (F64 F64Op.Add) -> op 0xa0
      | Binary (F64 F64Op.Sub) -> op 0xa1
      | Binary (F64 F64Op.Mul) -> op 0xa2
      | Binary (F64 F64Op.Div) -> op 0xa3
      | Binary (F64 F64Op.Min) -> op 0xa4
      | Binary (F64 F64Op.Max) -> op 0xa5
      | Binary (F64 F64Op.CopySign) -> op 0xa6

      | Binary (V128 V128Op.(I8x16 (Shuffle imms))) -> simd_op 0x0dl; List.iter u8 imms
      | Binary (V128 V128Op.(I8x16 Swizzle)) -> simd_op 0x0el
      | Binary (V128 V128Op.(I8x16 Eq)) -> simd_op 0x23l
      | Binary (V128 V128Op.(I8x16 Ne)) -> simd_op 0x24l
      | Binary (V128 V128Op.(I8x16 LtS)) -> simd_op 0x25l
      | Binary (V128 V128Op.(I8x16 LtU)) -> simd_op 0x26l
      | Binary (V128 V128Op.(I8x16 GtS)) -> simd_op 0x27l
      | Binary (V128 V128Op.(I8x16 GtU)) -> simd_op 0x28l
      | Binary (V128 V128Op.(I8x16 LeS)) -> simd_op 0x29l
      | Binary (V128 V128Op.(I8x16 LeU)) -> simd_op 0x2al
      | Binary (V128 V128Op.(I8x16 GeS)) -> simd_op 0x2bl
      | Binary (V128 V128Op.(I8x16 GeU)) -> simd_op 0x2cl
      | Binary (V128 V128Op.(I8x16 NarrowS)) -> simd_op 0x65l
      | Binary (V128 V128Op.(I8x16 NarrowU)) -> simd_op 0x66l
      | Binary (V128 V128Op.(I8x16 Add)) -> simd_op 0x6el
      | Binary (V128 V128Op.(I8x16 AddSatS)) -> simd_op 0x6fl
      | Binary (V128 V128Op.(I8x16 AddSatU)) -> simd_op 0x70l
      | Binary (V128 V128Op.(I8x16 Sub)) -> simd_op 0x71l
      | Binary (V128 V128Op.(I8x16 SubSatS)) -> simd_op 0x72l
      | Binary (V128 V128Op.(I8x16 SubSatU)) -> simd_op 0x73l
      | Binary (V128 V128Op.(I8x16 MinS)) -> simd_op 0x76l
      | Binary (V128 V128Op.(I8x16 MinU)) -> simd_op 0x77l
      | Binary (V128 V128Op.(I8x16 MaxS)) -> simd_op 0x78l
      | Binary (V128 V128Op.(I8x16 MaxU)) -> simd_op 0x79l
      | Binary (V128 V128Op.(I8x16 AvgrU)) -> simd_op 0x7bl
      | Binary (V128 V128Op.(I16x8 Eq)) -> simd_op 0x2dl
      | Binary (V128 V128Op.(I16x8 Ne)) -> simd_op 0x2el
      | Binary (V128 V128Op.(I16x8 LtS)) -> simd_op 0x2fl
      | Binary (V128 V128Op.(I16x8 LtU)) -> simd_op 0x30l
      | Binary (V128 V128Op.(I16x8 GtS)) -> simd_op 0x31l
      | Binary (V128 V128Op.(I16x8 GtU)) -> simd_op 0x32l
      | Binary (V128 V128Op.(I16x8 LeS)) -> simd_op 0x33l
      | Binary (V128 V128Op.(I16x8 LeU)) -> simd_op 0x34l
      | Binary (V128 V128Op.(I16x8 GeS)) -> simd_op 0x35l
      | Binary (V128 V128Op.(I16x8 GeU)) -> simd_op 0x36l
      | Binary (V128 V128Op.(I16x8 NarrowS)) -> simd_op 0x85l
      | Binary (V128 V128Op.(I16x8 NarrowU)) -> simd_op 0x86l
      | Binary (V128 V128Op.(I16x8 Add)) -> simd_op 0x8el
      | Binary (V128 V128Op.(I16x8 AddSatS)) -> simd_op 0x8fl
      | Binary (V128 V128Op.(I16x8 AddSatU)) -> simd_op 0x90l
      | Binary (V128 V128Op.(I16x8 Sub)) -> simd_op 0x91l
      | Binary (V128 V128Op.(I16x8 SubSatS)) -> simd_op 0x92l
      | Binary (V128 V128Op.(I16x8 SubSatU)) -> simd_op 0x93l
      | Binary (V128 V128Op.(I16x8 Mul)) -> simd_op 0x95l
      | Binary (V128 V128Op.(I16x8 MinS)) -> simd_op 0x96l
      | Binary (V128 V128Op.(I16x8 MinU)) -> simd_op 0x97l
      | Binary (V128 V128Op.(I16x8 MaxS)) -> simd_op 0x98l
      | Binary (V128 V128Op.(I16x8 MaxU)) -> simd_op 0x99l
      | Binary (V128 V128Op.(I16x8 AvgrU)) -> simd_op 0x9bl
      | Binary (V128 V128Op.(I32x4 Add)) -> simd_op 0xael
      | Binary (V128 V128Op.(I32x4 Sub)) -> simd_op 0xb1l
      | Binary (V128 V128Op.(I32x4 MinS)) -> simd_op 0xb6l
      | Binary (V128 V128Op.(I32x4 MinU)) -> simd_op 0xb7l
      | Binary (V128 V128Op.(I32x4 MaxS)) -> simd_op 0xb8l
      | Binary (V128 V128Op.(I32x4 MaxU)) -> simd_op 0xb9l
      | Binary (V128 V128Op.(I32x4 Mul)) -> simd_op 0xb5l
      | Binary (V128 V128Op.(I32x4 Eq)) -> simd_op 0x37l
      | Binary (V128 V128Op.(I32x4 Ne)) -> simd_op 0x38l
      | Binary (V128 V128Op.(I32x4 LtS)) -> simd_op 0x39l
      | Binary (V128 V128Op.(I32x4 LtU)) -> simd_op 0x3al
      | Binary (V128 V128Op.(I32x4 GtS)) -> simd_op 0x3bl
      | Binary (V128 V128Op.(I32x4 GtU)) -> simd_op 0x3cl
      | Binary (V128 V128Op.(I32x4 LeS)) -> simd_op 0x3dl
      | Binary (V128 V128Op.(I32x4 LeU)) -> simd_op 0x3el
      | Binary (V128 V128Op.(I32x4 GeS)) -> simd_op 0x3fl
      | Binary (V128 V128Op.(I32x4 GeU)) -> simd_op 0x40l
      | Binary (V128 V128Op.(I64x2 Add)) -> simd_op 0xcel
      | Binary (V128 V128Op.(I64x2 Sub)) -> simd_op 0xd1l
      | Binary (V128 V128Op.(I64x2 Mul)) -> simd_op 0xd5l
      | Binary (V128 V128Op.(F32x4 Eq)) -> simd_op 0x41l
      | Binary (V128 V128Op.(F32x4 Ne)) -> simd_op 0x42l
      | Binary (V128 V128Op.(F32x4 Lt)) -> simd_op 0x43l
      | Binary (V128 V128Op.(F32x4 Gt)) -> simd_op 0x44l
      | Binary (V128 V128Op.(F32x4 Le)) -> simd_op 0x45l
      | Binary (V128 V128Op.(F32x4 Ge)) -> simd_op 0x46l
      | Binary (V128 V128Op.(F32x4 Add)) -> simd_op 0xe4l
      | Binary (V128 V128Op.(F32x4 Sub)) -> simd_op 0xe5l
      | Binary (V128 V128Op.(F32x4 Mul)) -> simd_op 0xe6l
      | Binary (V128 V128Op.(F32x4 Div)) -> simd_op 0xe7l
      | Binary (V128 V128Op.(F32x4 Min)) -> simd_op 0xe8l
      | Binary (V128 V128Op.(F32x4 Max)) -> simd_op 0xe9l
      | Binary (V128 V128Op.(F32x4 Pmin)) -> simd_op 0xeal
      | Binary (V128 V128Op.(F32x4 Pmax)) -> simd_op 0xebl
      | Binary (V128 V128Op.(F64x2 Eq)) -> simd_op 0x47l
      | Binary (V128 V128Op.(F64x2 Ne)) -> simd_op 0x48l
      | Binary (V128 V128Op.(F64x2 Lt)) -> simd_op 0x49l
      | Binary (V128 V128Op.(F64x2 Gt)) -> simd_op 0x4al
      | Binary (V128 V128Op.(F64x2 Le)) -> simd_op 0x4bl
      | Binary (V128 V128Op.(F64x2 Ge)) -> simd_op 0x4cl
      | Binary (V128 V128Op.(F64x2 Add)) -> simd_op 0xf0l
      | Binary (V128 V128Op.(F64x2 Sub)) -> simd_op 0xf1l
      | Binary (V128 V128Op.(F64x2 Mul)) -> simd_op 0xf2l
      | Binary (V128 V128Op.(F64x2 Div)) -> simd_op 0xf3l
      | Binary (V128 V128Op.(F64x2 Min)) -> simd_op 0xf4l
      | Binary (V128 V128Op.(F64x2 Max)) -> simd_op 0xf5l
      | Binary (V128 V128Op.(F64x2 Pmin)) -> simd_op 0xf6l
      | Binary (V128 V128Op.(F64x2 Pmax)) -> simd_op 0xf7l
      | Binary (V128 V128Op.(V128 And)) -> simd_op 0x4el
      | Binary (V128 V128Op.(V128 AndNot)) -> simd_op 0x4fl
      | Binary (V128 V128Op.(V128 Or)) -> simd_op 0x50l
      | Binary (V128 V128Op.(V128 Xor)) -> simd_op 0x51l

      | Convert (I32 I32Op.ExtendSI32) -> assert false
      | Convert (I32 I32Op.ExtendUI32) -> assert false
      | Convert (I32 I32Op.WrapI64) -> op 0xa7
      | Convert (I32 I32Op.TruncSF32) -> op 0xa8
      | Convert (I32 I32Op.TruncUF32) -> op 0xa9
      | Convert (I32 I32Op.TruncSF64) -> op 0xaa
      | Convert (I32 I32Op.TruncUF64) -> op 0xab
      | Convert (I32 I32Op.TruncSatSF32) -> op 0xfc; vu32 0x00l
      | Convert (I32 I32Op.TruncSatUF32) -> op 0xfc; vu32 0x01l
      | Convert (I32 I32Op.TruncSatSF64) -> op 0xfc; vu32 0x02l
      | Convert (I32 I32Op.TruncSatUF64) -> op 0xfc; vu32 0x03l
      | Convert (I32 I32Op.ReinterpretFloat) -> op 0xbc

      | Convert (I64 I64Op.ExtendSI32) -> op 0xac
      | Convert (I64 I64Op.ExtendUI32) -> op 0xad
      | Convert (I64 I64Op.WrapI64) -> assert false
      | Convert (I64 I64Op.TruncSF32) -> op 0xae
      | Convert (I64 I64Op.TruncUF32) -> op 0xaf
      | Convert (I64 I64Op.TruncSF64) -> op 0xb0
      | Convert (I64 I64Op.TruncUF64) -> op 0xb1
      | Convert (I64 I64Op.TruncSatSF32) -> op 0xfc; vu32 0x04l
      | Convert (I64 I64Op.TruncSatUF32) -> op 0xfc; vu32 0x05l
      | Convert (I64 I64Op.TruncSatSF64) -> op 0xfc; vu32 0x06l
      | Convert (I64 I64Op.TruncSatUF64) -> op 0xfc; vu32 0x07l
      | Convert (I64 I64Op.ReinterpretFloat) -> op 0xbd

      | Convert (F32 F32Op.ConvertSI32) -> op 0xb2
      | Convert (F32 F32Op.ConvertUI32) -> op 0xb3
      | Convert (F32 F32Op.ConvertSI64) -> op 0xb4
      | Convert (F32 F32Op.ConvertUI64) -> op 0xb5
      | Convert (F32 F32Op.PromoteF32) -> assert false
      | Convert (F32 F32Op.DemoteF64) -> op 0xb6
      | Convert (F32 F32Op.ReinterpretInt) -> op 0xbe

      | Convert (F64 F64Op.ConvertSI32) -> op 0xb7
      | Convert (F64 F64Op.ConvertUI32) -> op 0xb8
      | Convert (F64 F64Op.ConvertSI64) -> op 0xb9
      | Convert (F64 F64Op.ConvertUI64) -> op 0xba
      | Convert (F64 F64Op.PromoteF32) -> op 0xbb
      | Convert (F64 F64Op.DemoteF64) -> assert false
      | Convert (F64 F64Op.ReinterpretInt) -> op 0xbf

      | Convert (V128 (V128Op.I8x16 V128Op.Splat)) -> simd_op 0x0fl;
      | Convert (V128 (V128Op.I16x8 V128Op.Splat)) -> simd_op 0x10l;
      | Convert (V128 (V128Op.I32x4 V128Op.Splat)) -> simd_op 0x11l;
      | Convert (V128 (V128Op.I64x2 V128Op.Splat)) -> simd_op 0x12l;
      | Convert (V128 (V128Op.F32x4 V128Op.Splat)) -> simd_op 0x13l;
      | Convert (V128 (V128Op.F64x2 V128Op.Splat)) -> simd_op 0x14l;
      | Convert (V128 _) -> assert false

      | SimdTernary (V128Op.Bitselect) -> simd_op 0x52l

      | SimdExtract (V128Op.I8x16 (SX, imm)) -> simd_op 0x15l; u8 imm
      | SimdExtract (V128Op.I8x16 (ZX, imm)) -> simd_op 0x16l; u8 imm
      | SimdExtract (V128Op.I16x8 (SX, imm)) -> simd_op 0x18l; u8 imm
      | SimdExtract (V128Op.I16x8 (ZX, imm)) -> simd_op 0x19l; u8 imm
      | SimdExtract (V128Op.I32x4 (ZX, imm)) -> simd_op 0x1bl; u8 imm
      | SimdExtract (V128Op.I64x2 (ZX, imm)) -> simd_op 0x1dl; u8 imm
      | SimdExtract (V128Op.F32x4 (ZX, imm)) -> simd_op 0x1fl; u8 imm
      | SimdExtract (V128Op.F64x2 (ZX, imm)) -> simd_op 0x21l; u8 imm
      | SimdExtract _ -> assert false

      | SimdReplace (V128Op.I8x16 imm) -> simd_op 0x17l; u8 imm
      | SimdReplace (V128Op.I16x8 imm) -> simd_op 0x1al; u8 imm
      | SimdReplace (V128Op.I32x4 imm) -> simd_op 0x1cl; u8 imm
      | SimdReplace (V128Op.I64x2 imm) -> simd_op 0x1el; u8 imm
      | SimdReplace (V128Op.F32x4 imm) -> simd_op 0x20l; u8 imm
      | SimdReplace (V128Op.F64x2 imm) -> simd_op 0x22l; u8 imm
      | SimdReplace _ -> assert false

      | SimdShift V128Op.(I8x16 Shl) -> simd_op 0x6bl
      | SimdShift V128Op.(I8x16 ShrS) -> simd_op 0x6cl
      | SimdShift V128Op.(I8x16 ShrU) -> simd_op 0x6dl
      | SimdShift V128Op.(I16x8 Shl) -> simd_op 0x8bl
      | SimdShift V128Op.(I16x8 ShrS) -> simd_op 0x8cl
      | SimdShift V128Op.(I16x8 ShrU) -> simd_op 0x8dl
      | SimdShift V128Op.(I32x4 Shl) -> simd_op 0xabl
      | SimdShift V128Op.(I32x4 ShrS) -> simd_op 0xacl
      | SimdShift V128Op.(I32x4 ShrU) -> simd_op 0xadl
      | SimdShift V128Op.(I64x2 Shl) -> simd_op 0xcbl
      | SimdShift V128Op.(I64x2 ShrS) -> simd_op 0xccl
      | SimdShift V128Op.(I64x2 ShrU) -> simd_op 0xcdl
      | SimdShift (_) -> assert false

      | SimdBitmask Simd.I8x16 -> simd_op 0x64l
      | SimdBitmask Simd.I16x8 -> simd_op 0x84l
      | SimdBitmask Simd.I32x4 -> simd_op 0xa4l
      | SimdBitmask (_) -> assert false

      | _ -> assert false

    let const c =
      list instr c.it; end_ ()

    (* Sections *)

    let section id f x needed =
      if needed then begin
        u8 id;
        let g = gap32 () in
        let p = pos s in
        f x;
        patch_gap32 g (pos s - p)
      end

    (* Type section *)
    let type_ t = func_type t.it

    let type_section ts =
      section 1 (vec type_) ts (ts <> [])

    (* Import section *)
    let import_desc d =
      match d.it with
      | FuncImport x -> u8 0x00; var x
      | TableImport t -> u8 0x01; table_type t
      | MemoryImport t -> u8 0x02; memory_type t
      | GlobalImport t -> u8 0x03; global_type t

    let import im =
      let {module_name; item_name; idesc} = im.it in
      name module_name; name item_name; import_desc idesc

    let import_section ims =
      section 2 (vec import) ims (ims <> [])

    (* Function section *)
    let func f = var f.it.ftype

    let func_section fs =
      section 3 (vec func) fs (fs <> [])

    (* Table section *)
    let table tab =
      let {ttype} = tab.it in
      table_type ttype

    let table_section tabs =
      section 4 (vec table) tabs (tabs <> [])

    (* Memory section *)
    let memory mem =
      let {mtype} = mem.it in
      memory_type mtype

    let memory_section mems =
      section 5 (vec memory) mems (mems <> [])

    (* Global section *)
    let global g =
      let {gtype; value} = g.it in
      global_type gtype; const value

    let global_section gs =
      section 6 (vec global) gs (gs <> [])

    (* Export section *)
    let export_desc d =
      match d.it with
      | FuncExport x -> u8 0; var x
      | TableExport x -> u8 1; var x
      | MemoryExport x -> u8 2; var x
      | GlobalExport x -> u8 3; var x

    let export ex =
      let {name = n; edesc} = ex.it in
      name n; export_desc edesc

    let export_section exs =
      section 7 (vec export) exs (exs <> [])

    (* Start section *)
    let start_section xo =
      section 8 (opt var) xo (xo <> None)

    (* Code section *)
    let compress ts =
      let combine t = function
        | (t', n) :: ts when t = t' -> (t, n + 1) :: ts
        | ts -> (t, 1) :: ts
      in List.fold_right combine ts []

    let local (t, n) = len n; value_type t

    let code f =
      let {locals; body; _} = f.it in
      let g = gap32 () in
      let p = pos s in
      vec local (compress locals);
      list instr body;
      end_ ();
      patch_gap32 g (pos s - p)

    let code_section fs =
      section 10 (vec code) fs (fs <> [])

    (* Element section *)
    let segment dat seg =
      let {index; offset; init} = seg.it in
      var index; const offset; dat init

    let table_segment seg =
      segment (vec var) seg

    let elem_section elems =
      section 9 (vec table_segment) elems (elems <> [])

    (* Data section *)
    let memory_segment seg =
      segment string seg

    let data_section data =
      section 11 (vec memory_segment) data (data <> [])

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
      elem_section m.it.elems;
      code_section m.it.funcs;
      data_section m.it.data
  end
  in E.module_ m; to_string s
