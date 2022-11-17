{ config, pkgs, lib, ... }:

{
  nixpkgs.overlays = [
    (self: super: {
      mpv = super.mpv.override {
        scripts = [
          self.mpvScripts.mpris
        ];
      };
    })
  ];

  environment.systemPackages = with pkgs; [
    brightnessctl
    blueman
    glib.bin
    hunspell
    iwd
    ldns
    pkg-config
    sshfs-fuse
    udisks
    udiskie
    yt-dlp
    xdg_utils
  ];


  programs = {
    gnupg.agent.enable = true;
    mtr.enable = true;
    light.enable = true;
    ssh.startAgent = true;
  };

}

