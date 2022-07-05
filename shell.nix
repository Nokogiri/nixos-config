{ pkgs ? import <nixpkgs> {} , ... }:
pkgs.mkShell {
  nativeBuildInputs = with pkgs; [
    nix
    home-manager
    git

    # Para deploy
    ssh-to-pgp
    gnupg
    age
    sops
  ];
}

