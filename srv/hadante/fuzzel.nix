{
  config,
  pkgs,
  inputs,
  ...
}:
let

  palette = inputs.catppuccin.legacyPackages.x86_64-linux.palette;
  colors = builtins.fromJSON (builtins.readFile "${palette.out}/palette.json");
  mocha = colors.mocha.colors;
in
{
  home-manager.users.${config.user} = {
    programs.fuzzel.enable = true;
    programs.fuzzel.settings = {
      main = {
        font = "ComicShannsMono Nerd Font";
        use-bold = true;
        fields = "name,categories";
      };
      colors = {
        background = mocha.surface0;
      };
    };
  };
}
