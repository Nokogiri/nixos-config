{ config, pkgs, lib, ... }:

{
  services = {

    avahi.enable = true;
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
        LLMNR=false
        ReadEtcHosts=true
        Cache=true
      '';
    };
    tlp.enable = true;
    udisks2.enable = true;
    upower.enable = true;

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
