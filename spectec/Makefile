# Configuration

NAME = watsup
EXT = $(NAME)

TESTDIRS = test-frontend test-latex


# Main targets

.PHONY: default all ci

default: exe
all: exe latex test
ci: all test-frontend test-latex


# Executable

EXE = exe-$(NAME)/main.exe
SRCDIR = src
OUTDIR = _build/default/src

.PHONY: exe

exe:
	dune build $(SRCDIR)/$(EXE)
	ln -f $(OUTDIR)/$(EXE) ./$(NAME)


# Latex

.PHONY: latex

latex: exe
	(cd test-latex && make latex)


# Test

.PHONY: test testpromote $(TESTDIRS)

test:
	@dune runtest && echo OK || echo Failure. Run \`make testpromote\` to accept changes in test expectations.

testpromote:
	dune promote

$(TESTDIRS): test-%: exe
	(cd $@ && make test)


# Cleanup

.PHONY: clean distclean

clean:
	dune clean
	rm -f src/front/parser.{automaton,conflicts}
	for dir in $(TESTDIRS); do (cd $$dir && make clean); done

distclean: clean
	rm -f ./$(NAME)
	for dir in $(TESTDIRS); do (cd $$dir && make distclean); done
