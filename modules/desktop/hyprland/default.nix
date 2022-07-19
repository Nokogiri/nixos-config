{ config, lib, pkgs, ... }:

{

  environment = {
    loginShellInit = ''
      if [ -z $DISPLAY ] && [ "$(tty)" = "/dev/tty1" ]; then
        exec Hyprland
      fi
    ''; # Will automatically open sway when logged into tty1

    sessionVariables = {
      "XDG_DATA_DIRS=${pkgs.gnome-desktop-schemas}/share/gsettings/${pkgs.gnome-desktop-schemas.name}:$XDG_DATA_DIRS"
    };
  };

  programs.hyprland = {
    enable = true;
    extraPackages = with pkgs; [
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
