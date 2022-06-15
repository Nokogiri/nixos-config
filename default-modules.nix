{ config, pkgs, lib, ... }:

{
  imports = [ 
    ./default.nix
    ./modules/fonts.nix
    ./modules/security.nix
  ];
}
