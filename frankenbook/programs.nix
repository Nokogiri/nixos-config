{ config, pkgs, libs, ... }:

{
  services.emacs.package = pkgs.emacsPgtkNativeComp;
  environment.systemPackages = with pkgs; [
    cmake
    gnumake
    hunspell
    hunspellDicts.en_US
    hunspellDicts.de_DE
    nixfmt
    pandoc
    shellcheck
    emacsPgtkNativeComp

  ];
  
}
