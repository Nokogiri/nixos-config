{ config, pkgs, libs, ... }:

{
  services.emacs.package = pkgs.emacsPgtkNativeComp;
  environment.systemPackages = with pkgs; [
    emacsPgtkNativeComp
  ];
  
}
