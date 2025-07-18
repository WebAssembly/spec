# Configuration

NAME = spectec
EXE = $(PWD)/../$(NAME)
EXT = $(NAME)
LOG = _log

OWNDIR = $(PWD)
SPECDIR = ../../specification
SPECCLONE = ../_specification
SPECS = $(shell ls $(SPECDIR))
TESTS = $(SPECS:%=test-%)
SPECFILES = $(shell ls $(SPECS:%=$(SPECDIR)/%/*.$(EXT)))


# Main targets

.PHONY: all

all: test


# Test

.PHONY: test $(TESTS)

test: $(TESTS)

$(TESTS): test-%: $(SPECCLONE) $(EXE)
	(cd $(SPECCLONE)/$* && $(EXE) -l *.$(EXT))


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
