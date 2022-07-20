{ pkgs, lib, user, ... }:

{
  imports =
    [ (import ./configuration.nix) ] ++
    [ (import ./network.nix) ] ++
    (import ../../modules/desktop) ++
    (import ../../modules/editors);
}
