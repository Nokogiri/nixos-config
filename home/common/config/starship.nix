{ config, pkgs, ... }:

{
  programs = {
    starship = {
      enable = false;
      enableZshIntegration = false;
      settings = {
        battery = {
          disabled = true;
        };
      };
    };
  };
}
