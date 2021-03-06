#!/bin/bash
#
# This is a wrapper around checkpatch.pl which is a code style-checking
# script borrowed from the Linux kernel. The wrapper calls checkpatch.pl
# with arguments to make it UnifyCR style-friendly.
#

basedir=$(dirname "$0")
checkpatch_cmd=$basedir/linux_kernel_checkpatch/checkpatch.pl

#
# These are checkpatch.pl message types to ignore for cases where
# UnifyCR deviates from the Linux kernel coding standards.
#
# See 'scripts/linux_kernel_checkpatch/checkpatch.pl --list-types'
# for all message types
#
checkpatch_ignore="LEADING_SPACE"       # Allow spaces for indentation
checkpatch_ignore+=",CODE_INDENT"       # Don't require tabs for indentation
checkpatch_ignore+=",MISSING_SIGN_OFF"  # Signed-off-by: line is optional
checkpatch_ignore+=",FILE_PATH_CHANGES" # Don't nag about updating MAINTAINERS
checkpatch_ignore+=",CONST_STRUCT"      # Don't nag about const structs

checkpatch_cmd+=" --ignore $checkpatch_ignore"

# Suppress summary warning about white space errors.
checkpatch_cmd+=" -q"

# Let checkpatch.pl run outside of kernel tree.
checkpatch_cmd+=" --no-tree"

#
# Check the tip of the current branch by if no argument is given.
# Otherwise check the given git revision, e.g. to check the all
# patches ahead of origin/dev:
#
#    ./checkpatch.sh origin/dev..HEAD
#
revisions=${1:-"HEAD^..HEAD"}

#
# If we're reading from a pipe then pass input directly into
# checkpatch.pl. Otherwise get the patch from git.
#
if [ ! -t 0 ] ; then
    show_patch_cmd="cat"
else
    show_patch_cmd="git format-patch -p -k --stdout $revisions"
fi

$show_patch_cmd | $checkpatch_cmd
