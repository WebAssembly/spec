# Configuration

NAME = spectec
EXE = $(PWD)/../$(NAME)
EXT = $(NAME)
LOG = _log

OWNDIR = $(PWD)
SPECDIR = ../../specification/wasm-latest
SPECCLONE = ../_specification/wasm-latest
SPECFILES = $(shell ls $(SPECDIR)/*.$(EXT))


# Main targets

.PHONY: all

all: test


# Test

.PHONY: test

test: $(SPECCLONE) $(EXE)
	(cd $(SPECCLONE) && $(EXE) -l *.$(EXT))


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
