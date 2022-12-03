# Home-manager configuration for desktop
#
#  flake.nix
#   ├─ ./hosts
#   │   └─ ./frankenbook
#   │       └─ ./home.nix
#   └─ ./modules
#       └─ ./desktop
#           └─ ./sway
#               └─ home.nix
#

{ config, lib, pkgs, ... }:

with lib;

{
  imports = (import ../../home/mowteng);
  home = {
    sessionVariables = { BROWSER = "friefox"; };
    packages = with pkgs; [
      ((emacsPackagesFor emacsPgtk).emacsWithPackages (epkgs: [ epkgs.vterm ]))
      (aspellWithDicts (ds: with ds; [ de en en-computers en-science ]))

      gparted

      gtk_engines
      nixfmt
    ];
  };
}
