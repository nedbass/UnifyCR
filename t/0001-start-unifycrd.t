#!/bin/bash

test_description="Test basic UnifycR functionality"

. $(dirname $0)/sharness.sh

test_expect_success "Start unifycrd" '
    basedir=$(dirname "$0")
    killall -q unifycrd
    rm -rf $UNIFYCR_META_DB_PATH
    mkdir $UNIFYCR_META_DB_PATH
    mpirun -wd $SHARNESS_BUILD_DIRECTORY -np 1 $UNIFYCRD &
'

test_expect_success "unifycrd running" 'process_is_running unifycrd 15'

test_done
