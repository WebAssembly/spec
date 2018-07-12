
open Merkle
open Ast
open Values

(* how to handle dynamic jumps? GCC labels as value??? *)

let mkop i32 i64 = function
  | I32 x -> i32 x
  | I64 x -> i64 x
  | _ -> ""

open Ast.IntOp

let test64 = function
 | Eqz -> "r2 = r1 == 0 ? 1 : 0;"

let test32 = function
 | Eqz -> "r1 = r1 & 0xffffffff; r2 = r1 == 0 ? 1 : 0;"

let una32 = function
 | Clz -> "r2 = clz32(r1);"
 | Ctz -> "r2 = ctz32(r1);"
 | Popcnt -> "r2 = popcnt32(r1);"

let una64 = function
 | Clz -> "r2 = clz64(r1);"
 | Ctz -> "r2 = ctz64(r1);"
 | Popcnt -> "r2 = popcnt64(r1);"

let cmp32 = function
 | Eq -> "r3 = ((int32_t)r1 == (int32_t)r2) ? 1 : 0;"
 | Ne -> "r3 = ((int32_t)r1 != (int32_t)r2) ? 1 : 0;"
 | LtS -> "r3 = ((int32_t)r1 < (int32_t)r2) ? 1 : 0;"
 | LtU -> "r3 = ((uint32_t)r1 < (uint32_t)r2) ? 1 : 0;"
 | GtS -> "r3 = ((int32_t)r1 > (int32_t)r2) ? 1 : 0;"
 | GtU -> "r3 = ((uint32_t)r1 > (uint32_t)r2) ? 1 : 0;"
 | LeS -> "r3 = ((int32_t)r1 <= (int32_t)r2) ? 1 : 0;"
 | LeU -> "r3 = ((uint32_t)r1 <= (uint32_t)r2) ? 1 : 0;"
 | GeS -> "r3 = ((int32_t)r1 >= (int32_t)r2) ? 1 : 0;"
 | GeU -> "r3 = ((uint32_t)r1 >= (uint32_t)r2) ? 1 : 0;"

let cmp64 = function
 | Eq -> "r3 = (r1 == r2) ? 1 : 0;"
 | Ne -> "r3 = (r1 != r2) ? 1 : 0;"
 | LtS -> "r3 = ((int64_t)r1 < (int64_t)r2) ? 1 : 0;"
 | LtU -> "r3 = ((uint64_t)r1 < (uint64_t)r2) ? 1 : 0;"
 | GtS -> "r3 = ((int64_t)r1 > (int64_t)r2) ? 1 : 0;"
 | GtU -> "r3 = ((uint64_t)r1 > (uint64_t)r2) ? 1 : 0;"
 | LeS -> "r3 = ((int64_t)r1 <= (int64_t)r2) ? 1 : 0;"
 | LeU -> "r3 = ((uint64_t)r1 <= (uint64_t)r2) ? 1 : 0;"
 | GeS -> "r3 = ((int64_t)r1 >= (int64_t)r2) ? 1 : 0;"
 | GeU -> "r3 = ((uint64_t)r1 >= (uint64_t)r2) ? 1 : 0;"

let bin32 = function
 | Add -> "r3 = (int32_t)r1 + (int32_t)r2;"
 | Sub -> "r3 = (int32_t)r1 - (int32_t)r2;"
 | Mul -> "r3 = (int32_t)r1 * (int32_t)r2;"
 | DivS -> "r3 = (int32_t)r1 / (int32_t)r2;"
 | DivU -> "r3 = (uint32_t)r1 / (uint32_t)r2;"
 | RemS -> "r3 = (int32_t)r1 % (int32_t)r2;"
 | RemU -> "r3 = (uint32_t)r1 % (uint32_t)r2;"
 | And -> "r3 = (int32_t)r1 & (int32_t)r2;"
 | Or -> "r3 = (int32_t)r1 | (int32_t)r2;"
 | Xor -> "r3 = (int32_t)r1 ^ (int32_t)r2;"
 | Shl -> "r3 = (int32_t)r1 << (int32_t)r2;"
 | ShrU -> "r3 = (uint32_t)r1 >> (uint32_t)r2;"
 | ShrS -> "r3 = (int32_t)r1 >> (int32_t)r2;"
 | Rotl -> "r3 = (r1<<r2) | (r1>>(32-r2));"
 | Rotr -> "r3 = (r1>>r2) | (r1<<(32-r2));"

