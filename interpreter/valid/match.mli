open Types

(* Equivalence *)

val eq_num_type : num_type -> num_type -> bool
val eq_ref_type : ref_type -> ref_type -> bool
val eq_val_type : val_type -> val_type -> bool

val eq_result_type : result_type -> result_type -> bool

val eq_func_type : func_type -> func_type -> bool
val eq_table_type : table_type -> table_type -> bool
val eq_memory_type : memory_type -> memory_type -> bool
val eq_global_type : global_type -> global_type -> bool

val eq_extern_type : extern_type -> extern_type -> bool

val eq_def_type : def_type -> def_type -> bool

(* Subtyping *)

val match_num_type : num_type -> num_type -> bool
val match_ref_type : ref_type -> ref_type -> bool
val match_val_type : val_type -> val_type -> bool

val match_result_type : result_type -> result_type -> bool

val match_func_type : func_type -> func_type -> bool
val match_table_type : table_type -> table_type -> bool
val match_memory_type : memory_type -> memory_type -> bool
val match_global_type : global_type -> global_type -> bool

val match_extern_type : extern_type -> extern_type -> bool

val match_def_type : def_type -> def_type -> bool
