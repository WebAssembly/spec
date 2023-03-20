module Set : Set.S with type elt = int

type vert = int array
type graph = vert array

val sccs : graph -> Set.t list
