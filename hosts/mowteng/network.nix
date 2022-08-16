{ config, pkgs, libs, ... }:

{
  #  sops.secrets = {
  #    "wg/private" = {
  #      mode = "0640";
  #      owner = config.users.users.systemd-network.name;
  #    };
  #    "wg/psk" = {
  #      mode = "0640";
  #      owner = config.users.users.systemd-network.name;
  #    };
  #  };

  networking = {
    hostName = "mowteng";
    useDHCP = false;
    #resolvconf.enable = true;
    wireless.iwd.enable = true;
    dhcpcd.extraConfig = "noipv6rs\nnoipv6";
  };


  #systemd.network.netdevs."90-wireguard" = {
  #  netdevConfig = {
  #    Kind = "wireguard";
  #    Name = "wg0";
  #  };
  #  wireguardConfig = {
  #    PrivateKeyFile = config.sops.secrets."wg/private".path;
  #    ListenPort = 51872;
  #  };
  #  wireguardPeers = [{
  #    wireguardPeerConfig = {
  #      AllowedIPs = [
  #        "10.200.200.0/24"
  #        "::/1"
  #      ];
  #      Endpoint = "46.38.240.252:51871";
  #      PersistentKeepalive = 25;
  #      PresharedKeyFile = config.sops.secrets."wg/psk".path;
  #      PublicKey = "IqYGE/5SPmMPEs0us6ZkH5RlePZ2KJDpGxBgjCBnQno=";
  #    };
  #  }];
  #};

  systemd.network = {
    enable = true;
    wait-online = {
      timeout = 20;
      anyInterface = true;
    };

    links."00-iwd" = {
      matchConfig.Type = [ "wlan" ];
      linkConfig.NamePolicy = "path";
    };

    networks."20-wired" = {
      matchConfig.Name = [ "en*" ];
      DHCP = "ipv4";
      dhcpV4Config = {
        RouteMetric = 10;
        UseDNS = true;
        UseRoutes = true;
      };
    };
    networks."25-wireless" = {
      matchConfig.Name = [ "wlan0" ];
      matchConfig.SSID = [ "!\\(\\=\\^\\-\\-\\^\\=\\)" ];
      DHCP = "ipv4";
      networkConfig = {
        MulticastDNS = true;
        IPv6AcceptRA = "no";
      };
      dhcpV4Config = {
        RouteMetric = 20;
        UseDNS = true;
        UseRoutes = true;
      };
    };
    networks."26-wireless" = {
      matchConfig.Name = [ "wlan0" ];
      networkConfig.IPv6AcceptRA = "no";
      DHCP = "no";
      address = [ "192.168.178.61/24" ];
      dns = [ "192.168.178.254" ];
      gateway = [ "192.168.178.1" ];
    };

    #networks."90-wireguard" = {
    #  matchConfig.Name = "wg0";
    #  address = [ "10.200.200.2/24" ];
    #  dns = [ "10.200.200.1" ];
    #  routes = [{
    #    routeConfig = {
    #      Destination = "10.200.200.0/24";
    #      Scope = "link";
    #    };
    #  }];
    #};
  };
}
