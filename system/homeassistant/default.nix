{ pkgs, lib, user, ... }:

{
  imports = [ (import ./configuration.nix) ] ++ (import ./modules);
}
