#!/bin/bash
set -eu

# TODO: branch protection, editorconfig, sponsorship

# TODO: setup subcommand, rename "standardize"

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
