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
  networking = {
    useDHCP = false;
    defaultGateway6 = {
      address = "fe80::1";
      interface = "enp1s0";
    };
    interfaces.enp1s0 = {
      ipv6.addresses = [
        {
          address = "2a01:4f9:c012:5dd3::";
          prefixLength = 64;
        }
      ];
    };
  };
  nixpkgs.hostPlatform = lib.mkDefault "aarch64-linux";
}
