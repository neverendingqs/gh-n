#!/bin/bash
set -eu

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

  editorconfig)
    gh api repos/{owner}/{repo}/contents/.editorconfig \
      --method PUT \
      --field message='chore(editorconfig): init.' \
      --field content="$(base64 ${DIRNAME}/payload/repo.editorconfig.editorconfig)" \
      --field branch=${PARAM_0}
    ;;

  merge-button)
    gh api repos/{owner}/{repo} \
      --method PATCH \
      --field allow_squash_merge=true \
      --field allow_merge_commit=false \
      --field allow_rebase_merge=false \
      --field delete_branch_on_merge=true
    ;;

  sponsorship)
    gh api repos/{owner}/{repo}/contents/.github/FUNDING.yml \
      --method PUT \
      --field message='chore(funding): init.' \
      --field content="$(base64 ${DIRNAME}/payload/repo.sponsorship.FUNDING.yml)" \
      --field branch=${PARAM_0}

    echo "Sponsorships should be automatically enabled now under 'https://github.com/$(gh repo view --json nameWithOwner --jq .nameWithOwner)/settings'!"
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
