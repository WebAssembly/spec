# Configuration

NAME = watsup
EXE = $(PWD)/../$(NAME)
EXT = $(NAME)

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
	(cd $(SPECDIR)/$* && $(EXE) *.$(EXT))


# Executable

$(EXE): exe

exe:
	@(cd ..; make exe)


# Cleanup

.PHONY: clean distclean

clean:
	# Nothing so far

distclean: clean
