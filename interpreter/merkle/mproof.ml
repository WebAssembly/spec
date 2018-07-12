
open Merkle
open Values
open Mrun
open Mbinary
open Byteutil

let trace = Merkle.trace

let to_hex a = "\"0x" ^ w256_to_string a ^ "\""


let machine_to_string m =
  "{" ^
  " \"vm\": " ^ to_hex m.bin_vm ^ "," ^
  " \"op\": " ^ to_hex (microp_word m.bin_microp) ^ "," ^
  " \"reg1\": " ^ to_hex (get_value m.bin_regs.reg1) ^ "," ^
  " \"reg2\": " ^ to_hex (get_value m.bin_regs.reg2) ^ "," ^
  " \"reg3\": " ^ to_hex (get_value m.bin_regs.reg3) ^ "," ^
  " \"ireg\": " ^ to_hex (get_value m.bin_regs.ireg) ^ " " ^
  "}"

(* so now we need the different proofs *)

type location_proof =
 | SimpleProof
 | LocationProof of (int * w256 list)
 | OobProof of w256 list
 | OobProof2 of (int * (w256 list * w256 list))
 | LocationProof2 of (int * int * (w256 list * w256 list)) (* loc1, loc2, proof1, proof2 *)
 | CustomProof of (int * w256 * (int * w256 list) * bytes)

let make_fetch_code vm =
  trace ("microp word " ^ to_hex (microp_word (get_code vm.code.(vm.pc))));
  let loc_proof = map_location_proof (fun v -> microp_word (get_code v)) vm.code vm.pc in
  (vm_to_bin vm, get_code vm.code.(vm.pc), loc_proof)

let read_position vm regs = function
 | NoIn -> 0
 | Immed -> 0
 | ReadPc -> 0
 | ReadStackPtr -> 0
 | MemsizeIn -> 0
 | GlobalIn -> value_to_int regs.reg1
 | StackIn0 ->
   trace ("Read stack from " ^ string_of_int (vm.stack_ptr-1));
   vm.stack_ptr-1
 | StackIn1 -> vm.stack_ptr-2
 | StackIn2 -> vm.stack_ptr-3
 | StackInReg -> vm.stack_ptr-value_to_int regs.reg1
 | StackInReg2 -> vm.stack_ptr-value_to_int regs.reg2
 | CallIn -> vm.call_ptr-1
 | MemoryIn1 -> (value_to_int regs.reg1+value_to_int regs.ireg) / 8
 | MemoryIn2 -> (value_to_int regs.reg1+value_to_int regs.ireg) / 8 + 1
 | TableIn -> value_to_int regs.reg1
 | TableTypeIn -> value_to_int regs.reg1
 | InputSizeIn -> value_to_int regs.reg1
 | InputNameIn -> 0
 | InputDataIn -> 0

let write_position vm regs = function
 | GlobalOut -> value_to_int regs.reg1
 | CallOut -> vm.call_ptr
 | MemoryOut1 (_,_) -> (value_to_int regs.reg1+value_to_int regs.ireg) / 8
 | MemoryOut2 (_,_) -> (value_to_int regs.reg1+value_to_int regs.ireg) / 8  + 1
 | StackOut0 -> vm.stack_ptr
 | StackOut1 -> vm.stack_ptr-1
 | StackOutReg1 -> vm.stack_ptr-value_to_int regs.reg1
 | StackOut2 -> vm.stack_ptr-2
 | InputSizeOut ->
    let res = value_to_int regs.reg1 in
    trace ("size position " ^ string_of_int res);
    res
 | InputCreateOut ->
    let res = value_to_int regs.reg1 in
    trace ("create position " ^ string_of_int res);
    res
 | CallTableOut -> value_to_int regs.ireg
 | CallTypeOut -> value_to_int regs.ireg
 | CustomFileWrite -> value_to_int regs.reg1
 | _ -> 0

let loc_proof loc f arr = (loc, map_location_proof f arr loc)

let loc_proof2 loc1 loc2 arr = (loc1, loc2, location_proof2 arr loc1 loc2)
let loc_proof_data loc1 loc2 arr = (loc1, loc2, location_proof_data arr loc1 loc2)

let mk_loc_proof loc f arr =
  if Array.length arr > loc then LocationProof (loc, map_location_proof f arr loc)
  else OobProof (map_location_proof f arr 0)

let mk_loc_proof2 loc1 loc2 arr =
  if loc1 >= 1024 then OobProof (fst (location_proof2 arr 0 0))
  else if loc2 >= Bytes.length arr.(loc1) then OobProof2 (loc1, location_proof2 arr loc1 0)
  else LocationProof2 (loc1, loc2, location_proof2 arr loc1 loc2)

let mk_loc_proof_data loc1 loc2 arr =
  if loc1 >= 1024 then OobProof (fst (location_proof_data arr 0 0))
  else if loc2 >= Bytes.length arr.(loc1) then OobProof2 (loc1, location_proof_data arr loc1 0)
  else LocationProof2 (loc1, loc2, location_proof_data arr loc1 loc2)

let get_read_location m loc =
 let pos = read_position m.m_vm m.m_regs loc in
 let vm = m.m_vm in
 match loc with
 | NoIn -> SimpleProof
 | Immed -> SimpleProof
 | ReadPc -> SimpleProof
 | ReadStackPtr -> SimpleProof
 | MemsizeIn -> SimpleProof
 | GlobalIn -> mk_loc_proof pos get_value vm.globals
 | StackIn0 -> mk_loc_proof pos get_value vm.stack
 | StackIn1 -> mk_loc_proof pos get_value vm.stack
 | StackIn2 -> mk_loc_proof pos get_value vm.stack
 | StackInReg -> mk_loc_proof pos get_value vm.stack
 | StackInReg2 -> mk_loc_proof pos get_value vm.stack
 | MemoryIn1 -> mk_loc_proof pos (fun i -> get_value (I64 i)) vm.memory
 | MemoryIn2 -> mk_loc_proof pos (fun i -> get_value (I64 i)) vm.memory
 | TableIn -> mk_loc_proof pos u256 vm.calltable
 | TableTypeIn -> mk_loc_proof pos (fun i -> get_value (I64 i)) vm.calltable_types
 | CallIn -> mk_loc_proof pos u256 vm.call_stack
 | InputSizeIn -> mk_loc_proof pos u256 vm.input.file_size
 | InputNameIn ->
   mk_loc_proof2 (value_to_int m.m_regs.reg2) (value_to_int m.m_regs.reg1) vm.input.file_name
 | InputDataIn ->
   mk_loc_proof_data (value_to_int m.m_regs.reg2) (value_to_int m.m_regs.reg1) vm.input.file_data

