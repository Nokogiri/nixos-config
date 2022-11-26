{ config, pkgs, lib, ... }:

{
  environment = {
    loginShellInit = ''
      if [ -z $DISPLAY ] && [ "$(tty)" = "/dev/tty1" ]; then
        exec sway
      fi
    ''; # Will automatically open sway when logged into tty1
  };

  programs.sway = {
    enable = true;
    wrapperFeatures.base = true;
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
      avizo
      cliphist
      eww-wayland
      fuzzel
      gsettings-desktop-schemas
      grim
      kitty
      mako
      ponymix
      pulseaudio
      rofi-wayland
      slurp
      sov
      swayidle
      swaylock-effects
      swaynotificationcenter
      swayr
      wl-clipboard
      wlr-randr
      wofi
    ];
  };

  environment.systemPackages = with pkgs; [
    (pkgs.writeTextFile {
      name = "configure-gtk";
      destination = "/bin/configure-gtk";
      executable = true;
      text =
        let
          schema = pkgs.gsettings-desktop-schemas;
          datadir = "${schema}/share/gsettings-schemas/${schema.name}";
        in
        ''
          export XDG_DATA_DIRS=${datadir}:$XDG_DATA_DIRS
          gnome_schema=org.gnome.desktop.interface
          gsettings set $gnome_schema gtk-theme 'vimix-dark'
          gsettings set $gnome_schema icon-theme 'Vimix-Black-dark'
          gsettings set $gnome_schema cursor-theme 'Vimix-White-dark'
        '';
    })
  ];

  xdg.portal = {
    enable = true;
    wlr.enable = true;
    extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
    #gtkUsePortal = true;
  };

  xdg.icons.enable = true;
  gtk.iconCache.enable = true;

  #systemd.user.targets.sway-session = {
  #  description = "Sway compositor session";
  #  bindsTo = [ "graphical-session.target" ];
  #  wants = [ "graphical-session-pre.target" ];
  #  after = [ "graphical-session-pre.target" ];
  #};

}

