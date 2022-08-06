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

{ pkgs, ... }:

{
  imports =
    (import ../../modules/frankenbook/home);
  #  ../../modules/desktop/sway/home.nix

  home = {
    packages = with pkgs;
    [
      emacsPgtkNativeComp
        firefox-wayland
        gimp
        gtk-pipe-viewer
        imv
        inkscape
        mpv
        ncspot
        neovide
        zathura

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
        #(polymc.override { msaClientID = "0b5d07b7-fcd2-4f81-901a-7596869a0cee"; })
        polymc
        vkquake
        yquake2-all-games
      ];
  };

  services = {
    # Applets
    blueman-applet.enable = true; # Bluetooth
  };
}
