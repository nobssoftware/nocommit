#!/bin/sh

# This pre-commit hook will prevent you from committing any line (or filename) containing
# the string NOCOMMIT. Use that tag in comments around source code you want to avoid
# accidentally committing, like temporary IP addresses or debug printfs.
#
# To add it to an existing repository, save it to .git/hooks/pre-commit (or append, if
# that file already exists). Remember to make executable (chmod +x ...)
#
# To automatically add this pre-commit hook to every repository you create or clone:
#
# mkdir -p "$HOME/.git_template/hooks"
# git config --global init.templatedir "$HOME/.git_template"
# cd "$HOME/.git_template/hooks"
# wget https://gist.githubusercontent.com/hraban/10c7f72ba6ec55247f2d/raw/pre-commit
# chmod +x pre-commit
#

if git diff --cached | grep '^[+d].*NOCOMMIT'; then
    echo
    echo "Adding line containing NOCOMMIT"
    exit 1
fi