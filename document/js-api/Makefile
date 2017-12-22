BUILDDIR      = _build
STATICDIR     = _static
DOWNLOADDIR   = _download
NAME          = WebAssembly

.PHONY: all
all:
	mkdir -p $(BUILDDIR)/html
	bikeshed spec index.bs $(BUILDDIR)/html/index.html
	@echo "Build finished. The HTML pages are in `pwd`/$(BUILDDIR)/html."

.PHONY: publish
publish:
	(cd ..; make publish-js-api)

.PHONY: clean
clean:
	rm -rf $(BUILDDIR)
	rm -rf $(STATICDIR)
