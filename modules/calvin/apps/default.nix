{ config, pkgs, lib, ... }:

{

  environment.systemPackages = with pkgs; [
    docker-compose
    git
    jellyfin-ffmpeg
    ncdu_2
  ];

  programs = {
    git.enable = true;
    gnupg.agent.enable = true;
    tmux.enable = true;
    ssh.startAgent = true;
  };
}
