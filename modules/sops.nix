{
  ...
}: {
  sops.defaultSopsFile = ../secrets/frankenbook.yaml;
  sops.age.keyFile = "/home/nokogiri/.config/sops/age/keys.txt";
  sops.secrets."wg_psk" = {};
}
