{config, pkgs, lib, ... }:

{
  services.emacs.package = pkgs.emacsPgtkNativeComp; 
}
