{ pkgs, ... }:

{
  fonts.fonts = with pkgs; [
    (nerdfonts.override {
      fonts = [
        "CascadiaCode"
        "FiraMono"
        "FiraCode"
        "Meslo"
      ];
    })
    #corefonts
    dejavu_fonts
    fira-code
    fira-mono
    unifont
    noto-fonts
    noto-fonts-emoji
    noto-fonts-cjk-sans
    powerline-symbols
    weather-icons
  ];

  fonts = {
    enableDefaultFonts = true;
    fontDir.enable = true;
    enableGhostscriptFonts = true;
    fontconfig = {
      enable = true;
      antialias = true;
      defaultFonts = {
        serif = [ "Fira Code" ];
        sansSerif = [ "Fira Code" ];
        monospace = [ "Fira Mono" ];
      };
    };
  };
}
