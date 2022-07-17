{ pkgs, ... }:

{
  fonts.fonts = with pkgs; [
    (nerdfonts.override {
      fonts = [ "FiraCode" "FiraMono" "Meslo" "Mononoki" ];
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
        serif = [ "MesloLGSDZ Nerd Font" ];
        sansSerif = [ "MesloLGSDZ Nerd Font" ];
        monospace = [ "mononoki Nerd Font Mono" ];
      };
    };
  };
}
