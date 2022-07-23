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
    cmake
    EmulationStation-DE
    emacsPgtkNativeComp
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
    kitty
    ldns
    libsForQt5.qtstyleplugin-kvantum
    libsForQt5.qt5ct
    mpv
    ncdu
    ncspot
    pandoc
    pavucontrol
    pinentry-gnome
    pipe-viewer
    gtk-pipe-viewer
    polkit_gnome
    (polymc.override { msaClientID = "0b5d07b7-fcd2-4f81-901a-7596869a0cee"; })
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
    swaynotificationcenter
    texlive.combined.scheme-small
    tridactyl-native
    udiskie
    xdg_utils
    yt-dlp
    zathura
    wob
  ];

  qt5.platformTheme = "qt5ct";

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

