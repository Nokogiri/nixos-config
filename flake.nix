{
  description = "My Personal NixOS and Darwin System Flake Configuration";
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

    sops-nix = {
      url = "github:Mic92/sops-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    home-manager = {
      url = "github:nix-community/home-manager/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    emacs-overlay = {
      url = "github:nix-community/emacs-overlay/46ffe03d0ac9f371501fd0030d7ca434c856c0c4";
      inputs.nixpgs.follows = "nixpkgs";
    };

    addins = {
      url = "git+https://codeberg.org/Nokogiri/nix-pkgs.git";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nix-minecraft = {
      url = "github:Infinidoge/nix-minecraft";
    };

    nur = {
      url = "github:nix-community/NUR"; # NUR packages
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
    , nur
    , ...
    }:
    let
      user = "nokogiri";
    in
    {
      nixosConfigurations = (
        import ./hosts {
          inherit (nixpkgs) lib;
          inherit inputs nixpkgs home-manager nur user addins emacs-overlay nix-minecraft sops-nix;
        }
      );
    };
}

