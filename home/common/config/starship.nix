{ config, pkgs, ... }:

{
  programs = {
    starship = {
      enable = true;
      enableZshIntegration = false;
      settings = {
        battery = {
          disabled = true;
        };
      };
    };
  };
}
