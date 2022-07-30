{ pkgs, ... }:
{
  qt = {
    enable = true;
    platformTheme = "gnome";
    style = {
      package = pkgs.libsForQt5.qtstyleplugin-kvantum;
      name = "kvantum";
    };
  };
}
