#!/bin/sh

set -eu

# This works for pull_request and push because on a pr github actions will
# create a synthetic merge commit and run the action on that, so this
# encompasses the entire potential merge.
! git show -m | grep '^[+d].*NO\(COMMIT\|MERGE\)'
