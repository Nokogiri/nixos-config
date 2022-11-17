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
    gnome.gnome-keyring.enable = false;
    logind.lidSwitch = "ignore";
    mbpfan = {
      enable = true;
      settings.general = {
        low_temp = 55;
        high_temp = 70;
        max_temp = 84;
        polling_interval = 2;
        min_fan1_speed = 2000;
      };
    };
    openssh.enable = true;
    pipewire = {
      enable = true;
      alsa.enable = true;
      pulse.enable = true;
      wireplumber.enable = true;
    };

    resolved.enable = true;
    tlp.enable = false;
    udisks2.enable = true;

  };

  virtualisation = {
    docker = {
      enable = true;
      storageDriver = "btrfs";
    };

    libvirtd = {
      enable = false;
      onBoot = "ignore";
      onShutdown = "shutdown";
    };
  };
}
