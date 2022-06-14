{config, pkgs, libs, ...}:

{
  networking = {
    hostName = "frankenbook";
    useDHCP = false;
    resolvconf.enable = true;
    wireless.iwd.enable = true;
    dhcpcd.extraConfig = "noipv6rs\nnoipv6";
  };

  systemd.network = {
    enable = true;
    wait-online = {
      timeout = 20;
      anyInterface = true;
    };
    
    links."79-iwd" = {
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
      matchConfig.Name = [ "wlp2s0" ];
      matchConfig.SSID = [ "!\\(\\=\\^\\-\\-\\^\\=\\)" ];
      DHCP = "ipv4";
      networkConfig = {
        MulticastDNS = true;
        IPv6AccetRA = "no";
      };
      dhcpV4Config = {
        RouteMetric = 20;
        UseDNS = true;
        UseRoutes = true;
      };
    };
    networks."26-wireless" = {
      matchConfig.Name = [ "wlp2s0" ];
      networkingConfig.IPv6AcceptRA = "no";
      DHCP = "no";
      address = [ "192.168.178.21/24" ];
      dns = [ "192.168.178.254" ];
      gateway = [ "192.168.178.1" ];
    };
  };
}
