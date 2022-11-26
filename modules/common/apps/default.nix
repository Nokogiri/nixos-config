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
    lsd
    ncdu
    neovim
    nix-diff
    nix-direnv
    nix-index
    nix-tree
    nix-top
    nix-pin
    nix-zsh-completions
    python
    ranger
    rclone
    ripgrep
    rsync
    ssh-to-age
    starship
    unrar
    unzip
    zip
    vivid
    wireguard-tools
  ];

  programs = {
    git.enable = true;
    gnupg.agent.enable = true;
    tmux.enable = true;
    zsh.enable = true;
  };

  programs.command-not-found.enable = false;
  programs.zsh.interactiveShellInit = ''
    source ${pkgs.nix-index}/etc/profile.d/command-not-found.sh
  '';
}
