#! /usr/bin/env bash
set -eu -o pipefail

echo "Ensure your VM is running first!"

# Disable strict host checking, so that SSH does not complain when we rebuild
# the VM from scratch and it gets a new host key.
ssh root@localhost -p 2221 -o UserKnownHostsFile=/dev/null -o StrictHostKeyChecking=no
