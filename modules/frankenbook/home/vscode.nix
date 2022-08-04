{ pkgs, ... }:
{
  programs.vscode = {
    enable = true;
    extensions = with pkgs.vscode-extensions; [
      bbenoist.nix
      bodil.file-browser
      jnoortheen.nix-ide
      yzhang.markdown-all-in-one
    ] ++ pkgs.vscode-utils.extensionsFromVscodeMarketplace [
      {
        name = "Theme-TomorrowKit";
        publisher = "ms-vscode";
        version = "0.1.4";
        sha256 = "qakwJWak+IrIeeVcMDWV/fLPx5M8LQGCyhVt4TS/Lmc=";
      }
    ];
  };
}
