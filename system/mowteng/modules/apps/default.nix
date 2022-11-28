{ config, pkgs, lib, ... }:

{
  #nixpkgs.overlays = [
  #  (self: super: {
  #    mpv = super.mpv.override { scripts = [ self.mpvScripts.mpris ]; };
  #  })
  #];
  #nixpkgs.config.packageOverrides = pkgs: {
  #  steam = pkgs.steam.override {
  #    extraPkgs = pkgs:
  #      with pkgs; [
  #        libgdiplus
  #        gamescope
  #        mangohud
  #        xorg.libXcursor
  #        xorg.libXi
  #       xorg.libXinerama
  #       xorg.libXScrnSaver
  ##       libpng
  #       libpulseaudio
  #       libvorbis
  #       stdenv.cc.cc.lib
  #       libkrb5
  #       keyutils
  #     ];
  # };
  #};
  environment.systemPackages = with pkgs; [
    brightnessctl
    firefox
    fprintd
    fwupd
    ffmpeg
    hunspell
    iio-sensor-proxy
    iwd
    iwgtk
    ldns
    libinput
    mpv
    pandoc
    pinentry-gnome
    polkit_gnome
    (let
      python-packages-plus = python-packages:
        with python-packages; [
          isort
          evdev
          jinja2
          nose
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
    udisks
    udiskie
    yt-dlp
    xdg_utils
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

