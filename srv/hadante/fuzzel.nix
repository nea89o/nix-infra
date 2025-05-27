{ config, pkgs, ... }:
{
  home-manager.users.${config.user} = {
    programs.fuzzel.enable = true;
    programs.fuzzel.settings = {
      main = {
        font = "ComicShannsMono Nerd Font";
        use-bold = true;
        fields = "name,categories";
      };
    };
  };
}
