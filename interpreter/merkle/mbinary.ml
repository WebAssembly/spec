
open Values
open Byteutil
open Ast
open Mrun
(* open Types *)

let u256 i = get_value (I64 (Int64.of_int i))

let op x = Char.chr x

(* cannot be zero because of size_code *)
let sz_code = function
 | Memory.Mem8 -> 1
 | Memory.Mem16 -> 2
 | Memory.Mem32 -> 4

let ext_code = function
 | Memory.ZX -> 0
 | Memory.SX -> 1

let size_code = function
 | None -> 0
 | Some (sz, ext) -> (sz_code sz lsl 1) lor ext_code ext

let alu_byte = function
 | Mrun.Nop -> op 0x00
 | Trap -> op 0x01
 (* implement these in solidity *)
 | Min -> op 0x02
 | CheckJump -> op 0x03
 | CheckJumpForward -> op 0x04
 | Exit -> op 0x06
 | CheckDynamicCall -> op 0x07
 | FixMemory (ty, sz) -> (* type, sz, ext : 4 * 3 * 2 = 24 *)
    op (0xc0 lor (type_code ty lsl 4) lor size_code sz)
    
 | Test (I32 I32Op.Eqz) -> op 0x45
 | Test (I64 I64Op.Eqz) -> op 0x50
 | Test (F32 _) -> assert false
 | Test (F64 _) -> assert false

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

      | Unary (I32 I32Op.Clz) -> op 0x67
      | Unary (I32 I32Op.Ctz) -> op 0x68
      | Unary (I32 I32Op.Popcnt) -> op 0x69

      | Unary (I64 I64Op.Clz) -> op 0x79
      | Unary (I64 I64Op.Ctz) -> op 0x7a
      | Unary (I64 I64Op.Popcnt) -> op 0x7b

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

      | Convert (I32 I32Op.ExtendSI32) -> assert false
      | Convert (I32 I32Op.ExtendUI32) -> assert false
      | Convert (I32 I32Op.WrapI64) -> op 0xa7
      | Convert (I32 I32Op.TruncSF32) -> op 0xa8
      | Convert (I32 I32Op.TruncUF32) -> op 0xa9
      | Convert (I32 I32Op.TruncSF64) -> op 0xaa
      | Convert (I32 I32Op.TruncUF64) -> op 0xab
      | Convert (I32 I32Op.ReinterpretFloat) -> op 0xbc

      | Convert (I64 I64Op.ExtendSI32) -> op 0xac
      | Convert (I64 I64Op.ExtendUI32) -> op 0xad
      | Convert (I64 I64Op.WrapI64) -> assert false
      | Convert (I64 I64Op.TruncSF32) -> op 0xae
      | Convert (I64 I64Op.TruncUF32) -> op 0xaf
      | Convert (I64 I64Op.TruncSF64) -> op 0xb0
      | Convert (I64 I64Op.TruncUF64) -> op 0xb1
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

let in_code_byte = function
 | NoIn -> 0x00
 | Immed -> 0x01
 | ReadPc -> 0x02
 | ReadStackPtr -> 0x03
 | MemsizeIn -> 0x04
 | GlobalIn -> 0x05
 | StackIn0 -> 0x06
 | StackIn1 -> 0x07
 | StackInReg -> 0x08
 | StackInReg2 -> 0x09
 | CallIn -> 0x0e
 | MemoryIn1 -> 0x0f
 | TableIn -> 0x10
 | MemoryIn2 -> 0x11
 | TableTypeIn -> 0x12
 | InputSizeIn -> 0x13
 | InputNameIn -> 0x14
 | InputDataIn -> 0x15
 | StackIn2 -> 0x16

let reg_byte = function
 | Reg1 -> 0x01
 | Reg2 -> 0x02
 | Reg3 -> 0x03

let out_sz_code = function
 | None -> 0
 | Some Memory.Mem8 -> 1
 | Some Memory.Mem16 -> 2
 | Some Memory.Mem32 -> 4

