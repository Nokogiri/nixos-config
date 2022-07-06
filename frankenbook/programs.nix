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
    hyprland
    newm
    appimage-run
    cmake
    EmulationStation-DE
    fusuma
    glib.bin
    gnome-icon-theme
    gnome.adwaita-icon-theme
    gtk-engine-murrine
    gtk_engines
    gsettings-desktop-schemas
    hunspell
    iwd
    kitty
    ldns
    libsForQt5.qtstyleplugin-kvantum
    mpv
    ncdu
    ncspot
    pandoc
    pavucontrol
    pinentry-gnome
    polkit_gnome
    (let
      python-packages-plus = python-packages: with python-packages; [
        isort
        nose
        pytest
        requests
        setuptools
      ];
      python-with-packages-plus = python3.withPackages python-packages-plus;
    in
    python-with-packages-plus)
    sshfs-fuse
    texlive.combined.scheme-small
    tridactyl-native
    udiskie
    xdg_utils
    yt-dlp
    zathura
  ];

  programs = {
    git.enable = true;
    gnupg.agent.enable = true;
    mtr.enable = true;
    light.enable = true;
    qt5ct.enable = true;
    ssh.startAgent = true;
    tmux.enable = true;
    waybar.enable = true;
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
