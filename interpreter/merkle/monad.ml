
module type SIG = sig

type 'a t

val pass : 'a -> 'a t

val read : int -> char t
val write : int -> char -> unit t

val (>>=) : 'a t -> ('a -> 'b t) -> 'b t

end

module Offchain : SIG = struct

(* this is the data... *)
type mem = bytes

type 'a t = mem -> 'a * mem

let pass x mem = (x, mem)

let read n mem = (Bytes.get mem n, mem)

let write n x mem =
  let nmem = Bytes.copy mem in
  Bytes.set nmem n x;
  ((), nmem)

let (>>=) f g mem =
  let a, mem1 = f mem in
  g a mem1

end

module OnchainNoCheck : SIG = struct

type mem = bytes

type 'a t =
 | Return of 'a
 | Stuck of (char -> 'a t)

let pass x = Return x

let read n = Stuck (fun b -> Return b)

let write n x = Return ()

let rec (>>=) f g =
  match f with
  | Return x -> g x
  | Stuck f -> Stuck (fun b ->
    match f b with
    | Return x -> g x
    | Stuck ff -> Stuck ff >>= g)

end

module type PROOF = sig

  type t
  
  val read : int -> bytes -> t
  val write : int -> char -> bytes -> t

end

module OffchainProof (Proof : PROOF) : SIG = struct

type mem = {
  data : bytes;
  steps : int;
  proof : int -> Proof.t option;
}

type 'a t = mem -> 'a * mem

let pass x mem = (x, mem)

let read n mem =
  let add_proof x = if x = mem.steps then Some (Proof.read n mem.data) else mem.proof x in
  (Bytes.get mem.data n, {mem with steps=mem.steps+1; proof=add_proof})

let write n v mem =
  let add_proof x = if x = mem.steps then Some (Proof.write n v mem.data) else mem.proof x in
  let ndata = Bytes.copy mem.data in
  Bytes.set ndata n v;
  ((), {data=ndata; steps=mem.steps+1; proof=add_proof})

let (>>=) f g mem =
  let a, mem1 = f mem in
  g a mem1

end

(* Using the proofs *)


(* Analysis: how to make it more realistic *)


