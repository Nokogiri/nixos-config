{ config, pkgs, libs, ... }:

{
#    nixpkgs.overlays = [
#    (import (builtins.fetchTarball {
#      url = https://github.com/nix-community/emacs-overlay/archive/5a16283b229aa4e7403a35b01ef2cc538c33dc03.tar.gz;
#      sha256 = "04bj00yd3mvliw3a79ga4y23y802i8s328g7k3l2qjfskjssd2rh";
#    }))
#  ];
  services.emacs.package = pkgs.emacsPgtkNativeComp;
  environment.systemPackages = with pkgs; [
    emacsPgtkNativeComp
  ];
  
}
