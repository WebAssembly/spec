(* Implements a wrapper library that allows the use of the reference
 * interpreter's encode/decode functionality in JavaScript.
 *)
open Js_of_ocaml

let _ =
  Js.export "WebAssemblyText"
    (object%js (_self)

      method encode (s : Js.js_string Js.t) : (Typed_array.arrayBuffer Js.t) =
        let def = Parse.string_to_definition (Js.to_string s) in
        let bs =
          match def.Source.it with
          | Script.Textual m -> Encode.encode m
          | Script.Encoded (_, bs) -> bs
          | Script.Quoted (_, _) -> failwith "Unsupported" in
        let buf = new%js Typed_array.arrayBuffer (String.length bs) in
        let u8arr = new%js Typed_array.uint8Array_fromBuffer buf in
        String.iteri (fun i c -> Typed_array.set u8arr i (int_of_char c)) bs; buf

      method decode (buf : Typed_array.arrayBuffer Js.t) width : (Js.js_string Js.t) =
        let s = Typed_array.String.of_uint8Array (new%js Typed_array.uint8Array_fromBuffer buf) in
        let m = Decode.decode "(decode)" s in
        Js.string (Sexpr.to_string width (Arrange.module_ m))

    end)
