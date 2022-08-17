{ config, pkgs, lib, ... }:

{
  services = {

    avahi.enable = true;
    clight = {
      enable = false;
      temperature = {
        day = 6500;
        night = 4200;
      };
    };
    dbus.enable = true;
    fwupd = {
      enable = true;
      enableTestRemote = true;
    };
    fprintd.enable = true;
    gnome.gnome-keyring.enable = true;
    mbpfan = {
      enable = false;
      settings.general = {
        low_temp = 55;
        high_temp = 65;
        max_temp = 84;
        polling_interval = 1;
        min_fan1_speed = 2500;
      };
    };

    pipewire = {
      enable = true;
      alsa.enable = true;
      pulse.enable = true;
      wireplumber.enable = true;
    };

    resolved.enable = true;
    tlp.enable = true;
    udisks2.enable = true;

  };

  security = {
    polkit.enable = true;
  };

  virtualisation = {
    docker = {
      enable = false;
      storageDriver = "btrfs";
    };

    libvirtd = {
      enable = true;
      onBoot = "ignore";
      onShutdown = "shutdown";
    };
  };
}
