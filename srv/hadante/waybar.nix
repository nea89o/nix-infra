{ pkgs, config, ... }:
{
  home-manager.users.${config.user} = {
    programs.waybar = {
      enable = true;
      settings = {
        mainBar = {
          layer = "top";
          position = "top";
          height = 30;
          modules-left = [
            "sway/workspaces"
            "sway/mode"
            "wlr/taskbar"
          ];
          modules-center = [
            "sway/window"
          ];
          modules-right = [
            "mpd"
            "temperature"
            "tray"
          ];

          "sway/workspaces" = {
            disable-scroll = true;
            all-outputs = true;
          };
        };
      };
    };
  };
}
