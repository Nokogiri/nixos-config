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
        name = "base16-generator";
        publisher = "golf1052";
        version = "1.17.0";
        sha256 = "IpCjeIfRLKJYoVA0S3oUtG5UxqjPBJ2Z3DFpXBCNWeA=";
      }
    ];
  };
}
