{ config, pkgs, lib, ... }:

{
  nixpkgs.overlays = [
    #(self: super:
    #{
    #  fusuma = super.callPackage ../pkgs/fusuma { };
    #})
    (self: super:
    {
      ncdu_fix = super.callPackage ../pkgs/ncdu_2 { };
    })
    (self: super: {
    mpv = super.mpv-with-scripts.override {
      scripts = [ 
        self.mpvScripts.mpris 
      ];
    };
  })
];

  #services.emacs.package = pkgs.emacsPgtkNativeComp;

  environment.systemPackages = with pkgs; [
    cmake
    chromium
    chromium-dev
    EmulationStation-DE
    #emacsPgtkNativeComp
    fusuma
    glib.bin
    gnome-icon-theme
    gnome.adwaita-icon-theme
    gtk-engine-murrine
    gtk_engines
    glfw-wayland
    gsettings-desktop-schemas
    hunspell
    hyprpaper
    iwd
    kitty
    ldns
    libsForQt5.qtstyleplugin-kvantum
    libsForQt5.qt5ct
    mpv
    ncdu
    ncspot
    neovide
    newm
    pandoc
    pavucontrol
    pinentry-gnome
    polkit_gnome
    (polymc.override { msaClientID = "0b5d07b7-fcd2-4f81-901a-7596869a0cee"; })
    (let
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
    python-with-packages-plus)
    sshfs-fuse
    swaynotificationcenter
    waybar-hyprland
    #waybar
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
    git.enable = true;
    gnupg.agent.enable = true;
    hyprland.enable = true;
    mtr.enable = true;
    light.enable = true;
    ssh.startAgent = true;
    tmux.enable = true;
    #waybar.enable = true;
    xwayland.enable = true;
  };
  
  systemd.user.services.fusuma = {
    partOf = ["graphical-session.target"];
    after = ["graphicial-session.target"];
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
