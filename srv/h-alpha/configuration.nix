{
  config,
  lib,
  pkgs,
  ...
}:
{
  imports = [
    ./hardware-configuration.nix
    ./disko-config.nix
  ];
  boot.loader.systemd-boot.enable = true;
  #  boot.loader.grub.device = "/dev/sda";

  users.users.nea = {
    isNormalUser = true;
    extraGroups = [ "wheel" ];
    openssh.authorizedKeys.keys = [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAINg2WYMRKINwbH5UCqqK2qq/qW0gG1NnaALHqEyU4NzM"
    ];
  };

  security.sudo.wheelNeedsPassword = false;
  nix.settings.trusted-users = [ "@wheel" ];
  services.openssh = {
    enable = true;
    settings = {
      PermitRootLogin = "no";
      PasswordAuthentication = false;
      KbdInteractiveAuthentication = false;
    };
  };

  system.stateVersion = "24.11";
}
