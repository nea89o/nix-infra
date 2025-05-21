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
}
