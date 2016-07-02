#!/bin/bash

if [ -z $CMANGOS_VERSION ]
then
  echo 'You need to specify the $CMANGOS_VERSION environment variable, which is the cmangos/mangos-classic version...see https://github.com/cmangos/mangos-classic/releases'
  exit 1
fi

TEMP_DIR="/tmp"
BINARY_PACKAGE="$TEMP_DIR/cmangos-classic-$CMANGOS_VERSION.tar.gz"
BINARY_DIR="/cmangos/bin"

if [ ! -d $BINARY_DIR ]
then
  if [ ! -e $BINARY_PACKAGE ]; then
    echo "$BINARY_PACKAGE missing...this file can be generated using https://github.com/maxc0c0s/cmangos-classic-deploy"
    exit 1
  fi

  echo "extracting $BINARY_PACKAGE"
  tar -xf $BINARY_PACKAGE -C /
fi

if [ -z $@ ]; then
  for script in $(ls -A $STARTUP_SCRIPTS_DIR); do
    case "$script" in
      *.sh)  echo "$0: running $script"; . $STARTUP_SCRIPTS_DIR/"$script" "$BINARY_DIR" "$TEMP_DIR";;
      *)  echo "$0: ignoring $script";;
    esac
  done
else
  exec $@
fi
