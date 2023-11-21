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

all: test


# Test

.PHONY: test

test: test-gen test-latex test-sphinx


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


# Latex splicing

SPLICEINNAME = spec-splice.in
SPLICEOUTNAME = spec-splice

.PHONY: test-splice

test-latex: $(SPECS:%=$(SPLICEOUTNAME)-%.pdf)

$(SPLICEOUTNAME)-%.tex: $(SPLICEINNAME).tex $(SPECFILES) $(EXE)
	cp $< $@
	(cd $(SPECDIR)/$* && $(EXE) *.$(EXT) -p $(OWNDIR)/$@)

$(SPLICEOUTNAME)-%.pdf: $(SPLICEOUTNAME)-%.tex
	pdflatex $<


# Sphinx splicing

SPHINXINNAME = spec-sphinx.in
SPHINXOUTNAME = spec-sphinx
SPHINXDIR = _sphinx

.PHONY: test-sphinx

test-sphinx: $(SPECS:%=sphinx-splice-%)

$(SPHINXOUTNAME)-%.rst: $(SPHINXINNAME).rst $(SPECFILES) $(EXE)
	cp $< $@
	(cd $(SPECDIR)/$* && $(EXE) *.$(EXT) --sphinx -p $(OWNDIR)/$@)

sphinx-splice-%: sphinx-html-% sphinx-pdf-%
	#

sphinx-html-%: $(SPHINXOUTNAME)-%.rst conf.py
	mkdir -p $(SPHINXDIR)/_build
	cp $(SPHINXOUTNAME)-$*.rst $(SPHINXDIR)/$(SPHINXOUTNAME).rst
	cp conf.py $(SPHINXDIR)
	sphinx-build -W -b html $(SPHINXDIR) $(SPHINXDIR)/_build
	sed "s/textsc{/mathrm{/g" $(SPHINXDIR)/_build/$(SPHINXOUTNAME).html >$(SPHINXOUTNAME).html.tmp
	mv -f $(SPHINXOUTNAME).html.tmp $(SPHINXDIR)/_build/$(SPHINXOUTNAME)-$*.html

sphinx-pdf-%: $(SPHINXOUTNAME)-%.rst conf.py
	mkdir -p $(SPHINXDIR)/_build
	cp $(SPHINXOUTNAME)-$*.rst $(SPHINXDIR)/$(SPHINXOUTNAME).rst
	cp conf.py $(SPHINXDIR)
	sphinx-build -W -b latex $(SPHINXDIR) $(SPHINXDIR)/_build
	(cd $(SPHINXDIR)/_build && ln -f $(SPHINXOUTNAME).tex $(SPHINXOUTNAME)-$*.tex && pdflatex $(SPHINXOUTNAME)-$*.tex)


# Executable

$(EXE): exe

exe:
	@(cd ..; make exe)


# Cleanup

.PHONY: clean distclean

clean:
	dune clean
	rm -f *.aux *.log
	rm -rf $(SPHINXDIR)

distclean: clean
	rm -f $(GENINNAME)-*.tex $(SPLICEOUTNAME)-*.tex $(SPHINXOUTNAME)-*.rst
	rm -f *.pdf