let find_file vm (name:string) =
  let res = ref SimpleProof in
  for i = 0 to Array.length vm.input.file_data - 1 do
    if string_from_bytes vm.input.file_name.(i) = name then res := LocationProof (loc_proof i bytes_to_root vm.input.file_data)
  done;
  !res

let find_files vm =
  let res = ref [] in
  for i = 0 to Array.length vm.input.file_data - 1 do
    if Bytes.length vm.input.file_name.(i) > 0 && (Bytes.get vm.input.file_name.(i) 0) <> '\000' then begin
      res := (map_location_proof bytes_to_root vm.input.file_data i, map_location_proof string_to_root vm.input.file_name i, i, Mbinary.string_from_bytes vm.input.file_name.(i) ^ ".out") :: !res
    end
  done;
  !res

let get_write_location m loc =
 let pos = write_position m.m_vm m.m_regs loc in
 let vm = m.m_vm in
 match loc with
 | NoOut -> SimpleProof
 | SetStack -> SimpleProof
 | SetCallStack -> SimpleProof
 | SetTable -> SimpleProof
 | SetMemory -> SimpleProof
 | SetTableTypes -> SimpleProof
 | SetGlobals -> SimpleProof
 | StackOutReg1 -> mk_loc_proof pos get_value vm.stack
 | StackOut0 -> mk_loc_proof pos get_value vm.stack
 | StackOut1 -> mk_loc_proof pos get_value vm.stack
 | StackOut2 -> mk_loc_proof pos get_value vm.stack
 | MemoryOut1 _ -> mk_loc_proof pos (fun i -> get_value (I64 i)) vm.memory
 | MemoryOut2 _ -> mk_loc_proof pos (fun i -> get_value (I64 i)) vm.memory
 | CallOut -> mk_loc_proof pos u256 vm.call_stack
 | GlobalOut -> mk_loc_proof pos get_value vm.globals
 | CallTypeOut -> mk_loc_proof pos (fun i -> get_value (I64 i)) vm.calltable_types
 | CallTableOut -> mk_loc_proof pos u256 vm.calltable
 | InputSizeOut -> mk_loc_proof pos u256 vm.input.file_size
 | InputCreateOut -> mk_loc_proof pos bytes_to_root vm.input.file_data
 | InputNameOut -> mk_loc_proof2 (value_to_int m.m_regs.reg1) (value_to_int m.m_regs.reg2) vm.input.file_name
 | InputDataOut -> mk_loc_proof_data (value_to_int m.m_regs.reg1) (value_to_int m.m_regs.reg2) vm.input.file_data
 | CustomFileWrite ->
   let dta, sz = process_custom vm (value_to_int m.m_regs.reg1) (value_to_int m.m_regs.ireg) in
   CustomProof (sz, string_to_root dta, loc_proof pos bytes_to_root vm.input.file_data, dta)

let make_register_proof1 m =
  (machine_to_bin m, vm_to_bin m.m_vm, get_read_location m m.m_microp.read_reg1)

let make_register_proof2 m =
  (machine_to_bin m, vm_to_bin m.m_vm, get_read_location m m.m_microp.read_reg2)

let make_register_proof3 m =
  (machine_to_bin m, vm_to_bin m.m_vm, get_read_location m m.m_microp.read_reg3)

let make_write_proof m wr =
  (machine_to_bin m, vm_to_bin m.m_vm, get_write_location m (snd wr))

let is_oob = function
 | (_, _, OobProof _) -> true
 | (_, _, OobProof2 _) -> true
 | _ -> false

type micro_proof = {
  fetch_code_proof : vm_bin * microp * w256 list;
  init_regs_proof : machine_bin * vm_bin;
  read_register_proof1 : machine_bin * vm_bin * location_proof;
  read_register_proof2 : machine_bin * vm_bin * location_proof;
  read_register_proof3 : machine_bin * vm_bin * location_proof;
  alu_proof : machine_bin * vm_bin;
  write_proof1 : machine_bin * vm_bin * location_proof;
  write_proof2 : machine_bin * vm_bin * location_proof;
  update_ptr_proof1 : machine_bin * vm_bin;
  update_ptr_proof2 : machine_bin * vm_bin;
  update_ptr_proof3 : machine_bin * vm_bin;
  memsize_proof : machine_bin * vm_bin;
  finalize_proof : vm_bin;
}

let wrap_proof_fetch vm = 
  try
    let op = get_code vm.code.(vm.pc) in
    let fetch_code_proof = make_fetch_code vm in
    op, fetch_code_proof
  with _ ->
    ( let proof = (vm_to_bin vm, noop, []) in
      vm.pc <- magic_pc;
      noop, proof )

let wrap_proof3 m vm f =
  try if vm.pc <> magic_pc then f () else raise Not_found
  with _ -> (
    let proof = (machine_to_bin m, vm_to_bin vm, SimpleProof) in
    vm.pc <- magic_pc; 
    proof )

