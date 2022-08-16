{ pkgs, lib, user, ... }:

{
  imports =
    [ (import ./configuration.nix) ] ++
    [ (import ./network.nix) ] ++
    (import ../../modules/frankenbook);
}
