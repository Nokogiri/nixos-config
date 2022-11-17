{ config, pkgs, lib, ... }:

{
  services = {

    avahi.enable = true;
    dbus.enable = true;
    logind.lidSwitch = "ignore";
    mbpfan = {
      enable = true;
      settings.general = {
        low_temp = 55;
        high_temp = 70;
        max_temp = 89;
        polling_interval = 2;
        min_fan1_speed = 2000;
      };
    };
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
}