let out_code_byte = function
 | NoOut -> 0x00
 | StackOutReg1 -> 0x02
 | StackOut0 -> 0x03
 | StackOut1 -> 0x04
 | MemoryOut1 (ty, sz) -> 0x80 lor (type_code ty lsl 3) lor out_sz_code sz
 | CallOut -> 0x06
 | GlobalOut -> 0x08
 | StackOut2 -> 0x09
 | MemoryOut2 (ty, sz) -> 0xc0 lor (type_code ty lsl 3) lor out_sz_code sz
 | InputSizeOut -> 0x0a
 | InputNameOut -> 0x0b
 | InputCreateOut -> 0x0c
 | InputDataOut -> 0x0d
 | CallTableOut -> 0x0e
 | CallTypeOut -> 0x0f
 | SetStack -> 0x10
 | SetCallStack -> 0x11
 | SetGlobals -> 0x12
 | SetTable -> 0x13
 | SetTableTypes -> 0x14
 | SetMemory -> 0x15
 | CustomFileWrite -> 0x16

let stack_ch_byte = function
 | StackRegSub -> 0x00
 | StackReg -> 0x01
 | StackReg2 -> 0x02
 | StackReg3 -> 0x03
 | StackInc -> 0x04
 | StackDec -> 0x05
 | StackNop -> 0x06
 | StackDec2 -> 0x07
 | StackDecImmed -> 0x08

(*
we have 31 bytes
  - immed: 8 bytes
  - alu: 1 byte
  - read: 3 bytes
  - out: 4 bytes
  - change ptr: 4 bytes
  - mem: 1 bytes

this is 21 bytes

*)

let microp_word op =
  u8 (in_code_byte op.read_reg1);
  u8 (in_code_byte op.read_reg2);
  u8 (in_code_byte op.read_reg3);
  put s (alu_byte op.alu_code);
  u8 (reg_byte (fst op.write1));
  u8 (out_code_byte (snd op.write1));
  u8 (reg_byte (fst op.write2));
  u8 (out_code_byte (snd op.write2));
  u8 (stack_ch_byte op.call_ch);
  u8 (stack_ch_byte op.stack_ch);
  u8 0x00;
  u8 (stack_ch_byte op.pc_ch);
  u8 (if op.mem_ch then 1 else 0);
  value op.immed;
  extend (to_bytes s) 32

type w256 = string

open Cryptokit

(* keccak two words, clear control byte *)

(*
let ccb w =
  let res = Bytes.copy w in
  Bytes.set res 31 (Char.chr 0);
  res

let ccb1 w =
  let res = Bytes.copy w in
  Bytes.set res 31 (Char.chr 0);
  res

let ccb2 w =
  let res = Bytes.copy w in
  Bytes.set res 31 (Char.chr 1);
  res
*)

let keccak w1 w2 =
  let hash = Hash.keccak 256 in
(*  let w1 = ccb w1 and w2 = ccb w2 in *)
  hash#add_string w1;
  hash#add_string w2;
  hash#result

let zeroword = get_value (I32 0l)
let zeroword16 = String.sub zeroword 0 16

let make_level arr n =
  let res = Array.make (n/2) zeroword in
  for i = 0 to n/2 - 1 do
     res.(i) <- keccak arr.(i*2) arr.(i*2+1)
  done;
  res

let rec make_levels_aux arr =
  if Array.length arr = 1 then [arr] else
  let res = make_level arr (Array.length arr) in
  arr :: make_levels_aux res

let rec next_pow2 n =
  if n <= 2 then 2 else
  2 * next_pow2 ((n+1)/2)

let make_levels arr =
  let len = Array.length arr in
  let fixed = Array.make (next_pow2 len) zeroword in
  for i = 0 to Array.length arr - 1 do
    fixed.(i) <- arr.(i)
  done;
  make_levels_aux fixed

exception EmptyArray

(*
let rec get_levels loc = function
 | [] -> raise EmptyArray
 | [a] -> []
 | a::tl -> (if loc mod 2 = 0 then a.(loc+1) else a.(loc-1)) :: get_levels (loc/2) tl

let location_proof arr loc =
  match make_levels arr with
  | [] -> raise EmptyArray
  (* base level *)
  | base :: tl ->
    base.(2*(loc/2)) :: base.(2*(loc/2)+1) :: get_levels (loc/2) tl
*)

let rec construct_root loc acc = function
 | [] -> acc
 | a :: tl -> construct_root (loc/2) (if loc mod 2 = 0 then keccak acc a else keccak a acc) tl

