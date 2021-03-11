open Types

type context = def_type list
type assump = (var * var) list


(* Equivalence *)

val eq_num_type : context -> assump -> num_type -> num_type -> bool
val eq_ref_type : context -> assump -> ref_type -> ref_type -> bool
val eq_value_type : context -> assump -> value_type -> value_type -> bool

val eq_result_type : context -> assump -> result_type -> result_type -> bool

val eq_func_type : context -> assump -> func_type -> func_type -> bool
val eq_table_type : context -> assump -> table_type -> table_type -> bool
val eq_memory_type : context -> assump -> memory_type -> memory_type -> bool
val eq_global_type : context -> assump -> global_type -> global_type -> bool

val eq_extern_type : context -> assump -> extern_type -> extern_type -> bool

val eq_def_type : context -> assump -> def_type -> def_type -> bool


(* Subtyping *)

val match_num_type : context -> assump -> num_type -> num_type -> bool
val match_ref_type : context -> assump -> ref_type -> ref_type -> bool
val match_value_type : context -> assump -> value_type -> value_type -> bool

val match_result_type : context -> assump -> result_type -> result_type -> bool

val match_func_type : context -> assump -> func_type -> func_type -> bool
val match_table_type : context -> assump -> table_type -> table_type -> bool
val match_memory_type : context -> assump -> memory_type -> memory_type -> bool
val match_global_type : context -> assump -> global_type -> global_type -> bool

val match_extern_type : context -> assump -> extern_type -> extern_type -> bool

val match_def_type : context -> assump -> def_type -> def_type -> bool
