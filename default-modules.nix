{ config, pkgs, lib, ... }:

{
  imports = [ 
    ./cachix.nix
    ./default.nix
    ./modules/fonts.nix
    ./modules/shell-programs.nix
  ];
}
