{
  pkgs,
  inputs,
  ...
}:
{
  imports = [
    inputs.agenix.nixosModules.default
  ];
  nixpkgs.overlays = [
    inputs.agenix.overlays.default
  ];
  environment.systemPackages = [ pkgs.agenix ];
  age = {
    secrets = {
      secret1.file = ../../secrets/secret1.age;
    };
    identityPaths = [ "/home/nea/.ssh/id_ed25519" ];

  };
}
