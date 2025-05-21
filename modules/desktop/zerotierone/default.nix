{
  config,
  lib,
  pkgs,
  modulesPath,
  ...
}:
{
  services.zerotierone = {
    enable = true;
    joinNetworks = [
      "363c67c55a720f73"
    ];
  };
}
