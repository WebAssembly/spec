# Configuration

NAME = watsup
EXT = $(NAME)


# Main targets

.PHONY: default all ci

default: exe
all: exe latex test
ci: all


# Executable

EXE = exe-$(NAME)/main.exe
SRCDIR = src
OUTDIR = _build/default/src
CLONEDIR = src/backend-interpreter/reference-interpreter

.PHONY: exe

exe: $(CLONEDIR)
	rm -f ./$(NAME)
	dune build $(SRCDIR)/$(EXE)
	ln -f $(OUTDIR)/$(EXE) ./$(NAME)

$(CLONEDIR):
	@rm -rf $(CLONEDIR)
	git clone --single-branch https://github.com/WebAssembly/gc.git $(CLONEDIR)
	@(cd $(CLONEDIR)/interpreter; git checkout 3fa0537 -q; rm dune-project jslib/wast.ml script/run.mli valid/match.mli; cp ../../dune-ref-interp dune)


# Latex

.PHONY: latex

latex: exe
	(cd test-latex && make all)


# Test

TESTDIRS = $(shell ls -d test-*)

.PHONY: test testpromote $(TESTDIRS)

test: exe $(TESTDIRS)
	@dune runtest && echo OK || (echo Failure. Run \`make testpromote\` to accept changes in test expectations. && false)

testpromote:
	dune promote

$(TESTDIRS): test-%: exe
	(cd $@ && make test >/dev/null)


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