let micro_step_proofs vm =
  (* fetch code *)
  let op, fetch_code_proof = wrap_proof_fetch vm in
  (* init registers *)
  let init_regs_proof = {bin_vm=hash_vm vm; bin_regs={reg1=i 0; reg2=i 0; reg3=i 0; ireg=i 0}; bin_microp=op}, vm_to_bin vm in
  let regs = {reg1=i 0; reg2=i 0; reg3=i 0; ireg=op.immed} in
  let m = {m_vm=vm; m_regs=regs; m_microp=op} in
  (* read registers *)
  let read_register_proof1 = wrap_proof3 m vm (fun () ->
      let proof = make_register_proof1 m in
      if is_oob proof then vm.pc <- magic_pc
      else regs.reg1 <- read_register vm regs op.read_reg1;
      proof) in
  let read_register_proof2 = wrap_proof3 m vm (fun () ->
      let proof = make_register_proof2 m in
      if is_oob proof then vm.pc <- magic_pc
      else regs.reg2 <- read_register vm regs op.read_reg2;
      proof) in
  let read_register_proof3 = wrap_proof3 m vm (fun () ->
      let proof = make_register_proof3 m in
      if is_oob proof then vm.pc <- magic_pc
      else regs.reg3 <- read_register vm regs op.read_reg3;
      proof) in
  (* ALU *)
  let alu_proof = (machine_to_bin m, vm_to_bin vm) in
  ( try regs.reg1 <- handle_alu regs.reg1 regs.reg2 regs.reg3 regs.ireg op.alu_code;
    with _ -> vm.pc <- magic_pc );
  (* Write registers *)
  let write_proof1 = wrap_proof3 m vm (fun () ->
    let proof = make_write_proof m op.write1 in
    if is_oob proof then vm.pc <- magic_pc
    else write_register vm regs (get_register regs (fst op.write1)) (snd op.write1);
    proof) in
  let write_proof2 = wrap_proof3 m vm (fun () ->
    let proof = make_write_proof m op.write2 in
    if is_oob proof then vm.pc <- magic_pc
    else write_register vm regs (get_register regs (fst op.write2)) (snd op.write2);
    proof) in
  (* update pointers *)
  let update_ptr_proof1 = (machine_to_bin m, vm_to_bin vm) in
  if vm.pc <> magic_pc then vm.pc <- handle_ptr regs vm.pc op.pc_ch;
  let update_ptr_proof2 = (machine_to_bin m, vm_to_bin vm) in
  if vm.pc <> magic_pc then vm.stack_ptr <- handle_ptr regs vm.stack_ptr op.stack_ch;
  let update_ptr_proof3 = (machine_to_bin m, vm_to_bin vm) in
  if vm.pc <> magic_pc then vm.call_ptr <- handle_ptr regs vm.call_ptr op.call_ch;
  let memsize_proof = (machine_to_bin m, vm_to_bin vm) in
  if vm.pc <> magic_pc && op.mem_ch then vm.memsize <- vm.memsize + value_to_int regs.reg1;
  let finalize_proof = vm_to_bin vm in
  {fetch_code_proof; init_regs_proof; 
   read_register_proof1; read_register_proof2; read_register_proof3; alu_proof; write_proof1; write_proof2;
   update_ptr_proof1; update_ptr_proof2; update_ptr_proof3; memsize_proof; finalize_proof}

let micro_step_proofs_with_error vm =
  (* fetch code *)
  let op = get_code vm.code.(vm.pc) in
  let fetch_code_proof = make_fetch_code vm in
  (* init registers *)
  let regs = {reg1=i 0; reg2=i 0; reg3=i 0; ireg=op.immed} in
  let init_regs_proof = {bin_vm=hash_vm vm; bin_regs={reg1=i 0; reg2=i 0; reg3=i 0; ireg=i 0}; bin_microp=op}, vm_to_bin vm in
  (* read registers *)
  let m = {m_vm=vm; m_regs=regs; m_microp=op} in
  let read_register_proof1 = make_register_proof1 m in
  regs.reg1 <- read_register vm regs op.read_reg1;
  let read_register_proof2 = make_register_proof2 m in
  regs.reg2 <- read_register vm regs op.read_reg2;
  let read_register_proof3 = make_register_proof3 m in
  regs.reg3 <- read_register vm regs op.read_reg3;
  (* ALU *)
  let alu_proof = machine_to_bin m, vm_to_bin vm in
  regs.reg1 <- handle_alu regs.reg1 regs.reg2 regs.reg3 regs.ireg op.alu_code;
  (* Insert error *)
  set_input_name vm 1023 10 (i 1);
  (* Write registers *)
  let write_proof1 = make_write_proof m op.write1 in
  write_register vm regs (get_register regs (fst op.write1)) (snd op.write1);
  let write_proof2 = make_write_proof m op.write2 in
  write_register vm regs (get_register regs (fst op.write2)) (snd op.write2);
  (* update pointers *)
  let update_ptr_proof1 = (machine_to_bin m, vm_to_bin vm) in
  vm.pc <- handle_ptr regs vm.pc op.pc_ch;
  let update_ptr_proof2 = (machine_to_bin m, vm_to_bin vm) in
  vm.stack_ptr <- handle_ptr regs vm.stack_ptr op.stack_ch;
  let update_ptr_proof3 = (machine_to_bin m, vm_to_bin vm) in
  vm.call_ptr <- handle_ptr regs vm.call_ptr op.call_ch;
  let memsize_proof = (machine_to_bin m, vm_to_bin vm) in
  if op.mem_ch then vm.memsize <- vm.memsize + value_to_int regs.reg1;
  let finalize_proof = vm_to_bin vm in
  {fetch_code_proof; init_regs_proof; 
   read_register_proof1; read_register_proof2; read_register_proof3; alu_proof; write_proof1; write_proof2;
   update_ptr_proof1; update_ptr_proof2; update_ptr_proof3; memsize_proof; finalize_proof}

(* Doing checks *)

(* Custom checking is not implemented *)

