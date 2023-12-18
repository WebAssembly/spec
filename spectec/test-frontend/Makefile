# Configuration

NAME = watsup
EXE = $(PWD)/../$(NAME)
EXT = $(NAME)

OWNDIR = $(PWD)
SPECDIR = ../spec
SPECFILES = $(shell cd $(SPECDIR) && ls -d wasm-*)
TESTFILES = $(shell ls *.$(EXT))
SPECS = $(SPECFILES:%=test-%)
TESTS = $(TESTFILES:%.$(EXT)=test-%)


# Main targets

.PHONY: all

all: test


# Test

.PHONY: test $(SPECS) $(TESTS)

test: $(SPECS) $(TESTS)

$(SPECS): test-%: $(EXE)
	(cd $(SPECDIR)/$* && $(EXE) *.$(EXT))

$(TESTS): test-%: %.$(EXT) $(EXE)
	($(EXE) $<)


# Executable

$(EXE): exe

exe:
	@(cd ..; make exe)


# Cleanup

.PHONY: clean distclean

clean:
	# Nothing so far

distclean: clean
