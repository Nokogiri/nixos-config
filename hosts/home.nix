{ config, lib, pkgs, user, ... }:

{
  imports =
    (import ../modules/common/home);

  home = {
    username = "${user}";
    homeDirectory = "/home/${user}";

    packages = with pkgs; [
      home-manager
    ];


    stateVersion = "22.05";
  };
  programs = {
    home-manager.enable = true;
  };

}
