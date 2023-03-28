let gen_string ?(decorated = true) el =
  let env = Render.env Config.latex el
    |> Render.with_syntax_decoration decorated
    |> Render.with_rule_decoration decorated
  in Render.render_script env el

let gen_file ?(decorated = true) file el =
  let latex = gen_string ~decorated el in
  let oc = Out_channel.open_text file in
  Fun.protect (fun () -> Out_channel.output_string oc latex)
    ~finally:(fun () -> Out_channel.close oc)
