{ config, pkgs, lib, ... }:

{
  services = {
    openssh.enable = true;
  };


  virtualisation = {
    docker = {
      enable = true;
      storageDriver = "btrfs";
    };
  };
}
