{ config, pkgs, lib, ... }:

{
  environment.systemPackages = with pkgs; [
    brightnessctl
    ldns
    rclone
    sshfs-fuse
    udisks
  ];

  programs = {
    gnupg.agent.enable = true;
    mtr.enable = true;
    light.enable = true;
    ssh.startAgent = true;
  };

}

