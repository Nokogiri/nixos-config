{ config, pkgs, lib, ... }:

{
  environment.systemPackages = with pkgs; [
    (pkgs.writeShellScriptBin "nixFlakes" ''
      exec ${pkgs.nixFlakes}/bin/nix --experimental-features "nix-command flakes" "$@"
    '')
    age
    bat
    btop
    dfc
    file
    fzf
    gitAndTools.diff-so-fancy
    neovim
    neovim-remote
    ncdu
    nix-diff
    nix-index
    nix-tree
    nix-top
    nix-pin
    ranger
    rsync
    ssh-to-age
    unrar
    unzip
    zip
    wireguard-tools
    yadm
  ];

}
