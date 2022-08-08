{ config, lib, pkgs, home-manager, ... }:

let
  cfg = config.wayland.windowManager.sway.config;
in
{
  wayland.windowManager.sway = {
    enable = true;
    config = {
      assigns = {
        "1" = [
          { app_id = "kitty"; }
        ];
        "2" = [
          { app_id = "firefox"; }
          { app_id = "chromium-browser"; }
        ];
        "3" = [
          { app_id = "mpv"; }
        ];
        "4" = [
          { class = "Emacs"; }
          { app_id = "emacs"; }
        ];
        "5" = [
          { app_id = "org.pwmt.zathura"; }
          { app_id = "com.github.maoschanz.drawing"; }
        ];
        "6" = [
          { class = "Steam"; }
        ];
        "7" = [
          { class = "Spotify"; }
          { app_id = "spotify-qt"; }
          { app_id = "dev.alextren.Spot"; }
        ];
        "8" = [

        ];
        "9" = [
          { class = "Com.github.johnfactotum.Foliate"; }
        ];
      };
      bars = [ ];
      colors = {
        background = "#ffffff";
        focused = {
          border = "#8abeb7";
          background = "#8abeb7";
          text = "#1d1f21";
          indicator = "#8abeb7";
          childBorder = "#8abeb7";
        };
        focusedInactive = {
          border = "#282a2e";
          background = "#282a2e";
          text = "#c5c8c6";
          indicator = "#282a2e";
          childBorder = "#282a2e";
        };
        placeholder = {
          border = "#1d1f21";
          background = "#1d1f21";
          text = "#c5c8c6";
          indicator = "#1d1f21";
          childBorder = "#1d1f21";
        };
        unfocused = {
          border = "#282a2e";
          background = "#1d1f21";
          text = "#c5c8c6";
          indicator = "#282a2e";
          childBorder = "#282a2e";
        };
        urgent = {
          border = "#cc6666";
          background = "#cc6666";
          text = "#1d1f21";
          indicator = "#cc6666";
          childBorder = "#cc6666";
        };
      };
      floating = {
        border = 1;
        criteria = [
          { app_id = "pavucontrol"; }
          { app_id = "retroarch"; }
          { title = "File Operation Progress"; }
        ];
        modifier = "Mod4";
      };
      focus = {
        followMouse = true;
      };
      fonts = {
        names = [ "mononoki Nerd Font" ];
        style = "Regular";
        size = 8.0;
      };
      gaps = {
        inner = 3;
        outer = 6;
        smartBorders = "on";
        smartGaps = false;
      };
      input = {
        "1452:594:Apple_Inc._Apple_Internal_Keyboard_/_Trackpad" = {
          xkb_layout = "us,de";
          xkb_model = "apple_laptop";
          xkb_options = "grp:alt_space_toggle";
          xkb_variant = "altgr-intl,";
        };
        "type:touchpad" = {
          events = "enabled";
          tap = "enabled";
        };
      };
      keybindings = {
        # Basics apps
        "${cfg.modifier}+Return" = "exec ${cfg.terminal}";
        "${cfg.modifier}+space" = "exec wofi --show drun";

        # basic internals
        "${cfg.modifier}+Shift+q" = "kill";
        "${cfg.modifier}+Shift+c" = "reload";

        # navigate windows
        "${cfg.modifier}+Left" = "focus left";
        "${cfg.modifier}+Down" = "focus down";
        "${cfg.modifier}+Right" = "focus right";
        "${cfg.modifier}+Up" = "focus up";

        # move windows
        "${cfg.modifier}+Shift+Left" = "move left";
        "${cfg.modifier}+Shift+Down" = "move down";
        "${cfg.modifier}+Shift+Right" = "move right";
        "${cfg.modifier}+Shift+Up" = "move up";

        # splitting
        "${cfg.modifier}+h" = "split h";
        "${cfg.modifier}+v" = "split v";

        # fullscreen
        "${cfg.modifier}+f" = "fullscreen toggle";

        # container layouts
        "${cfg.modifier}+s" = "layout stacking";
        "${cfg.modifier}+w" = "layout tabbed";
        "${cfg.modifier}+e" = "layout toggle split";

        # floating
        "${cfg.modifier}+Shift+f" = "floating toggle";
        "${cfg.modifier}+Shift+space" = "fcous mode-toggle";

        # focus parent
        "${cfg.modifier}+a" = "focus parent";

        # focus child
        "${cfg.modifier}+d" = "focus child";

        # switch to ws
        "${cfg.modifier}+Tab" = "workspace back_and_forth";
        "${cfg.modifier}+1" = "workspace number 1";
        "${cfg.modifier}+2" = "workspace number 2";
        "${cfg.modifier}+3" = "workspace number 3";
        "${cfg.modifier}+4" = "workspace number 4";
        "${cfg.modifier}+5" = "workspace number 5";
        "${cfg.modifier}+6" = "workspace number 6";
        "${cfg.modifier}+7" = "workspace number 7";
        "${cfg.modifier}+8" = "workspace number 8";
        "${cfg.modifier}+9" = "workspace number 9";

        # scratchpad
        "${cfg.modifier}+Shift+minus" = "move scratchpad";
        "${cfg.modifier}+minus" = "scratchpad show";

        # Apps
        ###
        # brightness
        "XF86MonBrightnessDown" = "exec lightctl -";
        "XF86MonBrightnessUp" = "exec lightctl +";
        "XF86KbdBrightnessDOwn" = "exec lightctl -D smc::kbd_backlight -";
        "XF86KbdBrightnessUp" = "exec lightctl -D smc::kbd_backlight +";

        "XF86AudioRaiseVolume" = "exec volumectl +";
        "XF86AudioLowerVolume" = "exec volumectl -";
        "XF86AudioMute" = "exec volumectl %";

        # grimshot
        "${cfg.modifier}+m" = "exec grimshot save output";
        "${cfg.modifier}+Shift+m" = "exec grimshot save active";
        "${cfg.modifier}+Mod1+m" = "exec grimshot save area";
        "${cfg.modifier}+Ctrl+m" = "exec grimshot save window";

        # mylock
        "${cfg.modifier}+l" = "exec ${config.home.homeDirectory}/.local/bin/mylock";
        "${cfg.modifier}+Shift+l" = "exec ${config.home.homeDirectory}/.local/bin/mylock at-home-mode";
        "${cfg.modifier}+Ctrl+l" = "exec ${config.home.homeDirectory}/.local/bin/mylock safe-mode";
        "${cfg.modifier}+Shift+Ctrl+l" = "exec ${config.home.homeDirectory}/.local/bin/mylock lock-now";
      };
      menu = "\${pkgs.wofi}/bin/wofi --show drun";
      modifier = "Mod4";
      output = {
        "*" = {
          bg = "${config.home.homeDirectory}/.config/wallpaper/current.png fill";
        };
      };
      seat = {
        "*" = {
          xcursor_theme = "Vimix-White-dark";
          hide_cursor = "when-typing 10";
        };
      };
      startup = [
        { command = "configure-gtk"; always = true; }
        { command = "wl-paste --watch cliphist store"; }
        { command = "avizo-service"; }
      ];
      terminal = "kitty";
      window = {
        border = 1;
      };
      workspaceAutoBackAndForth = true;

    };
    extraConfig = ''
      for_window [app_id="org.qutebrowser.qutebrowser"] inhibit_idle fullscreen
      for_window [app_id="firefox"] inhibit_idle fullscreen
    '';
    systemdIntegration = true;
  };
}
