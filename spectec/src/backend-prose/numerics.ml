open Al

type numerics = { name : string; f : value list -> value }

let wrap_int_unop op i = match i with
  | IntV i -> let result = op i in ListV [| IntV result |]
  | _ -> failwith "Operand of this unop should be FloatV"
let wrap_float_unop op f = match f with
  | FloatV f -> let result = op f in ListV [| FloatV result |]
  | _ -> failwith "Operand of this unop should be FloatV"
let unop: numerics =
  {
    name = "unop";
    f =
      (function
      | [ op; t; v ] -> (
        match t with
        | WasmTypeV (NumType (I32Type)) -> (
          match op with
          | StringV "Clz" -> wrap_int_unop (fun _ -> failwith "TODO: Clz") v
          | StringV "Ctz" -> wrap_int_unop (fun _ -> failwith "TODO: Ctz") v
          | StringV "Popcnt" -> wrap_int_unop (fun _ -> failwith "TODO: Popcnt") v
          | _ -> failwith ("Invalid unop: " ^ (Print.string_of_value op)))
        | WasmTypeV (NumType (F32Type)) -> (
          match op with
          | StringV "Neg" -> wrap_float_unop (Float.neg) v
          | StringV "Abs" -> wrap_float_unop (Float.abs) v
          | StringV "Ceil" -> wrap_float_unop (Float.ceil) v
          | StringV "Floor" -> wrap_float_unop (Float.floor) v
          (* TODO should Trunc and Nearest return an integer value? *)
          | StringV "Trunc" -> wrap_float_unop (Float.trunc) v
          | StringV "Nearest" -> wrap_float_unop (Float.round) v
          | StringV "Sqrt" -> wrap_float_unop (Float.sqrt) v
          | _ -> failwith ("Invalid unop: " ^ (Print.string_of_value op)))
        | _ -> failwith "Invalid unop")
      | StringV op :: _ -> failwith ("Invalid unop: " ^ op)
      | _ -> failwith "Invalid unop")
  }

let wrap_int_binop i1 op i2 = match i1, i2 with
  | IntV i1, IntV i2 -> let result = op i1 i2 in ListV [| IntV result |]
  | _ -> failwith "Operand of this binop should be IntV"
let wrap_float_binop f1 op f2 = match f1, f2 with
  | FloatV f1, FloatV f2 -> let result = op f1 f2 in ListV [| FloatV result |]
  | _ -> failwith "Operand of this binop should be FloatV"
