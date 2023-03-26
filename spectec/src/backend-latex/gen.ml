let gen_string el =
  Render.render_script Config.latex el

let gen_file file el =
  let latex = gen_string el in
  let oc = Out_channel.open_text file in
  Fun.protect (fun () -> Out_channel.output_string oc latex)
    ~finally:(fun () -> Out_channel.close oc)