let check_fetch state1 state2 (vm_bin, op, proof) =
  let microp = get_leaf vm_bin.bin_pc proof in
  trace ("OP: " ^ to_hex (microp_word op));
  if microp_word op <> microp then trace ("MICROP MISMATCH");
  trace ("Hashing VM");
  let vmhash = hash_vm_bin vm_bin in
  let c1 = (state1 = vmhash) in
  let c2 = (vm_bin.bin_code = get_root vm_bin.bin_pc proof) in
  let m = {bin_vm=hash_vm_bin vm_bin; bin_microp=op; bin_regs={reg1 = i 0; reg2 = i 0; reg3 = i 0; ireg=i 0}} in
  trace ("STATE2: " ^ machine_to_string m);
  let c3 = (state2 = hash_machine_bin m) in
  if not c1 then trace "Bad initial state";
  if not c2 then trace "Bad code";
  if not c3 then trace "Bad final state";
  c1 && c2 && c3 && microp_word op = microp
(*  state1 = hash_vm_bin vm_bin &&
  vm_bin.bin_code = get_root vm_bin.bin_pc proof &&
  state2 = keccak (hash_vm_bin vm_bin) microp *)

let check_init_registers state1 state2 m =
  let regs = {reg1 = i 0; reg2 = i 0; reg3 = i 0; ireg=m.bin_microp.immed} in
  state1 = hash_machine_bin m &&
  state2 = hash_machine_bin {m with bin_regs=regs}

let value_from_proof = function
 | LocationProof (loc, lst) -> get_leaf loc lst
 | CustomProof (_, _, (loc, lst), _) -> get_leaf loc lst
 | LocationProof2 (_, loc2, (_, lst2)) -> get_leaf loc2 lst2
 | _ -> raise EmptyArray

let read_from_proof regs vm proof = function
 | NoIn -> get_value (i 0)
 | Immed -> get_value regs.ireg
 | ReadPc -> get_value (i (vm.bin_pc+1))
 | MemsizeIn -> get_value (i vm.bin_memsize)
 | ReadStackPtr -> get_value (i vm.bin_stack_ptr)
 | InputDataIn ->
   ( match proof with
   | LocationProof2 (_, loc2, (_, lst2)) ->
     let leaf = get_leaf (loc2/32) lst2 in
     let byte = String.get leaf (loc2 mod 32) in
     get_value (i (Char.code byte))
   | _ -> raise EmptyArray )
 | _ -> value_from_proof proof

let read_position_bin vm regs = function
 | NoIn -> 0
 | Immed -> 0
 | ReadPc -> 0
 | ReadStackPtr -> 0
 | MemsizeIn -> 0
 | GlobalIn -> value_to_int regs.reg1
 | StackIn0 -> vm.bin_stack_ptr-1
 | StackIn1 -> vm.bin_stack_ptr-2
 | StackIn2 -> vm.bin_stack_ptr-3
 | StackInReg -> vm.bin_stack_ptr-value_to_int regs.reg1
 | StackInReg2 -> vm.bin_stack_ptr-value_to_int regs.reg2
 | CallIn -> vm.bin_call_ptr-1
 | MemoryIn1 -> (value_to_int regs.reg1+value_to_int regs.ireg) / 8
 | MemoryIn2 -> (value_to_int regs.reg1+value_to_int regs.ireg) / 8 + 1
 | TableIn -> value_to_int regs.reg1
 | TableTypeIn -> value_to_int regs.reg1
 | InputSizeIn -> value_to_int regs.reg1
 | InputNameIn -> 0
 | InputDataIn -> 0

let write_position_bin vm regs = function
 | NoOut -> 0
 | GlobalOut -> value_to_int regs.reg1
 | CallOut -> vm.bin_call_ptr
 | MemoryOut1 _ -> (value_to_int regs.reg1+value_to_int regs.ireg) / 8
 | MemoryOut2 _ -> (value_to_int regs.reg1+value_to_int regs.ireg) / 8 + 1
 | StackOut0 -> vm.bin_stack_ptr
 | StackOut1 -> vm.bin_stack_ptr-1
 | StackOutReg1 -> vm.bin_stack_ptr-value_to_int regs.reg1
 | StackOut2 -> vm.bin_stack_ptr-2
 | InputSizeOut ->
    value_to_int regs.reg1
 | InputCreateOut ->
    value_to_int regs.reg1
 | CallTableOut -> value_to_int regs.ireg
 | CallTypeOut -> value_to_int regs.ireg
 | _ -> 0

let read_root_bin vm = function
 | GlobalIn -> vm.bin_globals
 | StackIn0 -> vm.bin_stack
 | StackIn1 -> vm.bin_stack
 | StackIn2 -> vm.bin_stack
 | StackInReg -> vm.bin_stack
 | StackInReg2 -> vm.bin_stack
 | CallIn -> vm.bin_call_stack
 | MemoryIn1 -> vm.bin_memory
 | MemoryIn2 -> vm.bin_memory
 | TableIn -> vm.bin_calltable
 | TableTypeIn -> vm.bin_calltable_types
 | InputSizeIn -> vm.bin_input_size
 | _ -> assert false

let write_root_bin vm = function
 | GlobalOut -> vm.bin_globals
 | CallOut -> vm.bin_call_stack
 | MemoryOut1 _ -> vm.bin_memory
 | MemoryOut2 _ -> vm.bin_memory
 | StackOut0 -> vm.bin_stack
 | StackOut1 -> vm.bin_stack
 | StackOutReg1 -> vm.bin_stack
 | StackOut2 -> vm.bin_stack
 | InputSizeOut -> vm.bin_input_size
 | InputCreateOut -> vm.bin_input_data
 | CallTableOut -> vm.bin_calltable
 | CallTypeOut -> vm.bin_calltable_types
 | _ -> assert false

