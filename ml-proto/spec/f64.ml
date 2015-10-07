include Float.Make(struct
                     include Int64
                     let nondeterministic_nan = 0x7fff0f0f0f0f0f0fL
                     let bare_nan = 0x7ff0000000000000L
                     let print_nan_significand_digits a =
                       Printf.sprintf "%Lx" (abs (Int64.logxor bare_nan a))
                   end)
