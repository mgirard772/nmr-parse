#!/bin/bash

REPO_NAME=nmr-parse

if [ ! -d "$REPO_NAME" ]; then
  echo "Cloning repo at branch $BRANCH"
  git clone -b $BRANCH https://$GITHUB_PAT@github.com/mgirard772/$REPO_NAME.git $REPO_NAME
fi

echo "Entering src directory"
cd $REPO_NAME/src

echo "exec $@"
exec "$@"
