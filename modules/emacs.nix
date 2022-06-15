{config, pkgs, callPackage, ... }:
{

  nixpkgs.overlays = [
    (import (fetchzip {
      url = https://github.com/nix-community/emacs-overlay/archive/master.tar.gz;
    }))
  ];

}
