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
    pipewire = {
      enable = true;
      alsa.enable = true;
      pulse.enable = true;
      wireplumber.enable = true;
    };
    resolved = {
      enable = true;
      extraConfig = ''
        Domains=home.arpa
        MulticastDNS=true
        LLMNR=true
        ReadEtcHosts=true
        Cache=true
      '';
    };
    tlp.enable = true;
    udisks2.enable = true;

  };

  security = {
    polkit.enable = true;
    rtkit.enable = true;
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