let check_read_proof regs vm proof = function
 | NoIn -> true
 | Immed -> true
 | ReadPc -> true
 | MemsizeIn -> true
 | ReadStackPtr -> true
 | InputNameIn ->
    ( match proof with
    | LocationProof2 (loc1, loc2, (lst1, lst2)) ->
       value_to_int regs.reg2 = loc1 &&
       value_to_int regs.reg1 = loc2 &&
       vm.bin_input_name = get_root loc1 lst1 &&
       get_leaf loc1 lst1 = get_root loc2 lst2
    | _ -> false )
 | InputDataIn ->
    ( match proof with
    | LocationProof2 (loc1, loc2, (lst1, lst2)) ->
       value_to_int regs.reg2 = loc1 &&
       value_to_int regs.reg1 = loc2 &&
       vm.bin_input_data = get_root loc1 lst1 &&
       get_leaf loc1 lst1 = get_root (loc2/16) lst2
    | _ -> false )
 | a ->
    ( match proof with
    | LocationProof (loc, lst) ->
       read_position_bin vm regs a = loc &&
       read_root_bin vm a = get_root loc lst
    | _ -> false ) 

let check_write_proof regs vm proof = function
 | NoOut -> true
 | InputNameOut ->
    ( match proof with
    | LocationProof2 (loc1, loc2, (lst1, lst2)) ->
       value_to_int regs.reg2 = loc1 &&
       value_to_int regs.reg1 = loc2 &&
       vm.bin_input_name = get_root loc1 lst1 &&
       get_leaf loc1 lst1 = get_root loc2 lst2
    | _ -> false )
 | InputDataOut ->
    ( match proof with
    | LocationProof2 (loc1, loc2, (lst1, lst2)) ->
       value_to_int regs.reg2 = loc1 &&
       value_to_int regs.reg1 = loc2 &&
       vm.bin_input_data = get_root loc1 lst1 &&
       get_leaf loc1 lst1 = get_root (loc2/16) lst2
    | _ -> false )
 | a ->
    ( match proof with
    | LocationProof (loc, lst) ->
       write_position_bin vm regs a = loc &&
       write_root_bin vm a = get_root loc lst
    | _ -> false ) 

let check_read1_proof state1 state2 (m, vm, proof) =
  let regs = {(regs_to_bin m.bin_regs) with b_reg1 = read_from_proof m.bin_regs vm proof m.bin_microp.read_reg1} in
  state1 = hash_machine_bin m &&
  m.bin_vm = hash_vm_bin vm &&
  check_read_proof m.bin_regs vm proof m.bin_microp.read_reg1 &&
  state2 = hash_machine_regs m regs

let check_read2_proof state1 state2 (m, vm, proof) =
  let regs = {(regs_to_bin m.bin_regs) with b_reg2 = read_from_proof m.bin_regs vm proof m.bin_microp.read_reg2} in
  state1 = hash_machine_bin m &&
  m.bin_vm = hash_vm_bin vm &&
  check_read_proof m.bin_regs vm proof m.bin_microp.read_reg2 &&
  state2 = hash_machine_regs m regs

let check_read3_proof state1 state2 (m, vm, proof) =
  let regs = {(regs_to_bin m.bin_regs) with b_reg3 = read_from_proof m.bin_regs vm proof m.bin_microp.read_reg3} in
  state1 = hash_machine_bin m &&
  m.bin_vm = hash_vm_bin vm &&
  check_read_proof m.bin_regs vm proof m.bin_microp.read_reg3 &&
  state2 = hash_machine_regs m regs

let check_alu_proof state1 state2 m =
  let regs = {(m.bin_regs) with reg1 = handle_alu m.bin_regs.reg1 m.bin_regs.reg2 m.bin_regs.reg3 m.bin_regs.ireg m.bin_microp.alu_code} in
  state1 = hash_machine_bin m &&
  state2 = hash_machine_bin {m with bin_regs=regs}

let check_finalize state1 state2 m =
  state1 = hash_machine_bin m &&
  state2 = m.bin_vm

let check_update_stack_ptr state1 state2 (m,vm) =
  let vm2 = {vm with bin_stack_ptr=handle_ptr m.bin_regs vm.bin_stack_ptr m.bin_microp.stack_ch} in
  let m2 = {m with bin_vm=hash_vm_bin vm2} in
  state1 = hash_machine_bin m &&
  m.bin_vm = hash_vm_bin vm &&
  state2 = hash_machine_bin m2

let check_update_pc state1 state2 (m,vm) =
  let vm2 = {vm with bin_pc=handle_ptr m.bin_regs vm.bin_pc m.bin_microp.pc_ch} in
  let m2 = {m with bin_vm=hash_vm_bin vm2} in
  state1 = hash_machine_bin m &&
  m.bin_vm = hash_vm_bin vm &&
  state2 = hash_machine_bin m2

let check_update_call_ptr state1 state2 (m,vm) =
  let vm2 = {vm with bin_call_ptr=handle_ptr m.bin_regs vm.bin_call_ptr m.bin_microp.call_ch} in
  let m2 = {m with bin_vm=hash_vm_bin vm2} in
  state1 = hash_machine_bin m &&
  m.bin_vm = hash_vm_bin vm &&
  state2 = hash_machine_bin m2

let check_update_memsize (state1:w256) (state2:w256) (m,vm) =
  let vm2 = {vm with bin_memsize=(if m.bin_microp.mem_ch then value_to_int m.bin_regs.reg1 else 0) + vm.bin_memsize} in
  state1 = hash_machine_bin m &&
  m.bin_vm = hash_vm_bin vm &&
  state2 = hash_vm_bin vm2

let merkle_change nv = function
 | LocationProof (loc, lst) ->
   let lst = set_leaf loc nv lst in
   get_root loc lst
 | _ -> (* assert false *) u256 0

let merkle_change_memory1 regs nv sz = function
 | LocationProof (loc, lst) ->
   let old = get_leaf loc lst in
   trace ("Old memory 1: " ^ w256_to_string old);
   let addr = value_to_int regs.reg1+value_to_int regs.ireg in
   let mem = mini_memory (Byteutil.Decode.word old) 0L in
   memop mem (I64 (Byteutil.Decode.word nv)) (Int64.of_int (addr-(addr/8)*8)) sz;
   let res = fst (Byteutil.Decode.mini_memory mem) in
   trace ("New memory 1: " ^ w256_to_string (get_value (I64 res)));
   let lst = set_leaf loc (get_value (I64 res)) lst in
   get_root loc lst
 | _ -> assert false

