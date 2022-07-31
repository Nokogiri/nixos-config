{ config, pkgs, lib, ... }:

{
  nixpkgs.overlays = [
    (self: super: {
      mpv = super.mpv-with-scripts.override {
        scripts = [
          self.mpvScripts.mpris
        ];
      };
    })
  ];

  environment.systemPackages = with pkgs; [
    brightnessctl
    blueman
    cmake
    EmulationStation-DE
    ffmpeg
    fusuma
    glib.bin
    gnome-icon-theme
    gnome.adwaita-icon-theme
    gtk-engine-murrine
    gtk_engines
    glfw-wayland
    hunspell
    iwd
    iwgtk
    ldns
    libinput
    ncdu
    pandoc
    pavucontrol
    pinentry-gnome
    polkit_gnome
    (
      let
        python-packages-plus = python-packages: with python-packages; [
          isort
          evdev
          nose
          pytest
          requests
          setuptools
        ];
        python-with-packages-plus = python3.withPackages python-packages-plus;
      in
      python-with-packages-plus
    )
    sshfs-fuse
    texlive.combined.scheme-small
    tridactyl-native
    udiskie
    xdg_utils
    yt-dlp
    wob
  ];


  programs = {
    gnupg.agent.enable = true;
    mtr.enable = true;
    light.enable = true;
    ssh.startAgent = true;
    waybar.enable = true;
    xwayland.enable = true;
  };

  systemd.user.services.fusuma = {
    partOf = [ "graphical-session.target" ];
    after = [ "graphicial-session.target" ];
    path = [ pkgs.libinput ];
    wantedBy = [ "graphical-session.target" ];
    serviceConfig = {
      Type = "simple";
      ExecStart = ":${pkgs.fusuma}/bin/fusuma";
      TimeoutSec = 5;
      Restart = "on-failure";
      Slice = "app.slice";
    };
  };
}

