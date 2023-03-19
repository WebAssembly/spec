# Configuration

NAME = watsup
EXT = spasm


# Main targets

.PHONY: exe all

exe:
	dune build src/$(NAME).exe
	ln -f _build/default/src/$(NAME).exe ./$(NAME)

all: exe test


# Test

SPECDIR = spec
SPECFILES = syntax aux typing runtime reduction

.PHONY: test dunetest ci

test: exe
	./$(NAME) $(SPECFILES:%=$(SPECDIR)/%.$(EXT))

dunetest:
	dune runtest

ci: all dunetest


# Cleanup

.PHONY: clean distclean

clean:
	dune clean
	rm -f src/front/parser.{automaton,conflicts}

distclean: clean
	rm -f ./$(NAME)
