{ config, pkgs, ... }:

{
  programs = {
    starship = {
      enable = true;
      enableZshIntegration = false;
      settings = {
        add_newline = false;
        battery = { disabled = true; };
      };
    };
  };
}
