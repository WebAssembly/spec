#!/bin/bash

# Adapted from https://github.com/heycam/webidl/blob/master/deploy.sh

set -e # Exit with nonzero exit code if anything fails

SOURCE_BRANCH="master"
TARGET_BRANCH="gh-pages"

function doCompile {
  # TODO(littledan): Integrate with document/deploy.sh
  (cd document; make clean)
  (cd document; make)
}

# Pull requests and commits to other branches shouldn't try to deploy, just build to verify
if [[ "$TRAVIS_PULL_REQUEST" != "false" || "$TRAVIS_BRANCH" != "$SOURCE_BRANCH" ]]; then
  echo "Skipping deploy; just doing a build."
  doCompile
  exit 0
fi

# Save some useful information
REPO=`git config remote.origin.url`
SSH_REPO=${REPO/https:\/\/github.com\//git@github.com:}
SHA=`git rev-parse --verify HEAD`

# Get the deploy key by using Travis's stored variables to decrypt deploy_key.enc
ENCRYPTED_KEY_VAR="encrypted_${ENCRYPTION_LABEL}_key"
ENCRYPTED_IV_VAR="encrypted_${ENCRYPTION_LABEL}_iv"
ENCRYPTED_KEY=${!ENCRYPTED_KEY_VAR}
ENCRYPTED_IV=${!ENCRYPTED_IV_VAR}
openssl aes-256-cbc -K $ENCRYPTED_KEY -iv $ENCRYPTED_IV -in deploy_key.enc -out deploy_key -d || true
chmod 600 deploy_key
eval `ssh-agent -s`
ssh-add deploy_key || true

# Clone the existing gh-pages for this repo into _build/
# Create a new empty branch if gh-pages doesn't exist yet (should only happen
# on first deploy).
# Ensure no checkout in _build.
rm -rf document/_build
# Clone a second checkout of our repo to _build.
git clone $REPO document/_build
(
  # Checkout a parentless branch of gh-pages.
  cd document/_build
  git checkout $TARGET_BRANCH || git checkout --orphan $TARGET_BRANCH

  # Clean out existing contents (to be replaced with output from the build
  # that happens after this).
  rm -rf ./*
)

# Run our compile script (output into _build).
doCompile

# Set user info on the gh-pages repo in _build.
cd document/_build
git config user.name "Travis CI"
git config user.email "$COMMIT_AUTHOR_EMAIL"

# If there are no changes to the compiled out (e.g. this is a README update) then just bail.
if [[ -z "$(git status --porcelain)" ]]; then
  echo "No changes to the output on this push; exiting."
  exit 0
fi

# Commit the "changes", i.e. the new version.
# The delta will show diffs between new and old versions.
git add --all .
git commit -m "Deploy to GitHub Pages: ${SHA}"

# Now that we're all set up, we can push.
git push $SSH_REPO $TARGET_BRANCH
