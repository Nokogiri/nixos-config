{ pkgs, ... }:

{
  nixpkgs.config.packageOverrides = pkgs:
    with pkgs; {
      mpv = mpv.override { scripts = [ pkgs.mpvScripts.mpris ]; };
      steam = steam.override {
        extraPkgs = pkgs:
          with pkgs; [
            libgdiplus
            gamescope
            mangohud
            xorg.libXcursor
            xorg.libXi
            xorg.libXinerama
            xorg.libXScrnSaver
            libpng
            libpulseaudio
            libvorbis
            stdenv.cc.cc.lib
            libkrb5
            keyutils
          ];
      };
      nerdfonts = nerdfonts.override {
        fonts = [
          "CascadiaCode"
          "FiraMono"
          "FiraCode"
        ];
      };
    };
}