let binop : numerics =
  {
    name = "binop";
    f =
      (function
      | [ op; t; v1; v2 ] -> (
        match t with
        | WasmTypeV (NumType I32Type) -> (
          match op with
          | StringV "Add" -> wrap_int_binop v1 (+) v2
          | StringV "Sub" -> wrap_int_binop v1 (-) v2
          | StringV "Mul"  -> wrap_int_binop v1 ( * ) v2
          | StringV "DivS"
          | StringV "DivU" -> wrap_int_binop v1 (/) v2
          | StringV "RemS"
          | StringV "RemU" -> wrap_int_binop v1 (mod) v2
          | StringV "And"  -> wrap_int_binop v1 (land) v2
          | StringV "Or"   -> wrap_int_binop v1 (lor) v2
          | StringV "Xor"  -> wrap_int_binop v1 (lxor) v2
          | StringV "Shl"  -> wrap_int_binop v1 (lsl) v2
          | StringV "ShrS" -> wrap_int_binop v1 (asr) v2
          | StringV "ShrU" -> wrap_int_binop v1 (lsr) v2
          | StringV "Rotl" -> wrap_int_binop v1 (fun _ _ -> failwith "TODO: Rotl") v2
          | StringV "Rotr" -> wrap_int_binop v1 (fun _ _ -> failwith "TODO: Rotr") v2
          | _ -> failwith ("Invalid binop: " ^ (Print.string_of_value op)))
        | WasmTypeV (NumType F32Type) -> (
          match op with
          | StringV "Add" -> wrap_float_binop v1 (+.) v2 
          | StringV "Sub" -> wrap_float_binop v1 (-.) v2
          | StringV "Mul" -> wrap_float_binop v1 ( *. ) v2
          | StringV "Div" -> wrap_float_binop v1 (/.) v2
          | StringV "Min" -> wrap_float_binop v1 (Float.min) v2
          | StringV "Max" -> wrap_float_binop v1 (Float.max) v2
          | StringV "CopySign" -> wrap_float_binop v1 (fun _ _ -> failwith "TODO: CopySign") v2
          | _ -> failwith ("Invalid binop: " ^ (Print.string_of_value op)))
        | _ -> failwith "Invalid binop")
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
      | [ op; t; v1; v2 ] -> (
        match t with
        | WasmTypeV (NumType I32Type) -> (
          match op with
          | StringV "Eq" -> wrap_int_relop v1 (=) v2
          | StringV "Ne" -> wrap_int_relop v1 (<>) v2
          | StringV "LtS"
          | StringV "LtU" -> wrap_int_relop v1 (<) v2
          | StringV "LeS"
          | StringV "LeU" -> wrap_int_relop v1 (<=) v2
          | StringV "GtS"
          | StringV "GtU" -> wrap_int_relop v1 (>) v2
          | StringV "GeS"
          | StringV "GeU" -> wrap_int_relop v1 (>=) v2
          | _ -> failwith ("Invalid relop: " ^ (Print.string_of_value op)))
        | WasmTypeV (NumType F32Type) -> (
          match op with
          | StringV "Eq" -> wrap_float_relop v1 (=) v2 
          | StringV "Ne" -> wrap_float_relop v1 (<>) v2
          | StringV "Lt" -> wrap_float_relop v1 (<) v2
          | StringV "Gt" -> wrap_float_relop v1 (>) v2
          | StringV "Le" -> wrap_float_relop v1 (<=) v2
          | StringV "Ge" -> wrap_float_relop v1 (>=) v2
          | _ -> failwith ("Invalid relop: " ^ (Print.string_of_value op)))
        | _ -> failwith "Invalid relop")
      | StringV op :: _ -> failwith ("Invalid relop: " ^ op)
      | _ -> failwith "Invalid relop");
  }

let bytes_ : numerics =
  {
    name = "bytes_";
    f =
      (function
      | [ IntV n; IntV i ] ->
          let rec decompose n i =
            if n = 0 then
              []
            else
              (i mod 256) :: decompose (n-1) (n / 256)
            in
          ListV (decompose n i |> List.map (fun x -> IntV x) |> Array.of_list)
      | [ IntV _; FloatV _ ] -> failwith "TODO: bytes of floats"
      | _ -> failwith "Invalid bytes"
      );
  }
let inverse_of_bytes_ : numerics =
  {
    name = "inverse_of_bytes_";
    f =
      (function
      | [ IntV n; ListV bs] ->
          assert (n = Array.length bs);
          IntV (Array.fold_right (fun b acc ->
            match b with
            | IntV b when 0 <= b && b < 256 -> b + 255 * acc
            | _ -> failwith "Invalid inverse_of_bytes"
          ) bs 0)
      | _ -> failwith "Invalid inverse_of_bytes"
      );
  }

let wrap_ : numerics =
  {
    name = "wrap_";
    f =
      (function
      | [ ListV [| IntV _; IntV n |]; IntV i ] ->
          IntV (
            let mask = (1 lsl n) - 1 in
            i land mask
          )
      | _ -> failwith "Invalid wrap_"
      );
  }

let numerics_list : numerics list = [ unop; binop; testop; relop; bytes_; inverse_of_bytes_; wrap_ ]

let call_numerics fname args =
  let numerics =
    List.find (fun numerics -> numerics.name = fname) numerics_list
  in
  numerics.f args

let mem name = List.exists (fun numerics -> numerics.name = name) numerics_list
