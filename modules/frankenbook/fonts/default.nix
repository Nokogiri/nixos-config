{ pkgs, ... }:

{
  fonts.fonts = with pkgs; [
    (nerdfonts.override {
      fonts = [ "CascadiaCode" "FiraMono" "Meslo" "Mononoki" "SourceCodePro" ];
    })
    corefonts
    dejavu_fonts
    unifont
    noto-fonts
    noto-fonts-emoji
    noto-fonts-cjk-sans
  ];

  fonts = {
    enableDefaultFonts = true;
    fontDir.enable = true;
    enableGhostscriptFonts = true;
    fontconfig = {
      enable = true;
      antialias = true;
      defaultFonts = {
        serif = [ "SauceCodePro Nerd Font" ];
        sansSerif = [ "SauceCodePro Nerd Font" ];
        monospace = [ "mononoki Nerd Font Mono" ];
      };
    };
  };
}
