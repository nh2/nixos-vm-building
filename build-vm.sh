#! /usr/bin/env bash
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

NIX_PATH="$NIX_PATH" NIXOS_CONFIG="$PWD/configuration.nix" nixos-rebuild build-vm

# The above invocation creates a `./result` symlink in the current directory,
# which links the VM's content and startup script.
