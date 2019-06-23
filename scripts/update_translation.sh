#!/bin/bash

set -uev

CURRENT_DIR=`dirname $0`
source "${CURRENT_DIR}/common.sh"

cd "${ROOT_DIR}"

TRANSLATION_REPO="git@github.com:ruRust/rust-by-example-ru.git"
TRANSLATION_BRANCH="master"
WORK_DIR=`mktemp -d`

git clone $TRANSLATION_REPO -b $TRANSLATION_BRANCH $WORK_DIR

rsync -aougrhtl "${TRANSLATION_DIR}" "${WORK_DIR}"

cd "${WORK_DIR}"
git add -A .
git commit -m 'update translation'
git push origin "${TRANSLATION_BRANCH}"

cd "${ROOT_DIR}"

rm -rf "${WORK_DIR}"

#
