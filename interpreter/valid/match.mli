open Types


(* Extremas *)

val top_of_heap_type : heap_type -> heap_type
val bot_of_heap_type : heap_type -> heap_type
val top_of_str_type : str_type -> heap_type
val bot_of_str_type : str_type -> heap_type


(* Equivalence *)

val eq_num_type : num_type -> num_type -> bool
val eq_ref_type : ref_type -> ref_type -> bool
val eq_val_type : val_type -> val_type -> bool

val eq_result_type : result_type -> result_type -> bool

val eq_str_type : str_type -> str_type -> bool
val eq_sub_type : sub_type -> sub_type -> bool
val eq_rec_type : rec_type -> rec_type -> bool
val eq_def_type : def_type -> def_type -> bool

val eq_func_type : func_type -> func_type -> bool
val eq_table_type : table_type -> table_type -> bool
val eq_memory_type : memory_type -> memory_type -> bool
val eq_global_type : global_type -> global_type -> bool

val eq_extern_type : extern_type -> extern_type -> bool


(* Subtyping *)

type rec_context = heap_type list list

val match_num_type : rec_context -> num_type -> num_type -> bool
val match_ref_type : rec_context -> ref_type -> ref_type -> bool
val match_val_type : rec_context -> val_type -> val_type -> bool

val match_result_type : rec_context -> result_type -> result_type -> bool

val match_str_type : rec_context -> str_type -> str_type -> bool
val match_def_type : rec_context -> def_type -> def_type -> bool

val match_func_type : rec_context -> func_type -> func_type -> bool

val match_table_type : table_type -> table_type -> bool
val match_memory_type : memory_type -> memory_type -> bool
val match_global_type : global_type -> global_type -> bool

val match_extern_type : extern_type -> extern_type -> bool
