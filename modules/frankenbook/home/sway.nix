{
  wayland.windowManager.sway = {
    enable = true;
    config = {
      assigns = { };
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
      fonts = { };
    };
  };
}
