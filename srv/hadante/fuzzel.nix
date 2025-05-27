{ config, pkgs, ... }:
{
  home-manager.users.${config.user} = {
    programs.fuzzel.enable = true;
    programs.fuzzel.settings = {
    };
  };
}
