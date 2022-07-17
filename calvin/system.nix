{ config, pkgs, lib, ... }:

{
  #  imports =
  ##    [ # Include the results of the hardware scan.
  #      ./hardware-configuration.nix
  #    ];
  # Use the GRUB 2 boot loader.
  boot.loader.grub.enable = true;
  boot.loader.grub.version = 2;
  boot.loader.grub.useOSProber = true;
  boot.loader.grub.device = "/dev/sda";

  boot.initrd.availableKernelModules = [ "ata_piix" "uhci_hcd" "virtio_pci" "virtio_scsi" "sd_mod" "sr_mod" ];
  boot.initrd.kernelModules = [ ];
  boot.kernelModules = [ "fuse" ];
  boot.extraModulePackages = [ ];

  boot.kernelPackages = pkgs.linuxPackages_latest;


  fileSystems."/" =
    {
      device = "/dev/disk/by-uuid/75953a7e-d508-4fa7-ae83-1a6fd77ea05d";
      fsType = "btrfs";
      options = [ "subvol=@NixOS" ];
    };

  fileSystems."/home" =
    {
      device = "/dev/disk/by-uuid/75953a7e-d508-4fa7-ae83-1a6fd77ea05d";
      fsType = "btrfs";
      options = [ "subvol=@home" ];
    };

  fileSystems."/boot" =
    {
      device = "/dev/disk/by-uuid/1ae7005d-ec5b-45bf-b47c-7e6b8897189b";
      fsType = "ext4";
    };

  swapDevices = [ ];


  system.stateVersion = "22.05"; # Did you read the comment?
}
