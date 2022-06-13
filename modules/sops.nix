{
  ...
}: {
  sops.defaultSopsFile = ./secrets/frankebook.yaml;
  sops.age.KeyFile = "/home/nokogiri/.config/sops/age/keys.txt";
  sops.secrets."wg_psk" = {};
}
