{
  inputs = {
    nixpkgs = {
      url = "github:NixOS/nixpkgs/nixos-unstable";
    };
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    flake-utils = {
      url = "github:numtide/flake-utils";
    };
    lanzaboote = {
      url = "github:nix-community/lanzaboote/v0.4.2";

      # Optional but recommended to limit the size of your system closure.
      inputs.nixpkgs.follows = "nixpkgs";
    };
    disko = {
      url = "github:nix-community/disko";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    customss = {
      url = "github:nea89o/customss";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nix-index-database = {
      url = "github:nix-community/nix-index-database";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    agenix.url = "github:ryantm/agenix";
  };
  outputs =
    inputs@{
      self,
      nixpkgs,
      nix-index-database,
      lanzaboote,
      flake-utils,
      customss,
      home-manager,
      ...
    }:
    let
      staticConfig = rec {
        homeConfigurations = {
          hadante = nixosConfigurations.hadante.config.home-manager.users.nea.home;
        };
        nixosConfigurations = {
          hadante = nixpkgs.lib.nixosSystem rec {
            system = "x86_64-linux";
            specialArgs = { inherit inputs; };
            modules = [
              (inputs: {
                nixpkgs.overlays = [
                  customss.overlays.default
                  (import ./pkgs)
                ];
              })
              ./srv/hadante/configuration.nix
              lanzaboote.nixosModules.lanzaboote
              nix-index-database.nixosModules.nix-index
              (
                { pkgs, lib, ... }:
                {
                  environment.systemPackages = [
                    pkgs.sbctl
                  ];
                  boot.loader.systemd-boot.enable = lib.mkForce false;
                  boot.lanzaboote = {
                    enable = true;
                    pkiBundle = "/var/lib/sbctl";
                  };
                }
              )
            ];
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
          formatter = pkgs.nixfmt-tree;
        }
      );
    in
    (metaConfig // staticConfig);
}
