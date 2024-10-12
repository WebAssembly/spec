# Configuration

NAME = watsup
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
REFINTERPDIR = $(ROOTDIR)/interpreter
CLONEDIR = src/backend-interpreter/reference-interpreter
CLONERM = dune-project jslib

.PHONY: exe

exe: $(CLONEDIR)
	rm -f ./$(NAME)
	dune build $(SRCDIR)/$(EXE)
	ln -f $(OUTDIR)/$(EXE) ./$(NAME)

$(CLONEDIR): $(shell find $(REFINTERPDIR) -type f)
	rm -rf $(CLONEDIR)
	cp -R $(REFINTERPDIR) $(CLONEDIR)
	rm -r $(CLONERM:%=$@/%)
	cp $@/../dune-ref-interp $@/dune


# Latex

.PHONY: latex

latex: exe
	(cd test-latex && make all)


# Test

TESTDIRS = $(shell ls -d test-*)

.PHONY: test testpromote $(TESTDIRS)

test: exe $(TESTDIRS)

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


# Cleanup

.PHONY: clean distclean

clean:
	dune clean
	rm -f src/frontend/parser.{automaton,conflicts}
	for dir in $(TESTDIRS); do (cd $$dir && make clean); done

distclean: clean
	rm -f ./$(NAME)
	rm -rf $(CLONEDIR)
	for dir in $(TESTDIRS); do (cd $$dir && make distclean); done
