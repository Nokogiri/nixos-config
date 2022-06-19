{ config, pkgs, lib, ... }:

{
  services = {

    avahi.enable = true;

    clight.enable = true;

    dbus.enable = true;

    mbpfan = {
      enable = true;
      settings.general.max_temp = 80;
      settings.general.polling_interval = 2;
      settings.general.min_fan1_speed = 2600;    
    };

    pipewire = {
      enable = true;
      alsa.enable = true;
      pulse.enable = true;
      wireplumber.enable = true;
    };

    resolved.enable = true;

    tlp.enable = true;

  };

  virtualisation = {
    docker = {
      enable = false;
      storageDriver = "btrfs";
    };

    libvirtd = {
      enable = false;
      onBoot = "ignore";
      onShutdown = "shutdown";
    };
  };
}
