#!/bin/sh

set -eu

# Github by default does shallow clones, where there is only one single commit
# which adds everything.  In this action I’m only trying to check what was
# /added/ in this commit, not the entire repo, so we need the diff with the
# previous version.
git fetch --deepen=2
# This works for pull_request and push because on a pr github actions will
# create a synthetic merge commit and run the action on that, so this
# encompasses the entire potential merge.
! git show -m | grep '^[+d].*NO\(COMMIT\|MERGE\)'
