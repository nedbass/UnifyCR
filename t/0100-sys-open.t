#!/bin/bash
#
# Source sharness environment script so sys/open.t learns what mount
# point to use
#
. $(dirname $0)/sharness.d/01-env.sh
$UNIFYCR_BUILD_DIR/t/sys/open.t
