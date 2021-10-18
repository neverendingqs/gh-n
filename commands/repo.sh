#!/bin/bash
set -eu

# TODO: branch protection, editorconfig, sponsorship

DIRNAME=$(dirname ${0})

CMD=${1}
SUBCMD=${2}
PARAM_0=${3-main}

function set() {
  case "${SUBCMD}" in

  branch-protection)
    gh api repos/{owner}/{repo}/branches/{branch}/protection \
      --method PUT \
      --field branch=${PARAM_0} \
      --input ${DIRNAME}/payload/repo.branch-protection.json
    ;;

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
