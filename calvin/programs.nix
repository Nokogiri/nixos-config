{ config, pkgs, lib, ... }:

{

  environment.systemPackages = with pkgs; [
    #   vim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
    #   wget
    git
    rclone
    jellyfin-ffmpeg
  ];

  programs = {
    git.enable = true;
    gnupg.agent.enable = true;
    tmux.enable = true;
    ssh.startAgent = true;
  };
}
