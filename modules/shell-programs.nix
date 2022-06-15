{ config, pkgs, lib, ... }:

{
  environment.systemPackages = with pkgs; [
    (pkgs.writeShellScriptBin "nixFlakes" ''
      exec ${pkgs.nixFlakes}/bin/nix --experimental-features "nix-command flakes" "$@"
    '')
    age
    bat
    dfc
    diff-so-fancy
    neovim
    nix-index
    ranger
    ssh-to-age
    unrar
    unzip
    wireguard-tools
    yadm
  ];
}
