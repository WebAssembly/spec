let gen_string cfg el =
  let env = Render.env cfg el
    |> Render.with_syntax_decoration true
    |> Render.with_grammar_decoration true
    |> Render.with_rule_decoration true
  in Render.render_script env el

let gen_file cfg file el =
  let latex = gen_string cfg el in
  let oc = Out_channel.open_text file in
  Fun.protect (fun () -> Out_channel.output_string oc latex)
    ~finally:(fun () -> Out_channel.close oc)
