{
  description = "My Personal NixOS and Darwin System Flake Configuration";
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

    sops-nix = {
      url = "github:Mic92/sops-nix";
    };

    nix-minecraft = {
      url = "github:Infinidoge/nix-minecraft";
    };
  };

  outputs =
    inputs@{ self
    , nixpkgs
    , sops-nix
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
          inherit inputs nixpkgs user nix-minecraft sops-nix;
        }
      );
      nixosConfiguration = (
        import ./arm {
          inherit (nixpkgs) lib;
        }
      );
    };
}

