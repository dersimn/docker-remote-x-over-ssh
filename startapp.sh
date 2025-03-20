#!/bin/sh

# Exit if SSH_TARGET is not set or empty
if [ -z "$SSH_TARGET" ]; then
  echo "Error: SSH_TARGET is not set."
  exit 1
fi

# Exit if REMOTE_COMMAND is not set or empty
if [ -z "$REMOTE_COMMAND" ]; then
  echo "Error: REMOTE_COMMAND is not set."
  exit 2
fi

exec ssh "$SSH_TARGET" "$REMOTE_COMMAND"
