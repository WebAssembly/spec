
open Byteutil

(* read from merkle tree of any shape *)

(* each file/merkle root has chunks *)

type file = (bytes, bytes) Hashtbl.t

let chunks : (bytes, bytes) Hashtbl.t = Hashtbl.create 1000

let a1 = bytes_from_hex "ec4101639edb093ea5f5094092f33257ad58fa5d46346fadb3df39b9bca4ff18"
let a2 = bytes_from_hex "2121bef9f25785ef4916966349a7398d65ff76c71c6f87267c8182b5f11e490e"
let a3 = bytes_from_hex "290decd9548b62a8d60345a988386fc84ba6bc95484008f6362f93160ef3e563"

let empty = Bytes.make 0 '\000'

let _ =
  Hashtbl.add chunks a1 (Bytes.concat empty [Bytes.of_string "asd"; a2; Bytes.of_string "klklk"]);
  Hashtbl.add chunks a2 (Bytes.concat empty [Bytes.of_string "test"; a3; Bytes.of_string "stuff"]);
  Hashtbl.add chunks a3 (Bytes.make 32 '\000')

let rec read_file id lst =
  match lst with
  | (start, stop) :: lst ->
     ( try
       let chunk = Hashtbl.find chunks id in
       prerr_endline ("chunk " ^ w256_to_string (Bytes.to_string id) ^ " is " ^ String.escaped (Bytes.to_string chunk));
       let id = Bytes.sub chunk start 32 in
       read_file id lst
     with Not_found -> ( prerr_endline ("Cannot find chunk " ^ w256_to_string (Bytes.to_string id)) ; Bytes.make 32 '\000' ) )
  | [] -> id

let rec normalize prefix_length = function
  | (start, stop) :: lst -> (start-prefix_length, stop-prefix_length) :: normalize (prefix_length+stop) lst
  | [] -> []

let rec pairify = function
 | a::b::lst -> (a,b) :: pairify lst
 | _ -> []

(* Parse the file *)
let do_read dta =
  let id = Bytes.sub dta 0 32 in
  prerr_endline ("My id is " ^ w256_to_string (Bytes.to_string id));
  prerr_endline ("My dta is " ^ String.escaped (Bytes.to_string dta));
  let rec read idx =
     if idx+32 > Bytes.length dta then [] else
     let v = bytes32_to_int (Bytes.sub dta idx 32) in
     prerr_endline ("reading " ^ string_of_int v);
     v :: read (idx+32) in
  read_file id (List.rev (normalize 0 (pairify (read 32))))

