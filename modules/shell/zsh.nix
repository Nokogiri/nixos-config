{ pkgs, ... }:
{
  programs = {
    zsh = {
      enable = true;
      enableCompletion = true;
      initExtra = ''
        source ${pkgs.zsh-powerlevel10k}/share/zsh-powerlevel10k/powerlevel10k.zsh-theme
        POWERLEVEL9K_DISABLE_CONFIGURATION_WIZARD=true
        source ~/.p10k.zsh
        if [[ -r "$\{XDG_CACHE_HOME\}/p10k-instant-prompt-$\{(%):-%n\}.zsh" ]]; then
          source "$\{XDG_CACHE_HOME/p10k-instant-prompt-$\{(%):-%n\}.zsh"
        fi
      '';
      oh-my-zsh = {
        enable = true;
        plugins = [
          "fzf"
        ];
      };
      plugins = [
        {
          name = "zsh-autosuggestions";
          src = pkgs.fetchFromGitHub {
            owner = "zsh-users";
            repo = "zsh-autosuggestions";
            rev = "v0.7.0";
            sha256 = "022gf4mkaakad7l93d6i2ylkwlg35y5fylf6hd3662r5szlpznfc";
          };
        }
        {
          name = "fzf-tab";
          src = pkgs.fetchFromGitHub {
            owner = "Aloxaf";
            repo = "fzf-tab";
            rev = "master";
            sha256 = "ixUnuNtxxmiigeVjzuV5uG6rIBPY/1vdBZF2/Qv0Trs=";
          };
        }
      ];
    };
  };
}
