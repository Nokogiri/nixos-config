{
  description = "My Personal NixOS and Darwin System Flake Configuration";
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

    sops-nix = {
      url = "github:Mic92/sops-nix";
      #inputs.nixpkgs.follows = "nixpkgs";
    };

    home-manager = {
      url = "github:nix-community/home-manager/master";
      #inputs.nixpkgs.follows = "nixpkgs";
    };

    emacs-overlay = {
      url = "github:nix-community/emacs-overlay/";
      #inputs.nixpgs.follows = "nixpkgs";
    };

    addins = {
      url = "git+https://codeberg.org/Nokogiri/nix-pkgs.git";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nix-minecraft = {
      url = "github:Infinidoge/nix-minecraft";
    };
    nixpkgs-wayland = {
      url = "github:nix-community/nixpkgs-wayland";
    };
  };

  outputs =
    inputs@{ self
    , nixpkgs
    , sops-nix
    , home-manager
    , emacs-overlay
    , addins
    , nix-minecraft
    , nixpkgs-wayland
    , ...
    }:
    let
      user = "nokogiri";
      pkgs = nixpkgs.legacyPackages.x86_64-linux;
    in
    {
      nixosConfigurations = (
        import ./hosts {
          inherit (nixpkgs) lib;
          inherit inputs nixpkgs home-manager user addins emacs-overlay nix-minecraft nixpkgs-wayland sops-nix;
        }
      );
    };
}

