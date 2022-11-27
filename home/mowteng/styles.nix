{ pkgs, ... }: {
  gtk = {
    enable = true;
    cursorTheme = {
      package = pkgs.colloid-cursors;
      name = "Colloid-dark";
    };
    font = {
      name = "FiraCode Nerd Font";
      size = 13;
    };
    iconTheme = {
      package = pkgs.colloid-icon-theme;
      name = "Colloid-green-dark";
    };
    theme = {
      package = pkgs.catppuccin-gtk-frappe-green;
      name = "Catppuccin-Frappe-Green";
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
    style = { name = "gtk2"; };
  };
}
