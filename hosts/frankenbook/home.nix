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
        gimp
        gtk-pipe-viewer
        imv
        inkscape
        ncspot
        neovide
        zathura

        # media
        mpv
        playerctl

        #Emulation
        EmulationStation-DE
        gamemode
        ppsspp-sdl
        retroarch
        libretro.mgba
        libretro.bsnes
        libretro.bsnes-hd
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
        eduke32
        gzdoom
        minetest
        polymc
        vkquake
        yquake2-all-games

        # misc
        cmake
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
