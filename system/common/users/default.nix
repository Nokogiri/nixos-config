{ config, pkgs, lib, ... }:

{
  security = {
    doas = {
      enable = true;
      wheelNeedsPassword = true;
      extraRules = [
        {
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
        }
      ];
    };
  };

  users.groups = { nokogiri = { gid = 1000; }; };

  users.users.nokogiri = {
    description = "It'sa Me Nokogiri...a!";
    isNormalUser = true;
    group = "nokogiri";
    extraGroups = [
      "audio"
      "disk"
      "docker"
      "input"
      "jellyfin"
      "uinput"
      "users"
      "video"
      "wheel"
      "networkmanager"
      config.users.groups.keys.name
    ];
    shell = pkgs.zsh;
    openssh.authorizedKeys.keys = [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIExoigGlfblca2iJPTcyRc/bL5hqHuDlXmbBf/9PhVKZ nokogiri@frankenbook"
    ];
  };
}
