#!/bin/bash
set -eu

# TODO: branch protection, editorconfig, sponsorship

CMD=${1}
SUBCMD=${2}

function set() {
  case "${SUBCMD}" in
  merge-button)
    gh api repos/{owner}/{repo} \
      --method PATCH \
      --field allow_squash_merge=true \
      --field allow_merge_commit=false \
      --field allow_rebase_merge=false \
      --field delete_branch_on_merge=true
    ;;
  *)
    echo "Unsupported command \"${CMD} ${SUBCMD}\""
    ;;
  esac
}

case "${CMD}" in
set)
  set
  ;;
*)
  echo "Unsupported command \"${CMD}\""
  ;;
esac
