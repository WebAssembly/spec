type numerics = { name: string; f: Al.value list -> Al.value }

let testop: numerics = {
  name = "testop";
  f = function
    | [Al.StringV "Eqz"; _; Al.IntV i] ->
        let result = i = 0 |> Bool.to_int in
        Al.IntV result
    | _ -> failwith "Invalid testop"
}

let relop: numerics = {
  name = "relop";
  f = function
    | [Al.StringV "Gt"; _; Al.FloatV f1; Al.FloatV f2] ->
        let result = f1 > f2 |> Bool.to_int in
        Al.IntV result
    | [Al.StringV "GtS"; _; Al.IntV i1; Al.IntV i2] ->
        let result = i1 > i2 |> Bool.to_int in
        Al.IntV result
    | _ -> failwith "Invalid relop"
}

let numerics_list: numerics list = [ testop; relop ]

let call_numerics fname args =
  let numerics =
    List.find (fun numerics -> numerics.name = fname) numerics_list in
  numerics.f args

let mem name = List.exists (fun numerics -> numerics.name = name) numerics_list
