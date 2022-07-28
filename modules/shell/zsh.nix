{ config, pkgs, user, ... }:
{
  programs = {
    zsh = {
      dotDir = ".config/zsh";
      enable = true;
      enableAutosuggestions = true;
      enableCompletion = true;
      enableSyntaxHighlighting = true;
      initExtraFirst = ''
        if [[ -r "/home/${user}/.cache/p10k-instant-prompt-nokogiri.zsh" ]]; then
          source "/home/${user}/.cache/p10k-instant-prompt-nokogiri.zsh"
        fi
      '';
      initExtra = ''
        source ${pkgs.zsh-powerlevel10k}/share/zsh-powerlevel10k/powerlevel10k.zsh-theme
        POWERLEVEL9K_DISABLE_CONFIGURATION_WIZARD=true
        source ~/.p10k.zsh
        if test -n "$KITTY_INSTALLATION_DIR"; then
          export KITTY_SHELL_INTEGRATION="enabled"
          autoload -Uz -- "$KITTY_INSTALLATION_DIR"/shell-integration/zsh/kitty-integration
          kitty-integration
          unfunction kitty-integration
        fi
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
        plugins = [
          "git"
        ];
      };
      plugins = [
        {
          name = "fzf-tab";
          src = pkgs.fetchFromGitHub {
            owner = "Aloxaf";
            repo = "fzf-tab";
            rev = "7e0eee64df6c7c81a57792674646b5feaf89f263";
            sha256 = "ixUnuNtxxmiigeVjzuV5uG6rIBPY/1vdBZF2/Qv0Trs=";
          };
        }
        {
          name = "fzf-zsh";
          file = "plugins/fzf/fzf.plugin.zsh";
          src = pkgs.fetchFromGitHub {
            owner = "ohmyzsh";
            repo = "ohmyzsh";
            rev = "8362ae285a5c227cb20387543483a3597fa31931";
            sha256 = "4jQEGC3EXLC5dnDa+717/sf29vyS4zdDY/mrQ5gfepY=";
          };
        }
        {
          name = "zsh-history-substring-search";
          src = pkgs.fetchFromGitHub {
            owner = "zsh-users";
            repo = "zsh-history-substring-search";
            rev = "4abed97b6e67eb5590b39bcd59080aa23192f25d";
            sha256 = "8kiPBtgsjRDqLWt0xGJ6vBBLqCWEIyFpYfd+s1prHWk=";
          };
        }
      ];
    };
  };
}
