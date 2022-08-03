{ pkgs, ... }:
{
  gtk = {
    enable = true;
    cursorTheme = "Vimix White Dark";
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
