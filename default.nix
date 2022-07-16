{ config, pkgs, lib, ... }:

{
  nix = {
    package = pkgs.nixFlakes;
    extraOptions = ''
      experimental-features = nix-command flakes
      keep-outputs = true
      keep-derivations = true
    '';
    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 20d";
    };
    settings = {
      substituters = [
        "https://cache.fishoeder.net"
        "https://nix-community.cachix.org"
        "https://nookogiri.cachix.org"
        "https://cache.nixos.org"
      ];
      trusted-public-keys = [
        "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
        "nookogiri.cachix.org-1:tKY3HBn6Xhuqys5EcQRl1u+sKualOXFzCs9Q6qEXR+o="
        "cache.fishoeder.net:0wqH5JXoJJVWitNUfD9PCCVO+A8DOEOyXZSrkCi5lb8="
      ];
    };
  };

  environment.pathsToLink = [
    "/share/nix-direnv"
  ];

  nixpkgs.config.allowUnfree = true;

  i18n = {
    defaultLocale = "en_US.UTF-8";
    supportedLocales = [
      "en_US.UTF-8/UTF-8"
      "de_DE.UTF-8/UTF-8"
    ];
    extraLocaleSettings = {
      LC_CTYPE = "en_US.UTF-8";
      LC_NUMERIC = "de_DE.UTF-8";
      LC_TIME = "de_DE.UTF-8";
      LC_COLLATE = "en_US.UTF-8";
      LC_MONETARY = "de_DE.UTF-8";
      LC_MESSAGES = "en_US.UTF-8";
      LC_PAPER = "de_DE.UTF-8";
      LC_NAME = "en_US.UTF-8";
      LC_ADDRESS = "en_US.UTF-8";
      LC_TELEPHONE = "en_US.UTF-8";
      LC_MEASUREMENT = "de_DE.UTF-8";
      LC_IDENTIFICATION = "en_US.UTF-8";
    };
  };

  console.font = "Lat2-14";

  time.timeZone = "Europe/Berlin";

  security = {
    doas = {
      enable = true;
      wheelNeedsPassword = true;
      extraRules = [{
        groups = [ "wheel" ];
        noPass = false;
        keepEnv = true;
        persist = true;
      }
        {
          users = [ "nokogiri" ];
          noPass = true;
          keepEnv = true;
          persist = false;
        }];
    };
  };

  system.stateVersion = "22.05";
}
