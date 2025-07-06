open Types


(* Context *)

type context = deftype list


(* Extremas *)

val top_of_valtype : context -> valtype -> valtype
val top_of_heaptype : context -> heaptype -> heaptype
val bot_of_heaptype : context -> heaptype -> heaptype
val top_of_comptype : context -> comptype -> heaptype
val bot_of_comptype : context -> comptype -> heaptype


(* Subtyping *)

val match_numtype : context -> numtype -> numtype -> bool
val match_reftype : context -> reftype -> reftype -> bool
val match_valtype : context -> valtype -> valtype -> bool

val match_resulttype : context -> resulttype -> resulttype -> bool

val match_storagetype : context -> storagetype -> storagetype -> bool

val match_comptype : context -> comptype -> comptype -> bool
val match_deftype : context -> deftype -> deftype -> bool

val match_functype : context -> functype -> functype -> bool

val match_tabletype : context -> tabletype -> tabletype -> bool
val match_memorytype : context -> memorytype -> memorytype -> bool
val match_globaltype : context -> globaltype -> globaltype -> bool

val match_externtype : context -> externtype -> externtype -> bool
