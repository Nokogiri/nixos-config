{ config, pkgs, lib, ... }:

{
  sops.secrets = {
    "wg/private" = {};
    "wg/public" = {};
    "wg/psk" = {};
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
    wireguardPeers = {
      AllowedIPs = [
        "10.200.200.0/24"
        "::/1"
      ];
      Endpoint = "46.38.240.252:51871";
      PersistentKeepalive = 25;
      PresharedKeyFile = config.sops.secrets."wg/psk".path;
      PublicKey = "IqYGE/5SPmMPEs0us6ZkH5RlePZ2KJDpGxBgjCBnQno=";
    };
  };
}
