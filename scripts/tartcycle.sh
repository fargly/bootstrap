#!/usr/bin/env bash
if [ $# -ne 1 ]; then
  echo "Usage: $0 <tart vm name>"
  exit 1
fi

TART_VM_NAME="$1"

tart stop "$TART_VM_NAME"
tart delete "$TART_VM_NAME"
tart clone ghcr.io/cirruslabs/macos-sequoia-base:latest "$TART_VM_NAME"
nohup tart run "$TART_VM_NAME" > /dev/null 2>&1 &
ssh admin@$(tart ip "$TART_VM_NAME" )

## EOF