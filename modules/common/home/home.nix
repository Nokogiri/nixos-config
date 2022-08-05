{ config, ... }:

{
  home = {
    sessionVariables = {
      PAGER = "less";
      MANPAGER = "less";
      TERMINAL = "kitty";
      EDITOR = "nvim";
      VISUAL = "${config.home.sessionVariables.EDITOR}";
      BROWSER = "firefox";

      NIXOS_OZONE_WL = 1;

    };
  };
}