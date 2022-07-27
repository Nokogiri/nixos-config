{ config, pkgs, ... }:
{
  programs = {
    zsh = {
      dotDir = ".config/zsh";
      enable = true;
      enableAutosuggestions = true;
      enableCompletion = true;
      enableSyntaxHighlighting = true;
      initExtraFirst = ''
        if [[ -r "$\{XDG_CACHE_HOME\}/p10k-instant-prompt-$\{(%):-%n\}.zsh" ]]; then
          source "$\{XDG_CACHE_HOME/p10k-instant-prompt-$\{(%):-%n\}.zsh"
        fi
        export FZF_PREVIEW_ADVANCED=true
      '';
      initExtra = ''
        source ${pkgs.zsh-powerlevel10k}/share/zsh-powerlevel10k/powerlevel10k.zsh-theme
        POWERLEVEL9K_DISABLE_CONFIGURATION_WIZARD=true
        source ~/.p10k.zsh
      '';
      history = {
        expireDuplicatesFirst = true;
        extended = true;
        ignoreDups = true;
        ignoreSpace = true;
        path = "${config.xdg.configHome}/zsh/zsh_history";
        save = 100000;
        share = true;
        size = 100000;
      };
      oh-my-zsh = {
        enable = true;
        plugins = [
          "fzf"
        ];
      };
      plugins = [
        #{
        #  name = "zsh-autosuggestions";
        #  src = pkgs.fetchFromGitHub {
        #    owner = "zsh-users";
        #    repo = "zsh-autosuggestions";
        #    rev = "v0.7.0";
        #    sha256 = "KLUYpUu4DHRumQZ3w59m9aTW6TBKMCXl2UcKi4uMd7w=";
        #  };
        #}
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
