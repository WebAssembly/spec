# Configuration

NAME = watsup
EXT = $(NAME)

TESTDIR = spec
TESTLOG = $(TESTDIR)/TEST.md


# Main targets

.PHONY: default all ci

default: exe
all: exe test
ci: all test-exe test-latex


# Executable

EXE = exe-$(NAME)/main.exe
SRCDIR = src
OUTDIR = _build/default/src

.PHONY: exe

exe:
	dune build $(SRCDIR)/$(EXE)
	ln -f $(OUTDIR)/$(EXE) ./$(NAME)


# Test

.PHONY: test testpromote test-exe test-latex

test:
	@dune runtest && echo OK || echo Failure. Run \`make testpromote\` to accept changes in test expectations.

testpromote:
	dune promote

test-exe: exe
	(cd $(TESTDIR); ../$(NAME) *.$(EXT))

test-latex: exe
	(cd test-latex && ../$(NAME) ../$(TESTDIR)/*.$(EXT) -o spec.tex)
	(cd test-latex && pdflatex spec-main.tex)


# Cleanup

.PHONY: clean distclean

clean:
	dune clean
	rm -f src/front/parser.{automaton,conflicts}

distclean: clean
	rm -f ./$(NAME)
