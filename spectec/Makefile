# Configuration

NAME = watsup
EXT = spasm


# Main targets

.PHONY: default all

default:
	dune build src/$(NAME).exe
	ln -f _build/default/src/$(NAME).exe ./$(NAME)

all: default test


# Test

SPECDIR = spec
SPECFILES = syntax aux typing runtime reduction

.PHONY: test dunetest ci

test: all
	./$(NAME) $(SPECFILES:%=$(SPECDIR)/%.$(EXT))

dunetest:
	dune runtest

ci: all test dunetest


# Cleanup

.PHONY: clean distclean

clean:
	dune clean

distclean: clean
	rm -f ./$(NAME)
