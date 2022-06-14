{
  ...
}: {
  sops.defaultSopsFile = ./secrets/secrets.yaml;
  sops.age.keyFile = "/etc/nixos/keys/keys.txt";
  sops.secrets."wg/psk" = {};
}
