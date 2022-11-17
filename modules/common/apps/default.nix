{ config, pkgs, lib, ... }:

{
  environment.systemPackages = with pkgs; [
    (pkgs.writeShellScriptBin "nixVersions.stable" ''
      exec ${pkgs.nixVersions.stable}/bin/nix --experimental-features "nix-command flakes" "$@"
    '')
    docker-compose
    pfetch
    starship
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
