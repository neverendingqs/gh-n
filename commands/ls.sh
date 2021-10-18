#!/bin/bash
set -e

DIRNAME=$(dirname ${0})

ls ${DIRNAME} | grep '\.sh$'
