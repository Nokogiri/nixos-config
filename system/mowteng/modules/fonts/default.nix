{ pkgs, ... }:

{
  fonts.fonts = with pkgs; [
    nerdfonts
    cascadia-code
    dejavu_fonts
    unifont
    twemoji-color-font
    noto-fonts-cjk-sans
    weather-icons
  ];

  fonts = {
    enableDefaultFonts = false;
    fontDir.enable = true;
    enableGhostscriptFonts = true;
    fontconfig = {
      enable = true;
      antialias = true;
      defaultFonts = {
        serif = [ "Cascadia Code" ];
        sansSerif = [ "Cascadia Code" ];
        monospace = [ "Cascadia Mono" ];
        emoji = [ "Twitter Color Emoji" ];
      };
    };
  };
}
