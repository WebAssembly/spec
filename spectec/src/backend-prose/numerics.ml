open Al

type numerics = { name : string; f : value list -> value }

let wrap_int_binop i1 op i2 = match i1, i2 with
  | IntV i1, IntV i2 -> let result = op i1 i2 in ListV [| IntV result |]
  | _ -> failwith "Operand of this binop should be IntV"
let binop : numerics =
  {
    name = "binop";
    f =
      (function
      | [ StringV "Add"; _; i1; i2 ]  -> wrap_int_binop i1 (+) i2
      | [ StringV "Sub"; _; i1; i2 ]  -> wrap_int_binop i1 (-) i2
      | [ StringV "Mul"; _; i1; i2 ]  -> wrap_int_binop i1 ( * ) i2
      | [ StringV "DivS"; _; i1; i2 ] -> wrap_int_binop i1 (/) i2
      | [ StringV "DivU"; _; i1; i2 ] -> wrap_int_binop i1 (/) i2
      | [ StringV "RemS"; _; i1; i2 ] -> wrap_int_binop i1 (mod) i2
      | [ StringV "RemU"; _; i1; i2 ] -> wrap_int_binop i1 (mod) i2
      | [ StringV "And"; _; i1; i2 ]  -> wrap_int_binop i1 (land) i2
      | [ StringV "Or"; _; i1; i2 ]   -> wrap_int_binop i1 (lor) i2
      | [ StringV "Xor"; _; i1; i2 ]  -> wrap_int_binop i1 (lxor) i2
      | [ StringV "Shl"; _; i1; i2 ]  -> wrap_int_binop i1 (lsl) i2
      | [ StringV "ShrS"; _; i1; i2 ] -> wrap_int_binop i1 (asr) i2
      | [ StringV "ShrU"; _; i1; i2 ] -> wrap_int_binop i1 (lsr) i2
      | [ StringV "Rotl"; _; i1; i2 ] -> wrap_int_binop i1 (fun _ _ -> failwith "TODO: Rotl") i2
      | [ StringV "Rotr"; _; i1; i2 ] -> wrap_int_binop i1 (fun _ _ -> failwith "TODO: Rotr") i2
      | StringV op :: _ -> failwith ("Invalid binop: " ^ op)
      | _ -> failwith "Invalid binop");
  }

let testop : numerics =
  {
    name = "testop";
    f =
      (function
      | [ StringV "Eqz"; _; IntV i ] ->
          let result = i = 0 |> Bool.to_int in
          IntV result
      | _ -> failwith "Invalid testop");
  }

let wrap_int_relop i1 op i2 = match i1, i2 with
  | IntV i1, IntV i2 -> let result = op i1 i2 |> Bool.to_int in IntV result
  | _ -> failwith "Operand of this relop should be IntV"
let wrap_float_relop f1 op f2 = match f1, f2 with
  |  FloatV f1, FloatV f2 -> let result = op f1 f2 |> Bool.to_int in IntV result
  | _ -> failwith "Operand of this relop should be FloatV"
let relop : numerics =
  {
    name = "relop";
    f =
      (function
      (* TODO: difference b/w S and U? *)
      | [ StringV "LtS"; _; i1; i2 ]
      | [ StringV "LtU"; _; i1; i2 ] -> wrap_int_relop i1 (<) i2
      | [ StringV "LeS"; _; i1; i2 ]
      | [ StringV "LeU"; _; i1; i2 ] -> wrap_int_relop i1 (<=) i2
      | [ StringV "GtS"; _; i1; i2 ]
      | [ StringV "GtU"; _; i1; i2 ] -> wrap_int_relop i1 (>) i2
      | [ StringV "GeS"; _; i1; i2 ]
      | [ StringV "GeU"; _; i1; i2 ] -> wrap_int_relop i1 (>=) i2
      | [ StringV "Lt"; _; f1; f2 ] -> wrap_float_relop f1 (<) f2
      | [ StringV "Le"; _; f1; f2 ] -> wrap_float_relop f1 (<=) f2
      | [ StringV "Gt"; _; f1; f2 ] -> wrap_float_relop f1 (>) f2
      | [ StringV "Ge"; _; f1; f2 ] -> wrap_float_relop f1 (>=) f2
      | StringV op :: _ -> failwith ("Invalid relop: " ^ op)
      | _ -> failwith "Invalid relop");
  }

let numerics_list : numerics list = [ binop; testop; relop ]

let call_numerics fname args =
  let numerics =
    List.find (fun numerics -> numerics.name = fname) numerics_list
  in
  numerics.f args

let mem name = List.exists (fun numerics -> numerics.name = name) numerics_list
