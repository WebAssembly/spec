(* Identifier Status *)

module Set = Set.Make(String)

let vars = ref Set.empty
let scopes = ref []

let is_var x = Set.mem x !vars
let make_var x = vars := Set.add x !vars

let enter_scope () = scopes := !vars :: !scopes
let exit_scope () = vars := List.hd !scopes; scopes := List.tl !scopes

let reset () = vars := Set.empty; scopes := []
