BUILDDIR      = _build
STATICDIR     = _static
DOWNLOADDIR   = _download
NAME          = WebAssembly

.PHONY: all
all:
	mkdir -p $(BUILDDIR)/html
	# TODO(littledan): remove dummy and properly build into $(BUILDDIR)/html
	touch $(BUILDDIR)/html/index.html
	@echo "Build finished. The HTML pages are in `pwd`/$(BUILDDIR)/html."

.PHONY: publish
publish:
	(cd ..; make publish)

.PHONY: clean
clean:
	rm -rf $(BUILDDIR)
	rm -rf $(STATICDIR)
