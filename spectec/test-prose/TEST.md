# Preview

```sh
$ (cd ../spec && dune exec ../src/exe-watsup/main.exe -- *.watsup -v -l --totalize --sideconditions --animate --prose)
watsup 0.3 generator
== Parsing...
== Elaboration...
== IL Validation...
== Function totalization...
== IL Validation...
== Side condition inference
== IL Validation...
== Animate
Animation failed:if ($bytes_(!($size(nt <: valtype)), c) = $mem(z, 0)[(i + n_O) : (!($size(nt <: valtype)) / 8)])
Animation failed:where $bytes_(!($size(nt <: valtype)), c) := $mem(z, 0)[(i + n_O) : (!($size(nt <: valtype)) / 8)]
Animation failed:if ($bytes_(n, c) = $mem(z, 0)[(i + n_O) : (n / 8)])
Animation failed:where $bytes_(n, c) := $mem(z, 0)[(i + n_O) : (n / 8)]
== IL Validation...
== Prose Generation...
/Users/yundongjun/PLRG/spectec/spectec/_build/default/spec/../src/exe-watsup/main.exe: uncaught exception Failure("Invalid premise `where b*{b} := $bytes_(!($size(nt <: valtype)), c)` to be IR condition.")
Raised at Stdlib.failwith in file "stdlib.ml", line 29, characters 17-33
Called from Backend_prose__Il2ir.prem2cond in file "src/backend-prose/il2ir.ml", line 289, characters 60-71
Called from Backend_prose__Il2ir.reduction_group2algo.(fun) in file "src/backend-prose/il2ir.ml", line 328, characters 23-38
Called from Stdlib__List.map in file "list.ml", line 92, characters 20-23
Called from Stdlib__List.map in file "list.ml", line 92, characters 32-39
Called from Backend_prose__Il2ir.reduction_group2algo in file "src/backend-prose/il2ir.ml", line 325, characters 8-295
Called from Stdlib__List.fold_right in file "list.ml", line 126, characters 16-37
Called from Stdlib__List.fold_right in file "list.ml", line 126, characters 16-37
Called from Stdlib__List.fold_right in file "list.ml", line 126, characters 16-37
Called from Stdlib__List.fold_right in file "list.ml", line 126, characters 16-37
Called from Stdlib__List.fold_right in file "list.ml", line 126, characters 16-37
Called from Stdlib__List.fold_right in file "list.ml", line 126, characters 16-37
Called from Stdlib__List.fold_right in file "list.ml", line 126, characters 16-37
Called from Stdlib__List.fold_right in file "list.ml", line 126, characters 16-37
Called from Stdlib__List.fold_right in file "list.ml", line 126, characters 16-37
Called from Stdlib__List.fold_right in file "list.ml", line 126, characters 16-37
Called from Stdlib__List.fold_right in file "list.ml", line 126, characters 16-37
Called from Stdlib__List.fold_right in file "list.ml", line 126, characters 16-37
Called from Stdlib__List.fold_right in file "list.ml", line 126, characters 16-37
Called from Stdlib__List.fold_right in file "list.ml", line 126, characters 16-37
Called from Stdlib__List.fold_right in file "list.ml", line 126, characters 16-37
Called from Stdlib__List.fold_right in file "list.ml", line 126, characters 16-37
Called from Stdlib__List.fold_right in file "list.ml", line 126, characters 16-37
Called from Stdlib__List.fold_right in file "list.ml", line 126, characters 16-37
Called from Stdlib__List.fold_right in file "list.ml", line 126, characters 16-37
Called from Stdlib__List.fold_right in file "list.ml", line 126, characters 16-37
Called from Stdlib__List.fold_right in file "list.ml", line 126, characters 16-37
Called from Stdlib__List.fold_right in file "list.ml", line 126, characters 16-37
Called from Stdlib__List.fold_right in file "list.ml", line 126, characters 16-37
Called from Stdlib__List.fold_right in file "list.ml", line 126, characters 16-37
Called from Stdlib__List.fold_right in file "list.ml", line 126, characters 16-37
Called from Stdlib__List.fold_right in file "list.ml", line 126, characters 16-37
Called from Stdlib__List.fold_right in file "list.ml", line 126, characters 16-37
Called from Stdlib__List.fold_right in file "list.ml", line 126, characters 16-37
Called from Stdlib__List.fold_right in file "list.ml", line 126, characters 16-37
Called from Stdlib__List.fold_right in file "list.ml", line 126, characters 16-37
Called from Stdlib__List.fold_right in file "list.ml", line 126, characters 16-37
Called from Stdlib__List.fold_right in file "list.ml", line 126, characters 16-37
Called from Stdlib__List.fold_right in file "list.ml", line 126, characters 16-37
Called from Stdlib__List.fold_right in file "list.ml", line 126, characters 16-37
Called from Stdlib__List.fold_right in file "list.ml", line 126, characters 16-37
Called from Stdlib__List.fold_right in file "list.ml", line 126, characters 16-37
Called from Stdlib__List.fold_right in file "list.ml", line 126, characters 16-37
Called from Stdlib__List.fold_right in file "list.ml", line 126, characters 16-37
Called from Stdlib__List.fold_right in file "list.ml", line 126, characters 16-37
Called from Stdlib__List.fold_right in file "list.ml", line 126, characters 16-37
Called from Stdlib__List.fold_right in file "list.ml", line 126, characters 16-37
Called from Dune__exe__Main in file "src/exe-watsup/main.ml", line 157, characters 21-53
[2]
```
