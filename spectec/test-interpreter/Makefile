# Configuration

NAME = watsup
EXE = $(PWD)/../$(NAME)
EXT = $(NAME)

OWNDIR = $(PWD)
SPECDIR = ../spec/wasm-3.0
SPECFILES = $(sh ls $(SPECDIR)/*.$(EXT))


# Main targets

.PHONY: all

all: test


# Test

.PHONY: test

test: $(EXE)
	(cd $(SPECDIR) && $(EXE) *.$(EXT))


# Cleanup

.PHONY: clean distclean

clean:
	# Nothing so far

distclean: clean
