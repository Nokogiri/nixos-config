{ config, pkgs, ... }:

{
  programs = {
    starship = {
      enable = true;
      enableZshIntegration = true;
      settings = {
        battery = {
          disabled = true;
        };
      };
    };
  };
}
