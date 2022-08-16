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

      NIXOS_OZONE_WL = 1;

    };
    sessionPath = [
      "${config.home.homeDirectory}/.local/bin"
      "${config.xdg.configHome}/emacs/bin"
    ];
  };
}
