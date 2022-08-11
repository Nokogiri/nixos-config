{ config, libs, ... }:

{
  home = {
    sessionVariables = {
      PAGER = "less";
      MANPAGER = "sh -c 'col -bx | bat -l man -p'";
      TERMINAL = "kitty";
      EDITOR = "nvim";
      VISUAL = "${config.home.sessionVariables.EDITOR}";
      BROWSER = "firefox";
      XDG_CONFIG_HOME = "$HOME/.config";
      XDG_DATA_HOME = "$HOME/local/share";
      XDG_CACHE_HOME = "$HOME/.cache/";
 
      NIXOS_OZONE_WL = 1;

    };
    sessionPath = [
      "$HOME/.local/bin"
      "${config.xdg.configHome}/emacs/bin"
    ];
  };
}
