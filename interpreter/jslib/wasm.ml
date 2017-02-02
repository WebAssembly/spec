let encode s =
  let def = Parse.string_to_module s in
  match def.Source.it with
  | Script.Textual m -> Encode.encode m
  | Script.Encoded (_, bs) -> bs

let decode s width =
  let m = Decode.decode "(decode)" s in
  Sexpr.to_string width (Arrange.module_ m)
