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
    compsize
    direnv
    dfc
    fd
    file
    fzf
    git
    gitAndTools.diff-so-fancy
    jq
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
    vivid
    wireguard-tools
    yadm
  ];

  programs.zsh.enable = true;
  
  programs.command-not-found.enable = false;
  programs.zsh.interactiveShellInit = ''
    source ${pkgs.nix-index}/etc/profile.d/command-not-found.sh
  '';

}
