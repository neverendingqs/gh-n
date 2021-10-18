#!/bin/bash
set -e

DIRNAME=$(dirname ${0})
COMMAND=${1}

cat ${DIRNAME}/${COMMAND}.sh
