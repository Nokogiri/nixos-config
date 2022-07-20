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
      url = "github:nix-community/emacs-overlay/9b50baefd34772bfc42002d19c829b20565a6b06";
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

    hyprland = {
      url = "github:hyprwm/Hyprland";
      # build with your own instance of nixpkgs
      inputs.nixpkgs.follows = "nixpkgs";
    };
    newmpkg = {
      url = "github:jbuchermn/newm";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    pywm-fullscreenpkg = {
      url = "github:jbuchermn/pywm-fullscreen";
      inputs.nixpkgs.follows = "nixpkgs";
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
    , hyprland
    , nur
    , newmpkg
    , pywm-fullscreenpkg
    , ...
    }:
    let
      user = "nokogiri";
    in
    {
      nixosConfigurations = (
        import ./hosts {
          inherit (nixpkgs) lib;
          inherit inputs nixpkgs home-manager nur user hyprland addins emacs-overlay nix-minecraft sops-nix newmpkg pywm-fullscreenpkg;
        }
      );
    };
}

