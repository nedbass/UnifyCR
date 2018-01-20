#!/bin/bash
#
# Source sharness environment script so unifycr_unmount.t learns what mount
# point to use
#
. $(dirname $0)/sharness.d/01-env.sh
$UNIFYCR_BUILD_DIR/t/unifycr_unmount.t
