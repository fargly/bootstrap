#!/usr/bin/env bash

if [ $# -ne 1 ]; then
  echo "Usage: $0 <lima vm name>"
  exit 1
fi

LIMA_VM_NAME="$1"
limactl stop "$LIMA_VM_NAME"
limactl delete "$LIMA_VM_NAME"
limactl create --name="$LIMA_VM_NAME" template://default
limactl start "$LIMA_VM_NAME"


## EOF