#!/usr/bin/env bash

set -eu -o pipefail


# Set NIX_PATH to a sensible default if it's not already set
# (this is bash syntax, see https://stackoverflow.com/a/2013589/263061):
NIX_PATH="${NIX_PATH:-nixpkgs=https://github.com/NixOS/nixpkgs/archive/nixos-20.09.tar.gz}"

# Alternatively, specify a path to your nixpkgs checkout:
#NIX_PATH=nixpkgs=../nixpkgs

# Or set it from outside this script on the command line:
#
#     NIX_PATH=nixpkgs=../nixpkgs ./build-vm.sh
#
# If you're on NixOS or otherwise already have NIX_PATH set in your shell,
# and want to use the default value from this script, use:
#
#     env --unset NIX_PATH ./build-vm.sh

echo
echo "Using the following NIX_PATH to locate nixpkgs:"
echo "${NIX_PATH}"
echo
echo "You can change that to point to the nixpkgs you want to use."
echo

echo "Ensure your VM is running first!"

# See `ssh-vm.sh` for a description of these SSH options.
SSH_OPTIONS="-p 2221 -o UserKnownHostsFile=/dev/null -o StrictHostKeyChecking=no"

PROFILE="/nix/var/nix/profiles/system"

# Build the VM system
outPath="$(nix-build --no-out-link vm.nix -A vmSystem --arg configuration ./configuration.nix)"

# Upload to the VM with `nix-copy-closure`.
NIX_SSHOPTS="$SSH_OPTIONS" nix-copy-closure --to "root@localhost" --gzip "$outPath"

# Activate the new system
ssh $SSH_OPTIONS root@localhost nix-env --profile "$PROFILE" --set "$outPath"
ssh $SSH_OPTIONS root@localhost "$outPath/bin/switch-to-configuration" test
