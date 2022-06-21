{ config, pkgs, lib, ... }:

{
  environment.systemPackages = with pkgs; [
    (pkgs.writeShellScriptBin "nixFlakes" ''
      exec ${pkgs.nixFlakes}/bin/nix --experimental-features "nix-command flakes" "$@"
    '')
    age
    bat
    btop
    cachix
    exa
    dfc
    fd
    file
    fzf
    git
    gitAndTools.diff-so-fancy
    lesspipe
    linuxKernel.packages.linux_xanmod.cpupower
    neovim
    neovim-remote
    ncdu
    nix-diff
    nix-index
    nix-tree
    nix-top
    nix-pin
    ranger
    rbw
    ripgrep
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
