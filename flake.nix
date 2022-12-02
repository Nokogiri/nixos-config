{
  description = "My Personal NixOS System Flake Configuration";
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

    sops-nix = { url = "github:Mic92/sops-nix"; };

    home-manager = { url = "github:nix-community/home-manager/master"; };

    emacs-overlay = { url = "github:nix-community/emacs-overlay"; };

    spicetify-nix = { url = "github:the-argus/spicetify-nix"; };

    addins = { url = "git+https://codeberg.org/Nokogiri/nix-pkgs.git"; };

    nix-minecraft = { url = "github:Infinidoge/nix-minecraft"; };
  };

  outputs = inputs@{ self, nixpkgs, sops-nix, nix-minecraft, home-manager
    , emacs-overlay, addins, spicetify-nix, ... }:
    let user = "nokogiri";
    in {
      nixosConfigurations = (import ./system {
        inherit (nixpkgs) lib;
        inherit inputs nixpkgs user nix-minecraft sops-nix home-manager
          emacs-overlay addins spicetify-nix;
      });
      nixosConfiguration = (import ./arm { inherit (nixpkgs) lib; });
    };
}