let get_root loc = function
  | a::b::tl -> construct_root (loc/2) (keccak a b) tl
  | _ -> raise EmptyArray

let get_leaf loc = function
  | a::b::_ -> if loc mod 2 = 0 then a else b
  | _ -> raise EmptyArray

let set_leaf loc v = function
  | a::b::tl -> if loc mod 2 = 0 then v::b::tl else a::v::tl
  | _ -> raise EmptyArray

let do_set_leaf loc f = function
  | a::b::tl -> if loc mod 2 = 0 then f a::b::tl else a::f b::tl
  | _ -> raise EmptyArray

(*
let get_hash arr = (List.hd (List.rev (make_levels arr))).(0)
*)

let cache = Hashtbl.create 10000
let cache16 = Hashtbl.create 10000

let get_key arr idx len =
  let res = Buffer.create (len*32) in
  for i = idx to idx+len-1 do
       Buffer.add_string res (if i < Array.length arr then arr.(i) else zeroword)
  done;
  Buffer.contents res

let get_key16 arr idx len =
  let res = Buffer.create (len*32) in
  for i = idx to idx+len-1 do
(*       Buffer.add_string res (if i < Array.length arr then arr.(i) else ( prerr_endline ( "hmm " ^  string_of_int i ^  " len " ^  string_of_int (Array.length arr) ) ; zeroword16 ) ) *)
       Buffer.add_string res (if i < Array.length arr then arr.(i) else zeroword16 )
  done;
  Buffer.contents res

let get_key_f f arr idx len =
  let res = Buffer.create (len*32) in
  for i = idx to idx+len-1 do
      Buffer.add_string res (if i < Array.length arr then f arr.(i) else zeroword)
  done;
  Buffer.contents res

(*
let get_key arr idx len =
  let res = ref [] in
  for i = idx to idx+len-1 do
       res := (if i < Array.length arr then arr.(i) else zeroword) :: !res
  done;
  !res

let get_key16 arr idx len =
  let res = ref [] in
  for i = idx to idx+len-1 do
       res := (if i < Array.length arr then arr.(i) else ( prerr_endline ( "hmm " ^  string_of_int i ) ; zeroword16 ) ) :: !res
  done;
  !res

let get_key_f f arr idx len =
  let res = ref [] in
  for i = idx to idx+len-1 do
       res := (if i < Array.length arr then f arr.(i) else zeroword) :: !res
  done;
  !res
*)

let cache_const = 0

let rec makeMerkle16 arr idx level =
   (* prerr_endline (string_of_int idx ^ " level " ^ string_of_int level); *)
   if level > cache_const then keccak (makeMerkle16 arr idx (level-1)) (makeMerkle16 arr (idx+pow2 (level-1)) (level-1)) else
   (* let _ = prerr_endline ("find level " ^ string_of_int level ^ " idx " ^ string_of_int idx) in *)
   let key = get_key16 arr idx (pow2 level) in
   try
      let res = Hashtbl.find cache16 key in
(*      prerr_endline ("Cache level " ^ string_of_int level);
      prerr_endline ("Cache " ^ w256_to_string key ^ " -> " ^ w256_to_string res); *)
      res
   with Not_found ->
     let res = 
       if level = 0 then ( if idx < Array.length arr then arr.(idx) else ( (* prerr_endline "here" ; *) zeroword16 ) )
       else keccak (makeMerkle16 arr idx (level-1)) (makeMerkle16 arr (idx+pow2 (level-1)) (level-1)) in
     Hashtbl.add cache16 key res;
     res

let rec makeMerkle arr idx level =
   if level > cache_const then keccak (makeMerkle arr idx (level-1)) (makeMerkle arr (idx+pow2 (level-1)) (level-1)) else
   let key = get_key arr idx (pow2 level) in
   try Hashtbl.find cache key
   with Not_found ->
     let res = 
       if level = 0 then ( if idx < Array.length arr then arr.(idx) else zeroword )
       else keccak (makeMerkle arr idx (level-1)) (makeMerkle arr (idx+pow2 (level-1)) (level-1)) in
     Hashtbl.add cache key res;
     res

