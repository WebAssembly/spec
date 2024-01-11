# Test

```sh
$ (dune exec ../src/exe-watsup/main.exe -- test.watsup -o test.tex && cat test.tex)
Warning: No dune-project file has been found. A default one is assumed but
the project might break when dune is upgraded. Please create a dune-project
file.
Hint: generate the project file with: $ dune init project <name>
File "dune", line 1, characters 0-116:
1 | (mdx
2 |  (libraries spectec)
3 |  (deps
4 |   (file ../src/exe-watsup/main.exe)
5 |   (glob_files_rec ../spec/*))
6 |  (files TEST.md))
Error: 'mdx' is available only when mdx is enabled in the dune-project file.
You must enable it using (using mdx 0.4) in your dune-project file.
[1]
```


# Preview

```sh
$ (dune exec ../src/exe-watsup/main.exe -- ../spec/wasm-3.0/*.watsup)
Warning: No dune-project file has been found. A default one is assumed but
the project might break when dune is upgraded. Please create a dune-project
file.
Hint: generate the project file with: $ dune init project <name>
File "dune", line 1, characters 0-116:
1 | (mdx
2 |  (libraries spectec)
3 |  (deps
4 |   (file ../src/exe-watsup/main.exe)
5 |   (glob_files_rec ../spec/*))
6 |  (files TEST.md))
Error: 'mdx' is available only when mdx is enabled in the dune-project file.
You must enable it using (using mdx 0.4) in your dune-project file.
[1]
```
