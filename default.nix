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

rec {
  # This is the same as `vmConfig` from nixpkgs's `nixos/default.nix`,
  # copied here so that you can customise the VM's settings independent
  # from your `configuration.nix`.
  vmConfig =
    (import <nixpkgs/nixos/lib/eval-config.nix> {
      inherit system;
      modules = [
        # Your configuration that was passed in:
        configuration

        # NixOS config that provides working boot inside QEMU.
        <nixpkgs/nixos/modules/virtualisation/qemu-vm.nix>

        # Customise VM settings in this NixOS module;
        # See nixpkgs's' `nixos/modules/virtualisation/qemu-vm.nix` options
        # to see what options are available you have here; stable link:
        # https://github.com/NixOS/nixpkgs/blob/5ff4a674125abbe8586884db62c66a00a8b4f665/nixos/modules/virtualisation/qemu-vm.nix#L270
        ({ config, pkgs, ... }: {
          virtualisation = {
            memorySize = 1024; # MiB
            diskSize = 2048; # MiB
          };
        })
      ];
    }).config;

  # An attribute that just build the VM's contents as a nix store path, not the
  # VM itself. We use it for fast iteration in `deploy-to-running-vm.sh`.
  vmSystem = vmConfig.system.build.toplevel;

  vm = vmConfig.system.build.vm;

}
