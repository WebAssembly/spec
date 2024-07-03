# This Makefile uses dune but does not rely on ocamlfind or the Opam
# package manager to build. However, Opam package management is available
# optionally through the install target.
#
# The $(JSLIB).js target requires Js_of_ocaml (using ocamlfind).
#
# See README.me for instructions.


# Configuration

NAME =		wasm
LIB =		$(NAME)
JSLIB =		wast.js
ZIP =		$(NAME).zip

BUILDDIR =	_build/default

JS =		# set to JS shell command to run JS tests, empty to skip


# Main targets

.PHONY:		default all ci jslib zip

default:	$(NAME)
all:		default alltest
alltest:	unittest partest custompartest
ci:		all jslib zip

jslib:		$(JSLIB)
zip:		$(ZIP)


# Building

.PHONY:		$(NAME) $(JSLIB)

$(NAME):
	rm -f $@
	dune build $@.exe
	ln $(BUILDDIR)/$@.exe $@

$(JSLIB):
	rm -f $@
	dune build $(@:%.js=%.bc.js)
	ln $(BUILDDIR)/$(@:%.js=%.bc.js) $@


# Unit tests

UNITTESTDIR =	unittest
UNITTESTFILES =	$(shell cd $(UNITTESTDIR) > /dev/null; ls *.ml)
UNITTESTS =	$(UNITTESTFILES:%.ml=%)

.PHONY: unittest

unittest: $(UNITTESTS:%=unittest/%)

unittest/%:
	dune build $(@F).exe
	dune exec ./$(@F).exe
	@echo All unit tests passed.


# Core test suite

TESTDIR =	../test/core
TESTFILES =	$(shell cd $(TESTDIR) > /dev/null; ls *.wast; ls [a-z]*/*.wast)
TESTS =		$(TESTFILES:%.wast=%)

.PHONY: test partest quiettest

test: $(NAME)
	$(TESTDIR)/run.py --wasm `pwd`/$(NAME) $(if $(JS),--js '$(JS)',)

test/%: $(NAME)
	$(TESTDIR)/run.py --wasm `pwd`/$(NAME) $(if $(JS),--js '$(JS)',) $(TESTDIR)/$*.wast

run/%: $(NAME)
	./$(NAME) $(TESTDIR)/$*.wast

partest: $(NAME)
	make -j10 quiettest

quiettest: $(TESTS:%=quiettest/%)
	@echo All tests passed.

quiettest/%: $(NAME)
	@ ( \
	  $(TESTDIR)/run.py 2>$(@F).out --wasm `pwd`/$(NAME) $(if $(JS),--js '$(JS)',) $(TESTDIR)/$*.wast && \
	  rm $(@F).out \
	) || \
	(cat $(@F).out && rm $(@F).out && exit 1)


# Custom test suite

CUSTOMTESTDIR =	../test/custom
CUSTOMTESTDIRS =	$(shell cd $(CUSTOMTESTDIR); ls -d [a-z]*)
CUSTOMTESTFILES =	$(shell cd $(CUSTOMTESTDIR); ls [a-z]*/*.wast)
CUSTOMTESTS =		$(CUSTOMTESTFILES:%.wast=%)
CUSTOMOPTS = -c custom $(CUSTOMTESTDIRS:%=-c %)

.PHONY:		customtest custompartest customquiettest

customtest:		$(NAME)
		$(TESTDIR)/run.py --wasm `pwd`/$(NAME) --opts '$(CUSTOMOPTS)' $(if $(JS),--js '$(JS)',) $(CUSTOMTESTFILES:%=$(CUSTOMTESTDIR)/%)

customtest/%:		$(NAME)
		$(TESTDIR)/run.py --wasm `pwd`/$(NAME) --opts '$(CUSTOMOPTS) ' $(if $(JS),--js '$(JS)',) $(CUSTOMTESTDIR)/$*.wast

customrun/%:		$(NAME)
		./$(NAME) $(CUSTOMOPTS) $(CUSTOMTESTDIR)/$*.wast

custompartest: 	$(CUSTOMTESTS:%=customquiettest/%)
		@echo All custom tests passed.

customquiettest/%:	$(NAME)
		@ ( \
		  $(TESTDIR)/run.py 2>$(@F).out --wasm `pwd`/$(NAME) --opts '$(CUSTOMOPTS)' $(if $(JS),--js '$(JS)',) $(CUSTOMTESTDIR)/$*.wast && \
		  rm $(@F).out \
		) || \
		cat $(@F).out || rm $(@F).out || exit 1


# Packaging

.PHONY: install

install:
	dune build -p $(NAME) @install
	dune install

opam-release/%:
	git tag opam-$*
	git push --tags
	rm -f opam-$*.zip
	wget https://github.com/WebAssembly/spec/archive/opam-$*.zip
	cp wasm.opam opam
	echo "url {" >> opam
	echo "  src: \"https://github.com/WebAssembly/spec/archive/opam-$*.zip\"" >> opam
	echo "  checksum: \"md5=`md5 -q opam-$*.zip`\"" >> opam
	echo "}" >> opam
	rm opam-$*.zip
	@echo Created file ./opam, submit to github opam-repository/packages/wasm/wasm.$*/opam

$(ZIP):
	git archive --format=zip --prefix=$(NAME)/ -o $@ HEAD


# Cleanup

.PHONY: clean distclean

clean:
	dune clean

distclean: clean
	rm -f $(NAME) $(JSLIB) $(ZIP)
