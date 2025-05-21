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
    joinNetworks = import config.age.secrets.secret1.path;
  };
}
