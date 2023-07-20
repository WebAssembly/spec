open Splice

module Map = Map.Make(String)

(* Macro Generation *)

let gen_macro env =
  let s = Backend_prose.Render.render_macro (env_render_prose env) in
  let oc = Out_channel.open_text "macros.def" in
  Fun.protect (fun () -> Out_channel.output_string oc s) 
    ~finally:(fun () -> Out_channel.close oc)
