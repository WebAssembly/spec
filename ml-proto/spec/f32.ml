include Float.Make(struct
                     include Int32
                     let nondeterministic_nan = 0x7fc0f0f0l
                     let bare_nan = 0x7f800000l
                     let print_nan_significand_digits a =
                       Printf.sprintf "%lx" (abs (Int32.logxor bare_nan a))
                   end)
