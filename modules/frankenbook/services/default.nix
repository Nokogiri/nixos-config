{ config, pkgs, lib, ... }:

{
  services = {

    avahi = {
      enable = true;
      hostName = "homeassistant";
      ipv6 = false;
      publish = {
        enable = true;
        workstation = true;
        hinfo = true;
        domain = true;
        userServices = true;
      };
    };
    btrbk = {
      extraPackages = [
        pkgs.mbuffer
        pkgs.xz
      ];
    };
    dbus.enable = true;
    logind.lidSwitch = "ignore";
    mbpfan = {
      enable = true;
      settings.general = {
        low_temp = 50;
        high_temp = 65;
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
