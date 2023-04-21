type num = I32 of int

type value = num

type binop = Add | Sub | Mul | DivS | DivU | RemS | RemU
           | And | Or | Xor | Shl | ShrS | ShrU | Rotl | Rotr
type testop = Eqz

type instr = 
  | Const of num                      (* constant *)
  | Test of testop                    (* numeric test *)
  | Binary of binop                   (* binary numeric operator *)
