{
  ...
}: {
  sops.defaultSopsFile = ../secrets/frankenbook.yaml;
  sops.age.keyFile = "/etc/nixos/keys/keys.txt";
  sops.secrets."wg_psk" = {};
}