let bin64 = function
 | Add -> "r3 = (int64_t)r1 + (int64_t)r2;"
 | Sub -> "r3 = (int64_t)r1 - (int64_t)r2;"
 | Mul -> "r3 = (int64_t)r1 * (int64_t)r2;"
 | DivS -> "r3 = (int64_t)r1 / (int64_t)r2;"
 | DivU -> "r3 = (uint64_t)r1 / (uint64_t)r2;"
 | RemS -> "r3 = (int64_t)r1 % (int64_t)r2;"
 | RemU -> "r3 = (uint64_t)r1 % (uint64_t)r2;"
 | And -> "r3 = (int64_t)r1 & (int64_t)r2;"
 | Or -> "r3 = (int64_t)r1 | (int64_t)r2;"
 | Xor -> "r3 = (int64_t)r1 ^ (int64_t)r2;"
 | Shl -> "r3 = (int64_t)r1 << (int64_t)r2;"
 | ShrU -> "r3 = (uint64_t)r1 >> (uint64_t)r2;"
 | ShrS -> "r3 = (int64_t)r1 >> (int64_t)r2;"
 | Rotl -> "r3 = (r1<<r2) | (r1>>(64-r2));"
 | Rotr -> "r3 = (r1>>r2) | (r1<<(64-r2));"

let string_of_value = function
  | I32 i -> Int32.to_string i
  | I64 i -> Int64.to_string i
  | F32 z -> "0"
  | F64 z -> "0"

let compile labels = function
 | NOP -> "vm.pc++;"
 | STUB _ -> "vm.pc++;"
 | UNREACHABLE -> "assert(0);"
 | EXIT -> "exit(0);"
 | JUMP loc -> "vm.pc = " ^ string_of_int loc ^ "-1; goto label_" ^ string_of_int loc ^ ";"
 | JUMPI loc ->
    "vm.stack_ptr--;" ^
    "if (vm.stack[vm.stack_ptr]) { vm.pc = " ^ string_of_int loc ^ "-1; goto label_" ^ string_of_int loc ^ "; }" ^
    "else vm.pc++;"
 | JUMPFORWARD x ->
    "vm.stack_ptr--; r1 = vm.stack[vm.stack_ptr];" ^
    "if (r1 < 0 || r1 >= " ^ string_of_int x ^ ") r1 = " ^ string_of_int x ^ ";" ^
    "vm.pc = vm.pc + 1 + r1; goto *jumptable[vm.pc];"
 | CALL x ->
    Hashtbl.add labels x true;
    "vm.callstack[vm.call_ptr] = vm.pc+1;" ^
    "vm.call_ptr++;" ^
    "vm.pc = " ^ string_of_int x ^ "-1;" ^
    "goto label_" ^ string_of_int x ^ ";"
 | CHECKCALLI _ -> "vm.pc++;"
 | CALLI ->
    "vm.stack_ptr--;" ^
    "r1 = vm.stack[vm.stack_ptr];" ^
    "vm.callstack[vm.call_ptr] = vm.pc+1;" ^
    "vm.call_ptr++;" ^
    "vm.pc = vm.calltable[r1];" ^
    "goto *jumptable[vm.pc];"
 | INPUTSIZE ->
    "vm.pc++;" ^
    "vm.stack[vm.stack_ptr-1] = vm.inputsize[vm.stack[vm.stack_ptr-1]];"
 | INPUTNAME ->
    "vm.pc++;" ^
    "r1 = vm.stack[vm.stack_ptr-1];" ^
    "r2 = vm.stack[vm.stack_ptr-2];" ^
