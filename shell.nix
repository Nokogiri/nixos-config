{ pkgs ? import <nixpkgs> { }, ... }:
pkgs.mkShell {
  nativeBuildInputs = with pkgs; [
    nix
    home-manager
    git
    nix-universal-prefetch
    age
    sops
    ssh-to-age
  ];
}