let get_proof_root = function
 | LocationProof (loc, lst) -> get_root loc lst
 | _ -> assert false

let merkle_change_memory2 regs nv sz = function
 | LocationProof (loc, lst) ->
   let old = get_leaf loc lst in
   trace ("Old memory 2: " ^ w256_to_string old);
   let addr = value_to_int regs.reg1+value_to_int regs.ireg in
   let mem = mini_memory 0L (Byteutil.Decode.word old) in
   memop mem (I64 (Byteutil.Decode.word nv)) (Int64.of_int (addr-(addr/8)*8)) sz;
   let res = snd (Byteutil.Decode.mini_memory mem) in
   trace ("New memory 2: " ^ w256_to_string (get_value (I64 res)));
   let lst = set_leaf loc (get_value (I64 res)) lst in
   get_root loc lst
 | _ -> assert false

let rec make_root v zero =
  if v > 0 then make_root (v/2) (keccak zero zero)
  else zero

(*
let _ =
  prerr_endline (to_hex (make_root 1 (String.make 16 '\000')))
*)

let list_to_string lst = "[" ^ String.concat ", " (List.map to_hex lst) ^ "]"

let loc_to_string = function
 | SimpleProof -> "{ \"location\": 0, \"list\": [] }"
 | LocationProof (loc,lst) -> "{ \"location\": " ^ string_of_int loc ^ ", \"list\": " ^ list_to_string lst ^ " }"
 | OobProof lst -> "{ \"oob\": true, \"list\": " ^ list_to_string lst ^ " }"
 | CustomProof (result_size, result_state, (loc,lst), dta) ->
    "{ \"location\": " ^ string_of_int loc ^ ", \"list\": " ^ list_to_string lst ^ ", \"result_size\": " ^ string_of_int result_size ^ ", \"result_state\": " ^ to_hex result_state ^ ", \"data\": " ^ to_hex (Bytes.to_string dta) ^ "}"
 | LocationProof2 (loc1, loc2, (lst1, lst2)) ->
    "{ \"location1\": " ^ string_of_int loc1 ^ ", \"list1\": " ^ list_to_string lst1 ^ ", " ^
    " \"location2\": " ^ string_of_int loc2 ^ ", \"list2\": " ^ list_to_string lst2 ^ " }"
 | OobProof2 (loc1, (lst1, lst2)) ->
    "{ \"location1\": " ^ string_of_int loc1 ^ ", \"list1\": " ^ list_to_string lst1 ^ ", " ^
    " \"oob\": true, \"list2\": " ^ list_to_string lst2 ^ " }"

let rec make_zero n =
  if n = 0 then u256 0 else
  let z = make_zero (n-1) in
  keccak z z

let build_root v = make_zero (Int64.to_int (Decode.word v))

let modify_data i nv str =
  let nv = Int64.to_int (Decode.word nv) in
  let res = Bytes.of_string str in
  Bytes.set res i (Char.chr nv);
  Bytes.to_string res

let write_register_bin proof vm regs v = function
 | NoOut -> vm
 | SetStack -> {vm with bin_stack=build_root v}
 | SetCallStack -> {vm with bin_call_stack=build_root v}
 | SetTable -> {vm with bin_calltable=build_root v}
 | SetTableTypes -> {vm with bin_calltable_types=build_root v}
 | SetMemory -> {vm with bin_memory=build_root v}
 | SetGlobals -> {vm with bin_globals=build_root v}
 | GlobalOut -> {vm with bin_globals=merkle_change v proof}
 | CallOut -> {vm with bin_call_stack=merkle_change v proof}
 | StackOutReg1 -> {vm with bin_stack=merkle_change v proof}
 | StackOut0 -> {vm with bin_stack=merkle_change v proof}
 | StackOut1 -> {vm with bin_stack=merkle_change v proof}
 | StackOut2 -> {vm with bin_stack=merkle_change v proof}
 | InputSizeOut -> {vm with bin_input_size=merkle_change v proof}
 | CallTableOut -> {vm with bin_calltable=merkle_change v proof}
 | CallTypeOut -> {vm with bin_calltable_types=merkle_change v proof}
 | InputCreateOut ->
   let file = make_root (Int64.to_int (Decode.word v) / 32) (String.make 16 '\000') in
   let data = merkle_change file proof in
   trace ("data: " ^ to_hex data ^ " file: " ^ to_hex file ^ " " ^ to_hex (get_proof_root proof));
   {vm with bin_input_data=data}
 | CustomFileWrite ->
   {vm with bin_input_data=merkle_change v proof}
 | MemoryOut1 (_,sz) -> {vm with bin_memory=merkle_change_memory1 regs v sz proof}
 | MemoryOut2 (_,sz) -> {vm with bin_memory=merkle_change_memory2 regs v sz proof}
 | InputNameOut ->
   ( match proof with
   | LocationProof2 (loc1, loc2, (lst1, lst2)) ->
       assert (value_to_int regs.reg1 = loc1 &&
               value_to_int regs.reg2 = loc2 &&
               vm.bin_input_name = get_root loc1 lst1 &&
               get_leaf loc1 lst1 = get_root loc2 lst2);
       let lst2 = set_leaf loc2 v lst2 in
       let lst1 = set_leaf loc1 (get_root loc2 lst2) lst1 in
       {vm with bin_input_name=get_root loc1 lst1}
   | _ -> assert false )
 | InputDataOut ->
   ( match proof with
   | LocationProof2 (loc1, loc2, (lst1, lst2)) ->
       assert (value_to_int regs.reg1 = loc1 &&
               value_to_int regs.reg2 = loc2 &&
               vm.bin_input_data = get_root loc1 lst1 &&
               get_leaf loc1 lst1 = get_root loc2 lst2);
       let lst2 = do_set_leaf (loc2/16) (modify_data (loc2 mod 16) v) lst2 in
       let lst1 = set_leaf loc1 (get_root (loc2/32) lst2) lst1 in
       {vm with bin_input_data=get_root loc1 lst1}
   | _ -> assert false )

