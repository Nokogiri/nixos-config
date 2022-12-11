{ config, pkgs, lib, ... }:

{
  services = {

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

    resolved = {
      enable = true;
      extraConfig = ''
        Domains=home.arpa
        MulticastDNS=true
        LLMNR=true
      '';
    };
    udisks2.enable = true;

  };
}
