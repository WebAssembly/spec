# Configuration

NAME = watsup
EXE = $(PWD)/../$(NAME)
EXT = $(NAME)

OWNDIR = $(PWD)
SPECDIR = ../spec
SPECFILES = $(shell ls $(SPECDIR)/*.$(EXT))


# Main targets

.PHONY: all

all: latex-gen


# Latex generation

GENNAME = spec-gen-include
GENOUTNAME = spec-gen

.PHONY: latex-gen gen

$(GENNAME).tex: $(SPECFILES) $(EXE)
	(cd $(SPECDIR) && $(EXE) *.$(EXT) -o $(OWNDIR)/$@)

gen: $(GENNAME).tex

latex-gen: $(GENOUTNAME).tex gen
	pdflatex $<


# Test

.PHONY: test

test: latex-gen


# Cleanup

.PHONY: clean distclean

clean:
	dune clean
	rm -f *.aux *.log

distclean: clean
	rm -f $(GENNAME).tex
	rm -f *.pdf
