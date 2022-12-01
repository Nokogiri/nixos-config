{ pkgs, ... }: {
  gtk = {
    enable = true;
    cursorTheme = {
      package = pkgs.colloid-cursors;
      name = "Colloid-dark-Cursors";
    };
    font = {
      name = "FiraCode Nerd Font";
      size = 12;
    };
    iconTheme = {
      package = pkgs.colloid-icon-theme;
      name = "Colloid-teal-dark";
    };
    theme = {
      package = pkgs.catppuccin-gtk-frappe-teal;
      name = "Catppuccin-Frappe-Teal";
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
  #qt = {
  #  enable = true;
  #  platformTheme = "qt5ct";
  #style = { name = "gtk2"; };
  #};
  home.sessionVariables = { QT_QPA_PLATFORMTHEME = "qt5ct"; };
}
