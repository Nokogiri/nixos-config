{ config, pkgs, lib, ... }:

{
  sops.secrets = {
    wg_private = {};
    "wg_psk/consolero" = {};
    "wg_psk/frankenbook" = {};
    "wg_psk/hassio" = {};
    "wg_psk/kathi" = {};
    "wg_psk/mrpig" = {};
    "wg_psk/sm-af530" = {};
  };

  networking.firewall = {
    allowedUDPPorts = [ 51871 ];
  };

  systemd.network.netdevs."90-wireguard" = {
    netdevConfig = {
      Kind = "wireguard";
      Name = "wg0";
    };
    wireguardConfig = {
      PrivateKeyFile = config.sops.secrets.wg_private.path;
      ListenPort = 51871;
    };
    wireguardPeers = [
      {
      # consolero
      wireguardPeerConfig = {
        AllowedIPs = [
          "10.200.200.5/32"
        ];
        PublicKey = "ayew5N9nQFBl25vJHg5DOwOzVQAmJ2DS6wghNAwqtCg=";
        PresharedKeyFile = config.sops.secrets."wg_psk/consolero".path;
      };
    }
    {
      # frankenbook
      wireguarPeerConfig = {
        AllowedIPs = [
          "10.200.200.2/32"
        ];
        PublicKey = "40RkpFdcTlk+AWc9XC/yhWsnwDJKIhEY7t5z3meFJkQ=";
        PresharedKeyFile = config.sops.secrets."wg_psk/frankenbook".path;
      };
    }
    {
      # hassio
      wireguardPeerConfig = {
        AllowedIPs = [
          "10.200.200.6/32"
        ];
        PublicKey = "o0kQD7EjWYwU6rtDmLjVNy9f5IAfKk1HNRMnY6axNRw=";
        PresharedKeyFile = config.sops.secrets."wg_psk/hassio".path;
      };
    }
    {
     # kathi
      wireguardPeerConfig = {
        AlowedIPs = [
          "10.200.200.4/32"
        ];
        PublicKey = "KH6v0VRW9o4bzfnE1IRI6/e7lAlU52SkKCp22SXon2Y=";
        PreshredKeyFile = config.sops.secrets."wg_psk/kathi";
      };
    }
    {
      # mrpig
      wireguardPeerConfig = {
        AllowedIPs = [
          "10.200.200.7/32"
        ];
        PublicKey = "IqH0Yscrwv3QfQIiuK2v2QGHJDQEtYvSbLYX2alh3Fs=";
        PresharedKeyFile = config.sops.secrets."wg_psk/mrpig".path;
      };
    }
    {
      # sm-af530
      wireguardPeerConfig = {
        AllowedIPs = [
          "10.200.200.10/32"
        ];
        PublicKey = "olauwI++R95O0gucWSPDO9uH2/ufv2AvzAsVsUQ9Jl4=";
        PresharedKeyFile = config.sops.secrets."wg_psk/sm-af530".path;
      };
    }
  ];
  };

    systemd.network.networks."90-wireguard" = {
      matchConfig.Name = "wg0";
      address = [ "10.200.200.1/24" ];
      routes = [{
        routeConfig = {
          Destination = "10.200.200.0/24";
          Scope = "link";
        };
      }];
    };
  }
