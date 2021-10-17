#!/bin/bash
set -eu

case "${1}" in
standardize)
  gh api repos/{owner}/{repo} \
    --method PATCH \
    --field allow_squash_merge=true \
    --field allow_merge_commit=false \
    --field allow_rebase_merge=false \
    --field delete_branch_on_merge=true
  ;;
*)
  echo "Unsupported command ${1}"
  ;;
esac
