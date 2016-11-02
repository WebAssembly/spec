# This Makefile uses ocamlbuild but does not rely on ocamlfind or the Opam
# package manager to build. However, Opam package management is available
# optionally through the check/install/uninstall targets.
#
# See README.me for instructions.

NAME =		wasm
LIB =		wasm
NAME_OPT =      $(NAME).opt
NAME_UNOPT =    $(NAME)
LIB_OPT =	$(LIB).cmx
LIB_UNOPT =	$(LIB).cmo
DIRS =		util spec text host host/import
LIBS =		str bigarray

OCB_FLAGS += 	-cflags '-w +a-4-27-42-44-45 -warn-error +a'
OCB_FLAGS += 	$(DIRS:%=-I %)
OCB_FLAGS += 	$(LIBS:%=-libs %)
OCB =		ocamlbuild $(OCB_FLAGS)

.PHONY:		opt unopt all land
unopt:		$(NAME_UNOPT) $(LIB_UNOPT)
opt:		$(NAME_OPT) $(LIB_OPT)
all:		opt unopt test
land:		all winmake.bat

$(NAME_OPT):	main.native
		mv $< $@

$(NAME_UNOPT):	main.d.byte
		mv $< $@

wasm.mlpack:
		find $(DIRS) -iname '*.ml*' -type f | sed 's/\(.*\/\)\{0,1\}\(.*\)\.[^\.]*/\2/' | uniq | sort | grep -v main > $@

$(LIB_OPT):	_build/wasm.cmx

$(LIB_UNOPT):	_build/wasm.cmo

.PHONY:		_build/$(LIB_OPT)
_build/$(LIB_OPT): wasm.mlpack
		$(OCB) -quiet $(LIB_OPT)

.PHONY:		_build/$(LIB_UNOPT)
_build/$(LIB_UNOPT): wasm.mlpack
		$(OCB) -quiet $(LIB_UNOPT)

.PHONY:		main.native
main.native:
		$(OCB) -quiet $@

.PHONY:		main.d.byte
main.d.byte:
		$(OCB) -quiet $@

.PHONY:		test
test:		$(NAME)
		./runtests.py

winmake.bat:	clean
		echo rem Auto-generated from Makefile! >$@
		echo set NAME=$(NAME) >>$@
		echo if \'%1\' neq \'\' set NAME=%1 >>$@
		$(OCB) main.d.byte \
		| grep -v ocamldep \
		| grep -v mkdir \
		| sed s:`which ocaml`:ocaml:g \
		| sed s:host/main.d.byte:%NAME%: \
		>>$@

.PHONY:		zip
zip: 		winmake.bat
		git archive --format=zip --prefix=$(NAME)/ \
			-o $(NAME).zip HEAD

.PHONY:		clean
clean:
		$(OCB) -clean
		rm -f $(LIB_OPT) $(LIB_UNOPT) wasm.mlpack

.PHONY:		check
check:
		# check that we can find all relevant libraries
		# when using ocamlfind
		ocamlfind query $(LIBS)

install:	$(LIB_OPT) $(LIB_UNOPT)
		ocamlfind install wasm findlib/META _build/wasm.o \
		  $(wildcard _build/wasm.cm*) \
		  $(wildcard host/*.mli spec/*.mli build/*.mli)

.PHONY:		uninstall
uninstall:
		ocamlfind remove wasm
