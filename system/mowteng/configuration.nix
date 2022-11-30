# Do not modify this file!  It was generated by ‘nixos-generate-config’
# and may be overwritten by future invocations.  Please make changes
# to /etc/nixos/configuration.nix instead.
{ config, lib, pkgs, modulesPath, ... }:

{
  imports = [ (modulesPath + "/installer/scan/not-detected.nix") ];

  boot.loader = {
    systemd-boot.enable = true;
    efi.canTouchEfiVariables = true;
    efi.efiSysMountPoint = "/efi";
  };

  boot = {
    initrd.availableKernelModules = [ "nvme" "xhci_pci" "ahci" "sd_mod" ];
    initrd.kernelModules = [ "amd_pstate" "amdgpu" ];
    kernelModules = [ "kvm-amd" "zenpower" "msr" ];
    extraModprobeConfig = ''
      options hid_xpadneo ff_connect_notify=0
      blacklist pcspkr
      options usb_storage quirks=090c:1000:,152d:0578:u,0bc2:2322:u
    '';
    extraModulePackages = [ pkgs.linuxPackages_lqx.zenpower ];
    kernelPackages = pkgs.linuxPackages_lqx;
    kernelPatches = [{
      name = "d3cold-fix";
      patch = ./patches/d3cold.patch;
    }];
    tmpOnTmpfs = true;
    tmpOnTmpfsSize = "60%";
  };

  fileSystems."/" = {
    device = "/dev/disk/by-uuid/d1f0114c-069e-46c1-bf58-f2d024ca46f7";
    fsType = "btrfs";
    options = [ "subvol=@nixroot" "compress=zstd:9" "relatime" ];
  };

  fileSystems."/nix" = {
    device = "/dev/disk/by-uuid/d1f0114c-069e-46c1-bf58-f2d024ca46f7";
    fsType = "btrfs";
    options = [ "subvol=@nix" "compress=zstd:9" "relatime" ];
  };

  fileSystems."/efi" = {
    device = "/dev/disk/by-uuid/7141-64D6";
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
    device = "/dev/disk/by-uuid/d1f0114c-069e-46c1-bf58-f2d024ca46f7";
    fsType = "btrfs";
    options = [ "subvol=@home" "compress=zstd:9" "relatime" ];
  };

  fileSystems."/data/Games" = {
    device = "/dev/disk/by-uuid/d1f0114c-069e-46c1-bf58-f2d024ca46f7";
    fsType = "btrfs";
    options = [ "subvol=@GameData" "compress=zstd:9" "relatime" ];
  };

  fileSystems."/data/butter" = {
    device = "/dev/disk/by-uuid/d1f0114c-069e-46c1-bf58-f2d024ca46f7";
    fsType = "btrfs";
  };

  fileSystems."/data/snapshots" = {
    device = "/dev/disk/by-uuid/d1f0114c-069e-46c1-bf58-f2d024ca46f7";
    fsType = "btrfs";
    options = [ "subvol=@snapshots" ];
  };

  swapDevices =
    [{ device = "/dev/disk/by-uuid/cbd786fb-2d29-4652-9749-ab5e2b4fbee9"; }];

  hardware = {
    cpu.amd.updateMicrocode =
      lib.mkDefault config.hardware.enableRedistributableFirmware;
    enableRedistributableFirmware = true;
    bluetooth.enable = true;

    opengl = {
      driSupport = lib.mkDefault true;
      driSupport32Bit = lib.mkDefault true;
    };

    sensor.iio.enable = true;
    uinput.enable = true;
    xpadneo.enable = true;

  };

  services.logind.lidSwitch = "suspend";
  #systemd.sleep.extraConfig = ''
  #  HibernateMode=shutdown
  #'';

  environment.variables.AMD_VULKAN_ICD = lib.mkDefault "RADV";

  environment.systemPackages = with pkgs; [
    lm_sensors
    linuxKernel.packages.linux_lqx.cpupower
  ];

  powerManagement = {
    cpuFreqGovernor = "ondemand";
    powertop.enable = false;
  };

  services = {
    udev.extraRules = ''
      ENV{ID_FS_USAGE}=="filesystem|other|crypto", ENV{UDISKS_FILESYSTEM_SHARED}="1"
    '';
    udisks2.settings = {
      "mount_options.conf" = {
        "/dev/disk/by-uuid/542cd982-4845-4dbf-adad-de6536caf0e6" = {
          defaults = "compress-force=zstd:6";
        };
        "/dev/disk/by-uuid/4bf92d1a-b177-4f5d-ae06-927acbb655ea" = {
          defaults = "compress-force=zstd:6";
        };
      };
    };
  };

  sound.enable = true;

  location = {
    latitude = 50.9787;
    longitude = 11.03283;
  };
}