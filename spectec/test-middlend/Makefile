# Configuration

NAME = watsup
EXE = $(PWD)/../$(NAME)
EXT = $(NAME)
LOG = _log

OWNDIR = $(PWD)
SPECDIR = ../spec
SPECS = $(shell ls $(SPECDIR))
TESTS = $(SPECS:%=test-%)


# Main targets

.PHONY: all

all: test


# Test

.PHONY: test $(TESTS)

test: $(TESTS)

$(TESTS): test-%: $(EXE)
	(cd $(SPECDIR)/$* && $(EXE) -l *.$(EXT))


# Executable

$(EXE): exe

exe:
	@(cd ..; make exe)


# Cleanup

.PHONY: clean distclean

clean:
	rm -f $(LOG)

distclean: clean
