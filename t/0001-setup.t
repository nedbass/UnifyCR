#!/bin/bash
#
# Perform some initial setup for the test suite. This is not
# implemented as a sharness test because leaving a process running
# behind (i.e. unifycrd) causes tap-driver.sh to hang waiting for
# the process to exit.
#

echo 1..1

. $(dirname $0)/sharness.d/01-env.sh
. $(dirname $0)/sharness.d/02-functions.sh

# Start the UnifyCR daemon after killing and cleanup up after
# any previously running instance.
unifycrd_stop_daemon
unifycrd_cleanup
unifycrd_start_daemon

if process_is_running unifycrd 15; then
    echo ok 1 - unifycrd running
else
    echo not ok 1 - unifycrd running
    exit 1
fi

#
# Create temporary directories to be used as a common mount point and a
# common metadata directory across multiple tests. Save the value to a
# script in known location that later test scripts can source.
#
cat >"$UNIFYCR_TEST_ENV_SCRIPT" <<-EOF
export UNIFYCR_MOUNT_POINT=$(mktemp -d)
export UNIFYCR_META_DB_PATH=$(mktemp -d)
EOF

exit 0
