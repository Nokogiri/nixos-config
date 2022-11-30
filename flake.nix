{
  description = "My Personal NixOS System Flake Configuration";
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

    sops-nix = { url = "github:Mic92/sops-nix"; };

    home-manager = { url = "github:nix-community/home-manager/master"; };

    emacs-overlay = { url = "github:nix-community/emacs-overlay"; };
    hyprland = {
      url = "github:hyprwm/Hyprland";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    addins = { url = "git+https://codeberg.org/Nokogiri/nix-pkgs.git"; };

    nix-minecraft = { url = "github:Infinidoge/nix-minecraft"; };
  };

  outputs = inputs@{ self, nixpkgs, sops-nix, nix-minecraft, home-manager
    , hyprland, emacs-overlay, addins, ... }:
    let user = "nokogiri";
    in {
      nixosConfigurations = (import ./system {
        inherit (nixpkgs) lib;
        inherit inputs nixpkgs user nix-minecraft sops-nix home-manager hyprland
          emacs-overlay addins;
      });
      nixosConfiguration = (import ./arm { inherit (nixpkgs) lib; });
    };
}

