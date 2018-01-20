#!/bin/bash
#
# This test checks that I/O to the UnifyCR mount point was properly
# intercepted and redirected to the UnifyCR daemon.
#

test_description="Verify UnifyCR intercepted mount point is empty"

. $(dirname $0)/sharness.sh

test_expect_success "UnifyCR mountpoint is empty after unmount" '
    test_dir_is_empty $UNIFYCR_MOUNT_POINT
'

test_done
