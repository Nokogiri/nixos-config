{ pkgs, ... }:
{
programs.vscode = {
    enable = true;
    extensions = with pkgs.vscode-extensions; [
      bbenoist.nix
      eamodio.gitlens
      jnoortheen.nix-ide
      yzhang.markdown-all-in-one
    ];
  };
}