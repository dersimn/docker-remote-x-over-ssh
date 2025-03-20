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

ssh "$SSH_TARGET" "$REMOTE_COMMAND" &
SSH_PID=$!

echo "Started SSH session with PID: $SSH_PID"

is_window_open() {
    xprop -root _NET_CLIENT_LIST | grep -q "0x"
    return $?
}

# Keep checking for the VMware window
while sleep 5; do
    if ! is_window_open; then
        echo "All windows closed. Exiting SSH..."
        kill $SSH_PID
        exit 0
    fi
done
