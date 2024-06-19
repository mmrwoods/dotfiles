#!/bin/bash

set -e

if test "$1" == ""; then
  echo "usage: $0 <branch>"
  exit 1
fi

# Check we are not in detached HEAD state
git symbolic-ref HEAD >/dev/null

# Check that target branch is a valid ref
git show-ref --verify refs/heads/$1 > /dev/null

# Set upstream to common ancestor to avoid adding new commits from target
upstream=$(git merge-base HEAD $1)

merges=$(git log --oneline --merges $upstream..HEAD)
if test -n "$merges"; then
  echo "fatal: merge commits found, cannot automatically squash" >&2
  echo "hint: use \`git rebase -i -r\` to rebase and retain merges" >&2
  exit 1
fi

# Spit out a list of commits and ask user to confirm they want to squash
git log --oneline $upstream..HEAD
read -rp "Squash these commits? [y/n]"
if test "$REPLY" != "y"; then exit; fi

# Rebase the current branch interactively on the target branch, but use ed as
# the sequence editor and replace pick with squash on all but the first line.
# This just automates what you could manually do in vim, it just looks really
# messy because we need to use printf to send ed commands on separate lines.
git -c sequence.editor="printf \"%s\n\" \"2,\\\$s/^pick/squash/\" wQ | ed -s" rebase -i $upstream
