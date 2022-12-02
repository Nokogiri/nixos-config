{ pkgs, lib, spicetify-nix, ... }: 
{

  programs.spicetify = {
    enable = true;
    theme = "catppuccin-frappe";
    # OR 
    # theme = spicetify-nix.pkgSets.${pkgs.system}.themes.catppuccin-mocha;
    colorScheme = "teal";
  
    enabledCustomApps = [
      "lyrics-plus"
    ];
    enabledExtensions = [ "shuffle+.js" "hidePodcasts.js" ];
  };
}
