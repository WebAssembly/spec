let gen_string _il al =
  List.fold_left
    (fun acc algo -> acc ^ "\n" ^ Backend_interpreter.Print.string_of_algorithm algo)
    "" al
