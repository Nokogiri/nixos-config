{ config, pkgs, lib, ... }:

{
  nixpkgs.overlays = [
    (self: super:
    {
      fusuma = super.callPackage ../pkgs/fusuma { };
    })
  ];

  #services.emacs.package = pkgs.emacsPgtkNativeComp;

  environment.systemPackages = with pkgs; [
    cmake
    emacsPgtkNativeComp
    fusuma
    glib.bin
    gnome.adwaita-icon-theme
    gnumake
    gtk-engine-murrine
    gtk_engines
    gsettings-desktop-schemas
    hunspell
    hunspellDicts.en_US
    hunspellDicts.de_DE
    #jdk
    kitty
    libsForQt5.qtstyleplugin-kvantum
    mpv
    mpvScripts.mpris
    neovide
    nixfmt
    pandoc
    pipenv
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
    shellcheck
    texlive.combined.scheme-small
    tridactyl-native
    xdg_utils
  ];

  programs.git.enable = true;
  programs.gnupg.agent.enable = true;
  programs.light.enable = true;
  programs.qt5ct.enable = true;
  programs.ssh.startAgent = true;
  programs.tmux.enable = true;
  programs.waybar.enable = true;
  programs.xwayland.enable = true;
  programs.zsh.enable = true;

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