let rec mapMerkle f arr idx level =
   if level > cache_const then keccak (mapMerkle f arr idx (level-1)) (mapMerkle f arr (idx+pow2 (level-1)) (level-1)) else
   let key = get_key_f f arr idx (pow2 level) in
   try Hashtbl.find cache key
   with Not_found ->
     let res = 
       if level = 0 then ( if idx < Array.length arr then f arr.(idx) else zeroword )
       else keccak (mapMerkle f arr idx (level-1)) (mapMerkle f arr (idx+pow2 (level-1)) (level-1)) in
     Hashtbl.add cache key res;
     res
(*   if level = 0 then ( if idx < Array.length arr then f arr.(idx) else zeroword )
   else keccak (mapMerkle f arr idx (level-1)) (mapMerkle f arr (idx+pow2 (level-1)) (level-1)) *)

let rec depth x = if x <= 1 then 0 else 1 + depth (x/2)

let get_hash (arr: w256 array) =
  makeMerkle arr 0 (depth (Array.length arr*2-1))

let get_hash16 (arr: w256 array) =
  makeMerkle16 arr 0 (depth (Array.length arr*2-1))

let map_hash f arr = mapMerkle f arr 0 (depth (Array.length arr*2-1))

let rec get_levels loc = function
 | [] -> raise EmptyArray
 | [a] -> []
 | a::tl -> (if loc mod 2 = 0 then a.(loc+1) else a.(loc-1)) :: get_levels (loc/2) tl

let rec get_location_proof arr idx loc level =
  if level = 1 then [arr.(idx+1); arr.(idx)] else
  let sz = pow2 (level-1) in
  if idx + sz > loc then makeMerkle arr (idx+pow2 (level-1)) (level-1) :: get_location_proof arr idx loc (level-1)
  else makeMerkle arr idx (level-1) :: get_location_proof arr (idx+pow2 (level-1)) loc (level-1)

let rec get_map_location_proof f arr idx loc level =
  if level = 1 then [f arr.(idx+1); f arr.(idx)] else
  let sz = pow2 (level-1) in
  if idx + sz > loc then mapMerkle f arr (idx+pow2 (level-1)) (level-1) :: get_map_location_proof f arr idx loc (level-1)
  else mapMerkle f arr idx (level-1) :: get_map_location_proof f arr (idx+pow2 (level-1)) loc (level-1)

let map_location_proof f arr loc = List.rev (get_map_location_proof f arr 0 loc (depth (Array.length arr*2-1)))

let location_proof arr loc = List.rev (get_location_proof arr 0 loc (depth (Array.length arr*2-1)))

