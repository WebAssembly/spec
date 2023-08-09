module Make () =
struct
  exception Error of Source.region * string

  let warn at m = prerr_endline (Source.string_of_region at ^ ": warning: " ^ m)
  let error at m = raise (Error (at, m))
end

