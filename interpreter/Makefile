# This Makefile uses ocamlbuild but does not rely on ocamlfind or the Opam
# package manager to build. However, Opam package management is available
# optionally through the check/install/uninstall targets.
#
# The $(JSLIB).js target requires Js_of_ocaml (using ocamlfind).
#
# See README.me for instructions.


# Configuration

NAME =		wasm
UNOPT = 	$(NAME).debug
OPT =   	$(NAME)
LIB =		$(NAME)
ZIP =		$(NAME).zip
JSLIB =		wast
WINMAKE =	winmake.bat

DIRS =		util syntax binary text valid runtime exec script host main tests
LIBS =		
FLAGS = 	-lexflags -ml -cflags '-w +a-4-27-42-44-45-70 -warn-error +a-3'
OCBA =		ocamlbuild $(FLAGS) $(DIRS:%=-I %)
OCB =		$(OCBA) $(LIBS:%=-libs %)
JSO =		js_of_ocaml -q --opt 3
JS =		# set to JS shell command to run JS tests, empty to skip


# Main targets

.PHONY:		default opt unopt libopt libunopt jslib all land zip smallint dunebuild

default:	opt
debug:		unopt
opt:		$(OPT)
unopt:		$(UNOPT)
libopt:		_build/$(LIB).cmx _build/$(LIB).cmxa
libunopt:	_build/$(LIB).cmo _build/$(LIB).cma
jslib:		$(JSLIB).js
all:		unopt opt libunopt libopt test
land:		$(WINMAKE) all
zip: 		$(ZIP)
smallint:	smallint.native
ci:			land wast.js dunebuild

dunebuild:
	dune build


# Building executable

empty =
space =		$(empty) $(empty)
comma =		,

.INTERMEDIATE:	_tags
_tags:
		echo >$@ "true: bin_annot"
		echo >>$@ "true: debug"
		echo >>$@ "<{$(subst $(space),$(comma),$(DIRS))}/*.cmx>: for-pack($(PACK))"

$(UNOPT):	main.byte
		mv $< $@

$(OPT):		main.native
		mv $< $@

.PHONY:		main.byte main.native
main.byte:	_tags
		$(OCB) -quiet $@

main.native:	_tags
		$(OCB) -quiet $@

.PHONY:		smallint.byte smallint.native
smallint.byte: _tags
		$(OCB) -quiet $@
smallint.native: _tags
		$(OCB) -quiet $@


# Building library

FILES =		$(shell ls $(DIRS:%=%/*) | grep '[.]ml[^.]*$$')
PACK =		$(shell echo `echo $(LIB) | sed 's/^\(.\).*$$/\\1/g' | tr [:lower:] [:upper:]``echo $(LIB) | sed 's/^.\(.*\)$$/\\1/g'`)

.INTERMEDIATE:	$(LIB).mlpack
$(LIB).mlpack:	$(DIRS)
		ls $(FILES) \
		| sed 's:\(.*/\)\{0,1\}\(.*\)\.[^\.]*:\2:' \
		| grep -v main \
		| sort | uniq \
		>$@

.INTERMEDIATE:	$(LIB).mllib
$(LIB).mllib:
		echo Wasm >$@

_build/$(LIB).cmo: $(FILES) $(LIB).mlpack _tags Makefile
		$(OCB) -quiet $(LIB).cmo

_build/$(LIB).cmx: $(FILES) $(LIB).mlpack _tags Makefile
		$(OCB) -quiet $(LIB).cmx

_build/$(LIB).cma: $(FILES) $(LIB).mllib _tags Makefile
		$(OCBA) -quiet $(LIB).cma

_build/$(LIB).cmxa: $(FILES) $(LIB).mllib _tags Makefile
		$(OCBA) -quiet $(LIB).cmxa


# Building JavaScript library

JSLIB_DIR =		meta/jslib
JSLIB_FLAGS =	-I $(JSLIB_DIR) -use-ocamlfind -pkg js_of_ocaml -pkg js_of_ocaml-ppx

.INTERMEDIATE:	$(JSLIB).byte
$(JSLIB).byte:	$(JSLIB_DIR)/$(JSLIB).ml
		$(OCBA) $(JSLIB_FLAGS) $@

$(JSLIB).js: $(JSLIB).byte
		$(JSO) $<

# Building Windows build file

$(WINMAKE):	clean
		echo rem Auto-generated from Makefile! >$@
		echo set NAME=$(NAME) >>$@
		echo if \'%1\' neq \'\' set NAME=%1 >>$@
		$(OCB) main.byte \
		| grep -v ocamldep \
		| grep -v mkdir \
		| sed s:`which ocaml`:ocaml:g \
		| sed s:main/main.d.byte:%NAME%.exe: \
		>>$@


# Executing test suite

TESTDIR =	../test/core
# Skip _output directory, since that's a tmp directory, and list all other wast files.
TESTFILES =	$(shell cd $(TESTDIR); ls *.wast; ls [a-z]*/*.wast)
TESTS =		$(TESTFILES:%.wast=%)

.PHONY:		test debugtest partest dune-test

test:		$(OPT) smallint
		$(TESTDIR)/run.py --wasm `pwd`/$(OPT) $(if $(JS),--js '$(JS)',)
		./smallint.native
debugtest:	$(UNOPT) smallint
		$(TESTDIR)/run.py --wasm `pwd`/$(UNOPT) $(if $(JS),--js '$(JS)',)
		./smallint.native

test/%:		$(OPT)
		$(TESTDIR)/run.py --wasm `pwd`/$(OPT) $(if $(JS),--js '$(JS)',) $(TESTDIR)/$*.wast
debugtest/%:	$(UNOPT)
		$(TESTDIR)/run.py --wasm `pwd`/$(UNOPT) $(if $(JS),--js '$(JS)',) $(TESTDIR)/$*.wast

run/%:		$(OPT)
		./$(OPT) $(TESTDIR)/$*.wast
debug/%:	$(UNOPT)
		./$(UNOPT) $(TESTDIR)/$*.wast

partest: 	$(TESTS:%=quiettest/%)
		@echo All tests passed.

quiettest/%:	$(OPT)
		@ ( \
		  $(TESTDIR)/run.py 2>$(@F).out --wasm `pwd`/$(OPT) $(if $(JS),--js '$(JS)',) $(TESTDIR)/$*.wast && \
		  rm $(@F).out \
		) || \
		cat $(@F).out || rm $(@F).out || exit 1

smallinttest:	smallint
		@./smallint.native

dunetest:
	dune test


# Miscellaneous targets

.PHONY:		clean

$(ZIP):		$(WINMAKE)
		git archive --format=zip --prefix=$(NAME)/ -o $@ HEAD

clean:
		rm -rf _build/jslib $(LIB).mlpack _tags $(JSLIB).js
		$(OCB) -clean


# Opam support

.PHONY:		check install uninstall

check:
		# Check that we can find all relevant libraries
		# when using ocamlfind
		ocamlfind query $(LIBS)

install:	_build/$(LIB).cmx _build/$(LIB).cmo
		ocamlfind install $(LIB) meta/findlib/META _build/$(LIB).o \
		  $(wildcard _build/$(LIB).cm*) \
		  $(wildcard $(DIRS:%=%/*.mli))

uninstall:
		ocamlfind remove $(LIB)
