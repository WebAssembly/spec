# Configuration

NAME = spectec
EXE = $(PWD)/../$(NAME)
EXT = $(NAME)
LOG = _log

OWNDIR = $(PWD)
SPECDIR = ../../specification
SPECCLONE = ../_specification
SPECFILES = $(shell cd $(SPECDIR) && ls -d wasm-*)
TESTFILES = $(shell ls *.$(EXT))
SPECS = $(SPECFILES:%=test-%)
TESTS = $(TESTFILES:%.$(EXT)=test-%)
SPECDEPFILES = $(shell ls $(SPECFILES:%=$(SPECDIR)/%/*.$(EXT)))


# Main targets

.PHONY: all

all: test


# Test

.PHONY: test $(SPECS) $(TESTS)

test: $(SPECS) $(TESTS)

$(SPECS): test-%: $(SPECCLONE) $(EXE)
	(cd $(SPECCLONE)/$* && $(EXE) -l *.$(EXT))

$(TESTS): test-%: %.$(EXT) $(EXE)
	($(EXE) -l $<)


# Executable

$(EXE): exe

exe:
	@(cd ..; make exe)


# Specification

$(SPECCLONE): $(SPECDEPFILES)
	@(cd ..; make _specification)


# Cleanup

.PHONY: clean distclean

clean:
	rm -f $(LOG)

distclean: clean
