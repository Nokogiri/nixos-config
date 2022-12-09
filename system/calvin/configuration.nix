{ config, pkgs, lib, ... }:

{
  #  imports =
  ##    [ # Include the results of the hardware scan.
  #      ./hardware-configuration.nix
  #    ];
  # Use the GRUB 2 boot loader.
  boot.loader.grub.enable = true;
  boot.loader.grub.version = 2;
  boot.loader.grub.useOSProber = false;
  boot.loader.grub.device = "/dev/sda";

  boot.initrd.availableKernelModules =
    [ "ata_piix" "uhci_hcd" "virtio_pci" "virtio_scsi" "sd_mod" "sr_mod" ];
  boot.initrd.kernelModules = [ ];
  boot.kernelModules = [ "fuse" ];
  boot.extraModulePackages = [ ];

  fileSystems."/" = {
    device = "/dev/disk/by-uuid/75953a7e-d508-4fa7-ae83-1a6fd77ea05d";
    fsType = "btrfs";
    options = [ "subvol=@NixOS" "compress=zstd:9" ];
  };

  fileSystems."/home" = {
    device = "/dev/disk/by-uuid/75953a7e-d508-4fa7-ae83-1a6fd77ea05d";
    fsType = "btrfs";
    options = [ "subvol=@home" "compress=zstd:9" ];
  };

  fileSystems."/boot" = {
    device = "/dev/disk/by-uuid/1ae7005d-ec5b-45bf-b47c-7e6b8897189b";
    fsType = "ext4";
  };

  fileSystems."/nextData" = {
    device = "/dev/disk/by-uuid/ec8f2811-bb28-404a-a5f0-7ca3544cf437";
    fsType = "btrfs";
    options = [ "compress=zstd:9" ];
  };

  swapDevices = [ ];

  system.stateVersion = "22.05"; # Did you read the comment?
  programs.fuse.userAllowOther = true;

}
