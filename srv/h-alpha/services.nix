{
  config,
  lib,
  pkgs,
  modulesPath,
  ...
}:
{
  imports = [
    ../../modules/caddy.nix
  ];
  services.neaCaddy = {
    enable = true;
    baseUrl = "alpha-site.nea.moe";
    reverseProxy = {
      "sentry" = {
        port = 1234;
      };

    };
  };
}
