{ config, pkgs, lib, ... }:

{

  environment.systemPackages = with pkgs; [ jellyfin-ffmpeg rclone ];

  programs = {
    git.enable = true;
    gnupg.agent.enable = true;
    tmux.enable = true;
    ssh.startAgent = true;
  };
}
