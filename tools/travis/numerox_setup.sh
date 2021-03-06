#!/usr/bin/env bash

set -ev # exit on first error, print commands

if [ "${TEST_RUN}" = "style" ]; then
    flake8 --exclude=doc .
else
    if [ "${TEST_RUN}" = "sdist" ]; then
        python setup.py sdist
        ARCHIVE=`ls dist/*.tar.gz`
        pip install --verbose "${ARCHIVE[0]}"
    else
        pip install --verbose "."
    fi
    # Workaround for https://github.com/travis-ci/travis-ci/issues/6522
    set +e
    python "tools/test-installed-numerox.py"
fi
