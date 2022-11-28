{ config, pkgs, lib, ... }:

{
  nixpkgs.overlays = [
    (self: super: {
      mpv = super.mpv.override { scripts = [ self.mpvScripts.mpris ]; };
    })
  ];
  nixpkgs.config.packageOverrides = pkgs: {
    steam = pkgs.steam.override {
      extraPkgs = pkgs:
        with pkgs; [
          libgdiplus
          gamescope
          mangohud
          xorg.libXcursor
          xorg.libXi
          xorg.libXinerama
          xorg.libXScrnSaver
          libpng
          libpulseaudio
          libvorbis
          stdenv.cc.cc.lib
          libkrb5
          keyutils
        ];
    };
  };
  environment.systemPackages = with pkgs; [
    amdvlk
    brightnessctl
    blueman
    cmake
    clang
    firefox
    fprintd
    fwupd
    gcc
    gnumake
    ffmpeg
    glib.bin
    glfw-wayland
    hunspell
    iio-sensor-proxy
    iwd
    iwgtk
    ldns
    libinput
    libva-utils
    mpv
    pandoc
    pinentry-gnome
    pkg-config
    polkit_gnome
    (let
      python-packages-plus = python-packages:
        with python-packages; [
          isort
          evdev
          jinja2
          nose
          pytest
          requests
          unidecode
          setuptools
        ];
      python-with-packages-plus = python3.withPackages python-packages-plus;
    in python-with-packages-plus)
    sshfs-fuse
    texlive.combined.scheme-small
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
    steam = {
      enable = true;
      remotePlay.openFirewall = true;
      dedicatedServer.openFirewall = true;
    };
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

