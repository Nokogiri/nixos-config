# Do not modify this file!  It was generated by ‘nixos-generate-config’
# and may be overwritten by future invocations.  Please make changes
# to /etc/nixos/configuration.nix instead.
{ config, lib, pkgs, modulesPath, ... }:

{
  imports =
    [ (modulesPath + "/installer/scan/not-detected.nix")
    ];

  boot.initrd.availableKernelModules = [ "xhci_pci" "ehci_pci" "ahci" "firewire_ohci" "usb_storage" "usbhid" "sd_mod" "sdhci_pci" ];
  boot.initrd.kernelModules = [ ];
  #boot.kernelModules = [ "kvm-intel" "wl" ];
  boot.extraModulePackages = [ config.boot.kernelPackages.broadcom_sta ];

  fileSystems."/" =
    { device = "/dev/disk/by-uuid/1f200403-52ed-4fe6-8e44-edfa6aed6cf9";
      fsType = "btrfs";
      options = [ "subvol=@nixos" ];
    };

  fileSystems."/boot" =
    { device = "/dev/disk/by-uuid/2052-3A83";
      fsType = "vfat";
    };

  fileSystems."/home" =
    { device = "/dev/disk/by-uuid/1f200403-52ed-4fe6-8e44-edfa6aed6cf9";
      fsType = "btrfs";
      options = [ "subvol=@home" ];
    };

  fileSystems."/efi" =
    { device = "/dev/disk/by-uuid/67E3-17ED";
      fsType = "vfat";
    };

  swapDevices =
    [ { device = "/dev/disk/by-uuid/649f67bb-4f10-493f-b4e6-0c0aa625552d"; }
    ];

  # Enables DHCP on each ethernet and wireless interface. In case of scripted networking
  # (the default) this is the recommended approach. When using systemd-networkd it's
  # still possible to use this option, but it's recommended to use it in conjunction
  # with explicit per-interface declarations with `networking.interfaces.<interface>.useDHCP`.
  networking.useDHCP = lib.mkDefault true;
  # networking.interfaces.enp1s0f0.useDHCP = lib.mkDefault true;

  hardware.cpu.intel.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
}
