# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, lib, ... }:

let
  dbus-sway-environment = pkgs.writeTextFile {
    name = "dbus-sway-environment";
    destination = "/bin/dbus-sway-environment";
    executable = true;

    text = ''
  dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP=sway
  systemctl --user stop pipewire pipewire-media-session xdg-desktop-portal xdg-desktop-portal-wlr
  systemctl --user start pipewire pipewire-media-session xdg-desktop-portal xdg-desktop-portal-wlr
      '';
  };

  configure-gtk = pkgs.writeTextFile {
      name = "configure-gtk";
      destination = "/bin/configure-gtk";
      executable = true;
      text = let
        schema = pkgs.gsettings-desktop-schemas;
        datadir = "${schema}/share/gsettings-schemas/${schema.name}";
      in ''
        export XDG_DATA_DIRS=${datadir}:$XDG_DATA_DIRS
        gnome_schema=org.gnome.desktop.interface
        gsettings set $gnome_schema gtk-theme 'Fluent-grey-dark-compact'
	gsettings set $gnome_schema icon-theme 'Fluent-grey-dark'
	gsettings set $gnome_schema cursor-theme 'Vimix-white-dark'
        '';
  };
in
{
  nix = {
    #package = pkgs.nixUnstable;
    package = pkgs.nixFlakes;
    extraOptions = ''
      experimental-features = nix-command flakes
    '';
    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 20d";
    };
  };

  imports =
    [
      #./hosts/frankenbook.nix
      #./modules/sops.nix
    ];

#  security = {
#    doas = { 
#      enable = true;
#      wheelNeedsPassword = true;
#      extraRules = [{
#        groups = [ "wheel" ];
#        noPass = false;
#        keepEnv = true;
#        persist = true;
#      }];
#    };
#  };
  
  # Set your time zone.
  time.timeZone = "Europe/Berlin";
  location = {
    latitude = 50.9787;
    longitude = 11.03283;
  };

  nixpkgs.config.allowUnfree = true;

  # Select internationalisation properties.
  i18n = {
    supportedLocales = [
      "en_US.UTF-8/UTF-8" 
      "de_DE.UTF-8/UTF-8"
    ];
    defaultLocale = "en_US.UTF-8";
    extraLocaleSettings = { LC_CTYPE = "en_US.UTF-8";
    			    LC_NUMERIC = "de_DE.UTF-8";
			    LC_TIME = "de_DE.UTF-8";
			    LC_COLLATE = "en_US.UTF-8";
			    LC_MONETARY = "de_DE.UTF-8";
			    LC_MESSAGES = "en_US.UTF-8";
			    LC_PAPER = "de_DE.UTF-8";
			    LC_NAME = "en_US.UTF-8";
			    LC_ADDRESS = "en_US.UTF-8";
			    LC_TELEPHONE = "en_US.UTF-8";
			    LC_MEASUREMENT = "de_DE.UTF-8";
			    LC_IDENTIFICATION= "en_US.UTF-8";
			    };
  };

  console = {
    font = "Lat2-14";
  };

  services.clight.enable = true;
  services.tlp.enable = true;
  services.resolved.enable = true;
  # Enable CUPS to print documents.
  # services.printing.enable = true;

  # Enable sound.
  sound.enable = true;

  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  # environment.systemPackages = with pkgs; [
  #   vim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
  #   wget
  # ];
  users.users.nokogiri = {
    isNormalUser = true;
    extraGroups = [ 
      "wheel"
      "video"
      "audio"
      "input"
      "config.users.groups.keys.name"
    ];
    shell = pkgs.zsh;
  };
  fonts.fonts = with pkgs; [
    (nerdfonts.override { fonts = [ "FiraCode" "FiraMono" "Meslo" "Mononoki" ]; })
    corefonts
    dejavu_fonts
    unifont
    noto-fonts
    noto-fonts-emoji
    noto-fonts-cjk-sans
    ];

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
    };

  programs.git.enable = true;
  programs.gnupg.agent.enable = true;
  programs.light.enable = true;
  programs.qt5ct.enable = true;
  programs.ssh.startAgent = true;
  programs.tmux.enable = true;
  programs.waybar.enable = true;
  programs.xwayland.enable = true;
  programs.zsh.enable = true;
  
  xdg.icons.enable = true;
  gtk.iconCache.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    pulse.enable = true;
    wireplumber.enable = true;
  };

  services.dbus.enable = true;
  xdg.portal = {
    enable = true;
    wlr.enable = true;
    # gtk portal needed to make gtk apps happy
    extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
    gtkUsePortal = true;
  };
  
  services.mbpfan = {
    enable = true;
    settings.general.max_temp = 80;
    settings.general.polling_interval = 2;
    settings.general.min_fan1_speed = 2600;    
  };
  services.avahi.enable = true;
  environment.systemPackages = with pkgs; [
    (pkgs.writeShellScriptBin "nixFlakes" ''
      exec ${pkgs.nixFlakes}/bin/nix --experimental-features "nix-command flakes" "$@"
    '')
    age
    bat
    cliphist
    configure-gtk
    dbus-sway-environment
    dfc
    diff-so-fancy
    firefox-esr-wayland
    fusuma
    glib
    gnome3.adwaita-icon-theme
    gnome.gnome-settings-daemon
    gnome.gnome-themes-extra
    grim
    gsettings-desktop-schemas
    gtk-engine-murrine
    hicolor-icon-theme
    iwd
    kitty
    libsForQt5.qtstyleplugin-kvantum
    linuxKernel.packages.linux_5_17.cpupower
    mako
    neovide
    neovim
    nix-index
    nwg-launchers
    python311
    ranger
    rofi-wayland
    slurp
    ssh-to-age
    swayidle
    swaylock-effects
    swayr
    tridactyl-native
    udiskie
    unrar
    unzip
    vimix-icon-theme
    wireguard-tools
    wl-clipboard
    wlr-randr
    wofi
    yadm
    yt-dlp
  ];
  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };
  virtualisation = {
    docker = {
      enable = false;
      storageDriver = "btrfs";
    };
    libvirtd = {
      enable = false;
      onBoot = "ignore";
      onShutdown = "shutdown";
    };
  };
  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # Copy the NixOS configuration file and link it from the resulting system
  # (/run/current-system/configuration.nix). This is useful in case you
  # accidentally delete configuration.nix.
  # system.copySystemConfiguration = true;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "22.05"; # Did you read the comment?

}