let check_write1_proof state1 state2 (m, vm, proof) =
  let vm2 = write_register_bin proof vm m.bin_regs (get_value (get_register m.bin_regs (fst m.bin_microp.write1))) (snd m.bin_microp.write1) in
  state1 = hash_machine_bin m &&
  m.bin_vm = hash_vm_bin vm &&
  check_write_proof m.bin_regs vm proof (snd m.bin_microp.write1) &&
  state2 = hash_machine_bin {m with bin_vm=hash_vm_bin vm2}

let check_write2_proof state1 state2 (m, vm, proof) =
  let vm2 = write_register_bin proof vm m.bin_regs (get_value (get_register m.bin_regs (fst m.bin_microp.write2))) (snd m.bin_microp.write2) in
  state1 = hash_machine_bin m &&
  m.bin_vm = hash_vm_bin vm &&
  check_write_proof m.bin_regs vm proof (snd m.bin_microp.write2) &&
  state2 = hash_machine_bin {m with bin_vm=hash_vm_bin vm2}

let t1 (a,_,_) = a

let array_to_string arr =
  let res = Buffer.create 1000 in
  Buffer.add_string res "[";
  for i = 0 to Array.length arr - 1 do
    if i > 0 then Buffer.add_string res ",";
    Buffer.add_string res (to_hex arr.(i))
  done;
  Buffer.add_string res "]";
  Buffer.contents res

(*

let _ =
  let arr = Array.make 2 (-1L) in
  prerr_endline (to_hex (u256 (-1)));
  prerr_endline (to_hex (get_value (I64 (Int64.of_int (-1)))))

let _ = prerr_endline (to_hex (microp_word (get_code Merkle.EXIT)))

*)

let whole_vm_to_string vm =
  "{" ^
  " \"code\": " ^ array_to_string (Array.map (fun v -> microp_word (get_code v)) vm.code) ^ "," ^
  " \"stack\": " ^ array_to_string (Array.map (fun v -> get_value v) vm.stack) ^ "," ^
  " \"memory\": " ^ array_to_string (Array.map (fun v -> get_value (I64 v)) vm.memory) ^ "," ^
  " \"call_stack\": " ^ array_to_string (Array.map (fun v -> u256 v) vm.call_stack) ^ "," ^
  " \"globals\": " ^ array_to_string (Array.map (fun v -> get_value v) vm.globals) ^ "," ^
  " \"calltable\": " ^ array_to_string (Array.map (fun v -> u256 v) vm.calltable) ^ "," ^
  " \"calltypes\": " ^ array_to_string (Array.map (fun v -> get_value (I64 v)) vm.calltable_types) ^ "," ^
  " \"pc\": " ^ string_of_int vm.pc ^ "," ^
  " \"stack_ptr\": " ^ string_of_int vm.stack_ptr ^ "," ^
  " \"call_ptr\": " ^ string_of_int vm.call_ptr ^ "," ^
  " \"memsize\": " ^ string_of_int vm.memsize ^ " " ^
  "}"

let vm_to_string vm =
  "{" ^
  " \"code\": " ^ to_hex vm.bin_code ^ "," ^
  " \"stack\": " ^ to_hex vm.bin_stack ^ "," ^
  " \"memory\": " ^ to_hex vm.bin_memory ^ "," ^
  " \"input_size\": " ^ to_hex vm.bin_input_size ^ "," ^
  " \"input_name\": " ^ to_hex vm.bin_input_name ^ "," ^
  " \"input_data\": " ^ to_hex vm.bin_input_data ^ "," ^
  " \"call_stack\": " ^ to_hex vm.bin_call_stack ^ "," ^
  " \"globals\": " ^ to_hex vm.bin_globals ^ "," ^
  " \"calltable\": " ^ to_hex vm.bin_calltable ^ "," ^
  " \"calltypes\": " ^ to_hex vm.bin_calltable_types ^ "," ^
  " \"pc\": " ^ string_of_int vm.bin_pc ^ "," ^
  " \"stack_ptr\": " ^ string_of_int vm.bin_stack_ptr ^ "," ^
  " \"call_ptr\": " ^ string_of_int vm.bin_call_ptr ^ "," ^
  " \"memsize\": " ^ string_of_int vm.bin_memsize ^ " " ^
  "}"

let proof3_to_string (m, vm, loc) =
  "{ \"vm\": " ^ vm_to_string vm ^ ", \"machine\": " ^ machine_to_string m ^ ", \"merkle\": " ^ loc_to_string loc ^ " }"

let proof2_to_string (m, vm) =
  "{ \"vm\": " ^ vm_to_string vm ^ ", \"machine\": " ^ machine_to_string m ^ " }"

let print_fetch (a, _, b) = Printf.printf "{ \"vm\": %s, \"location\": %s }\n" (vm_to_string a) (list_to_string b)

let check_proof proof =
  let vm1, _, proof1 = proof.fetch_code_proof in
  let state1 = hash_vm_bin vm1 in
