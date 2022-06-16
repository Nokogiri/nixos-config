{ config, pkgs, lib, ... }:

{
  programs.sway = {
    enable = true;
    wrapperFeatures.gtk = true;
    extraSessionCommands = ''
      export TDESKTOP_DISABLE_GTK_INTEGRATION=1
      export CLUTTER_BACKEND=wayland
      export BEMENU_BACKEND=wayland
      export MOZ_ENABLE_WAYLAND=1
      export QT_QPA_PLATFORM=wayland-egl
      export QT_WAYLAND_FORCE_DPI=physical
      export QT_WAYLAND_DISABLE_WINDOWDECORATION=1
      export QT_STYLE_OVERRIDE=kvantum
      export SDL_VIDEODRIVER=wayland
      export _JAVA_AWT_WM_NONREPARENTING=1
      export NO_AT_BRIDGE=1
      export WINIT_UNIX_BACKEND=wayland
      '';
    extraPackages = with pkgs; [
      cliphist
      firefox-esr-wayland
      fusuma
      grim
      imv
      kitty
      libsForQt5.qtstyleplugin-kvantum
      mako
      mpv
      mpvScripts.mpris
      neovide
      nwg-launchers
      ponymix
      rofi-wayland
      slurp
      swayidle
      swaylock-effects
      swayr
      tridactyl-native
      vimix-icon-theme
      wl-clipboard
      wlr-randr
      wofi
    ];
  };

  environment.systemPackages = with pkgs; [
    xdg_utils
    polkit_gnome
    glib.bin
    hicolor-icon-theme
    gnome.adwaita-icon-theme
    gnome.gnome-themes-extra
    gtk-engine-murrine
    gtk_engines
    gsettings-desktop-schemas
    libsForQt5.qtstyleplugin-kvantum
  ];

}
