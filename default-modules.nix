{ config, pkgs, lib, ... }:

{
  imports = [ 
    ./modules/security.nix
  ];
}
