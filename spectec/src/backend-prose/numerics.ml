open Al

type numerics = { name: string; f: value list -> value }

let binop: numerics = {
  name = "binop";
  f = function
    | [StringV "Add"; _; IntV i1; IntV i2] ->
        let result = i1 + i2 in
        ListV [| IntV result |]
    | _ -> failwith "Invalid binop"
}

let testop: numerics = {
  name = "testop";
  f = function
    | [StringV "Eqz"; _; IntV i] ->
        let result = i = 0 |> Bool.to_int in
        IntV result
    | _ -> failwith "Invalid testop"
}

let relop: numerics = {
  name = "relop";
  f = function
    | [StringV "Gt"; _; FloatV f1; FloatV f2] ->
        let result = f1 > f2 |> Bool.to_int in
        IntV result
    | [StringV "GtS"; _; IntV i1; IntV i2] ->
        let result = i1 > i2 |> Bool.to_int in
        IntV result
    | _ -> failwith "Invalid relop"
}

let numerics_list: numerics list = [ binop; testop; relop ]

let call_numerics fname args =
  let numerics =
    List.find (fun numerics -> numerics.name = fname) numerics_list in
  numerics.f args

let mem name = List.exists (fun numerics -> numerics.name = name) numerics_list
