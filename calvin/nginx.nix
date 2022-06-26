{ pkgs, config, lib, ... }:

{
  sops.secrets.ovh_dns = {
    owner = "acme";
  };

  security.acme = {
    acceptTerms = true;
    defaults = {
      credentialsFile = "/run/secrets/ovh_dns";
      dnsProvider = "ovh";
      email = "nokogiri@gefjon.org";
      #group = "nginx";
    };

    certs = {
      "fishoeder.net" = {
        domain = "fishoeder.net";
        extraDomainNames = [
          "*.fishoeder.net"
        ];
      };
      "gefjon.org" = {
        domain = "gefjon.org";
        extraDomainNames = [
          "*.gefjon.org"
        ];
      };
    };
  };
}
