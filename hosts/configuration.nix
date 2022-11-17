{ config, lib, pkgs, inputs, user, ... }:

{
  imports =
    (import ../modules/common);
  nix = {
    package = pkgs.nixVersions.stable;
    extraOptions = ''
      experimental-features = nix-command flakes
      keep-outputs = true
      keep-derivations = true
    '';
    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 20d";
    };
    settings = {
      auto-optimise-store = true;
      #extra-sandbox-paths = [ (toString config.programs.ccache.cacheDir) ];
      substituters = [
        #"https://cache.fishoeder.net"
        "https://nix-community.cachix.org"
        "https://cache.nixos.org"
      ];
      trusted-public-keys = [
        "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
        #"cache.fishoeder.net:0wqH5JXoJJVWitNUfD9PCCVO+A8DOEOyXZSrkCi5lb8="
      ];
    };
  };

  environment.pathsToLink = [
    "/share/nix-direnv"
    "/share/zsh"
  ];

  nixpkgs.config.allowUnfree = true;

  i18n = {
    defaultLocale = "en_US.UTF-8";
    supportedLocales = [
      "en_US.UTF-8/UTF-8"
      "de_DE.UTF-8/UTF-8"
    ];
    extraLocaleSettings = {
      LC_CTYPE = "en_US.UTF-8";
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
      LC_IDENTIFICATION = "en_US.UTF-8";
    };
  };

  console.font = "Lat2-14";

  time.timeZone = "Europe/Berlin";

  security = {
    doas = {
      enable = true;
      wheelNeedsPassword = true;
      extraRules = [{
        groups = [ "wheel" ];
        noPass = false;
        keepEnv = true;
        persist = true;
      }
        {
          users = [ "nokogiri" ];
          noPass = true;
          keepEnv = true;
          persist = false;
        }];
    };
  };

  system.stateVersion = "22.05";

  sops.age.sshKeyPaths = [ "/etc/ssh/ssh_host_ed25519_key" ];

  environment.systemPackages = with pkgs; [
    (pkgs.writeShellScriptBin "nixVersions.stable" ''
      exec ${pkgs.nixVersions.stable}/bin/nix --experimental-features "nix-command flakes" "$@"
    '')
    age
    bat
    btop
    cachix
    compsize
    direnv
    dfc
    fd
    file
    fzf
    git
    gitAndTools.diff-so-fancy
    jq
    lesspipe
    linuxKernel.packages.linux_zen.cpupower
    lsd
    neovim
    nix-diff
    nix-direnv
    nix-index
    nix-tree
    nix-top
    nix-pin
    ranger
    rbw
    ripgrep
    rsync
    ssh-to-age
    tmux
    unrar
    unzip
    zip
    vivid
    wireguard-tools
    yadm
  ];

  programs.zsh.enable = true;

  programs.command-not-found.enable = false;
  programs.zsh.interactiveShellInit = ''
    source ${pkgs.nix-index}/etc/profile.d/command-not-found.sh
  '';
}
