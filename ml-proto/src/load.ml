let load file =
  let f = open_in file in
  let size = in_channel_length f + 1 in
  let buf = bytes_create size in
  let rec loop () =
    let len = input f buf 0 size in
    let source = Bytes.sub_string 0 len in
    if len < size then source else source ^ loop ()
  in loop ();
  close_in f;
  source
