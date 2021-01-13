# This file, `default.nix`, is used when you invoke `nix-build` without giving
# a file to it explicitly.
#
# You can use it e.g. to store attributes to request from the command line.
#
# For example, we define `vmSystem` below, so that we can build it with
# `nix-build -A vmSystem`.

{ configuration
, system ? builtins.currentSystem
}:

let

  eval = modules: import <nixpkgs/nixos/lib/eval-config.nix> {
    inherit system modules;
  };

in {

  # An attribute that just build's the VM's config, not the VM itself.
  # Saves some disk space, is faster, and we also use it in
  # `deploy-to-running-vm.sh`.
  vmSystem =
    (eval [
      configuration
      <nixpkgs/nixos/modules/virtualisation/qemu-vm.nix>
    ]).config.system.build.toplevel;

}
