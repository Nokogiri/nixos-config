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
        firefox-wayland
        gimp
        gtk-pipe-viewer
        imv
        inkscape
        mpv
        ncspot
        zathura

        #Emulation
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
        opentyrian
        polymc
        vkquake
        yquake2-all-games
      ];
  };

  programs.vscode = {
    enable = true;
    extensions = with pkgs.vscode-extensions; [
      bbenoist.nix
      eamodio.gitlens
      jnoortheen.nix-ide
      yzhang.markdown-all-in-one
      vscodevim.vim
    ];
  };

  services = {
    # Applets
    blueman-applet.enable = true; # Bluetooth
  };
}
