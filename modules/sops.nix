{ ...
}: {
  sops.defaultSopsFile = ../secrets/secrets.yaml;
  sops.age.keyFile = "../keys/keys.txt";
}