(*  trace ("STATE1: " ^ machine_to_string (proof.init_regs_proof)); *)
  let state2 = hash_machine_bin (fst proof.init_regs_proof) in
  if check_fetch state1 state2 proof.fetch_code_proof then trace "Fetch Success"
  else trace "Fetch Failure";
  let state3 = hash_machine_bin (t1 proof.read_register_proof1) in
  if check_init_registers state2 state3 (fst proof.init_regs_proof) then trace "Init Success"
  else trace "Init Failure";
  let state4 = hash_machine_bin (t1 proof.read_register_proof2) in
  if check_read1_proof state3 state4 proof.read_register_proof1 then trace "Read R1 Success"
  else trace "Read R1 Failure";
  let state5 = hash_machine_bin (t1 proof.read_register_proof3) in
  if check_read2_proof state4 state5 proof.read_register_proof2 then trace "Read R2 Success"
  else trace "Read R2 Failure";
  let state6 = hash_machine_bin (fst proof.alu_proof) in
  if check_read3_proof state5 state6 proof.read_register_proof3 then trace "Read R3 Success"
  else trace "Read R3 Failure";
  let state7 = hash_machine_bin (t1 proof.write_proof1) in
  if check_alu_proof state6 state7 (fst proof.alu_proof) then trace "ALU Success"
  else trace "ALU Failure";
  let state8 = hash_machine_bin (t1 proof.write_proof2) in
  if check_write1_proof state7 state8 proof.write_proof1 then trace "Write 1 Success"
  else trace "Write 1 Failure";
  let state9 = hash_machine_bin (fst proof.update_ptr_proof1) in
  if check_write2_proof state8 state9 proof.write_proof2 then trace "Write 2 Success"
  else trace "Write 2 Failure";
  let state10 = hash_machine_bin (fst proof.update_ptr_proof2) in
  if check_update_pc state9 state10 proof.update_ptr_proof1 then trace "PC Success"
  else trace "PC Failure";
  let state12 = hash_machine_bin (fst proof.update_ptr_proof3) in
  if check_update_stack_ptr state10 state12 proof.update_ptr_proof2 then trace "Stack Ptr Success"
  else trace "Stack Ptr Failure";
  let state13 = hash_machine_bin (fst proof.memsize_proof) in
  if check_update_call_ptr state12 state13 proof.update_ptr_proof3 then trace "Call Ptr Success"
  else trace "Call Ptr Failure";
  let state14 = hash_vm_bin proof.finalize_proof in
  if check_update_memsize state13 state14 proof.memsize_proof then trace "Memsize Success"
  else trace "Memsize Failure";
  let states = [state1;state2;state3;state4;state5;state6;state7;state8;state9;state10;state12;state13;state14] in
  Printf.printf "{\n";
  Printf.printf "  \"states\": [%s],\n" (String.concat ", " (List.map to_hex states));
  Printf.printf "  \"fetch\": { \"vm\": %s, \"location\": %s },\n"
    (vm_to_string vm1) (list_to_string proof1);
  Printf.printf "  \"init\": %s,\n" (proof2_to_string proof.init_regs_proof);
  Printf.printf "  \"reg1\": %s,\n" (proof3_to_string proof.read_register_proof1);
  Printf.printf "  \"reg2\": %s,\n" (proof3_to_string proof.read_register_proof2);
  Printf.printf "  \"reg3\": %s,\n" (proof3_to_string proof.read_register_proof3);
  Printf.printf "  \"alu\": %s,\n" (proof2_to_string proof.alu_proof);
  Printf.printf "  \"write1\": %s,\n" (proof3_to_string proof.write_proof1);
  Printf.printf "  \"write2\": %s,\n" (proof3_to_string proof.write_proof2);
  Printf.printf "  \"pc\": %s,\n" (proof2_to_string proof.update_ptr_proof1);
  Printf.printf "  \"stack_ptr\": %s,\n" (proof2_to_string proof.update_ptr_proof2);
  Printf.printf "  \"call_ptr\": %s,\n" (proof2_to_string proof.update_ptr_proof3);
  Printf.printf "  \"memsize\": %s,\n" (proof2_to_string proof.memsize_proof);
  Printf.printf "  \"final\": %s\n" (vm_to_string proof.finalize_proof);
  Printf.printf "}\n";
  ()

let micro_step_states vm =
  let open Values in
  (* fetch code *)
  let res = ref [] in
  let push st = res := st :: !res in
  try
    push (hash_vm vm);
    let regs = {reg1=i 0; reg2=i 0; reg3=i 0; ireg=i 0} in
    let op = get_code vm.code.(vm.pc) in
    let m = {m_vm=vm; m_regs=regs; m_microp=op} in
    push (hash_machine m);
    (* init registers *)
    regs.ireg <- op.immed;
    push (hash_machine m);
    (* read registers *)
    regs.reg1 <- read_register vm regs op.read_reg1;
    push (hash_machine m);
    trace ("read R1 " ^ string_of_value regs.reg1);
    regs.reg2 <- read_register vm regs op.read_reg2;
    push (hash_machine m);
    trace ("read R2 " ^ string_of_value regs.reg2);
    regs.reg3 <- read_register vm regs op.read_reg3;
    push (hash_machine m);
    trace ("read R3 " ^ string_of_value regs.reg3);
    (* ALU *)
    regs.reg1 <- handle_alu regs.reg1 regs.reg2 regs.reg3 regs.ireg op.alu_code;
    push (hash_machine m);
    (* Write registers *)
    let w1 = get_register regs (fst op.write1) in
    push (hash_machine m);
    trace ("write 1: " ^ string_of_value w1);
    write_register vm regs w1 (snd op.write1);
    let w2 = get_register regs (fst op.write2) in
    push (hash_machine m);
    trace ("write 2: " ^ string_of_value w2);
    write_register vm regs w2 (snd op.write2);
    push (hash_machine m);
    (* update pointers *)
    trace "update pointers";
    vm.pc <- handle_ptr regs vm.pc op.pc_ch;
    push (hash_machine m);
    vm.stack_ptr <- handle_ptr regs vm.stack_ptr op.stack_ch;
    push (hash_machine m);
    vm.call_ptr <- handle_ptr regs vm.call_ptr op.call_ch;
    push (hash_machine m);
    if op.mem_ch then vm.memsize <- vm.memsize + value_to_int regs.reg1;
    push (hash_vm vm);
    raise VmError
  with a ->
    Printf.printf "{\"states\": [%s]}\n" (String.concat ", " (List.map to_hex (List.rev !res)))


