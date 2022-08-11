{ config, pkgs, user, ... }:
{
  xdg.configFile."zsh/p10k.zsh".source = ./p10k.zsh;
  xdg.configFile."zsh/p10k-linux.zsh".source = ./p10k-linux.zsh;
  programs = {
    zsh = {
      dotDir = ".config/zsh";
      enable = true;
      enableAutosuggestions = true;
      enableCompletion = true;
      enableSyntaxHighlighting = true;
      autocd = true;
      initExtraFirst = ''
        if [[ -r "/home/${user}/.cache/p10k-instant-prompt-${user}.zsh" ]]; then
          source "/home/${user}/.cache/p10k-instant-prompt-${user}.zsh"
        fi

        WORDCHARS=""
        
      '';
      initExtra = 
      let
        schema = pkgs.gsettings-desktop-schemas;
        datadir = "${schema}/share/gsettings-schemas/${schema.name}";
      in
      #initExtra = ''
      ''
        #export XDG_DATA_DIRS=${datadir}:$XDG_DATA_DIRS
        zmodload zsh/terminfo
        bindkey "$terminfo[kcuu1]" history-substring-search-up
        bindkey "$terminfo[kcud1]" history-substring-search-down

        export COMPLETION_WAITING_DOTS="true"
        
        setopt correct
        unsetopt correctall

        POWERLEVEL9K_DISABLE_CONFIGURATION_WIZARD=true

        if [[ ! $TERM =~ "linux" ]]; then
          source ~/.config/zsh/p10k.zsh
        else
          source ~/.config/zsh/p10k-linux.zsh
        fi

        # Miscellaneous settings
        #setopt INTERACTIVE_COMMENTS  # Enable comments in interactive shell.
        
        setopt extended_glob # Enable more powerful glob features
        
        # Long running processes should return time after they complete. Specified
        # in seconds.
        REPORTTIME=2
        TIMEFMT="%U user %S system %P cpu %*Es total"

        autoload -U zmv

        ZSH_AUTOSUGGEST_CLEAR_WIDGETS+=(bracketed-paste)
        
        setopt hist_verify
        setopt INC_APPEND_HISTORY
        unsetopt BEEP
        setopt hist_expire_dups_first
        setopt hist_ignore_all_dups


        # Add some completions settings
        setopt ALWAYS_TO_END     # Move cursor to the end of a completed word.
        setopt AUTO_LIST         # Automatically list choices on ambiguous completion.
        setopt AUTO_MENU         # Show completion menu on a successive tab press.
        setopt AUTO_PARAM_SLASH  # If completed parameter is a directory, add a trailing slash.
        setopt COMPLETE_IN_WORD  # Complete from both ends of a word.
        unsetopt MENU_COMPLETE   # Do not autoselect the first completion entry.


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
        enable = true;
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
        {
          name = "powerlevel10k";
          file = "powerlevel10k.zsh-theme";
          src = pkgs.fetchFromGitHub {
            owner = "romkatv";
            repo = "powerlevel10k";
            rev = "e72264e01cb24431455ed6e398a769bca0da7ffe";
            sha256 = "FbjjOLod4l+FGvOhSAmTuAdsoBrxdfEY/MYP163N1xY=";
          };
        }
      ];
      shellAliases = {
        sys = "doas systemctl";
        sysu = "systemctl --user";
      };
    };
  };
}
