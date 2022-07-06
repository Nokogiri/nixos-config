{ config, pkgs, lib, ... }:

{
  environment.systemPackages = with pkgs; [
    gamemode
    ppsspp-sdl
    retroarch
    libretro.mgba
    libretro.bsnes
    libretro.bsnes-hd
    libretro.snes9x
    #libretro.ppsspp
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
  ];
}