(*    "fprintf(stderr, \"input name %ld %ld\\n\", r1, r2);" ^ *)
    "vm.stack[vm.stack_ptr-2] = vm.inputname[r2][r1];" ^
    "vm.stack_ptr--;"
 | INPUTDATA ->
    "vm.pc++;" ^
    "r1 = vm.stack[vm.stack_ptr-1];" ^
    "r2 = vm.stack[vm.stack_ptr-2];" ^
    "vm.stack[vm.stack_ptr-2] = vm.inputdata[r2][r1];" ^
    "vm.stack_ptr--;"
 | OUTPUTSIZE ->
    "vm.pc++;" ^
    "r1 = vm.stack[vm.stack_ptr-1];" ^
    "r2 = vm.stack[vm.stack_ptr-2];" ^
    "vm.inputdata[r1] = (uint8_t*)malloc(r2*sizeof(uint8_t));" ^
    "vm.inputsize[r1] = r2;" ^
    "vm.stack_ptr -= 2;"
 | OUTPUTNAME ->
    "vm.pc++;" ^
    "r1 = vm.stack[vm.stack_ptr-1];" ^
    "r2 = vm.stack[vm.stack_ptr-2];" ^
    "r3 = vm.stack[vm.stack_ptr-3];" ^
    "vm.inputname[r3][r2] = r1;" ^
    "vm.stack_ptr -= 3;"
 | OUTPUTDATA ->
    "vm.pc++;" ^
    "r1 = vm.stack[vm.stack_ptr-1];" ^
    "r2 = vm.stack[vm.stack_ptr-2];" ^
    "r3 = vm.stack[vm.stack_ptr-3];" ^
    "vm.inputdata[r3][r2] = r1;" ^
    "vm.stack_ptr -= 3;"
 | LOADGLOBAL x ->
    "vm.pc++;" ^
    "vm.stack[vm.stack_ptr] = vm.globals[" ^ string_of_int x ^ "];" ^
    "vm.stack_ptr++;"
 | STOREGLOBAL x ->
    "vm.pc++;" ^
    "vm.globals[" ^ string_of_int x ^ "] = vm.stack[vm.stack_ptr-1];" ^
    "vm.stack_ptr--;"
 | CURMEM -> "vm.pc++; vm.stack[vm.stack_ptr] = vm.memsize; vm.stack_ptr++;"
 | GROW -> "vm.pc++; vm.memsize = vm.stack[vm.stack_ptr--]; vm.stack_ptr--;"
 | LABEL _ -> "assert(0);"
 | RETURN ->
   "vm.call_ptr--;" ^
   "vm.pc = vm.callstack[vm.call_ptr];" ^
   "goto *jumptable[vm.pc+1];"
 | LOAD x ->
   let ty = string_of_int (Byteutil.type_code x.ty) in
   let packing, sign_extend = match x.sz with
    | None -> "0", "0"
    | Some (pack, ext) -> string_of_int (Mbinary.sz_code pack), string_of_int (Mbinary.ext_code ext) in
   "vm.pc++;" ^
   "r1 = vm.stack[vm.stack_ptr-1] + " ^ Int32.to_string x.offset ^ ";" ^
   "r2 = vm.memory[r1 >> 3];" ^
   "r2 = vm.memory[(r1 >> 3) + 1];" ^
   "tmp = toMemory(r2, r3);" ^
   "vm.stack[vm.stack_ptr-1] = load(tmp, r1&0x7, " ^ ty ^ ", " ^ packing ^ ", " ^ sign_extend ^ ");"
 | STORE x ->
   let ty = string_of_int (Byteutil.type_code x.ty) in
   let packing = match x.sz with
    | None -> "0"
    | Some pack -> string_of_int (Mbinary.sz_code pack) in
   "vm.pc++;" ^
   "r1 = vm.stack[vm.stack_ptr-2] + " ^ Int32.to_string x.offset ^ ";" ^
   "r2 = vm.memory[r1 >> 3];" ^
   "r3 = vm.memory[(r1 >> 3) + 1];" ^
   "tmp = toMemory(r2, r3);" ^
   "r2 = vm.stack[vm.stack_ptr-1];" ^
   "r3 = (r1-(r1/8)*8);" ^
   "store(tmp, r3, r2, " ^ ty ^ ", " ^ packing ^ ");" ^
   "vm.memory[r1>>3] = fromMemory1(tmp);" ^
   "vm.memory[(r1>>3) + 1] = fromMemory2(tmp);" ^
   "vm.stack_ptr -= 2;"
 | DROP_N ->
   "vm.pc++;" ^
   "vm.stack_ptr -= vm.stack[vm.stack_ptr-1];"
 | INITCALLTABLE x ->
    "vm.pc++;" ^
    "vm.stack_ptr--;" ^
    "vm.calltable[" ^ string_of_int x ^ "] = vm.stack[vm.stack_ptr];"
 | INITCALLTYPE x ->
    "vm.pc++;" ^
    "vm.stack_ptr--;" ^
    "vm.calltypes[" ^ string_of_int x ^ "] = vm.stack[vm.stack_ptr];"
 | DROP x ->
    "vm.pc++;" ^
    "vm.stack_ptr -= " ^ string_of_int x ^ ";"
 | DUP x ->
    "vm.pc++;" ^
    "vm.stack[vm.stack_ptr] = vm.stack[vm.stack_ptr - " ^ string_of_int x ^ "];" ^
