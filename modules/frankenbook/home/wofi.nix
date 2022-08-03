{ config, pkgs, ... }:

{
  xdg.configFile."wofi/style.css".source = ./config/wofi/style.css;
  xdg.configFile."wofi/config".text = ''
    width=965
    height=540
    mode=run
    allow_images=true
  '';
}
