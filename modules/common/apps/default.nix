{ config, pkgs, lib, ... }:

{
  environment.systemPackages = with pkgs; [
    (pkgs.writeShellScriptBin "nixFlakes" ''
      exec ${pkgs.nixFlakes}/bin/nix --experimental-features "nix-command flakes" "$@"
    '')
    age
    bat
    btop
    compsize
    direnv
    dfc
    fd
    file
    fzf
    git
    gitAndTools.diff-so-fancy
    jq
    killall
    lesspipe
    linuxKernel.packages.linux_xanmod_latest.cpupower
    lsd
    neovim
    neovim-remote
    nix-diff
    nix-direnv
    nix-index
    nix-tree
    nix-top
    nixpkgs-fmt
    ranger
    rbw
    ripgrep
    rsync
    tmux
    unrar
    unzip
    zip
    zsh-powerlevel10k
    vivid
    wireguard-tools
    yadm
  ];

  programs = {
    git.enable = true;
    tmux.enable = true;
    zsh.enable = true;
  };

  programs.command-not-found.enable = false;
  programs.zsh.interactiveShellInit = ''
    source ${pkgs.nix-index}/etc/profile.d/command-not-found.sh
  '';
}
