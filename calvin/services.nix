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
  };


  virtualisation = {
    docker = {
      enable = true;
      storageDriver = "btrfs";
    };
  };
}
