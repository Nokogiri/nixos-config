{ config, pkgs, libs, ... }:

{

  #services.emacs.package = pkgs.emacsPgtkGcc;
  environment.systemPackages = with pkgs; [
    (emacsPackagesFor emacsPgtkGcc)
  #    emacsPgtkGcc
  ];
}
