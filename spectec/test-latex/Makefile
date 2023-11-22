# Configuration

NAME = watsup
EXE = $(PWD)/../$(NAME)
EXT = $(NAME)

OWNDIR = $(PWD)
SPECDIR = ../spec
SPECS = $(shell ls $(SPECDIR))
SPECFILES = $(shell ls $(SPECS:%=$(SPECDIR)/%/*.$(EXT)))

SPEC = 
TEST = $(SPEC:%=test-%)


# Main targets

.PHONY: all

all: test-gen

# Latex generation

GENINNAME = spec-gen.include
GENOUTNAME = spec-gen

.PHONY: gen test-gen
.INTERMEDIATE: $(SPECS:%=$(GENINNAME)-%.tex)

gen: $(SPECS:%=$(GENINNAME)-%.tex)

test-gen: $(SPECS:%=$(GENOUTNAME)-%.pdf)

$(GENINNAME)-%.tex: $(SPECFILES) $(EXE)
	(cd $(SPECDIR)/$* && $(EXE) *.$(EXT) -o $(OWNDIR)/$@)

$(GENOUTNAME)-%.tex: $(GENOUTNAME).tex
	ln -f $< $@

$(GENOUTNAME)-%.pdf: $(GENOUTNAME)-%.tex $(EXE) $(GENINNAME)-%.tex
	ln -f $(GENINNAME)-$*.tex $(GENINNAME).tex
	pdflatex $<
	rm $(GENINNAME).tex

# Test

.PHONY: test

test: test-gen


# Cleanup

.PHONY: clean distclean

clean:
	dune clean
	rm -f *.aux *.log

distclean: clean
	rm -f $(GENNAME).tex
	rm -f *.pdf
