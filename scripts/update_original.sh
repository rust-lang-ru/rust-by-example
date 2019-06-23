#!/bin/bash

set -euv

CURRENT_DIR=`dirname $0`
source "${CURRENT_DIR}/common.sh"

ORIGINAL_REPO="https://github.com/rust-lang/rust-by-example.git"

cd "${ROOT_DIR}"

git pull origin master
rm -rf "${ORIGINAL_DIR}"
git clone --depth=1 "${ORIGINAL_REPO}" "${ORIGINAL_DIR}"
rm -rf "${ORIGINAL_DIR}/.git"

git add -A "${ORIGINAL_DIR}"
git commit -m 'update original'
git push origin master

#
