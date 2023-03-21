# Configuration

NAME = watsup
EXT = $(NAME)

TESTDIR = spec
TESTLOG = $(TESTDIR)/TEST.md


# Main targets

.PHONY: default all ci

default: exe
all: exe test
ci: all testexe


# Executable

EXE = exe-$(NAME)/main.exe
SRCDIR = src
OUTDIR = _build/default/src

.PHONY: exe

exe:
	dune build $(SRCDIR)/$(EXE)
	ln -f $(OUTDIR)/$(EXE) ./$(NAME)


# Test

.PHONY: test testpromote testexe

test:
	@dune runtest && echo OK || echo Failure. Run \`make testpromote\` to accept changes in test expectations.

testpromote:
	dune promote

testexe: exe
	(cd $(TESTDIR); ../$(NAME) *.$(EXT))


# Cleanup

.PHONY: clean distclean

clean:
	dune clean
	rm -f src/front/parser.{automaton,conflicts}

distclean: clean
	rm -f ./$(NAME)
