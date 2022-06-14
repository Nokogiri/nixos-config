{ config, pkgs, lib, ... }:

{
  imports = [ 
    ./default.nix
    ./modules/security.nix
  ];
}
