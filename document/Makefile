DIRS     = core js-api web-api
FILES    = index.html
BUILDDIR = _build

.PHONY: all
all:
	for dir in $(DIRS); \
	do \
	  (cd $$dir; make BUILDDIR=$(BUILDDIR) all) \
	done

.PHONY: deploy
deploy:
	mkdir -p $(BUILDDIR)
	cp -f $(FILES) $(BUILDDIR)/
	for dir in $(DIRS); \
	do \
	  mkdir -p $(BUILDDIR)/$$dir; \
	  cp -R $$dir/$(BUILDDIR)/html/* $(BUILDDIR)/$$dir/; \
	done
	touch $(BUILDDIR)/.nojekyll
	GIT_DEPLOY_DIR=$(BUILDDIR) sh deploy.sh
	rm -rf $(BUILDDIR)

.PHONY: publish
publish: all deploy

.PHONY: clean
clean:
	rm -rf $(BUILDDIR)
	for dir in $(DIRS); \
	do \
	  (cd $$dir; make BUILDDIR=$(BUILDDIR) clean) \
	done

.PHONY: help
help:
	@echo "Please use \`make <target>' where <target> is one of"
	@echo "  all        to build all documents"
	@echo "  publish    to make all and push to gh-pages"

.PHONY: usage
usage: help