(* simple hash, not merkle root *)
let hash_stack arr =
  let hash = Hash.keccak 256 in
  Array.iter (fun v -> hash#add_string (get_value v)) arr;
  hash#result

let string_to_array str =
  (* need one extra for nil terminated strings*)
  let res = Array.make (Bytes.length str) (u256 0) in
  for i = 0 to Bytes.length str - 1 do
    res.(i) <- u256 (Char.code (Bytes.get str i))
  done;
  res

let string_to_root str = get_hash (string_to_array str)

let zeros = Bytes.make 64 (Char.chr 0)

let get_bytes32 str n = Bytes.sub str n 32
let get_bytes16 str n = Bytes.sub str n 16

let bytes_to_array32 str =
  let cells = max ((Bytes.length str + 31) / 32) 2 in
  let res = Array.make cells (u256 0) in
  let str_e = Bytes.cat str zeros in
  for i = 0 to cells - 1 do
    res.(i) <- Bytes.to_string (get_bytes32 str_e (i*32))
  done;
  res

let bytes_to_array16 str =
  let cells = max ((Bytes.length str + 15) / 16) 2 in
  let res = Array.make cells (u256 0) in
  let str_e = Bytes.cat str zeros in
  for i = 0 to cells - 1 do
    res.(i) <- Bytes.to_string (get_bytes16 str_e (i*16))
  done;
  res

let bytes_to_array = bytes_to_array16

let bytes_to_root str =
  get_hash16 (bytes_to_array str)

(* probably most simple to just generate two proofs *)
let location_proof2 arr loc1 loc2 =
  (* first make the first level proof *)
  let proof1 = map_location_proof string_to_root arr loc1 in
  let proof2 = location_proof (string_to_array arr.(loc1)) loc2 in
  (proof1, proof2)

let location_proof_data arr loc1 loc2 =
  (* first make the first level proof *)
  let proof1 = map_location_proof bytes_to_root arr loc1 in
  let proof2 = location_proof (bytes_to_array arr.(loc1)) (loc2/16) in
  (proof1, proof2)

(*
let hash_input input =
  let hash = Hash.keccak 256 in
  hash#add_string (get_hash (Array.map u256 input.file_size));
  hash#add_string (get_hash (Array.map string_to_root input.file_name));
  hash#add_string (get_hash (Array.map string_to_root input.file_data));
  hash#result
*)

type vm_bin = {
  bin_code : w256;
  bin_stack : w256;
  bin_memory : w256;
  bin_call_stack : w256;
  bin_globals : w256;
  bin_calltable : w256;
  bin_calltable_types : w256;
  bin_input_size : w256;
  bin_input_name : w256;
  bin_input_data : w256;

  bin_pc : int;
  bin_stack_ptr : int;
  bin_call_ptr : int;
  bin_memsize : int;
}

let hash_vm_bin vm =
  let hash = Hash.keccak 256 in
  hash#add_string vm.bin_code;
  hash#add_string vm.bin_memory;
  hash#add_string vm.bin_stack;
  hash#add_string vm.bin_globals;
  hash#add_string vm.bin_call_stack;
  hash#add_string vm.bin_calltable;
  hash#add_string vm.bin_calltable_types;
  hash#add_string vm.bin_input_size;
  hash#add_string vm.bin_input_name;
  hash#add_string vm.bin_input_data;
  hash#add_string (u256 vm.bin_pc);
  hash#add_string (u256 vm.bin_stack_ptr);
  hash#add_string (u256 vm.bin_call_ptr);
  hash#add_string (u256 vm.bin_memsize);
  let res = hash#result in
  trace ("hash vm bin " ^ w256_to_string res);
  res

let hash_io_bin vm =
  let hash = Hash.keccak 256 in
  hash#add_string vm.bin_code;
  hash#add_string vm.bin_input_size;
  hash#add_string vm.bin_input_name;
  hash#add_string vm.bin_input_data;
  let res = hash#result in
  trace ("hash io bin " ^ w256_to_string res);
  res

let hash_io vm =
  let hash = Hash.keccak 256 in
  hash#add_string (map_hash (fun v -> microp_word (get_code v)) vm.code);
  hash#add_string (map_hash u256 vm.input.file_size);
  hash#add_string (map_hash string_to_root vm.input.file_name);
  hash#add_string (map_hash bytes_to_root vm.input.file_data);
  hash#result

let string_from_bytes bs =
  let rec aux n = 
    if Bytes.length bs = n || Char.code (Bytes.get bs n) = 0 then "" else String.make 1 (Bytes.get bs n) ^ aux (n+1) in
  aux 0

let code_hash arr = get_hash (Array.map (fun v -> microp_word (get_code v)) arr)

let vm_to_bin vm = {
  bin_code = map_hash (fun v -> microp_word (get_code v)) vm.code;
  bin_memory = map_hash (fun v -> get_value (I64 v)) vm.memory;
  bin_input_size = map_hash u256 vm.input.file_size;
  bin_input_name = map_hash string_to_root vm.input.file_name;
  bin_input_data = map_hash bytes_to_root vm.input.file_data;
  bin_stack = map_hash (fun v -> get_value v) vm.stack;
  bin_globals = map_hash (fun v -> get_value v) vm.globals;
  bin_call_stack = map_hash (fun v -> u256 v) vm.call_stack;
  bin_calltable = map_hash (fun v -> u256 v) vm.calltable;
  bin_calltable_types = map_hash (fun v -> get_value (I64 v)) vm.calltable_types;
  bin_pc = vm.pc;
  bin_stack_ptr = vm.stack_ptr;
  bin_call_ptr = vm.call_ptr;
  bin_memsize = vm.memsize;
}

let hash_vm vm =
  let hash_code = map_hash (fun v -> microp_word (get_code v)) vm.code in
  let hash_mem = map_hash (fun v -> get_value (I64 v)) vm.memory in
  let hash_stack = map_hash get_value vm.stack in
  let hash_global = map_hash (fun v -> get_value v) vm.globals in
  let hash_call = map_hash (fun v -> u256 v) vm.call_stack in
  let hash_table = map_hash (fun v -> u256 v) vm.calltable in
  let hash_ttable = map_hash (fun v -> get_value (I64 v)) vm.calltable_types in
  let hash = Hash.keccak 256 in
  hash#add_string hash_code;
  hash#add_string hash_mem;
  hash#add_string hash_stack;
  hash#add_string hash_global;
  hash#add_string hash_call;
  hash#add_string hash_table;
  hash#add_string hash_ttable;
  hash#add_string (map_hash u256 vm.input.file_size);
  hash#add_string (map_hash string_to_root vm.input.file_name);
  hash#add_string (map_hash bytes_to_root vm.input.file_data);
  hash#add_string (u256 vm.pc);
  hash#add_string (u256 vm.stack_ptr);
  hash#add_string (u256 vm.call_ptr);
  hash#add_string (u256 vm.memsize);
  let res = hash#result in
  trace ("hash vm " ^ w256_to_string res);
  trace ("and hash vm bin " ^ w256_to_string (hash_vm_bin (vm_to_bin vm)));
  res

type machine_bin = {
  bin_vm : w256;
  bin_microp : microp;
  bin_regs : registers;
}

type machine = {
  m_vm : vm;
  m_microp : microp;
  m_regs : registers;
}

let machine_to_bin m = {
  bin_vm = hash_vm_bin (vm_to_bin m.m_vm);
  bin_microp = m.m_microp;
  bin_regs = {(m.m_regs) with ireg = m.m_regs.ireg};
}

type bin_regs = {
  b_reg1 : w256;
  b_reg2 : w256;
  b_reg3 : w256;
  b_ireg : w256;
}

let regs_to_bin r = {
  b_reg1 = get_value r.reg1;
  b_reg2 = get_value r.reg2;
  b_reg3 = get_value r.reg3;
  b_ireg = get_value r.ireg;
}

let hash_machine m =
  let hash = Hash.keccak 256 in
  hash#add_string (hash_vm m.m_vm);
  hash#add_string (microp_word m.m_microp);
  hash#add_string (get_value m.m_regs.reg1);
  hash#add_string (get_value m.m_regs.reg2);
  hash#add_string (get_value m.m_regs.reg3);
  hash#add_string (get_value m.m_regs.ireg);
  let res = hash#result in
  trace ("hash machine " ^ w256_to_string res);
  res

let hash_machine_bin m =
  let hash = Hash.keccak 256 in
  hash#add_string m.bin_vm;
  hash#add_string (microp_word m.bin_microp);
  hash#add_string (get_value m.bin_regs.reg1);
  hash#add_string (get_value m.bin_regs.reg2);
  hash#add_string (get_value m.bin_regs.reg3);
  hash#add_string (get_value m.bin_regs.ireg);
  let res = hash#result in
  trace ("hash machine bin " ^ w256_to_string res);
  res

let hash_machine_regs m regs =
  let hash = Hash.keccak 256 in
  hash#add_string m.bin_vm;
  hash#add_string (microp_word m.bin_microp);
  hash#add_string (regs.b_reg1);
  hash#add_string (regs.b_reg2);
  hash#add_string (regs.b_reg3);
  hash#add_string (regs.b_ireg);
  let res = hash#result in
  trace ("hash machine regs " ^ w256_to_string res);
  res

let test2 () =
  let hash = Hash.keccak 256 in
  (*
  hash#add_string (from_hex "7e8a5fd3482d94aefa965cbd5705c30e6b57dd9bded9c9a327eb70f738c20b6c");
  hash#add_string (from_hex "dfe10c92f3c8a8cfaa561c6217518398699e72dd6045576a0bd81c79439503b1");
  
  prerr_endline (w256_to_string (u256 1));
  hash#add_string (from_hex "0000000000000000000000000000000000000000000000000000000000000001");
  *)
  hash#add_string (u256 1);
  prerr_endline (w256_to_string hash#result);
  prerr_endline (w256_to_string (microp_word (get_code Merkle.EXIT)))

(*
let _ = test2()
*)

(*
let test n =
  let w = Bytes.create 32 in
  let arr = Array.make n w in
  let lst = make_levels_aux arr in
  prerr_endline (string_of_int (List.length lst))
*)


