{
  config,
  lib,
  pkgs,
  modulesPath,
  ...
}:

{
  imports = [ (modulesPath + "/profiles/qemu-guest.nix") ];
  boot.initrd.availableKernelModules = [
    "ahci"
    "xhci_pci"
    "virtio_pci"
    "virtio_scsi"
    "sd_mod"
    "sr_mod"
    "virtio_gpu"
    "ext4"
  ];
  boot.initrd.kernelModules = [ ];
  boot.kernelModules = [ ];
  boot.extraModulePackages = [ ];
  swapDevices = [ ];

  networking.useNetworkd = true;
  systemd.network.networks."30-wan" = {
    matchConfig.Name = "enp1s0";
    addresses = [
      { Address = "65.21.54.251"; }
      { Address = "2a01:4f9:c012:5dd3::/64"; } # TODO: figure out if nix lets me bind against the entire block using anyip
    ];

    routes = [
      { Gateway = "fe80::1"; }
      {
        Destination = "172.31.1.1";
      }
      {
        Gateway = "172.31.1.1";
        GatewayOnLink = true;
      }
      {
        Destination = "172.16.0.0/12";
        Type = "unreachable";
      }
      {
        Destination = "192.168.0.0/16";
        Type = "unreachable";
      }
      {
        Destination = "10.0.0.0/8";
        Type = "unreachable";

      }
      {
        Destination = "fc00::/7";
        Type = "unreachable";
      }
    ];
  };

  nixpkgs.hostPlatform = lib.mkDefault "aarch64-linux";
}
