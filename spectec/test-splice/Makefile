# Configuration

NAME = watsup
EXE = $(PWD)/../$(NAME)
EXT = $(NAME)

OWNDIR = $(PWD)
SPECDIR = ../spec
SPECS = $(shell cd $(SPECDIR) && ls -d wasm-*)
SPECFILES = $(shell ls $(SPECS:%=$(SPECDIR)/%/*.$(EXT)))


# Main targets

.PHONY: all

all: test


# Test

.PHONY: test

test: test-latex test-sphinx


# Latex splicing

LATEXINNAME = spec-latex.in
LATEXOUTNAME = spec-latex

.PHONY: test-latex

test-latex: $(SPECS:%=$(LATEXOUTNAME)-%.pdf)

$(LATEXOUTNAME)-%.tex: $(LATEXINNAME).tex $(SPECFILES) $(EXE)
	(cd $(SPECDIR)/$* && $(EXE) *.$(EXT) --splice-latex -p $(OWNDIR)/$< -o $(OWNDIR)/$@)

$(LATEXOUTNAME)-%.pdf: $(LATEXOUTNAME)-%.tex
	pdflatex $<


# Sphinx splicing

SPHINXINNAME = spec-sphinx.in
SPHINXOUTNAME = spec-sphinx
SPHINXDIR = _sphinx

.PHONY: test-sphinx

test-sphinx: $(SPECS:%=sphinx-splice-%)

$(SPHINXOUTNAME)-%.rst: $(SPHINXINNAME).rst $(SPECFILES) $(EXE)
	(cd $(SPECDIR)/$* && $(EXE) *.$(EXT) --splice-sphinx -p $(OWNDIR)/$< -o $(OWNDIR)/$@)

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
	rm -f $(LATEXOUTNAME)-*.tex $(SPHINXOUTNAME)-*.rst
	rm -f *.pdf
