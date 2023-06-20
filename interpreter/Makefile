# This Makefile uses dune but does not rely on ocamlfind or the Opam
# package manager to build. However, Opam package management is available
# optionally through the check/install/uninstall targets.
#
# The $(JSLIB).js target requires Js_of_ocaml (using ocamlfind).
#
# See README.me for instructions.


# Configuration

NAME = wasm
OPT =		$(NAME).exe
ZIP =		$(NAME).zip
JSLIB =		wast.js

BUILDDIR = _build/default

JS =		# set to JS shell command to run JS tests, empty to skip


# Main targets

.PHONY:		default opt jslib all zip smallint

default:	$(OPT)
jslib:		$(JSLIB)
all:		$(OPT) test
zip:		$(ZIP)
smallint:	smallint.exe
ci:		all jslib

# Building executable
.PHONY:		$(NAME).exe
$(NAME).exe:
	dune build $@
	rm -f $(NAME)
	cp $(BUILDDIR)/$(OPT) $(NAME)

.PHONY:		smallint.exe
smallint.exe:
	dune build $@

# Building JavaScript library

$(JSLIB):
	dune build $@

# Executing test suite

TESTDIR =	../test/core
# Skip _output directory, since that's a tmp directory, and list all other wast files.
TESTFILES =	$(shell cd $(TESTDIR); ls *.wast; ls [a-z]*/*.wast)
TESTS =		$(TESTFILES:%.wast=%)

.PHONY:		test partest dune-test

test:		$(OPT) smallint
		$(TESTDIR)/run.py --wasm `pwd`/$(BUILDDIR)/$(OPT) $(if $(JS),--js '$(JS)',)
		dune exec ./smallint.exe

test/%:		$(OPT)
		$(TESTDIR)/run.py --wasm `pwd`/$(BUILDDIR)/$(OPT) $(if $(JS),--js '$(JS)',) $(TESTDIR)/$*.wast

run/%:		$(OPT)
		./$(OPT) $(TESTDIR)/$*.wast

partest:	$(TESTS:%=quiettest/%)
		@echo All tests passed.

quiettest/%:	$(OPT)
		@ ( \
		  $(TESTDIR)/run.py 2>$(@F).out --wasm `pwd`/$(BUILDDIR)/$(OPT) $(if $(JS),--js '$(JS)',) $(TESTDIR)/$*.wast && \
		  rm $(@F).out \
		) || \
		cat $(@F).out || rm $(@F).out || exit 1

smallinttest:	smallint
	dune exec ./smallint.exe

dunetest:
	dune test


# Miscellaneous targets

.PHONY:		clean

$(ZIP):
	git archive --format=zip --prefix=wasm/ -o $@ HEAD

clean:
	dune clean
