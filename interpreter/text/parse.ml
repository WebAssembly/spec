exception Syntax = Parse_error.Syntax

module type S =
sig
  type t
  val parse : string -> Lexing.lexbuf -> t
  val parse_file : string -> t
  val parse_string : ?offset:Source.region -> string -> t
  val parse_channel : in_channel -> t
end

let wrap_lexbuf lexbuf =
  let open Lexing in
  let inner_refill = lexbuf.refill_buff in
  let refill_buff lexbuf =
    let oldlen = lexbuf.lex_buffer_len - lexbuf.lex_start_pos in
    inner_refill lexbuf;
    let newlen = lexbuf.lex_buffer_len - lexbuf.lex_start_pos in
    let start = lexbuf.lex_start_pos + oldlen in
    let n = newlen - oldlen in
    Annot.extend_source (Bytes.sub_string lexbuf.lex_buffer start n)
  in
  let n = lexbuf.lex_buffer_len - lexbuf.lex_start_pos in
  Annot.extend_source (Bytes.sub_string lexbuf.lex_buffer lexbuf.lex_start_pos n);
  {lexbuf with refill_buff}

let convert_pos lexbuf =
  { Source.left = Lexer.convert_pos lexbuf.Lexing.lex_start_p;
    Source.right = Lexer.convert_pos lexbuf.Lexing.lex_curr_p
  }

let make (type a) (start : _ -> _ -> a) : (module S with type t = a) =
  (module struct
    type t = a

    let parse name lexbuf =
      Annot.reset ();
      Lexing.set_filename lexbuf name;
      let lexbuf = wrap_lexbuf lexbuf in
      let result =
        try start Lexer.token lexbuf with Parser.Error ->
          raise (Syntax (convert_pos lexbuf, "unexpected token"))
      in
      let annots = Annot.get_all () in
      if not (Annot.NameMap.is_empty annots) then
        let annot = List.hd (snd (Annot.NameMap.choose annots)) in
        raise (Custom.Syntax (annot.Source.at, "misplaced annotation"))
      else
        result

    let parse_string ?offset s =
      let open Source in
      let name, s' =
        match offset with
        | None -> "string", s
        | Some at ->
          (* Note: this is a hack that only works for singular string literals
           * with no escapes in them.
           * TODO: Figure out why we need to add 2 instead of 1 to column. *)
          at.left.file,
          String.make (max 0 (at.left.line - 1)) '\n' ^
          String.make (at.left.column + 2) ' ' ^ s
      in parse name (Lexing.from_string ~with_positions:true s')

    let parse_channel oc =
      parse "channel" (Lexing.from_channel ~with_positions:true oc)

    let parse_file name =
      let oc = open_in name in
      Fun.protect ~finally:(fun () -> close_in oc) (fun () ->
        parse name (Lexing.from_channel ~with_positions:true oc)
      )
  end)

module Module = (val make Parser.module1)
module Script = (val make Parser.script)
module Script1 = (val make Parser.script1)
