{ pkgs, ... }:

{
  fonts.fonts = with pkgs; [
    nerdfonts
    dejavu_fonts
    fira-code
    fira-mono
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
        serif = [ "Fira Code" ];
        sansSerif = [ "Fira Code" ];
        monospace = [ "Fira Mono" ]; 
        emoji = [ "Twitter Color Emoji" ];
      };
    };
  };
}
