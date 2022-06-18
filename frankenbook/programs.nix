{ config, pkgs, lib, ... }:

{
  environment.systPackages = with pkgs; [
    cmake
    emacsPgtkNativeComp
    glib.bin
    gnome.adwaita-icon-theme
    gnumake
    gtk-engine-murrine
    gtk_engines
    gsettings-desktop-schemas
    hunspell
    hunspellDicts.en_US
    hunspellDicts.de_DE
    jdk
    kitty
    libsForQt5.qtstyleplugin-kvantum
    mpv
    mpvScripts.mpris
    neovide
    nixfmt
    pandoc
    polkit_gnome
    shellcheck
    texlive.combined.scheme-small
    tridactyl-native
    xdg_utils
  ];
}
