{ config, lib, pkgs, ... }:

{

  environment = {
    loginShellInit = ''
      if [ -z $DISPLAY ] && [ "$(tty)" = "/dev/tty1" ]; then
        exec hyprland-run
      fi
    ''; # Will automatically open sway when logged into tty1
  };

  programs.hyprland = {
    enable = true;
    extraPackages = with pkgs; [
      (pkgs.writeTextFile {
        name = "wayland_env";
        destination = "/bin/wayland_env";
        executable = true;
        text =
          let
            schema = pkgs.gsettings-desktop-schemas;
            datadir = "${schema}/share/gsettings-schemas/${schema.name}";
          in
          ''
            #
            # GTK environment
            #

            #export GDK_BACKEND=wayland # May cause problems with some xorg applications
            export TDESKTOP_DISABLE_GTK_INTEGRATION=1
            export CLUTTER_BACKEND=wayland
            export BEMENU_BACKEND=wayland

            # Firefox
            export MOZ_ENABLE_WAYLAND=1

            #
            # Qt environment
            #
            export QT_QPA_PLATFORM=wayland-egl #error with apps xcb
            export QT_WAYLAND_FORCE_DPI=physical
            export QT_WAYLAND_DISABLE_WINDOWDECORATION=1

            #
            # Elementary environment
            #
            export ELM_DISPLAY=wl
            export ECORE_EVAS_ENGINE=wayland_egl
            export ELM_ENGINE=wayland_egl
            export ELM_ACCEL=opengl
            # export ELM_SCALE=1

            #
            # SDL environment
            #
            export SDL_VIDEODRIVER=wayland

            #
            # Java environment
            #
            export _JAVA_AWT_WM_NONREPARENTING=1

            export NO_AT_BRIDGE=1
            export WINIT_UNIX_BACKEND=wayland
            export DBUS_SESSION_BUS_ADDRESS
            export DBUS_SESSION_BUS_PID
            export XDG_DATA_DIRS=${datadir}:$XDG_DATA_DIRS
          '';
        })
        (pkgs.writeTextFile = {
          name = "hyprland-run";
          destination = "/bin/hyprland-run";
          executable = true;
          text =
            ''
              # Session
              export XDG_SESSION_TYPE=wayland
              export XDG_SESSION_DESKTOP=wlroots
              export XDG_CURRENT_DESKTOP=wlroots
              export XDG_CURRENT_SESSION=wlroots

              systemd-cat --identifyer=hyprland Hyprland $@
            '';
        })
      cliphist
      firefox-esr-wayland
      fluent-gtk-theme
      fluent-icon-theme
      gsettings-desktop-schemas
      grim
      imv
      libinput
      libsForQt5.qtstyleplugin-kvantum
      kitty
      mako
      nwg-launchers
      ponymix
      pulseaudio
      rofi-wayland
      slurp
      swayidle
      swaylock-effects
      vimix-cursors
      wl-clipboard
      wlr-randr
      waybar-hyprland
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
          gsettings set $gnome_schema gtk-theme 'Fluent-grey-Dark-compact'
          gsettings set $gnome_schema icon-theme 'Fluent-grey-dark'
          gsettings set $gnome_schema cursor-theme 'Vimix White dark'
        '';
    })
    (pkgs.writeTextFile {
      name = "dbus-hyprland-environment";
      destination = "/bin/dbus-hyprland-environment";
      executable = true;

      text = ''
        dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP=hyprland
        systemctl --user stop pipewire pipewire-media-session xdg-desktop-portal xdg-desktop-portal-wlr
        systemctl --user start pipewire pipewire-media-session xdg-desktop-portal xdg-desktop-portal-wlr
      '';
    })
  ];


  xdg.portal = {
    enable = true;
    wlr.enable = true;
    #extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
    #gtkUsePortal = true;
  };

  xdg.icons.enable = true;
  gtk.iconCache.enable = true;
}
