# Configuration

NAME = watsup
EXE = $(PWD)/../$(NAME)
EXT = $(NAME)

GENNAME = spec-gen
OUTNAME = spec

OWNDIR = $(PWD)
SPECDIR = ../spec
SPECFILES = $(shell ls $(SPECDIR)/*.$(EXT))


# Main targets

.PHONY: all

all: latex


# Latex generation

.PHONY: latex gen

$(GENNAME).tex: $(SPECFILES) $(EXE)
	(cd $(SPECDIR) && $(EXE) *.$(EXT) -o $(OWNDIR)/$@)

gen: $(GENNAME).tex

latex: $(OUTNAME).tex gen
	pdflatex $<


# Test

.PHONY: test

test: latex


# Cleanup

.PHONY: clean distclean

clean:
	dune clean
	rm -f *.aux *.log

distclean: clean
	rm -f $(GENNAME).tex
	rm -f $(OUTNAME).pdf
