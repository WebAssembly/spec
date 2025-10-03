type sx = S | U
type packsize = Pack8 | Pack16 | Pack32 | Pack64
type packshape = Pack8x8 | Pack16x4 | Pack32x2
type vext =
  | ExtLane of packshape * sx
  | ExtSplat
  | ExtZero

let packed_size = function
  | Pack8 -> 1
  | Pack16 -> 2
  | Pack32 -> 4
  | Pack64 -> 8

let packed_shape_size = function
  | Pack8x8 | Pack16x4 | Pack32x2 -> 8
