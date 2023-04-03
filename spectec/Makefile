# Configuration

NAME = watsup
EXT = $(NAME)

TESTDIRS = test-frontend test-latex


DUNE_OPTS ?=

# Main targets

.PHONY: default all ci

default: exe exe-haskell
all: exe latex test
ci: all test-frontend test-latex


# Executable

EXE = exe-$(NAME)/main.exe
SRCDIR = src
OUTDIR = _build/default/src

.PHONY: exe

exe:
	dune build $(DUNE_OPTS) $(SRCDIR)/$(EXE)
	ln -sf $(OUTDIR)/$(EXE) ./$(NAME)

exe-haskell:
	dune build $(DUNE_OPTS) $(SRCDIR)/exe-haskell/main.exe
	ln -sf $(OUTDIR)/exe-haskell/main.exe ./$(NAME)-haskell


# Latex

.PHONY: latex

latex: exe
	(cd test-latex && make all)


# Test

.PHONY: test testpromote $(TESTDIRS)

test:
	@dune runtest && echo OK || (echo Failure. Run \`make testpromote\` to accept changes in test expectations. && false)

testpromote:
	dune promote

$(TESTDIRS): test-%: exe
	(cd $@ && make test)


# Cleanup

.PHONY: clean distclean

clean:
	dune clean
	rm -f src/frontend/parser.{automaton,conflicts}
	for dir in $(TESTDIRS); do (cd $$dir && make clean); done

distclean: clean
	rm -f ./$(NAME)
	for dir in $(TESTDIRS); do (cd $$dir && make distclean); done
