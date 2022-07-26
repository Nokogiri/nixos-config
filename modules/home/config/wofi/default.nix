{ config, pkgs, ... }:

{
  #xdg.configFile."wofi/config".source = ./config;
  xdg.configFile."wofi/style.css".source = ./style.css;

  xdg.configFile."wofi/config".text = ''
    width=965
    height=540
    mode=run
    allow_images=true
  '';
}
