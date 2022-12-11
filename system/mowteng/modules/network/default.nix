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
    "wifi/pass" = {
      mode = "0640";
      owner = config.users.users.systemd-network.name;
    };
  };
  
  networking.firewall = { allowedUDPPorts = [ 5353 ]; };
  networking = {
    hostName = "mowteng";
    useDHCP = false;
    wireless = { 
      enable = true;
      environmentFile = config.sops.secrets."wifi/pass".path;
      networks = {
        "(=^--^=)" = {
          psk = "@PSK_HOME@";
        };
      };
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

  networking.networkmanager = { 
    enable = false;
    extraConfig = ''
      [connection]
      connection.mdns=2
      '';
    };
  systemd.network = {
    enable = true;
    wait-online = {
      timeout = 20;
      anyInterface = true;
    };

    networks."25-wireless" = {
      matchConfig.Name = [ "wl*" ];
      DHCP = "yes";
      dhcpV4Config = {
        RouteMetric = 20;
        UseDNS = true;
        UseRoutes = true;
        UseDomains = true;
      };
      linkConfig = { Multicast = true; };
      networkConfig = {
        MulticastDNS = true;
        LLMNR = true;
      };
    };
    networks."90-wireguard" = {
      matchConfig.Name = "wg0";
      address = [ "10.200.200.3/24" ];
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
