#
#  Project-local sharness code for UnifyCR
#

# Run command with a timeout
#
# $1        - Number of seconds to wait before timing out
# $2 .. $n  - Command and arguments to execute
run_timeout()
{
    perl -e 'alarm shift @ARGV; exec @ARGV' "$@"
}

# Check if a process with a given name is running, retrying up
# to a given number of seconds before giving up.
#
# $1 - Name of a process to check for
# $2 - Number of seconds to wait before giving up
#
# Returns 0 if the named process is found, otherwise returns 1.
process_is_running()
{
    local proc=${1:-"unifycrd"}
    local secs_to_wait=${2:-15}

    for ((i=0; i<$(($secs_to_wait * 2)); i++)) ; do
        if ! test -z $(pidof $proc) ; then
            return 0
        else
            sleep .5
        fi
    done
    return 1
}
