#!/bin/bash

# skip if build is triggered by pull request
if [ $TRAVIS_PULL_REQUEST == "true" ]; then
  echo "this is PR, exiting"
  exit 0
fi

# enable error reporting to the console
set -e

# cleanup "_site"
rm -rf _site
mkdir _site

# clone remote repo to "_site"
git clone https://${GH_TOKEN}@github.com/fakepaperclips/molecule.git --branch gh-pages _site

# build with Jekyll into "_site"
bundle exec jekyll build

# push
cd _site
git config user.email "molecule@berkeley.edu"
git config user.name "Molly Nicholas"
git add --all
git commit -a -m "Travis #$TRAVIS_BUILD_NUMBER"
git push --force origin gh-pages
