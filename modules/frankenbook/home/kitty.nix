{
  programs = {
    kitty = {
      enable = true;
      font = {
        name = "mononoki Nerd Font Mono";
        size = 10;
      };
      extraConfig = ''
        include ./base16-tomorrow-night-256.conf
      '';
      settings = {
        kitty_mod = "ctrl+shift";

        tab_bar_edge = "bottom";
        tab_bar_margin_height = "0.0 0.0";
        tab_bar_margin_width = "0.0";
        tab_bar_style = "powerline";
        tab_bar_min_tabs = 1;
        tab_switch_strategy = "previous";
        tab_fade = "0 0 0 0";
        tab_separator = "";
        tab_title_template = "{fmt.fg._c5c6c8}{fmt.bg._1d1f21} {index}:{f'{title[:10]}…{title[-10:]}' if title.rindex(title[-1]) + 1 > 21 else title}{' []' if layout_name == 'stack' else ''} ";
        active_tab_title_template = "{fmt.fg._1d1f21}{fmt.bg._c5c6c8} {index}:{f'{title[:10]}…{title[-10:]}' if title.rindex(title[-1]) + 1 > 21 else title}{' []' if layout_name == 'stack' else ''} ";
        tab_activity_symbol = "none";
        tab_powerline_style = "angled";
        active_tab_font_style = "bold";
        inactive_tab_font_style = "normal";
      };
      keybindings = {
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
        "kitty_mod+n" = "new_os_window";
        "kitty_mod+w" = "close_window";
        "kitty_mod+]" = "next_window";
        "kitty_mod+[" = "previous_window";
        "kitty_mod+f" = "move_window_forward";
        "kitty_mod+b" = "move_window_backward";
        "kitty_mod+`" = "move_window_to_top";
        "kitty_mod+r" = "start_resizing_window";
        "kitty_mod+1" = "first_window";
        "kitty_mod+2" = "second_window";
        "kitty_mod+3" = "third_window";
        "kitty_mod+4" = "fourth_window";
        "kitty_mod+5" = "fifth_window";
        "kitty_mod+6" = "sixth_window";
        "kitty_mod+7" = "seventh_window";
        "kitty_mod+8" = "eighth_window";
        "kitty_mod+9" = "ninth_window";
        "kitty_mod+0" = "tenth_window";
        "kitty_mod+right" = "next_tab";
        "kitty_mod+left" = "previous_tab";
        "kitty_mod+t" = "new_tab";
        "kitty_mod+q" = "close_tab";
        "kitty_mod+." = "move_tab_forward";
        "kitty_mod+," = "move_tab_backward";
        "kitty_mod+alt+t" = "set_tab_title";
        "kitty_mod+l" = "next_layout";
        "shift+up" = "move_window up";
        "shift+left" = "move_window left";
        "shift+right" = "move_window right";
        "shift+down" = "move_window down";
        "kitty_mod+equal" = "change_font_size all +2.0";
        "kitty_mod+minus" = "change_font_size all -2.0";
        "kitty_mod+backspace" = "change_font_size all 0";
        "kitty_mod+e" = "kitten hints";
        "kitty_mod+p>f" = "kitten hints --type path --program -";
        "kitty_mod+p>shift+f" = "kitten hints --type path";
        "kitty_mod+p>l" = "kitten hints --type line --program -";
        "kitty_mod+p>w" = "kitten hints --type word --program -";
        "kitty_mod+p>h" = "kitten hints --type hash --program -";
        "Alt+Insert" = "kitten grab1.py";
        "kitty_mod+f11" = "toggle_fullscreen";
        "kitty_mod+f10" = "toggle_maximized";
        "kitty_mod+u" = "kitten unicode_input";
        "kitty_mod+f2" = "edit_config_file";
        "kitty_mod+escape" = "kitty_shell window";
        "kitty_mod+a>m" = "set_background_opacity +0.1";
        "kitty_mod+a>l" = "set_background_opacity -0.1";
        "kitty_mod+a>1" = "set_background_opacity 1";
        "kitty_mod+a>d" = "set_background_opacity default";
        "kitty_mod+delete" = "clear_terminal reset active";
      };
    };
  };
}
