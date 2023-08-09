# Configuration

NAME = watsup
EXE = $(PWD)/../$(NAME)
EXT = $(NAME)

OWNDIR = $(PWD)
SPECDIR = ../spec
SPECFILES = $(shell ls $(SPECDIR)/*.$(EXT))

SPHINXBUILD = sphinx-build
SPHINXDIR = _sphinx
BUILDDIR = _sphinx/_build

# Main targets

.PHONY: all

all: pdf

# Sphinx splicing

INDEX = index

SYNTAX = syntax

SYNTAXFILES = $(wildcard $(SYNTAX)/*-in.rst)

SYNTAXINPUT = $(strip $(subst " ", " ", $(SYNTAXFILES)))

SYNTAXOUTPUT = $(strip $(subst -in.rst,.rst,$(SYNTAXFILES)))

EXEC = exec

EXECFILES = $(wildcard $(EXEC)/*-in.rst)

EXECINPUT = $(strip $(subst " ", " ", $(EXECFILES)))

EXECOUTPUT = $(strip $(subst -in.rst,.rst,$(EXECFILES)))

VALID = valid

VALIDFILES = $(wildcard $(VALID)/*-in.rst)

VALIDINPUT = $(strip $(subst " ", " ", $(VALIDFILES)))

VALIDOUTPUT = $(strip $(subst -in.rst,.rst,$(VALIDFILES)))

UTIL = util

MACRO = macros.def

.PHONY: splice

splice: $(SYNTAX) $(EXEC) $(VALID) $(UTIL)
	$(EXE) $(SPECDIR)/*.$(EXT) --sideconditions --animate --splice-sphinx -o $(SYNTAXOUTPUT) $(EXECOUTPUT) $(VALIDOUTPUT) -p $(SYNTAXINPUT) $(EXECINPUT) $(VALIDINPUT) 
ifneq ($(wildcard $(MACRO)),) 
	mv $(MACRO) $(UTIL)
else
	touch $(UTIL)/$(MACRO)
endif

.PHONY: doc

doc: conf.py $(INDEX).rst splice

.PHONY: html

html: doc
	mkdir -p $(BUILDDIR)
	cp -r conf.py $(INDEX).rst $(SYNTAX) $(EXEC) $(VALID) $(UTIL) $(SPHINXDIR)
	rm -f $(SPHINXDIR)/$(SYNTAX)/*-in.rst
	rm -f $(SPHINXDIR)/$(EXEC)/*-in.rst
	rm -f $(SPHINXDIR)/$(VALID)/*-in.rst
	$(SPHINXBUILD) -b html -d $(SPHINXDIR)/doctrees $(SPHINXDIR) $(BUILDDIR)/html
	@echo "html finished; the HTML pages are in $(BUILDDIR)/html."

.PHONY: pdf

pdf: latexpdf 
	cp $(BUILDDIR)/latex/*.pdf .
	@echo "pdf finished; the PDF files are in the current directory."

.PHONY: latexpdf

latexpdf: doc
	mkdir -p $(BUILDDIR)
	cp -r conf.py $(INDEX).rst $(SYNTAX) $(EXEC) $(VALID) $(UTIL) $(SPHINXDIR)
	rm -f $(SPHINXDIR)/$(SYNTAX)/*-in.rst
	rm -f $(SPHINXDIR)/$(EXEC)/*-in.rst
	rm -f $(SPHINXDIR)/$(VALID)/*-in.rst
	$(SPHINXBUILD) -b latex -d $(SPHINXDIR)/doctrees $(SPHINXDIR) $(BUILDDIR)/latex
	$(MAKE) -C $(BUILDDIR)/latex LATEXMKOPTS=" </dev/null" all-pdf >$(BUILDDIR)/latex/LOG 2>&1 || cat $(BUILDDIR)/latex/LOG
	@echo "pdflatex finished; the PDF files are in $(BUILDDIR)/latex."

# Cleanup

.PHONY: clean

clean:
	dune clean
	rm -f *.aux *.log
	rm -rf $(SPHINXDIR)
	rm -f $(SYNTAXOUTPUT)
	rm -f $(EXECOUTPUT) 
	rm -f $(VALIDOUTPUT)
	rm -f $(UTIL)/$(MACRO)
	rm -f *.pdf
