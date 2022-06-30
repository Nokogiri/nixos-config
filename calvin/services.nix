{ config, pkgs, lib, ... }:

{
  services = {
    openssh.enable = true;
    qemuGuest.enable = true;
    jellyfin.enable = true;
  };


  virtualisation = {
    docker = {
      enable = true;
      storageDriver = "btrfs";
    };
  };
}
