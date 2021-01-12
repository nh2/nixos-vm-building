{ config, pkgs, lib, ... }:

{
  imports = [
    # ./hardware-configuration.nix
  ];

  boot.loader.grub.enable = true;
  boot.loader.grub.version = 2;
  boot.loader.grub.device = "/dev/vda";

  networking.hostName = "vm1";

  i18n.defaultLocale = "en_US.UTF-8";

  services.openssh.enable = true;
  services.openssh.permitRootLogin = "yes";
  services.timesyncd.enable = lib.mkDefault true;

  environment.systemPackages = with pkgs; [
    dnsutils
    htop
    inetutils
    vim
  ];

  users.mutableUsers = false;
  # Initial empty root password for easy login.
  # Also allow to log in with that empty password via SSH.
  users.users.root.password = "";
  services.openssh.extraConfig = ''
    PermitEmptyPasswords yes
  '';

  # This value determines the NixOS release with which your system is to be
  # compatible, in order to avoid breaking some software such as database
  # servers. You should change this only after NixOS release notes say you
  # should.
  system.stateVersion = "20.09"; # Did you read the comment?
}
