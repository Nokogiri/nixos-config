# Do not modify this file!  It was generated by ‘nixos-generate-config’
# and may be overwritten by future invocations.  Please make changes
# to /etc/nixos/configuration.nix instead.
{ config, lib, pkgs, modulesPath, ... }:

{
  imports =
    [ (modulesPath + "/installer/scan/not-detected.nix")
  ];


  boot.loader = {
    systemd-boot.enable = true;
    efi.canTouchEfiVariables = true;
    efi.efiSysMountPoint = "/efi";
  };

  boot = {
    blacklistedKernelModules = [ "b43" ];
    consoleLogLevel = 3;
    extraModulePackages = [ config.boot.kernelPackages.broadcom_sta ];
    extraModprobeConfig = ''
      options hid_apple fnmode=2 swap_fn_leftctrl=1 iso_layout=0
    '';
    initrd.availableKernelModules = [ "xhci_pci" "ehci_pci" "ahci" "firewire_ohci" "usb_storage" "usbhid" "sd_mod" "sdhci_pci" ];
    initrd.kernelModules = [ "i915" "hid=apple"];
    kernelModules = [ "wl" "kvm-intel" ];
    kernelPackages = pkgs.linuxKernel.packages.linux_5_17;
    kernelParams = [
      "acpi_backlight=vendor"
      "i915.fastboot=1"
      "i915.enable_guc=2"
      "i915.enable_fbc=1"
      "sdhci.debug_quirks2=4"
      "intremap=off"
    ];
  };



  fileSystems."/" = {
    device = "/dev/disk/by-uuid/1f200403-52ed-4fe6-8e44-edfa6aed6cf9";
    fsType = "btrfs";
    options = [ 
      "subvol=@nixos"
      "compress=zstd:9"
    ];
  };

  fileSystems."/boot" = {
    device = "/dev/disk/by-uuid/2052-3A83";
    fsType = "vfat";
    options = [
      "fmask=0022"
      "dmask=0022"
      "codepage=437"
      "iocharset=ascii"
      "shortname=mixed"
      "utf8"
    ];
  };

  fileSystems."/home" = {
    device = "/dev/disk/by-uuid/1f200403-52ed-4fe6-8e44-edfa6aed6cf9";
    fsType = "btrfs";
    options = [ 
      "subvol=@home"
      "compress=zstd:9"
    ];
  };

  fileSystems."/efi" = {
    device = "/dev/disk/by-uuid/67E3-17ED";
    fsType = "vfat";
    options = [
      "fmask=0022"
      "dmask=0022"
      "codepage=437"
      "iocharset=ascii"
      "shortname=mixed"
      "utf8"
    ];
  };

  swapDevices = [
    { device = "/dev/disk/by-uuid/649f67bb-4f10-493f-b4e6-0c0aa625552d"; }
  ];


  hardware.cpu.intel.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
}
