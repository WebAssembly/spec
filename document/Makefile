DIRS     = core js-api web-api
FILES    = index.html
BUILDDIR = _build

# Global targets.

.PHONY: all
all: $(DIRS)

$(BUILDDIR):
	mkdir -p $@
	cp -f $(FILES) $(BUILDDIR)/
	touch $(BUILDDIR)/.nojekyll

.PHONY: deploy
deploy:
	GIT_DEPLOY_DIR=$(BUILDDIR) bash deploy.sh

.PHONY: publish
publish: all deploy

.PHONY: clean
clean: $(DIRS:%=clean-%)
	rm -rf $(BUILDDIR)


# Directory-specific targets.

.PHONY: $(DIRS)
$(DIRS): %: $(BUILDDIR)
	(cd $@; make BUILDDIR=$(BUILDDIR) all)
	mkdir -p $(BUILDDIR)/$@
	cp -R $@/$(BUILDDIR)/html/* $(BUILDDIR)/$@/

.PHONY: $(DIRS:%=deploy-%)
$(DIRS:%=deploy-%):
	GIT_DEPLOY_DIR=$(BUILDDIR) GIT_DEPLOY_SUBDIR=$(@:deploy-%=%) bash deploy.sh

.PHONY: $(DIRS:%=publish-%)
$(DIRS:%=publish-%): publish-%: % deploy-%

.PHONY: $(DIRS:%=clean-%)
$(DIRS:%=clean-%):
	(cd $(@:clean-%=%); make BUILDDIR=$(BUILDDIR) clean)
	rm -rf $(BUILDDIR)/$(@:clean-%=%)


# Help.

.PHONY: help
help:
	@echo "Please use \`make <target>' where <target> is one of"
	@echo "  all             to build all documents"
	@echo "  publish         to make all and push to gh-pages"
	@echo "  <dir>           to build a specific subdirectory"
	@echo "  publish-<dir>   to build and push a specific subdirectory"

.PHONY: usage
usage: help
