{ config, pkgs, lib, ... }:

{
  services = {
    openssh.enable = true;
    qemuGuest.enable = true;
    jellyfin.enable = true;
    nix-serve = {
      enable = true;
      secretKeyFile = "/var/cache-priv-key.pem";
    };
    transmission = {
      enable = true;
      user = "nokogiri";
      openPeerPorts = true;
      credentialsFile = "/var/lib/secrets/transmission/settings.json";
      settings = { 
        rpc-bind-address = "10.200.200.1";
      };
    };
  };
}
