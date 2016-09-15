#!/bin/bash

set -ux
SCRIPT=$1
BUNDLES="core invoice"
ENVS="prod smoke smoke_core smoke_invoice"
PRODUCT=kite

ROOT="/homes/`ls /homes|grep kite|head -1`"
for env in $ENVS; do
  if [ -d $ROOT/$env ]; then
    ROOT="$ROOT/$env"
    break
  fi
done


function find_jar () {
  if [ "$1" == "piggybank.jar" ]; then
    echo `yinst ls pig -files | grep piggybank.jar | awk '{print $1}' | sort | tail -1`
  else
    for bundle in $BUNDLES; do
      JARS=$ROOT/$bundle/`ls -tr $ROOT/$bundle | tail -1`/lib/jars
      if [ -f "$JARS/$1" ]; then
        echo $JARS/$1
        break
      fi
    done
  fi
}

link_jars () {
  for jar in `grep -E -i '^register' $1 | sed 's/^[^\ ]*\ \(.*\)\.jar.*/\1/'`; do
    if [ ! -f $jar.jar ]; then
      JAR=`find_jar $jar.jar`
      if [ "$JAR" == "" ]; then
        echo "Can't find $jar.jar"
        exit 1
      elif [ ! -f $JAR ]; then
        echo "$JAR doesn't exist"
        exit 1
      else
        echo Linking $jar.jar to $JAR
        ln -s -f $JAR $jar.jar
      fi
    fi
  done
}

link_jars $SCRIPT
