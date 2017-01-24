# This Makefile uses ocamlbuild but does not rely on ocamlfind or the Opam
# package manager to build. However, Opam package management is available
# optionally through the check/install/uninstall targets.
#
# See README.me for instructions.


# Configuration

NAME =		wasm
UNOPT = 	$(NAME)
OPT =   	$(NAME).opt
LIB =		$(NAME)
ZIP =		$(NAME).zip
WINMAKE =	winmake.bat

DIRS =		util spec text host host/import
LIBS =		str bigarray
FLAGS = 	-cflags '-w +a-4-27-42-44-45 -warn-error +a'
OCB =		ocamlbuild $(FLAGS) $(DIRS:%=-I %) $(LIBS:%=-libs %)
JS =		# set to JS shell command to run JS tests


# Main targets

.PHONY:		unopt opt libunopt libopt all land zip

unopt:		$(UNOPT)
opt:		$(OPT)
libunopt:	_build/$(LIB).cmo
libopt:		_build/$(LIB).cmx
all:		unopt opt libunopt libopt test
land:		all $(WINMAKE)
zip: 		$(ZIP)


# Building executable

$(UNOPT):	main.d.byte
		mv $< $@

$(OPT):		main.native
		mv $< $@

.PHONY:		main.d.byte main.native
main.d.byte:
		$(OCB) -quiet $@

main.native:
		$(OCB) -quiet $@


# Building library

.INTERMEDIATE:	$(LIB).mlpack
$(LIB).mlpack:	$(DIRS)
		ls $(DIRS:%=%/*.ml*) \
		| sed 's:\(.*/\)\{0,1\}\(.*\)\.[^\.]*:\2:' \
		| grep -v main \
		| sort | uniq \
		>$@

_build/$(LIB).cmo: $(LIB).mlpack
		$(OCB) -quiet $(LIB).cmo

_build/$(LIB).cmx: $(LIB).mlpack
		$(OCB) -quiet $(LIB).cmx


# Building Windows build file

$(WINMAKE):	clean
		echo rem Auto-generated from Makefile! >$@
		echo set NAME=$(NAME) >>$@
		echo if \'%1\' neq \'\' set NAME=%1 >>$@
		$(OCB) main.d.byte \
		| grep -v ocamldep \
		| grep -v mkdir \
		| sed s:`which ocaml`:ocaml:g \
		| sed s:host/main.d.byte:%NAME%.exe: \
		>>$@


# Miscellaneous targets

.PHONY:		test clean

$(ZIP):		$(WINMAKE)
		git archive --format=zip --prefix=$(NAME)/ -o $@ HEAD

test:		$(NAME)
		../test/core/run.py --wasm `pwd`/wasm $(if $(JS),--js '$(JS)',)

test/%:		$(NAME)
		../test/core/run.py --wasm `pwd`/wasm $(if $(JS),--js '$(JS)',) $(@:test/%=../test/core/%.wast)

clean:
		$(OCB) -clean


# Opam support

.PHONY:		check install uninstall

check:
		# Check that we can find all relevant libraries
		# when using ocamlfind
		ocamlfind query $(LIBS)

install:	_build/$(LIB).cmx _build/$(LIB).cmo
		ocamlfind install wasm findlib/META _build/wasm.o \
		  $(wildcard _build/$(LIB).cm*) \
		  $(wildcard $(DIRS:%=%/*.mli))

uninstall:
		ocamlfind remove wasm
