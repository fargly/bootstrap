#!/usr/bin/env bash

if [ $# -ne 1 ]; then
  echo "Usage: $0 <lima vm name>"
  exit 1
fi

LIMA_VM_NAME="$1"
limactl stop "$LIMA_VM_NAME"
limactl delete "$LIMA_VM_NAME"
limactl create --name="$LIMA_VM_NAME" --yes
limactl start "$LIMA_VM_NAME" --yes
limactl shell "$LIMA_VM_NAME"


## EOF
