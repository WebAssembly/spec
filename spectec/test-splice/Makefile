# Configuration

NAME = watsup
EXE = $(PWD)/../$(NAME)
EXT = $(NAME)

OWNDIR = $(PWD)
SPECDIR = ../spec/wasm-3.0
SPECFILES = $(shell ls $(SPECDIR)/*.$(EXT))


# Main targets

.PHONY: all

all: latex-splice sphinx-splice


# Latex splicing

SPLICEINNAME = spec-splice.in
SPLICEOUTNAME = spec-splice

.PHONY: latex-splice

$(SPLICEOUTNAME).tex: $(SPLICEINNAME).tex $(SPECFILES) $(EXE)
	(cd $(SPECDIR) && $(EXE) *.$(EXT) --splice-latex -p $(OWNDIR)/$< -o $(OWNDIR)/$@)

latex-splice: $(SPLICEOUTNAME).tex
	pdflatex $<


# Sphinx splicing

SPHINXINNAME = spec-sphinx.in
SPHINXOUTNAME = spec-sphinx
SPHINXDIR = _sphinx

.PHONY: sphinx-splice sphinx-html sphinx-pdf

$(SPHINXOUTNAME).rst: $(SPHINXINNAME).rst $(SPECFILES) $(EXE)
	(cd $(SPECDIR) && $(EXE) *.$(EXT) --splice-sphinx -p $(OWNDIR)/$< -o $(OWNDIR)/$@)

sphinx-splice: sphinx-html sphinx-pdf

sphinx-html: $(SPHINXOUTNAME).rst conf.py
	mkdir -p $(SPHINXDIR)/_build
	cp $(SPHINXOUTNAME).rst conf.py $(SPHINXDIR)
	sphinx-build -W -b html $(SPHINXDIR) $(SPHINXDIR)/_build
	sed "s/textsc{/mathrm{/g" $(SPHINXDIR)/_build/$(SPHINXOUTNAME).html >$(SPHINXOUTNAME).html.tmp
	mv -f $(SPHINXOUTNAME).html.tmp $(SPHINXDIR)/_build/$(SPHINXOUTNAME).html

sphinx-pdf: $(SPHINXOUTNAME).rst conf.py
	mkdir -p $(SPHINXDIR)/_build
	cp $(SPHINXOUTNAME).rst conf.py $(SPHINXDIR)
	sphinx-build -W -b latex $(SPHINXDIR) $(SPHINXDIR)/_build
	(cd $(SPHINXDIR)/_build; pdflatex $(SPHINXOUTNAME).tex)


# Test

.PHONY: test

test: latex-splice sphinx-splice


# Cleanup

.PHONY: clean distclean

clean:
	dune clean
	rm -f *.aux *.log
	rm -rf $(SPHINXDIR)

distclean: clean
	rm -f $(SPLICEOUTNAME).tex $(SPHINXOUTNAME).rst
	rm -f *.pdf
