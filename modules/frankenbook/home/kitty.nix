{
  programs = {
    kitty = {
      enable = true;
      font = {
        name = "mononoki Nerd Font Mono";
        size = 10;
      };
      settings = {
        kitty_mod = "ctrl+shift";

      };
      keybindings = {
        "kitty_mod+c" = "copy_to_clipboard";
        "kitty_mod+c" = "copy_to_clipboard";
        "kitty_mod+v" = "paste_from_clipboard";
        "kitty_mod+s" = "paste_from_selection";
        "shift+insert" = "paste_from_selection";
        "kitty_mod+o" = "pass_selection_to_program";
        "kitty_mod+up" = "scroll_line_up";
        "kitty_mod+k" = "scroll_line_up";
        "kitty_mod+down" = "scroll_line_down";
        "kitty_mod+j" = "scroll_line_down";
        "kitty_mod+page_up" = "scroll_page_up";
        "kitty_mod+page_down" = "scroll_page_down";
        "kitty_mod+home" = "scroll_home";
        "kitty_mod+end" = "scroll_end";
        "kitty_mod+h" = "show_scrollback";
        "kitty_mod+enter" = "new_window";
      };
    };
  };
}
