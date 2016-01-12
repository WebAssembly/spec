include Float.Make(struct
                     include Int64
                     let default_nan = 0x7ff8000000000000L
                     let alternate_nan = 0xfff8000000000000L
                     let bare_nan = 0x7ff0000000000000L
                     let print_nan_significand_digits a =
                       Printf.sprintf "%Lx" (abs (Int64.logxor bare_nan a))
                   end)
