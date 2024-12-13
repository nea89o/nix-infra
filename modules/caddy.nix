{
  lib,
  pkgs,
  config,
  ...
}:
with lib;
let
  cfg = config.services.neaCaddy;
in
{
  options.services.neaCaddy = {
    enable = mkEnableOption "Custom Caddy Service";
    baseUrl = mkOption {
      type = types.str;
      description = "The default domain under which all service subdomains get registered";
      example = "nea.moe";
    };
    reverseProxy = mkOption {
      type = types.attrsOf (
        types.submodule {
          options = {
            port = mkOption {
              type = types.int;
              description = "The local port of the reverse proxied service";
            };
          };
        }
      );
      description = "List of reverse proxy hosts to enable";
    };

  };
  config = mkIf cfg.enable {
    services.caddy = (
      {
        enable = true;
      }
      // ({
        virtualHosts = attrsets.mapAttrs' (
          name: value:
          attrsets.nameValuePair (name + "." + cfg.baseUrl) {
            extraConfig = ''
              reverse_proxy http://localhost:${toString value.port}
            '';
          }
        ) cfg.reverseProxy;
      })
    );
  };
}
