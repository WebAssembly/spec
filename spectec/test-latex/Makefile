# Configuration

NAME = watsup
EXE = $(PWD)/../$(NAME)
EXT = $(NAME)

OWNDIR = $(PWD)
SPECDIR = ../spec
SPECS = $(shell cd $(SPECDIR) && ls -d wasm-*)
SPECFILES = $(shell ls $(SPECS:%=$(SPECDIR)/%/*.$(EXT)))
TESTFILES = $(shell ls *.$(EXT))


# Main targets

.PHONY: all

all: test


# Test

.PHONY: test


test: test-gen


# Latex generation

GENINNAME = spec-gen.include
GENOUTNAME = spec-gen

.PHONY: gen test-gen test-test
.INTERMEDIATE: $(SPECS:%=$(GENINNAME)-%.tex) $(TESTFILES:%.$(EXT)=%.tex)

gen: $(SPECS:%=$(GENINNAME)-%.tex)

test-gen: $(SPECS:%=$(GENOUTNAME)-%.pdf) test-test

$(GENINNAME)-%.tex: $(SPECFILES) $(EXE)
	(cd $(SPECDIR)/$* && $(EXE) *.$(EXT) -o $(OWNDIR)/$@)

$(GENOUTNAME)-%.tex: $(GENOUTNAME).tex
	ln -f $< $@

$(GENOUTNAME)-%.pdf: $(GENOUTNAME)-%.tex $(EXE) $(GENINNAME)-%.tex
	ln -f $(GENINNAME)-$*.tex $(GENINNAME).tex
	pdflatex $<
	rm $(GENINNAME).tex

test-test: $(TESTFILES:%.$(EXT)=test-%.pdf)

test-%.tex: %.$(EXT) $(EXE)
	$(EXE) $< -o $@

test-%.pdf: test-%.tex $(GENOUTNAME).tex
	ln -f $< $(GENINNAME).tex
	ln -f $(GENOUTNAME).tex $<
	pdflatex $<
	rm $(GENINNAME).tex $<


# Executable

$(EXE): exe

exe:
	@(cd ..; make exe)


# Cleanup

.PHONY: clean distclean

clean:
	dune clean
	rm -f *.aux *.log

distclean: clean
	rm -f $(GENINNAME)-*.tex test-*.tex
	rm -f *.pdf
