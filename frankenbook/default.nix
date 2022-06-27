{ config, pkgs, lib, ... }:

{
  imports = [
    ./network.nix
    ./programs.nix
    ./retroarch.nix
    ./services.nix
    ./sops.nix
    ./sway.nix
    ./system.nix
    ./users.nix
  ];
}

