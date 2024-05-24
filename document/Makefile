DIRS     = core js-api web-api legacy/exception-handling
FILES    = index.html
BUILDDIR = _build

# Global targets.

.PHONY: all
all: $(BUILDDIR) root $(DIRS)

$(BUILDDIR):
	mkdir -p $@

.PHONY: deploy
deploy:
	GIT_DEPLOY_DIR=$(BUILDDIR) bash deploy.sh

.PHONY: publish
publish: all deploy

.PHONY: clean
clean: $(DIRS:%=clean-%)
	rm -rf $(BUILDDIR)

.PHONY: diff
diff: $(DIRS:%=diff-%)


# Directory-specific targets.

.PHONY: root
root: $(BUILDDIR)
	touch $(BUILDDIR)/.nojekyll
	cp -f $(FILES) $(BUILDDIR)/

.PHONY: $(DIRS)
$(DIRS): %: $(BUILDDIR) $(DIRS:%=build-%) $(DIRS:%=dir-%)

.PHONY: $(DIRS:%=build-%)
$(DIRS:%=build-%): build-%:
	(cd $(@:build-%=%); make BUILDDIR=$(BUILDDIR) all)

.PHONY: $(DIRS:%=dir-%)
$(DIRS:%=dir-%): dir-%:
	mkdir -p $(BUILDDIR)/$(@:dir-%=%)
	rm -rf $(BUILDDIR)/$(@:dir-%=%)/*
	cp -R $(@:dir-%=%)/$(BUILDDIR)/html/* $(BUILDDIR)/$(@:dir-%=%)/

.PHONY: $(DIRS:%=deploy-%)
$(DIRS:%=deploy-%): deploy-%:
	GIT_DEPLOY_DIR=$(BUILDDIR) GIT_DEPLOY_SUBDIR=$(@:deploy-%=%) bash deploy.sh

.PHONY: $(DIRS:%=publish-%)
$(DIRS:%=publish-%): publish-%: % deploy-%

.PHONY: $(DIRS:%=clean-%)
$(DIRS:%=clean-%): clean-%:
	(cd $(@:clean-%=%); make BUILDDIR=$(BUILDDIR) clean)
	rm -rf $(BUILDDIR)/$(@:clean-%=%)

.PHONY: $(DIRS:%=diff-%)
$(DIRS:%=diff-%): diff-%:
	(cd $(@:diff-%=%); make BUILDDIR=$(BUILDDIR) diff)


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
