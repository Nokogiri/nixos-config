# Home-manager configuration for desktop
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
  imports = (import ../../home/mowteng);
  home = {
    sessionVariables = { BROWSER = "friefox"; };
    packages = with pkgs; [
      ((emacsPackagesFor emacsPgtkNativeComp).emacsWithPackages
        (epkgs: [ epkgs.vterm ]))
      (aspellWithDicts (ds: with ds; [ de en en-computers en-science ]))
      firefox-wayland
      tridactyl-native
      chromium
      gimp
      gopass
      gtk-pipe-viewer
      imv
      inkscape
      ncspot
      zathura

      gparted
      # media
      mpv
      pamixer
      playerctl
      spotify
      yt-dlp

      #Emulation
      cemu
      ppsspp-sdl-wayland
      rpcs3
      retroarch
      libretro.mgba
      libretro.bsnes
      libretro.bsnes-hd
      libretro.dolphin
      libretro.snes9x
      libretro.flycast
      libretro.melonds
      libretro.gambatte
      libretro.genesis-plus-gx
      libretro.beetle-psx
      libretro.beetle-psx-hw
      libretro.beetle-pce-fast
      libretro.beetle-supergrafx
      libretro.mupen64plus
      libretro.parallel-n64

      #Games
      gamemode
      gamescope
      heroic-beta
      mangohud
      prismlauncher

      # misc
      cmake
      gtk_engines
      nixfmt
      pavucontrol
    ];
  };

  services = {
    # Applets
    blueman-applet.enable = true; # Bluetooth
  };
}
