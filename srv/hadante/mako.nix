{ config, pkgs, ... }:
{
  home-manager.users.${config.user} = {
    services.mako.enable = true;
    services.mako.settings = {
      actions = true;
      anchor = "top-right";
      output = "DP-1";
    };
  };
}
