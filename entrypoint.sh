#!/bin/sh

set -eu

# Github by default does shallow clones, where there is only one single commit
# which adds everything.  In this action I’m only trying to check what was
# /added/ in this commit, not the entire repo, so we need the diff with the
# previous version.
git fetch --deepen=2

>&2 echo

# This works for pull_request and push because on a pr github actions will
# create a synthetic merge commit and run the action on that, so this
# encompasses the entire potential merge.
if git show -m | grep '^[+d].*NO\(COMMIT\|MERGE\)'; then
   >&2 cat <<EOF


This commit adds a line or file containing the string 'nomerge' or 'nocommit'.
The exact line(s) are shown above.

This tag is added, usually in comments, log statements or filenames, by people
who want to avoid accidentally merging temporary code to master.  The GitHub
Action you're looking at was installed to help catch that.  If this is your PR
and you added it yourself, you'll probably know what to do.

If this is your PR, but you never added a 'nocommit' or 'nomerge' tag, it's
possible you moved a file around, which happened to contain that tag.  Git
implements 'moving' as 'remove + add', so this check gets triggered as if it's
new.  You can check with colleagues where this tag comes from, and if it should
remain, or you can try to just ignore this check if that's appropriate.

N.B.: by "tag" I just mean the actual letters--grep is used to find them, there
is no special notation necessary for your programming language.  The string has
to be capitalized. It's not capitalized in this error message to avoid tripping
up over my own check.

More info at https://github.com/nobssoftware/nocommit/

Good luck!
EOF
   exit 1
fi
