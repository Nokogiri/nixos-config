{ config, pkgs, lib, ... }:

{
  imports = [
    ./emacs.nix
    ./fusuma.nix
    ./network.nix
    ./python.nix
    ./ruby.nix
    ./security.nix
    ./services.nix
    ./sway.nix
    ./users.nix
  ];
}

