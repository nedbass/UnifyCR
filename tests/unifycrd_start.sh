#!/bin/bash

export UNIFYCR_META_SERVER_RATIO=1
export UNIFYCR_META_DB_NAME=unifycr_db
export UNIFYCR_CHUNK_MEM=0

tests_dir=$(dirname "$0")

NODES=1
PROCS=1

srun -N ${NODES} -n ${PROCS} $tests_dir/../server/src/unifycrd &
