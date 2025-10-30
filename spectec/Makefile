# Configuration

NAME = spectec
EXT = $(NAME)
LOG = _log


# Main targets

.PHONY: default all ci

default: exe
all: exe latex test
ci: all


# Executable

EXE = exe-$(NAME)/main.exe
SRCDIR = src
OUTDIR = _build/default/src
ROOTDIR = ..
INTERPRETERDIR = $(ROOTDIR)/interpreter
CLONEDIR = src/backend-interpreter/reference-interpreter
CLONERM = dune-project jslib
OPAMPACKAGES = zarith menhir mdx


.PHONY: exe

packages:
	opam install $(OPAMPACKAGES)

exe: $(CLONEDIR) packages
	rm -f ./$(NAME)
	dune build $(SRCDIR)/$(EXE)
	ln -f $(OUTDIR)/$(EXE) ./$(NAME)

$(CLONEDIR): $(shell find $(INTERPRETERDIR) -type f)
	rm -rf $(CLONEDIR)
	cp -R $(INTERPRETERDIR) $(CLONEDIR)
	rm -r $(CLONERM:%=$@/%)
	cp $@/../dune-ref-interp $@/dune


# Latex

.PHONY: latex

latex: exe
	(cd test-latex && make all)


# Test

TESTDIRS = $(shell ls -d test-*)

.PHONY: test testpromote $(TESTDIRS) doc/example

test: exe $(TESTDIRS) doc/example

dunetest:
	@echo "#### Running (dune runtest)"
	@dune runtest && echo OK || (echo "####>" Failure running dune test. && echo "####>" Run \`make testpromote\` to accept changes in test expectations. && false)

testpromote:
	dune promote

$(TESTDIRS): test-%: exe
	@echo "#### Running (cd $@; make test)"
	@(cd $@ && ((make test >$(LOG) 2>&1 && (grep warning $(LOG) || true)) || (cat $(LOG) && echo "####>" Failure running $@. See log above. && false)))
	@echo "#### Running (cd $@; dune runtest)"
	@(cd $@ && dune runtest)

doc/example: exe
	@echo "#### Running (cd $@; make all)"
	@(cd $@ && make out clean >$(LOG) 2>&1 && rm -f $(LOG))


# Specification (copy to local workspace to make dune deps for tests happy)

SPECIFICATIONDIR = $(ROOTDIR)/specification
SPECCLONEDIR = _specification

$(SPECCLONEDIR): $(shell find $(SPECIFICATIONDIR) -type f)
	rm -rf $(SPECCLONEDIR)
	cp -R $(SPECIFICATIONDIR) $(SPECCLONEDIR)


# Spec document

.PHONY: spec spec-pdf

spec:
	(cd ../document/core && make main)

spec-pdf:
	(cd ../document/core && make pdf)

spec-html:
	(cd ../document/core && make html)

spec-clean:
	(cd ../document/core && make clean)


# Cleanup

.PHONY: clean distclean

clean:
	dune clean
	rm -f src/frontend/parser.{automaton,conflicts}
	for dir in $(TESTDIRS); do (cd $$dir && make clean); done

distclean: clean spec-clean
	rm -f ./$(NAME)
	rm -rf $(CLONEDIR)
	for dir in $(TESTDIRS); do (cd $$dir && make distclean); done
