{ config, pkgs, lib, ... }:

{
  services = {

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
    printing.enable = true;
    resolved = {
      enable = true;
      extraConfig = ''
        Domains=home.arpa
        #MulticastDNS=resolve
        #LLMNR=false
        ReadEtcHosts=true
        Cache=true
      '';
    };
    udisks2.enable = true;
    upower.enable = true;

  };

  security = {
    polkit = {
      enable = true;
      adminIdentities = [ "unix-user:nokogiri" ];
    };
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
