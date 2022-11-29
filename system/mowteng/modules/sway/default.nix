{ config, pkgs, lib, home-manager, ... }:

{
  environment = {
    loginShellInit = ''
      if [ -z $DISPLAY ] && [ "$(tty)" = "/dev/tty1" ]; then
        exec sway
      fi
    ''; # Will automatically open sway when logged into tty1
  };

  environment.systemPackages = with pkgs;
    [
      (pkgs.writeTextFile {
        name = "configure-gtk";
        destination = "/bin/configure-gtk";
        executable = true;
        text = let
          schema = pkgs.gsettings-desktop-schemas;
          datadir = "${schema}/share/gsettings-schemas/${schema.name}";
        in ''
          export XDG_DATA_DIRS=${datadir}:$XDG_DATA_DIRS
          gnome_schema=org.gnome.desktop.interface
          gsettings set $gnome_schema gtk-theme 'Catppuccin-Frappe-Green'
          gsettings set $gnome_schema icon-theme 'Colloid-green-dark'
          gsettings set $gnome_schema cursor-theme 'Colloid-dark-Cursors'
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

}

