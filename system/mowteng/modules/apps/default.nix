{ config, pkgs, lib, ... }:

{
  environment.systemPackages = with pkgs; [

    # web
    chromium
    firefox-wayland
    transmission-remote-gtk
    widevine-cdm

    # documents, graphics etc
    gimp
    imv
    inkscape
    pandoc
    xournalpp
    zathura

    # video & audio
    ffmpeg
    gtk-pipe-viewer
    mpv
    spotify
    yt-dlp

    # emultation
    cemu
    libretro.beetle-pce-fast
    libretro.beetle-psx
    libretro.beetle-psx-hw
    libretro.beetle-supergrafx
    libretro.dolphin
    libretro.mgba
    libretro.mupen64plus
    libretro.parallel-n64
    libretro.snes9x
    ppsspp
    rpcs3
    ryujinx
    yuzu-mainline

    # game-utils
    gamemode
    gamescope
    mangohud
    prismlauncher

    # general utils
    iwgtk
    pavucontrol
    udiskie

    # cli utils
    gopass
    neofetch
    pamixer
    playerctl
    ponymix
    xdg_utils

    # wm utils
    avizo
    cliphist
    eww-wayland
    fuzzel
    glib.bin
    grim
    kitty
    kitty-themes
    libsForQt5.qtstyleplugin-kvantum
    mako
    slurp
    swayidle
    swaylock-effects
    swaynotificationcenter
    wl-clipboard
    wlr-randr
    wofi

    # misc
    hyprland

    # edit ++ devel
    tree-sitter
    gcc
    gnumake
    # system
    nvtop-amd
    fwupd
    iio-sensor-proxy
    ldns
    libinput
    pinentry-gnome
    polkit_gnome
    (let
      python-packages-plus = python-packages:
        with python-packages; [
          isort
          evdev
          jinja2
          nose
          pynvim
          pytest
          requests
          unidecode
          setuptools
        ];
      python-with-packages-plus = python3.withPackages python-packages-plus;
    in python-with-packages-plus)
    ryzen-ppd
    sshfs-fuse
    texlive.combined.scheme-small
  ];

  programs = {
    gnupg.agent.enable = true;
    mtr.enable = true;
    light.enable = true;
    ssh.startAgent = true;
    steam = {
      enable = true;
      remotePlay.openFirewall = true;
      dedicatedServer.openFirewall = true;
    };
    sway = {
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
    };
    waybar.enable = true;
    xwayland.enable = true;
  };

  systemd.services.ryzen-ppd = {
    after = [ "dbus.service" ];
    wantedBy = [ "multi-user.target" ];
    serviceConfig = {
      Type = "simple";
      ExecStart = ":${pkgs.ryzen-ppd}/bin/ryzen-ppd";
      Environment = "PYTHONUNBUFFERED=1";
    };
  };

  environment.etc = {
    "ryzen-ppd.ini".text = ''
      [ryzenadj]
      limits = ["stapm_limit", "fast_limit", "slow_limit", "apu_slow_limit", "tctl_temp", "apu_skin_temp_limit"]
      monitor = fast_limit
      [profiles]
      battery     = [ 9000,  8800,  8800, 12000, 60, 45 ]
      low-power   = [ 11000,  9900,  9900, 13500, 60, 45 ]
      balanced    = [ 20000, 20000, 15000, 15000, 70, 45 ]
      performance = [ 44000, 44000, 44000, 30000, 87, 60 ]
      #custom      = [ 30000, 30000, 28000, 17000, 96, 64 ]

      [dytc]

      [ac]
      profile = performance
      # Rate in seconds at which a profile is applied. Default: 4
      update_rate_s = 10
      # ACPI platform profile. Default: balanced
      platform_profile = performance
      # Settings that are applied when using a battery as the power source.
      [battery]
      # Power profile. Default: low-power
      profile = low-power
      # Rate in seconds at which a profile is applied. Default: 32
      update_rate_s = 32
      # ACPI platform profile. Default: low-power
      platform_profile = low-power
    '';

  };
  systemd.user.services.fusuma = {
    partOf = [ "graphical-session.target" ];
    after = [ "graphicial-session.target" ];
    path = [ pkgs.libinput ];
    wantedBy = [ "graphical-session.target" ];
    serviceConfig = {
      Type = "simple";
      ExecStart = ":${pkgs.fusuma}/bin/fusuma";
      TimeoutSec = 5;
      Restart = "on-failure";
      Slice = "app.slice";
    };
  };
}

