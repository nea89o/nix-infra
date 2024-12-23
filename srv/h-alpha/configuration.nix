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
    ./services.nix
  ];

  nix.package = pkgs.lix;

  boot.loader.systemd-boot.enable = true;

  users.users.nea = {
    isNormalUser = true;
    extraGroups = [ "wheel" ];
    openssh.authorizedKeys.keys = [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAINg2WYMRKINwbH5UCqqK2qq/qW0gG1NnaALHqEyU4NzM nea@smiley-mk1"
    ];
    initialHashedPassword = "$y$j9T$a4xR89vrsf1Kp1Rm.hxBM.$0KMdqEwi1uU6AbXKr.cdbQXahjs2TNairGr/3PMO6s7";
  };

  security.sudo.wheelNeedsPassword = false;
  nix.settings.trusted-users = [ "@wheel" ];
  services.openssh = {
    enable = true;
    settings = {
      PermitRootLogin = "no";
      #      PasswordAuthentication = false;
      KbdInteractiveAuthentication = false;
    };
  };

  programs.git.enable = true;

  networking.hostName = "alpha-site";

  networking.firewall.allowedTCPPorts = [
    22
    80
    443
  ];

  system.stateVersion = "24.11";

  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];
}
