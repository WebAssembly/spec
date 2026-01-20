# Configuration

NAME = spectec
EXE = $(PWD)/../$(NAME)
EXT = $(NAME)
LOG = _log

OWNDIR = $(PWD)
SPECDIR = ../../specification
SPECCLONE = ../_specification
SPECS = $(shell ls -d $(SPECDIR)/wasm-*)
TESTS = $(SPECS:%=test-%)
SPECFILES = $(shell ls $(SPECS:%=$(SPECDIR)/%/*.$(EXT)))


# Main targets

.PHONY: all

all: test


# Test

.PHONY: test

test:
	dune runtest



# Executable

$(EXE): exe

exe:
	@(cd ..; make exe)


# Specification

$(SPECCLONE): $(SPECFILES)
	@(cd ..; make _specification)


# Cleanup

.PHONY: clean distclean

clean:
	rm -f $(LOG)

distclean: clean
