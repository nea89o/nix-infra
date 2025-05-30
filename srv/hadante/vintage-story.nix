{
  inputs,
  pkgs,
  config,
  system,
  ...
}:
let
  VSPkgs = inputs.vintagestory-nix.packages.${system}.net8;
in
{
  home-manager.users.${config.user} = {
    # imports = [ inputs.vintagestory-nix.homeManagerModules.default ];
    # programs.vs-launcher = {
    #   enable = true;
    #   installedVersions = with VSPkgs; [
    #     # Current version I'm playing on with mods
    #     v1-20-10
    #   ];
    # };
    home.packages = [
      pkgs.vintagestory
    ];
  };
  nixpkgs.config.permittedInsecurePackages = [
    "dotnet-runtime-7.0.20"
  ];
}