(*    "fprintf(stderr, \"dup %ld\\n\", vm.stack[vm.stack_ptr]);" ^ *)
    "vm.stack_ptr++;"
 | SWAP x ->
    "vm.pc++;" ^
    "vm.stack[vm.stack_ptr - " ^ string_of_int x ^ "] = vm.stack[vm.stack_ptr-1];"
 | PUSH lit ->
    "vm.pc++;" ^
    "vm.stack[vm.stack_ptr] = " ^ string_of_value lit ^ ";" ^
    "vm.stack_ptr++;"
 | CONV op ->
    "vm.pc++;" ^
    "r1 = vm.stack[vm.stack_ptr-1];" ^
(*    make_conv op ^ *)
    "vm.stack[vm.stack_ptr-1] = r2;"
 | TEST op ->
    "vm.pc++;" ^
    "r1 = vm.stack[vm.stack_ptr-1];" ^
    mkop test32 test64 op ^
    "vm.stack[vm.stack_ptr-1] = r2;"
 | UNA op ->
    "vm.pc++;" ^
    "r1 = vm.stack[vm.stack_ptr-1];" ^
    mkop una32 una64 op ^
    "vm.stack[vm.stack_ptr-1] = r2;"
 | CMP op ->
    "vm.pc++;" ^
    "r2 = vm.stack[vm.stack_ptr-1];" ^
    "r1 = vm.stack[vm.stack_ptr-2];" ^
    mkop cmp32 cmp64 op ^
    "vm.stack[vm.stack_ptr-2] = r3;" ^
    "vm.stack_ptr--;"
 | BIN op ->
    "vm.pc++;" ^
    "r2 = vm.stack[vm.stack_ptr-1];" ^
    "r1 = vm.stack[vm.stack_ptr-2];" ^
    mkop bin32 bin64 op ^
    "vm.stack[vm.stack_ptr-2] = r3;" ^
    "vm.stack_ptr--;"
 | _ -> assert false

let compile_with_label labels loc inst =
(*  ( if inst = NOP || Hashtbl.mem labels loc then "label_" ^ string_of_int loc ^ ": " else "") ^  *)
  ( "label_" ^ string_of_int loc ^ ": " ) ^  
  (* fprintf(stderr, \"PC: %ld, stack: %ld\\n\", vm.pc, vm.stack_ptr); " ^ *)
  compile labels inst ^ "\n"

let compile_all code =
  let res = ref [] in
  (* make jump table with all labels *)
  let labels = Hashtbl.create 1000 in
  for i = 0 to Array.length code - 1 do
    (* if code.(i) = NOP || Hashtbl.mem labels i then *)
    res := ("jumptable[" ^ string_of_int i ^ "] = &&label_" ^ string_of_int i ^ ";\n") :: !res
  done;
  for i = 0 to Array.length code - 1 do
    res := compile_with_label labels i code.(i) :: !res
  done;
  String.concat "" (List.rev !res)


