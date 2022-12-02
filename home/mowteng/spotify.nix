{ pkgs, lib, spicetify-nix, ... }: {

  #imports = [ spicetify-nix.homeManagerModule ];
  programs.spicetify = {
    enable = true;
    theme = "catppuccin-frappe";
    # OR 
    # theme = spicetify-nix.pkgSets.${pkgs.system}.themes.catppuccin-mocha;
    colorScheme = "teal";

    enabledExtensions = [ "fullAppDisplay.js" "shuffle+.js" "hidePodcasts.js" ];
  };
}
