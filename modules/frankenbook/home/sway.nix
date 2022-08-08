{ config, lib, pkgs, ... }:

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
        "${cfg.modifier}+Space" = "exec wofi --show drun";

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



      };
      modifier = "Mod4";
      terminal = "kitty";
    };
  };
}
