{ config, pkgs, lib, ... }:

{
  environment.systemPackages = with pkgs; [
    brightnessctl
    iwd
    ldns
    sshfs-fuse
    udisks
    udiskie
    yt-dlp
  ];


  programs = {
    gnupg.agent.enable = true;
    mtr.enable = true;
    light.enable = true;
    ssh.startAgent = true;
  };

}

