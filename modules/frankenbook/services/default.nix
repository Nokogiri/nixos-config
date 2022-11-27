{ config, pkgs, lib, ... }:

{
  services = {

    avahi = {
      enable = false;
      hostName = "homeassistant";
      interfaces = [ "enp1s0f0" ];
      ipv6 = false;
      nssmdns = true;
      publish = {
        enable = true;
        workstation = true;
        hinfo = true;
        domain = true;
        userServices = true;
      };
    };
    btrbk = { extraPackages = [ pkgs.mbuffer pkgs.xz ]; };
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
      enable = false;
      alsa.enable = false;
      pulse.enable = false;
      wireplumber.enable = false;
    };

    resolved = {
      enable = true;
      extraConfig = ''
        Domains=home.arpa
        MulticastDNS=true
        LLMNR=true
      '';
    };
    tlp.enable = false;
    udisks2.enable = true;

  };
}
