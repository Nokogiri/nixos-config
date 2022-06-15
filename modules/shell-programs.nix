{ config, pkgs, lib, ... }:

{
  environment.systemPackages = with pkgs; [
    (pkgs.writeShellScriptBin "nixFlakes" ''
      exec ${pkgs.nixFlakes}/bin/nix --experimental-features "nix-command flakes" "$@"
    '')
    age
    bat
    btop
    linuxKernel.packages.linux_xanmod.cpupower
    dfc
    file
    fzf
    gitAndTools.diff-so-fancy
    lesspipe
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
    tmux
    unrar
    unzip
    zip
    wireguard-tools
    yadm
  ];

  programs.zsh.enable = true;
  
  programs.command-not-found.enable = false;
  programs.zsh.interactiveShellInit = ''
    source ${pkgs.nix-index}/etc/profile.d/command-not-found.sh
  '';

}
