{ pkgs, lib, spicetify-nix, ... }:
let spicePkgs = spicetify-nix.pkgSets.${pkgs.system};
in {

  programs.spicetify = {
    enable = true;
    #theme = "catppuccin-frappe";
    # OR 
    theme = spicePkgs.themes.catppuccin-frappe;
    colorScheme = "teal";

    #enabledCustomApps = with spicetify-nix.pkgSets.${pkgs.system}.apps; [ lyrics-plus ];
    enabledCustomApps = with spicePkgs.apps; [ marketplace lyrics-plus ];
    enabledExtensions = [ "shuffle+.js" "hidePodcasts.js" "fullAppDisplay.js" ];
  };
}
