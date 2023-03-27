# Configuration

NAME = watsup
EXE = $(PWD)/../$(NAME)
EXT = $(NAME)

OWNDIR = $(PWD)
SPECDIR = ../spec
SPECFILES = $(shell ls $(SPECDIR)/*.$(EXT))


# Main targets

.PHONY: all

all: latex-gen latex-splice sphinx-splice


# Latex generation

GENNAME = spec-gen-include
GENOUTNAME = spec-gen

.PHONY: latex-gen gen

$(GENNAME).tex: $(SPECFILES) $(EXE)
	(cd $(SPECDIR) && $(EXE) *.$(EXT) -o $(OWNDIR)/$@)

gen: $(GENNAME).tex

latex-gen: $(GENOUTNAME).tex gen
	pdflatex $<


# Latex splicing

SPLICEINNAME = spec-splice-in
SPLICEOUTNAME = spec-splice

.PHONY: latex-splice

$(SPLICEOUTNAME).tex: $(SPLICEINNAME).tex $(SPECFILES) $(EXE)
	cp $< $@
	(cd $(SPECDIR) && $(EXE) *.$(EXT) -p $(OWNDIR)/$@)

latex-splice: $(SPLICEOUTNAME).tex
	pdflatex $<


# Sphinx splicing

SPHINXINNAME = spec-sphinx-in
SPHINXOUTNAME = spec-sphinx
SPHINXDIR = _sphinx

.PHONY: sphinx-splice

$(SPHINXOUTNAME).rst: $(SPHINXINNAME).rst $(SPECFILES) $(EXE)
	cp $< $@
	(cd $(SPECDIR) && $(EXE) *.$(EXT) --sphinx -p $(OWNDIR)/$@)

sphinx-splice: $(SPHINXOUTNAME).rst conf.py
	mkdir -p $(SPHINXDIR)/_build
	cp $(SPHINXOUTNAME).rst conf.py $(SPHINXDIR)
	sphinx-build -b html $(SPHINXDIR) $(SPHINXDIR)/_build


# Test

.PHONY: test

test: latex-gen latex-splice sphinx-splice


# Cleanup

.PHONY: clean distclean

clean:
	dune clean
	rm -f *.aux *.log
	rm -rf $(SPHINXDIR)

distclean: clean
	rm -f $(GENNAME).tex $(SPLICEOUTNAME).tex $(SPHINXOUTNAME).rst
	rm -f *.pdf
