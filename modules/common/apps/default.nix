{ config, pkgs, lib, ... }:

{
  environment.systemPackages = with pkgs; [
    (pkgs.writeShellScriptBin "nixVersions.stable" ''
      exec ${pkgs.nixVersions.stable}/bin/nix --experimental-features "nix-command flakes" "$@"
    '')
    age
    atool
    bat
    btop
    chezmoi
    compsize
    direnv
    dfc
    docker-compose
    fd
    file
    fzf
    git
    jq
    killall
    lesspipe
    linuxKernel.packages.linux_zen.cpupower
    lsd
    ncdu
    neovim
    nix-diff
    nix-direnv
    nix-index
    nix-tree
    nix-top
    nix-zsh-completions
    nixpkgs-fmt
    pfetch
    python
    ranger
    rbw
    ripgrep
    rsync
    starship
    tmux
    unrar
    unzip
    zip
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
