#
#  Home-manager configuration for desktop
#
#  flake.nix
#   ├─ ./hosts
#   │   └─ ./frankenbook
#   │       └─ ./home.nix
#   └─ ./modules
#       └─ ./desktop
#           └─ ./sway
#               └─ home.nix
#

{ config, lib, pkgs, ... }:

with lib;

{
  imports =
    (import ../../home/frankenbook);
  home = {
    sessionVariables = {
      BROWSER = "friefox";
    };
    packages = with pkgs;
      [
        ((emacsPackagesFor emacsPgtkNativeComp).emacsWithPackages
          (epkgs: [ epkgs.vterm ]))
        (aspellWithDicts (ds: with ds; [ de en en-computers en-science ]))
        firefox-wayland
        tridactyl-native
        imv

        # media
        mpv
        pamixer
        playerctl

        #Emulation

        # misc
        cmake
        gtk_engines
        nixfmt
        pavucontrol
        xfce.thunar
        xfce.tumbler
        ffmpegthumbnailer
      ];
  };

  services = {
    # Applets
    blueman-applet.enable = true; # Bluetooth
  };
}
