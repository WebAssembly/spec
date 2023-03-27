open Types

type context = ctx_type list

(* Extremas *)

val top_of_heap_type : context -> heap_type -> heap_type
val bot_of_heap_type : context -> heap_type -> heap_type
val top_of_str_type : context -> str_type -> heap_type
val bot_of_str_type : context -> str_type -> heap_type

(* Equivalence *)

val eq_num_type : context -> num_type -> num_type -> bool
val eq_ref_type : context -> ref_type -> ref_type -> bool
val eq_val_type : context -> val_type -> val_type -> bool

val eq_result_type : context -> result_type -> result_type -> bool

val eq_func_type : context -> func_type -> func_type -> bool
val eq_table_type : context -> table_type -> table_type -> bool
val eq_memory_type : context -> memory_type -> memory_type -> bool
val eq_global_type : context -> global_type -> global_type -> bool

val eq_extern_type : context -> extern_type -> extern_type -> bool

val eq_str_type : context -> str_type -> str_type -> bool
val eq_sub_type : context -> sub_type -> sub_type -> bool
val eq_def_type : context -> def_type -> def_type -> bool
val eq_ctx_type : context -> ctx_type -> ctx_type -> bool
val eq_var_type : context -> var -> var -> bool

(* Subtyping *)

val match_num_type : context -> num_type -> num_type -> bool
val match_ref_type : context -> ref_type -> ref_type -> bool
val match_val_type : context -> val_type -> val_type -> bool

val match_result_type : context -> result_type -> result_type -> bool

val match_func_type : context -> func_type -> func_type -> bool
val match_table_type : context -> table_type -> table_type -> bool
val match_memory_type : context -> memory_type -> memory_type -> bool
val match_global_type : context -> global_type -> global_type -> bool

val match_extern_type : context -> extern_type -> extern_type -> bool

val match_storage_type : context -> storage_type -> storage_type -> bool
val match_str_type : context -> str_type -> str_type -> bool
val match_var_type : context -> var -> var -> bool
