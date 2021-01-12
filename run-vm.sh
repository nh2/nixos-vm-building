#! /usr/bin/env bash
set -eu -o pipefail

# `vm1` is the hostname of the machine as defined in `configuration.nix`.
#
# Note that running the VM stores its state in `./vm1.qcow`.
# Delete it for a fresh start.

QEMU_NET_OPTS=hostfwd=tcp::2221-:22 ./result/bin/run-vm1-vm
