#
#  Project-local sharness code for UnifyCR
#

# Configure UnifyCR runtime settings
export UNIFYCR_USE_SPILLOVER=1
export UNIFYCR_META_SERVER_RATIO=1
export UNIFYCR_META_DB_NAME=unifycr_db
export UNIFYCR_CHUNK_MEM=0
export UNIFYCR_META_DB_PATH=$(readlink -f $SHARNESS_BUILD_DIRECTORY/../ucr)
export UNIFYCR_SERVER_DEBUG_LOG=$UNIFYCR_META_DB_PATH/unifycrd_debuglog
export UNIFYCR_EXTERNAL_DATA_DIR=$UNIFYCR_META_DB_PATH
export UNIFYCR_EXTERNAL_META_DIR=$UNIFYCR_META_DB_PATH

# Set paths to executables
UNIFYCRD=$SHARNESS_BUILD_DIRECTORY/server/src/unifycrd
TEST_WRITE_GOTCHA=$SHARNESS_BUILD_DIRECTORY/client/tests/test_write_gotcha
TEST_READ_GOTCHA=$SHARNESS_BUILD_DIRECTORY/client/tests/test_read_gotcha
SYS_OPEN=$SHARNESS_BUILD_DIRECTORY/tests/sys_open
