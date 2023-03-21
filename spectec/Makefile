# Configuration

NAME = watsup
EXT = $(NAME)

SPECDIR = spec
SPECFILES = syntax aux typing runtime reduction
SPECLOG = TEST.md


# Main targets

EXE = exe-$(NAME)/main.exe
SRCDIR = src
OUTDIR = _build/default/src

.PHONY: exe all

exe:
	dune build $(SRCDIR)/$(EXE)
	ln -f $(OUTDIR)/$(EXE) ./$(NAME)

all: exe test


# Test

CONFIGURED_INVOKE = $$ dune exec ../$(SRCDIR)/$(EXE) -- $(SPECFILES:%=%.$(EXT))
CURRENT_INVOKE = $(shell grep "dune exec" $(SPECDIR)/$(SPECLOG))

.PHONY: test dunetest dunepromote fix-dunetest ci

test: exe
	./$(NAME) $(SPECFILES:%=$(SPECDIR)/%.$(EXT))

fix-dunetest:
	@ \
	if [ "$(CURRENT_INVOKE)" != "$(CONFIGURED_INVOKE)" ]; then \
	  echo Updating dune test invocation in $(SPECDIR)/$(SPECLOG) ;\
	  sed "s!$(CURRENT_INVOKE)!$(CONFIGURED_INVOKE)!" $(SPECDIR)/$(SPECLOG) >$(SPECDIR)/$(SPECLOG).tmp ;\
	  mv $(SPECDIR)/$(SPECLOG).tmp $(SPECDIR)/$(SPECLOG) ;\
	fi

dunetest: fix-dunetest
	dune runtest

dunepromote:
	dune promote

ci: all dunetest


# Cleanup

.PHONY: clean distclean

clean:
	dune clean
	rm -f src/front/parser.{automaton,conflicts}

distclean: clean
	rm -f ./$(NAME)
