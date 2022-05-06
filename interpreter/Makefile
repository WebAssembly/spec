# This Makefile uses ocamlbuild but does not rely on ocamlfind or the Opam
# package manager to build. However, Opam package management is available
# optionally through the check/install/uninstall targets.
#
# The wast.js target requires node.js and BuckleScript.
#
# See README.me for instructions.


# Configuration

BUILDDIR =  _build/default
UNOPT =     $(BUILDDIR)/main/main.bc
OPT =       $(BUILDDIR)/main/main.exe
JS =        # set to JS shell command to run JS tests
TESTDIR =	  ../test/core
# Skip _output directory, since that's a tmp directory, and list all other wast files.
TESTFILES =	$(shell cd $(TESTDIR); ls *.wast; ls [a-z]*/*.wast)

# Main targets

.PHONY: default jslib all land zip

default: $(OPT)
debug: $(UNOPT)
jslib: $(BUILDDIR)/jslib/wasm.bc.js
all: $(UNOPT) $(OPT) test
land: all
zip: wasm.zip

$(BUILDDIR)/%:
	dune build $*

# Executing test suite

.PHONY:	test debugtest partest winmake.bat

winmake.bat:
	dune clean
	dune build main/main.bc
	cat _build/log | grep -v "^#" | grep -v "ocamldep\.opt" | sed s:`which ocaml`:ocaml:g | sed s:_build/default:_build/:g | sed s:"cd _build/ &&"::g | sed s:".wasm.objs/"::g | sed s:"byte/"::g | sed s:"-I byte"::g | sed s:"^...."::g | sed s:")"::g | sed s:"  ":" ":g

test/%: $(OPT)
		$(TESTDIR)/run.py --wasm `pwd`/$< $(if $(JS),--js '$(JS)',) $(TESTDIR)/$*.wast
debugtest/%: $(UNOPT)
		$(TESTDIR)/run.py --wasm `pwd`/$< $(if $(JS),--js '$(JS)',) $(TESTDIR)/$*.wast

test: $(OPT) smallinttest
		$(TESTDIR)/run.py --wasm `pwd`/$< $(if $(JS),--js '$(JS)',)
debugtest: $(UNOPT) smallinttest
		$(TESTDIR)/run.py --wasm `pwd`/$< $(if $(JS),--js '$(JS)',)

run/%:
		dune exec -- main/main.exe $(TESTDIR)/$*.wast
debug/%:
		dune exec -- main/main.bc $(TESTDIR)/$*.wast

partest: $(TESTFILES:%.wast=quiettest/%)
		@echo All tests passed.

quiettest/%: $(OPT)
		@ ( \
		  $(TESTDIR)/run.py 2>$(@F).out --wasm `pwd`/$< $(if $(JS),--js '$(JS)',) $(TESTDIR)/$*.wast && \
		  rm $(@F).out \
		) || \
		cat $(@F).out || rm $(@F).out || exit 1

smallinttest:
		dune runtest

# Miscellaneous targets

wasm.zip:
		git archive --format=zip --prefix=wasm/ -o $@ HEAD

clean:
		dune clean

# Opam support

install:
		dune install

uninstall:
		dune uninstall
