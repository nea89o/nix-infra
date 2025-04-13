{
  inputs = {
    nixpkgs = {
      url = "github:NixOS/nixpkgs/nixos-24.11";
    };
    flake-utils = {
      url = "github:numtide/flake-utils";
    };
    disko = {
      url = "github:nix-community/disko";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };
  outputs =
    inputs@{
      self,
      nixpkgs,
      flake-utils,
      ...
    }:
    let
      osConfig = {
        nixosConfigurations = {
          hadante = nixpkgs.lib.nixosSystem {
            system = "x86_64-linux";
            modules = [ ./srv/hadante/configuration.nix ];
          };
          alpha-site = nixpkgs.lib.nixosSystem {
            system = "aarch64-linux";
            modules = [
              ./srv/h-alpha/configuration.nix
              inputs.disko.nixosModules.disko
            ];
          };
        };
      };
      metaConfig = flake-utils.lib.eachDefaultSystem (
        system:
        let
          pkgs = import nixpkgs {
            inherit system;
          };
        in
        {
          formatter = pkgs.nixfmt-rfc-style;
        }
      );
    in
    (metaConfig // osConfig);
}
