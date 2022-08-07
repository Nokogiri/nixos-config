{ pkgs, ... }:
{
  gtk = {
    enable = true;
    cursorTheme = {
      package = pkgs.vimix-icon-theme;
      name = "Vimix-White-dark";
    };
    font = {
      name = "MesloLGSDZ Nerd Font";
      size = 10;
    };
    iconTheme = {
      package = pkgs.vimix-icon-theme;
      name = "Vimix-Black-dark";
    };
    theme = {
      package = pkgs.vimix-gtk-themes;
      name = "vimix-dark";
    };
    gtk3 = {
      extraConfig = {
        gtk-button-images = false;
        gtk-menu-images = false;
        gtk-enable-event-sounds = false;
        gtk-enable-animations = true;
        gtk-application-prefer-dark-theme = true;
      };
    };
  };
  qt = {
    enable = true;
    platformTheme = "gtk";
    style = {
      name = "gtk2";
    };
  };
}
