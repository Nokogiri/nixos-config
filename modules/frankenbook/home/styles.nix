{ pkgs, ... }:
{
  gtk = {
    enable = true;
    cursorTheme = {
      name = "Vimix White dark";
    };
    font = {
      name = "MesloLGSDZ Nerd Font";
      size = 10;
    };
    iconTheme = {
      name = "Fluent-grey-dark";
    };
    theme = {
      name = "Fluent-grey-Dark-compact";
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
    platformTheme = "gnome";
    style = {
      package = pkgs.libsForQt5.qtstyleplugin-kvantum;
      name = "kvantum";
    };
  };
}
