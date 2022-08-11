{
  description = "My Personal NixOS and Darwin System Flake Configuration";
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

    sops-nix = {
      url = "github:Mic92/sops-nix";
    };

    home-manager = {
      url = "github:nix-community/home-manager/master";
    };

    emacs-overlay = {
      url = "github:nix-community/emacs-overlay/962851d3e66ce26c65693ab9e2eadd87c24b5c7c";
      #url = "github:nix-community/emacs-overlay";
    };

    addins = {
      url = "git+https://codeberg.org/Nokogiri/nix-pkgs.git";
    };

    nix-minecraft = {
      url = "github:Infinidoge/nix-minecraft";
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
    , ...
    }:
    let
      user = "nokogiri";
    in
    {
      nixosConfigurations = (
        import ./hosts {
          inherit (nixpkgs) lib;
          inherit inputs nixpkgs home-manager user addins emacs-overlay nix-minecraft sops-nix;
        }
      );
      nixosConfiguration = (
        import ./arm {
          inherit (nixpkgs) lib;
        }
      );
    };
}

