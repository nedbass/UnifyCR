#!/bin/bash

test_description="Shut down unifycrd"

. $(dirname $0)/sharness.sh

#
# TODO: fix premature death of unifycrd under travis
#
if test "$TRAVIS" == "true"; then
    test_fn=test_expect_failure
else
    test_fn=test_expect_success
fi

$test_fn "unifycrd still running" 'process_is_running unifycrd 2'

$test_fn "Stop unifycrd" 'killall unifycrd'

test_done
