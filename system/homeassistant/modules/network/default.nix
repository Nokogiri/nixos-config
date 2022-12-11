{ config, pkgs, libs, ... }:

{
  sops.secrets = {
    "wg/private" = {
      mode = "0640";
      owner = config.users.users.systemd-network.name;
    };
    "wg/psk" = {
      mode = "0640";
      owner = config.users.users.systemd-network.name;
    };
  };

  networking = {
    hostName = "homeassistant";
    useDHCP = false;
    enableIPv6 = true;
    dhcpcd.extraConfig = ''
      noipv6rs
      noipv6'';
    firewall = {
      trustedInterfaces = [ "wg0" "enp1s0f0" ];
      allowedTCPPorts = [ 80 443 5353 6052 8123 ];
    };
  };

  systemd.network.netdevs."90-wireguard" = {
    netdevConfig = {
      Kind = "wireguard";
      Name = "wg0";
    };
    wireguardConfig = {
      PrivateKeyFile = config.sops.secrets."wg/private".path;
      ListenPort = 51872;
    };
    wireguardPeers = [{
      wireguardPeerConfig = {
        AllowedIPs = [ "10.200.200.0/24" "::/1" ];
        Endpoint = "46.38.240.252:51871";
        PersistentKeepalive = 25;
        PresharedKeyFile = config.sops.secrets."wg/psk".path;
        PublicKey = "IqYGE/5SPmMPEs0us6ZkH5RlePZ2KJDpGxBgjCBnQno=";
      };
    }];
  };

  systemd.network = {
    enable = true;
    wait-online = {
      timeout = 20;
      anyInterface = true;
    };

    networks."20-wired" = {
      matchConfig.Name = [ "en*" ];
      DHCP = "no";
      address = [ "192.168.178.57/24" ];
      gateway = [ "192.168.178.1" ];
      dns = [ "192.168.178.254" ];
      dhcpV4Config = {
        RouteMetric = 10;
        UseDNS = true;
        UseRoutes = true;
      };
      linkConfig = { Multicast = true; };
      networkConfig = {
        MulticastDNS = true;
        LLMNR = true;
      };
    };

    networks."90-wireguard" = {
      matchConfig.Name = "wg0";
      address = [ "10.200.200.2/24" ];
      dns = [ "10.200.200.1" ];
      routes = [{
        routeConfig = {
          Destination = "10.200.200.0/24";
          Scope = "link";
        };
      }];
    };
  };
}
