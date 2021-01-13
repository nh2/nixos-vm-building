# nixos-vm-building

Example of how to iterate on a NixOS config in a local VM.

Useful if:

* You want to try out NixOS and how to configure/use it.
* You want to develop a new NixOS module.

Originally based on this blog post: http://blog.patapon.info/nixos-local-vm/


## Usage

Run in order:

* `build-vm.sh` - Builds the VM. Read it to see how to customise the nixpkgs version to use.
* `run-vm.sh` - Runs the VM
* `ssh-vm.sh` - SSHs into the VM

Modify `configuration.nix` as you please, and rerun.

These scripts are very simple, usually one-liner `nix` CLI invocations that you could run yourself.
But they have added explanations; read their contents and the blog post to understand what's going on.


### In-place redeployment for fast iteration

With the VM running, run:

* `./deploy-to-running-vm.sh`


## Troubleshooting

* **`error: preallocating file of 54420 bytes: No space left on device`**
  Your VM's disk is too small.
  Increase the `diskSize` in `default.nix`, delete the VM state delete and rebuild using: `rm vm1.qcow2 && ./build-vm.sh`.
