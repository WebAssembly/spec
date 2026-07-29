NAME = NanoWasm
SPECTECDIR = ../..
SPECTEC = $(SPECTECDIR)/spectec
SPHINX = sphinx-build
BUILDDIR = _build


# Menu

default:
	@echo "Targets available:"
	@echo "make check    (run SpecTec)"
	@echo "make rst      (run SpecTec splicing)"
	@echo "make html     (run SpecTec + Sphinx)"
	@echo "make latex    (run SpecTec + Sphinx)"
	@echo "make pdf      (run SpecTec + Sphinx + Latex)"
	@echo "make all      (run everything)"
	@echo "make out      (run everything and update output directory)"
	@echo "make spectec  (build updir SpecTec)"

all: rst html latex pdf


# Building SpecTec itself

spectec:
	(cd $(SPECTECDIR); make exe >/dev/null)


# Running SpecTec

check: $(NAME).spectec
	$(SPECTEC) $(NAME).spectec


# Running SpecTec splicing

RSTFILE = $(NAME).rst

rst: $(RSTFILE)

$(RSTFILE): $(NAME).rst.in $(NAME).spectec
	$(SPECTEC) $(NAME).spectec --splice-sphinx -p $< -o $@


# Running Sphinx

HTMLFILE = $(BUILDDIR)/html/$(NAME).html
TEXFILE = $(BUILDDIR)/latex/$(NAME).tex

html: $(HTMLFILE)

$(HTMLFILE): $(RSTFILE) conf.py
	$(SPHINX) -b html -d $(BUILDDIR)/doctrees . $(BUILDDIR)/html

latex: $(TEXFILE)

$(TEXFILE): $(RSTFILE) conf.py
	$(SPHINX) -b latex -d $(BUILDDIR)/doctrees . $(BUILDDIR)/latex


# Running Latex

PDFFILE = $(BUILDDIR)/latex/$(NAME).pdf

pdf: $(PDFFILE)

$(PDFFILE): $(TEXFILE)
	$(MAKE) -C $(BUILDDIR)/latex LATEXMKOPTS=" </dev/null" all-pdf


# Copying to output directory

out: $(PDFFILE) $(HTMLFILE)
	cp -rf $^ output


# Clean-up

clean:
	rm -f $(NAME).rst
	rm -rf $(BUILDDIR)
