{ config, pkgs, libs, ... }:

{
  environment.systemPackages = with pkgs; [
    cmake
    gnumake
    hunspell
    hunspellDicts.en_US
    hunspellDicts.de_DE
    jdk
    nixfmt
    pandoc
    texlive.combined.scheme-small
    shellcheck
    emacsPgtkNativeComp

  ];
  
}
