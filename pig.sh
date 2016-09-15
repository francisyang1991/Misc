#!/bin/bash

set -ux
PT=hdfs://phazontan-nn1.tan.ygrid.yahoo.com
QUEUE=apg_p7

WHY=$(basename ${0%.*})
PIG_SCRIPT=${0%.*}.pig
BUNDLE=invoice
SUBDIR=preagg/15m
LOADTIME=2015072400*

STORETIME=`echo $LOADTIME | sed 's/\([^{}\*]*\).*/\1/'`

INPUT_DIR=/projects/kite/prod/internal/$BUNDLE/$SUBDIR/$LOADTIME
OUTPUT_DIR=/user/kylejao/$WHY/$BUNDLE/$SUBDIR/$STORETIME

MDQ_ARCHIVE=/projects/kite/prod/internal/mdq/mdq_rollup/hourly/$LOADTIME/trf.tgz


echo "PIG_SCRIPT=$PIG_SCRIPT"
echo "INPUT_DIR=$INPUT_DIR"
echo "OUTPUT_DIR=$OUTPUT_DIR"

./link_jars.sh $PIG_SCRIPT

hadoop fs -rm -r -skipTrash $OUTPUT_DIR

pig \
-param INPUT_DIR=$INPUT_DIR \
-param OUTPUT_DIR=$OUTPUT_DIR \
-Dmapred.job.queue.name=$QUEUE \
-Dmapreduce.job.cache.archives=$MDQ_ARCHIVE#cdb \
-Dfs.permissions.umask-mode=022 \
-file $PIG_SCRIPT
